-- luacheck-Konfiguration für den HighSpeedTrain-Mod.
-- Geprüft wird die Data-Stufe (data.lua, settings.lua, prototypes/*) und die
-- Control-Stufe in migrations/ (Faktorio-Migrations laufen im Control-Kontext).
std = "lua52"          -- Faktorio bettet Lua 5.2 (mit LuaJIT-Erweiterungen)
max_line_length = 120

-- Faktorio-Idiome, die luachecks Klemmen grundlos melden würden:
-- * Event-Handler behalten ihre volle Signatur, auch bei ungenutzten Argumenten.
-- * Teil-Destrukturierung aus pairs() lässt Folgewerte bewusst ungenutzt.
-- * data:extend(...), force.reset_recipes() usw. sind Faktorio-Methoden, kein
--   Lua-OO mit self.
unused_args = false
unused_secondaries = false
self = false

-- copyPrototype definiert lib.lua global; data.lua lädt es per require in den
-- Global-Raum, die prototypes/*.lua lesen es von dort.
-- Der bewusste Alt-Code in lib.lua (results-Schleife in copyPrototype) bleibt
-- unverändert -- er erzeugt keine Meldung, deshalb hier kein Ignore nötig.
globals = { "copyPrototype" }

-- Von Faktorio gesetzte Globals; read_globals = nur lesen, nicht zuweisen.
read_globals = {
  "data", "settings", "mods", "script", "log", "helpers", "remote",
  "prototypes", "game", "defined",
  -- Faktorio erweitert die mitgelieferte Standardbibliothek (table.deepcopy).
  table = { other_fields = true },
  math = { other_fields = true },
  string = { other_fields = true },
}
