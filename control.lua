-- HighSpeedTrain: Control-Stufe (Runtime). Der Mod ist im Kern ein Data-Mod;
-- diese Control-Stufe ist bewusst duenn und macht nichts pro Tick, sondern
-- haengt nur an drei Stellen:
--
--   * init / Konfigurationswechsel: Versions-Stempel in storage, damit ein
--     Spielstand weiss, welcher Mod-Stand ihn zuletzt angefasst hat.
--   * on_train_created: Der neu angelegte Zug wird genau einmal gelesen. Nutzt er
--     zwei oder mehr verschiedene HighSpeedTrain-Lokstufen, kommt ein kurzer
--     Hinweis im Chat. Ausserdem merken wir uns jeden Highspeed-Fahrzeugtyp, der
--     dabei vorkam - genau diese Liste liefert /hst-info zurueck (ehrlich und
--     billig, statt dafuer bei jedem Aufruf die ganze Karte abzusuchen).

-- Version zur Laufzeit aus der aktiven Mod-Liste lesen: semantic-release bumpet
-- nur info.json, ein hartkodierter String waere nach jedem Release veraltet.
local MOD_VERSION = script.active_mods["HighSpeedTrain"] or "dev"

-- Die Lokomotiven des Mods heissen highspeed-locomotive, ...MK2, ...MK3, ...MK4.
-- Die Vanilla-Lok heisst nur "locomotive", das Praefix trifft sie also nicht.
local LOCO_PREFIX = "highspeed-locomotive"

-- Alle Wagons des Mods: highspeed-cargo-wagon*, highspeed-fluid-wagon*,
-- highspeed-artillery-wagon.
local WAGON_PREFIX = "highspeed-"

-- Ein Zug faehrt so schnell wie seine schnellste Lok (in 2.1 hat kein Waggon
-- mehr max_speed); gemischte Stufen bedeuten deshalb unterschiedliche
-- Bremswerte in einem Zugverband, kaum vorhersehbar fuer den Fahrplan.
-- LuaTrain hat in 2.1 kein name-Feld mehr (das Konzept "Zugname" wurde in 2.0
-- entfernt), deshalb stattdessen eine Ortsangabe im Text.
local MIXED_LOCO_WARNING =
  "[HighSpeedTrain] Ein Zug%s nutzt %d verschiedene Hochspeed-Lokstufen (%s). " ..
  "Ein Zug fährt so schnell wie seine schnellste Lok, Bremskraft und " ..
  "Beschleunigung mischen sich dabei - besser pro Zug nur eine Stufe einsetzen."

