#!/usr/bin/env bash
# Smoke test: package the mod and load it in an isolated Factorio.
# [3/4] runs the data stage (broken prototypes, bad locale, setting mistakes)
# and [4/4] runs the control stage: --create starts a real map creation, which
# loads control.lua, registers events/commands and runs mod migrations. A Lua
# load error there fails the stage even though the data stage passed.
#
# Modes:
#   FACTORIO_BIN=/path/to/factorio   use an existing binary (local dev)
#   otherwise                        -> download current stable headless tarball
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

NAME=$(sed -n 's/.*"name": *"\([^"]*\)".*/\1/p' info.json)
VERSION=$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' info.json)
[ -n "$NAME" ] && [ -n "$VERSION" ] || { echo "::error::Could not read name/version from info.json"; exit 1; }

# Always smoke-test the current checkout (CI: commit state, locally: working tree).
WORK=$(mktemp -d "${TMPDIR:-/tmp}/hst-smoke.XXXXXX")
trap 'rm -rf "$WORK"' EXIT

# One write-data dir per Factorio stage: each stage writes its own
# factorio-current.log, so the stages cannot hide each other's log.
write_run_config() {
  local rundir="$1"
  mkdir -p "$rundir"
  # Minimal config: keep all writes (log, dumps, saves, cache) inside the stage
  # directory and leave the real user install untouched. Factorio fills the
  # remaining defaults itself.
  {
    echo "[path]"
    echo "write-data=$rundir"
    if [ -n "${READ_DATA:-}" ]; then echo "read-data=$READ_DATA"; fi
  } > "$rundir/config.ini"
}

echo "== [1/4] Static checks =="
python3 - "$NAME" <<'PY'
import json, sys
info = json.load(open("info.json"))
assert info["name"] == sys.argv[1], "info.json name mismatch"
assert info.get("factorio_version"), "info.json: factorio_version missing"
print("info.json: OK (factorio_version %s)" % info["factorio_version"])
PY

LUAC=""
for c in luac5.2 luac luajit; do
  if command -v "$c" >/dev/null 2>&1; then LUAC="$c"; break; fi
done
if [ -n "$LUAC" ]; then
  FAIL=0
  while IFS= read -r f; do
    if [ "$LUAC" = luajit ]; then
      "$LUAC" -e "assert(loadfile([[$f]]))" || { echo "::error::Lua syntax error: $f"; FAIL=1; }
    else
      "$LUAC" -p "$f" || { echo "::error::Lua syntax error: $f"; FAIL=1; }
    fi
  done < <(find . -name '*.lua' -not -path './.git/*')
  [ "$FAIL" -eq 0 ] && echo "Lua syntax: OK ($LUAC)" || exit 1
else
  echo "::warning::No lua interpreter found, skipping syntax check"
fi

echo "== [2/4] Package mod =="
STAGE="$WORK/mods_stage/$NAME\_$VERSION"
mkdir -p "$STAGE"
git ls-files -co --exclude-standard | grep -v -E '^(\.|scripts/)' | while IFS= read -r f; do
  mkdir -p "$STAGE/$(dirname "$f")"
  cp "$f" "$STAGE/$f"
done
mkdir -p "$WORK/mods"
(cd "$WORK/mods_stage" && zip -qr "$WORK/mods/${NAME}_${VERSION}.zip" "$NAME\_$VERSION")
echo "Packed: ${NAME}_${VERSION}.zip"

echo "== [3/4] Data stage =="
BIN="${FACTORIO_BIN:-}"
if [ -z "$BIN" ]; then
  # Current stable headless tarball is publicly downloadable (no account).
  case "$(uname -m)" in
    x86_64)  PLAT=linux64 ;;
    aarch64|arm64) PLAT=linux-arm64 ;;
    *) echo "::error::Unsupported platform $(uname -m) for auto-download; set FACTORIO_BIN"; exit 1 ;;
  esac
  echo "Downloading current stable Factorio headless ($PLAT, anonymous)..."
  curl -fsSL "https://factorio.com/get-download/stable/headless/$PLAT" -o "$WORK/factorio.tar.xz"
  mkdir -p "$WORK/fbin"
  tar -xJf "$WORK/factorio.tar.xz" -C "$WORK/fbin"
  BIN=$(find "$WORK/fbin" -type f -name factorio -path "*/bin/*" | head -n1)
  [ -n "$BIN" ] || { echo "::error::Downloaded archive contains no factorio binary"; exit 1; }
  chmod +x "$BIN"
  # Tarball installs are self-contained: point read-data at the extracted data
  # dir, otherwise the game probes system paths and finds no "core" package.
  # Layout: <install>/bin/<arch>/factorio  ->  data sits at <install>/data
  INSTALL=$(dirname "$(dirname "$(dirname "$BIN")")")
  if [ -d "$INSTALL/data" ]; then READ_DATA="$INSTALL/data"; fi
fi

GAME_VERSION=$("$BIN" --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1) || GAME_VERSION="unknown"
echo "Game version: $GAME_VERSION"
SERIES=$(sed -n 's/.*"factorio_version": *"\([0-9]*\.[0-9]*\).*/\1/p' info.json)
case "$GAME_VERSION" in
  "$SERIES".*) : ;;
  *) echo "::error::info.json targets Factorio $SERIES but binary is $GAME_VERSION"; exit 1 ;;
