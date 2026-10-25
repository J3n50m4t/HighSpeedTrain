#!/usr/bin/env bash
# Smoke test: package the mod and load it in headless Factorio.
# Catches broken prototypes, Lua errors and missing locale during data stage.
#
# Modes:
#   FACTORIO_BIN=/path/to/factorio   use an existing binary (local dev)
#   FACTORIO_USERNAME + FACTORIO_TOKEN set -> download latest 2.0 headless (CI)
#   neither available                -> Lua/info.json checks only, with warning
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

NAME=$(sed -n 's/.*"name": *"\([^"]*\)".*/\1/p' info.json)
VERSION=$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' info.json)
[ -n "$NAME" ] && [ -n "$VERSION" ] || { echo "::error::Could not read name/version from info.json"; exit 1; }

# Always smoke-test the current checkout (CI: commit state, locally: working tree).
WORK=$(mktemp -d "${TMPDIR:-/tmp}/hst-smoke.XXXXXX")
trap 'rm -rf "$WORK"' EXIT

echo "== [1/3] Static checks =="
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

echo "== [2/3] Package mod =="
STAGE="$WORK/mods_stage/$NAME\_$VERSION"
mkdir -p "$STAGE"
git ls-files -co --exclude-standard | grep -v -E '^(\.git/|\.github/|\.vscode/|scripts/|\.releaserc$|\.gitignore$)' | while IFS= read -r f; do
  mkdir -p "$STAGE/$(dirname "$f")"
  cp "$f" "$STAGE/$f"
done
mkdir -p "$WORK/mods"
(cd "$WORK/mods_stage" && zip -qr "$WORK/mods/${NAME}_${VERSION}.zip" "$NAME\_$VERSION")
echo "Packed: ${NAME}_${VERSION}.zip"

echo "== [3/3] Headless data-stage load =="
BIN="${FACTORIO_BIN:-}"
if [ -z "$BIN" ]; then
  # Current stable headless tarball is publicly downloadable (no account).
  echo "Downloading current stable Factorio headless (linux64, anonymous)..."
  curl -fsSL "https://factorio.com/get-download/stable/headless/linux64" -o "$WORK/factorio.tar.xz"
  mkdir -p "$WORK/fbin"
  tar -xJf "$WORK/factorio.tar.xz" -C "$WORK/fbin"
  BIN=$(find "$WORK/fbin" -type f -name factorio -path "*/bin/*" | head -n1)
  [ -n "$BIN" ] || { echo "::error::Downloaded archive contains no factorio binary"; exit 1; }
  chmod +x "$BIN"
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
# (e.g. local Steam install) only support --dump-data, which still runs the
# full data stage. Both are enough to catch broken prototypes.
# Isolation via fresh config + mod-directory (works on all 2.0 builds).
mkdir -p "$WORK/config"
# Minimal config: keep all writes (log, dumps, cache) inside $WORK, leave the
# real user install untouched. Factorio fills the remaining defaults itself.
cat > "$WORK/config/config.ini" <<EOF
[path]
write-data=$WORK
EOF
COMMON_ARGS=(-c "$WORK/config/config.ini" --mod-directory "$WORK/mods")
if "$BIN" --help 2>&1 | grep -q -- "--headless"; then
  LOAD_ARGS=(--headless "${COMMON_ARGS[@]}" --create "$WORK/testworld.zip")
else
  echo "Binary has no --headless; using --dump-data (data stage only)."
  LOAD_ARGS=("${COMMON_ARGS[@]}" --dump-data)
fi

if ! "$BIN" "${LOAD_ARGS[@]}" >"$WORK/stdout.log" 2>&1; then
  echo "::error::Factorio exited non-zero. Last 40 log lines:"
  tail -n 40 "$WORK/factorio-current.log" 2>/dev/null || cat "$WORK/stdout.log"
  exit 1
fi
if grep -nE "Error|Failed to (load|parse)" "$WORK/factorio-current.log" 2>/dev/null; then
  echo "::error::Errors in Factorio log:"
  tail -n 40 "$WORK/factorio-current.log"
  exit 1
fi
echo "Headless load OK (Factorio $GAME_VERSION, $NAME $VERSION)"
echo "Smoke test PASSED"
