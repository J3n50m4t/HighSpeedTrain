# HighSpeedTrain

Adds high-speed locomotives and matching wagons for fast rail networks: four
locomotive tiers, upgraded cargo and fluid wagons, and a high-speed artillery
wagon. Everything is a modified copy of the vanilla counterpart, so the wagons
behave like the ones you already know.

Current version: 1.4.0, targeting Factorio 2.1 (`factorio_version` in
`info.json`). All numbers below are read back from the game's own data dump
(Factorio 2.1.23), not from memory.

![HighSpeedTrain thumbnail](thumbnail.png)

## Locomotives

`max_speed` is the prototype value; a train drives at the `max_speed` of its
fastest locomotive. The vanilla 2.1 locomotive sits at 1.2, which is what the
"vs vanilla" column compares against.

| Entity | `max_speed` | vs vanilla (1.2) | `max_power` | `braking_force` | weight | health |
|---|---|---|---|---|---|---|
| High-Speed Locomotive | 4 | ≈3.3× | 4000 kW | 90 | 1000 | 800 |
| High-Speed Locomotive Mk2 | 5 | ≈4.2× | 5000 kW | 110 | 1000 | 800 |
| High-Speed Locomotive Mk3 | 7 | ≈5.8× | 7000 kW | 130 | 1000 | 800 |
| High-Speed Locomotive Mk4 | 50 | ≈42× | 7000 kW | 250 | 1000 | 800 |

For reference, vanilla: `max_speed` 1.2, 600 kW, braking force 10, weight 2000,
health 1000. The high-speed locos are lighter, stronger-powered and brake far
harder, but are slightly less tough.

## Wagons

| Entity | Capacity / inventory | `braking_force` | weight | health |
|---|---|---|---|---|
| High-Speed Cargo Wagon | 100 slots (vanilla: 40) | 50 | 1000 | 800 |
| High-Speed Cargo Wagon Mk2 | 100 slots (vanilla: 40) | 250 | 1000 | 800 |
| High-Speed Fluid Wagon | 111,000 (vanilla: 50,000) | 50 | 2500 | 800 |
| High-Speed Fluid Wagon Mk2 | 111,000 (vanilla: 50,000) | 250 | 2500 | 800 |
| High-Speed Artillery Wagon | artillery stats unchanged from vanilla (gun, ammo, range) | 50 | 4000 | 1000 |

Wagon capacity and inventory use the live 2.1 fields (`capacity`,
`inventory_size`). Wagons do not carry a speed value any more — see
"Factorio 2.1 notes".

## Startup settings

Both are startup settings: switch them on when you create the map. Verified by
running the data stage with both switched on. The shipped migration
(`migrations/1.2.0.lua`) resets recipes and technologies on existing saves, so
unlock state lines up again after an update.

| Setting (internal name) | Default | Effect |
|---|---|---|
| High-speed trains do not need fuel (`highspeedtrain-no-fuel`) | off | All four high-speed locomotives get a `void` energy source and run without fuel. Vanilla locomotives are untouched. |
| Free recipes and instant unlocks (`highspeedtrain-free-mode`) | off | All nine HighSpeedTrain recipes become ingredient-free and are enabled right away; the nine technologies are hidden, lose prerequisites and unlock effects, and shrink to a single automation pack in 1 s. |

## Research and crafting (default mode)

Technology tree — the technologies are named after the tier, the recipes after the
entity, so `highspeedtrain` unlocks the `highspeed-locomotive` recipe:

```
braking-force-2 ─► highspeedtrain ─┬─► highspeedtrainmk2 ─► highspeedtrainmk3 ─► highspeedtrainmk4
                                   ├─► highspeedcargo ─► highspeedcargomk2
                                   ├─► highspeedfluid ─► highspeedfluidmk2
                                   └─► highspeedartillery  (also needs vanilla "artillery")
```

Recipes are built from vanilla parts, and each tier consumes the previous one:

| Recipe | Ingredients |
|---|---|
| High-Speed Locomotive | 1 locomotive, 20 processing units, 10 speed modules |
| High-Speed Locomotive Mk2 | 1 High-Speed Locomotive, 20 processing units, 10 speed modules 2 |
| High-Speed Locomotive Mk3 | 1 Mk2 loco, 20 processing units, 10 speed modules 2 |
| High-Speed Locomotive Mk4 | 3 Mk3 locos, 250 processing units, 10 speed modules 3 |
| High-Speed Cargo Wagon | 3 cargo wagons, 20 processing units, 10 speed modules |
| High-Speed Cargo Wagon Mk2 | 5 High-Speed Cargo Wagons, 250 processing units, 10 speed modules |
| High-Speed Fluid Wagon | 3 fluid wagons, 20 processing units, 10 speed modules, 100 lubricant |
| High-Speed Fluid Wagon Mk2 | 5 High-Speed Fluid Wagons, 250 processing units, 10 speed modules, 100 lubricant |
| High-Speed Artillery Wagon | 1 artillery wagon, 40 processing units, 20 electric engine units, 10 speed modules 2 |

The fluid wagon recipes are `crafting-with-fluid` (as in 2.1). Research costs
follow the tier: the top-tier technologies (`highspeedtrainmk4`,
`highspeedcargomk2`, `highspeedfluidmk2`) ask for 200 packs of all seven
science types.

## Mk4: intentionally extreme

The Mk4 sits at `max_speed` 50 — about 42 times the vanilla locomotive, and
roughly 7 times the Mk3. That is on purpose: it is an endgame, "because I can"
locomotive, priced accordingly (3 Mk3 locos, 250 processing units, 10 speed
modules 3, plus 200 packs of every science type). Its braking force of 250 is
the highest of the four, but it grows far less than the speed does: 2.8 times the
Mk1's braking force for 12.5 times its speed. Stopping therefore takes far more
track than with the lower tiers, so the Mk4 belongs on long, dedicated,
well-blocked mainlines. If you want a fast network that still behaves sanely,
stop at Mk3.

## Factorio 2.1 notes

- **Train speed comes from locomotives only.** In 2.1 no wagon prototype has a
  `max_speed` field — not the vanilla wagons, and not this mod's wagons
  (confirmed by dumping `data.raw`). A train's top speed is the highest
  `max_speed` among its locomotives. Weight and braking force of wagons still
  matter for acceleration and stopping, which is why the Mk2 wagons are mostly
  about braking force (250 instead of 50), not about speed.
- **Fluid wagon capacity** is set through the 2.1 field `capacity`. The pre-2.1
  names `total_capacity` and `pumping_speed` are not part of the 2.1 fluid-wagon
  prototype at all (they appear nowhere in the data dump), so they are not used
  here.
- **Quality.** In 2.1, whether a quality tier scales a stat is decided per
  prototype by flags like `quality_affects_max_speed`,
  `quality_affects_inventory_size` and `quality_affects_capacity`. Base sets
  those to `true` for its own prototypes in a data phase that runs *after* this
  mod's copy step (`Loading mod HighSpeedTrain (data.lua)` precedes
  `Loading mod base (data-updates.lua)`), so this mod sets the flags itself.
  A quality tier scales HighSpeedTrain locomotive speed, cargo-wagon inventory
  and fluid-wagon capacity just like it does for the matching vanilla wagon;
  the artillery wagon carries no such flag because the vanilla artillery wagon
  has none either.
- **Recipes** use the merged 2.1 `categories` field; the pre-2.0
  `category`/`additional_categories` pair is rejected by the loader.

## Testing and contributing

```sh
luacheck .
```

```sh
FACTORIO_BIN="$HOME/Library/Application Support/Steam/steamapps/common/Factorio/factorio.app/Contents/MacOS/factorio" \
  ./scripts/smoke-test.sh
```

`scripts/smoke-test.sh` checks `info.json`, lints Lua syntax, packs the current
checkout into a temporary mods directory and loads it through the data stage of
a headless/isolated Factorio, then fails if the log contains errors or if the
mod never appeared in the load sequence. Without `FACTORIO_BIN` it downloads the
current stable headless tarball anonymously, which is what CI does. The
smoke-test workflow (`.github/workflows/smoke-test.yml`) runs `luacheck .` and
the smoke test on pushes to `main` and `dev`, on pull requests and manually;
releases to the Mod Portal happen from `main` via `.github/workflows/release.yml`
(semantic-release), so please send PRs against `dev` and use
conventional-commit messages (`feat:`, `fix:`, `chore:` …).

Localization lives in `locale/en` and `locale/de` — translations of the entity,
technology and setting strings are easy wins. Issues and pull requests on
GitHub: <https://github.com/J3n50m4t/HighSpeedTrain>.

Authors: J3n50m4t and Ostrei.