esac
# 2.1 mod-list format: name+enabled only (version fields cause pattern errors);
# expansion cores (quality, space-age, ...) are auto-added by the game.
cat > "$WORK/mods/mod-list.json" <<EOF
{
  "mods": [
    { "name": "base", "enabled": true },
    { "name": "$NAME", "enabled": true }
  ]
}
EOF

# Headless builds support --create (also runs mod migrations); client builds
# (e.g. local Steam install) accept --dump-data, which still runs the full data
# stage. Both are enough to catch broken prototypes.
# Isolation via fresh config + mod-directory (works on all 2.0 builds).
DATA_RUN="$WORK/data_run"
write_run_config "$DATA_RUN"
COMMON_ARGS=(-c "$DATA_RUN/config.ini" --mod-directory "$WORK/mods")
HELP=$("$BIN" --help 2>&1)
if grep -q -- "--headless" <<<"$HELP"; then
  # Full client build: can enter headless mode and runs migrations via --create.
  LOAD_ARGS=(--headless "${COMMON_ARGS[@]}" --create "$DATA_RUN/testworld.zip")
elif grep -q -- "--window-size" <<<"$HELP"; then
  # GUI-only build (e.g. macOS Steam client): --dump-data still runs data stage.
  echo "GUI-only binary detected; using --dump-data (data stage only)."
  LOAD_ARGS=("${COMMON_ARGS[@]}" --dump-data)
else
  # Dedicated headless build: no --headless flag (it is headless already).
  LOAD_ARGS=("${COMMON_ARGS[@]}" --create "$DATA_RUN/testworld.zip")
fi

if ! "$BIN" "${LOAD_ARGS[@]}" >"$DATA_RUN/stdout.log" 2>&1; then
  echo "::error::Factorio exited non-zero. Last 40 log lines:"
  tail -n 40 "$DATA_RUN/factorio-current.log" 2>/dev/null || cat "$DATA_RUN/stdout.log"
  exit 1
fi
if grep -nE "Error|Failed to (load|parse)" "$DATA_RUN/factorio-current.log" 2>/dev/null; then
  echo "::error::Errors in Factorio log:"
  tail -n 40 "$DATA_RUN/factorio-current.log"
  exit 1
fi
# Guard against a silent pass where the mod was never actually loaded.
if ! grep -q "Loading mod $NAME" "$DATA_RUN/factorio-current.log" 2>/dev/null; then
  echo "::error::Mod $NAME never appeared in the load sequence:"
  tail -n 40 "$DATA_RUN/factorio-current.log"
  exit 1
fi
echo "Data stage OK (Factorio $GAME_VERSION, $NAME $VERSION)"

echo "== [4/4] Runtime stage (--create) =="
# --create loads the mod's control stage (control.lua: event/command
# registration, on_init, migrations). Both the GUI client and the dedicated
# headless build accept it; the client even runs it headless by itself.
RUNTIME_RUN="$WORK/runtime_run"
write_run_config "$RUNTIME_RUN"
RUNTIME_LOG="$RUNTIME_RUN/factorio-current.log"
RUNTIME_OUT="$RUNTIME_RUN/stdout.log"
# A Lua load error during --create is reported on stdout rather than in the log
# file, so both sources are searched and printed - otherwise the reason is lost.
dump_runtime_output() {
  echo "--- factorio-current.log (last 40 lines) ---"
  tail -n 40 "$RUNTIME_LOG" 2>/dev/null || true
  echo "--- stdout (last 40 lines) ---"
  tail -n 40 "$RUNTIME_OUT" 2>/dev/null || true
}
if ! grep -q -- "--create" <<<"$HELP"; then
  # Loud skip: the runtime stage exists, this binary simply cannot run it.
  echo "::warning::This Factorio binary does not offer --create; runtime stage (control.lua) skipped."
else
  if ! "$BIN" -c "$RUNTIME_RUN/config.ini" --mod-directory "$WORK/mods" \
       --create "$RUNTIME_RUN/hst-loadtest.zip" >"$RUNTIME_OUT" 2>&1; then
    echo "::error::Runtime stage (--create) exited non-zero."
    dump_runtime_output
    exit 1
  fi
  # Lua errors in control.lua abort map creation with these signatures; the exit
  # code alone is not enough, some builds still finish the map with errors logged.
  if grep -hnE "Error|Failed to (load|parse)|non-recoverable error" "$RUNTIME_LOG" "$RUNTIME_OUT" 2>/dev/null; then
    echo "::error::Errors in the runtime-stage output:"
    dump_runtime_output
    exit 1
  fi
  # Proof that the control stage really ran: Factorio logs one checksum line per
  # loaded control script, and older builds say "Loading mod X (control.lua)".
  if ! grep -qE "__${NAME}__/control\.lua" "$RUNTIME_LOG" 2>/dev/null &&
     ! grep -qE "__${NAME}__/control\.lua" "$RUNTIME_OUT" 2>/dev/null &&
     ! grep -qE "Loading mod ${NAME}.*control\.lua" "$RUNTIME_LOG" 2>/dev/null; then
    echo "::error::control.lua of $NAME was never loaded in the runtime stage:"
    dump_runtime_output
    exit 1
  fi
  if [ ! -s "$RUNTIME_RUN/hst-loadtest.zip" ]; then
    echo "::error::Runtime stage produced no map file:"
    dump_runtime_output
    exit 1
  fi
  echo "Runtime stage OK (control.lua of $NAME $VERSION loaded, map created)"
fi

echo "Smoke test PASSED"