local function starts_with(name, prefix)
  return type(name) == "string" and name:sub(1, #prefix) == prefix
end

local function bump(counts, name)
  counts[name] = (counts[name] or 0) + 1
end

-- Zaehlt die Namen einer Entity-Liste (LuaTable von LuaEntity) in counts und
-- gibt die erste gueltige Entity zurueck (fuer die Ortsangabe der Warnung).
-- Defensiv: Liste kann fehlen, Entities koennen beim Zug-Event bereits ungueltig
-- sein (z.B. wenn ein anderer Mod den Zug im selben Tick aufloest).
local function collect(counts, list)
  local first = nil
  if list then
    for index = 1, #list do
      local entity = list[index]
      if entity and entity.valid and entity.name then
        bump(counts, entity.name)
        if not first then first = entity end
      end
    end
  end
  return first
end

-- Stufen-Kurzfassung fuer die Warnung: highspeed-locomotive -> Mk1,
-- highspeed-locomotiveMK3 -> Mk3 (der Prototyptail heisst MK3, im Text Mk3).
local function tier_label(name)
  local suffix = name:sub(#LOCO_PREFIX + 1)
  if suffix == "" then return "Mk1" end
  if suffix:sub(1, 2) == "MK" then return "Mk" .. suffix:sub(3) end
  return suffix
end

-- sortierte Namen aus einer Zaehltabelle (stabile Reihenfolge in der Ausgabe)
local function sorted_names(counts)
  local names = {}
  for name in pairs(counts) do names[#names + 1] = name end
  table.sort(names)
  return names
end

local function stamp_version()
  storage.hst_version = MOD_VERSION
  storage.hst_loco_types = storage.hst_loco_types or {}
  storage.hst_wagon_types = storage.hst_wagon_types or {}
end

script.on_init(stamp_version)
script.on_configuration_changed(stamp_version)

-- In 2.x liegen die Ereignisse mit on_-Praefix in defines.events; die alten Namen
-- ohne Praefix sind dort nil, was script.on_event sofort mit einem Ladeehler
-- quittiert. Das faengt die Runtime-Stufe des Smoke-Tests ab.
script.on_event(defines.events.on_train_created, function(event)
  local train = event.train
  if not train or not train.valid then return end

  local locos, wagons, first_loco = {}, {}, nil
  local locomotives = train.locomotives
  if locomotives then
    local front = collect(locos, locomotives.front_movers)
    local back = collect(locos, locomotives.back_movers)
    first_loco = front or back
  end
  -- Die Wagensammlung heisst in 2.1 carriages; der fruehere Name cars ist dort
  -- kein Schluessel von LuaTrain und wirft beim Zugriff eine Laufzeitfehler-
  -- meldung. carriages enthaelt in 2.x auch die Loks, der Wagondurchlauf unten
  -- wirft Prototypen mit dem Lok-Praefix deshalb wieder raus.
  collect(wagons, train.carriages)

  local hst_locos = {}
  for name, count in pairs(locos) do
    if starts_with(name, LOCO_PREFIX) then
      hst_locos[name] = count
      storage.hst_loco_types[name] = (storage.hst_loco_types[name] or 0) + count
    end
  end
  for name, count in pairs(wagons) do
    if starts_with(name, WAGON_PREFIX) and not starts_with(name, LOCO_PREFIX) then
      storage.hst_wagon_types[name] = (storage.hst_wagon_types[name] or 0) + count
    end
  end

  local mixed = sorted_names(hst_locos)
  if #mixed >= 2 then
    local tiers = {}
    for index = 1, #mixed do tiers[index] = tier_label(mixed[index]) end
    local spot = ""
    if first_loco then
      spot = string.format(" bei x=%d y=%d", math.floor(first_loco.position.x), math.floor(first_loco.position.y))
    end
    game.print(string.format(MIXED_LOCO_WARNING, spot, #mixed, table.concat(tiers, " + ")))
  end
end)

-- /hst-info: Version plus die Hochspeed-Fahrzeugtypen, die auf dieser Karte
-- schon beim Zug-Anlegen gesehen wurden (storage-Zaehler, kein Karten-Scan).
commands.add_command("hst-info",
  "HighSpeedTrain: Version und die auf dieser Karte gesehenen Hochspeed-Fahrzeugtypen anzeigen",
  function(event)
    local loco_names = sorted_names(storage.hst_loco_types or {})
    local wagon_names = sorted_names(storage.hst_wagon_types or {})
    local function listed(names)
      return #names > 0 and table.concat(names, ", ") or "keine"
    end

    local text = "HighSpeedTrain " .. MOD_VERSION .. "\n" ..
      "Gesehene Hochspeed-Lokomotiven (" .. #loco_names .. "): " .. listed(loco_names) .. "\n" ..
      "Gesehene Hochspeed-Wagons (" .. #wagon_names .. "): " .. listed(wagon_names) .. "\n" ..
      "Gezählt wird beim Anlegen von Zügen (on_train_created); Züge, die vor der " ..
      "Installation des Mods schon fuhren, tauchen erst nach einer Neuanlage auf."

    -- Antwort: game.print an alle (in 2.1 gibt es im Kommando-Event kein
    -- command_source-Feld, das Feld heisst "parameter"), zusaetzlich der
    -- command_result fuer die aufrufende Konsole.
    game.print(text)
    return { return_message = text }
  end)
