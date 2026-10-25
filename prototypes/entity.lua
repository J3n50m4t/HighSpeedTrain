local no_fuel = settings.startup["highspeedtrain-no-fuel"] and settings.startup["highspeedtrain-no-fuel"].value

-- Mk4-Tempo in Prozent des Referenzwerts (50 = 100 %): bewusster Regler, um den
-- Mk4-Ausreisser nach oben zu entschaerfen. Skaliert NUR max_speed von Mk4.
local mk4_speed_setting = settings.startup["highspeedtrain-mk4-speed-percent"]
local mk4_speed_percent = (mk4_speed_setting and mk4_speed_setting.value) or 100
local MK4_MAX_SPEED_REFERENCE = 50.0

local function apply_energy_source(prototype)
  if no_fuel then
    prototype.energy_source = { type = "void" }
  end
end

-- Akustik pro Mk-Stufe: ausschliesslich das Vanilla-Soundmaterial der locomotive, so
-- wie der base-Dump es in working_sound.main_sounds hinterlegt (Index 1
-- train-engine-driving.ogg, Index 2 train-engine.ogg = Idle-Droehnlayer, Index 3
-- train-wheels.ogg). Die Mod nennt keine eigene Audiodatei und setzt nur Felder, die
-- der base-Dump im Vanilla-Soundmuster auch wirklich zeigt:
-- * Subset der main_sounds: Mk2/Mk4 ohne Idle-Droehnlayer (klingt hoeher/motorischer),
--   Mk3 mit allen drei Layern und max_sounds_per_prototype 3 statt 2 (base nutzt fuer
--   dieses Feld 1..20) - die Layer hoeren sich gleichzeitig an, also druckvoller.
-- * activity_to_speed_modifiers.maximum: Vanilla-Feld desselben Sounds, Dump-Werte
--   1.15/1.2/1.4. Schnellere Loks pitchen Antriebs- und Radgeraeusch mit der Aktivitaet
--   weiter hoch. Kein erfundenes Pitch-Feld.
-- * audible_distance_modifier am Einzel-Sound: Feld der SoundPrototype mit Vanilla-
--   Werten 0.2..6.25 (innerhalb von working_sound nutzt base 0.2..0.8, lautere
--   Effekte wie Explosionen 3.8). Wir nehmen ausschliesslich im base-Dump belegte
--   Werte: 1.45 (Mk2) / 1.7 (Mk3) / 2 (Mk4) - die Lok ist hoeher stufig frueher/laenger
--   hoerenbar. apparent_volume, audible_distance, play_type und pitch-Felder kommen im
--   gesamten base-Dump nirgends vor und bleiben deshalb ungenutzt.
-- Mk1 bleibt unangetastet und verhaelt sich akustisch exakt wie die Vanilla-Lok.
local IDLE_SOUND_INDEX = 2 -- main_sounds[2] = __base__/sound/train-engine.ogg

local function drop_idle_sound_layer(prototype)
  table.remove(prototype.working_sound.main_sounds, IDLE_SOUND_INDEX)
end

local function set_sound_audible_distance(prototype, modifier)
  for _, entry in ipairs(prototype.working_sound.main_sounds) do
    entry.sound.audible_distance_modifier = modifier
  end
end

-- Wirkt nur auf Layer, die diesen Vanilla-Block bereits haben (drive + wheels).
local function set_speed_pitch_ceiling(prototype, maximum)
  for _, entry in ipairs(prototype.working_sound.main_sounds) do
    if entry.activity_to_speed_modifiers then
      entry.activity_to_speed_modifiers.maximum = maximum
    end
  end
end

-- Quality-Skalierung: base setzt quality_affects_* erst in data-updates.lua, also
-- NACH unserer data.lua - copyPrototype kann die Vanilla-Flags nicht erben, unsere
-- Kopien haetten ohne diese Zuweisungen nil und Quality wirke nicht. Wir setzen pro
-- Proto ausschliesslich das Feld, das das Vanilla-Vorbild laut base-Dump hat:
-- locomotive -> max_speed, cargo-wagon -> inventory_size, fluid-wagon -> capacity.
-- artillery-wagon hat in Vanilla kein quality_affects_*-Feld, bleibt deshalb leer.
--
-- Farbcodierung pro Mk-Stufe: color (Fahrzeug auf der Karte) ist pro Stufe eindeutig
-- und gleich der RGB des Icon-Tints in item.lua/recipe.lua (dort alpha 1.0):
-- Mk1 Blau, Mk2 Cyan, Mk3 Orange, Mk4 Rot. Auf der Karte unterscheidbar, dezent genug
-- fuer den Vanilla-Kartenhintergrund. Wagen bleiben bei Vanilla-color (nur Icons getaenmt).

local highspeed_loco = copyPrototype("locomotive", "locomotive", "highspeed-locomotive")
highspeed_loco.icon = "__base__/graphics/icons/locomotive.png"
highspeed_loco.color = {r = 0.10, g = 0.19, b = 0.80, a = 0.5}
highspeed_loco.weight = 1000
highspeed_loco.max_speed = 4 --860.km/h
highspeed_loco.quality_affects_max_speed = true
highspeed_loco.max_power = "4000kW"
highspeed_loco.reversing_power_modifier = 0.5 --no effect on automatic trains
highspeed_loco.braking_force = 90
highspeed_loco.friction_force = 1
highspeed_loco.air_resistance = 0.0005
highspeed_loco.max_health = 800
apply_energy_source(highspeed_loco)
-- working_sound hier bewusst NICHT gesetzt: Mk1 erbt das Vanilla-working_sound der
-- locomotive unveraendert (3 Layer, max_sounds_per_prototype 2).


local highspeed_locomk2 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk2.color = {r = 0.05, g = 0.55, b = 0.75, a = 0.5}
highspeed_locomk2.weight = 1000
highspeed_locomk2.max_speed = 5 --860.km/h
highspeed_locomk2.quality_affects_max_speed = true
highspeed_locomk2.max_power = "5000kW"
highspeed_locomk2.reversing_power_modifier = 0.5 --no effect on automatic trains
highspeed_locomk2.braking_force = 110
highspeed_locomk2.friction_force = 1
highspeed_locomk2.air_resistance = 0.0005
highspeed_locomk2.max_health = 800
apply_energy_source(highspeed_locomk2)
-- Akustik Mk2: Idle-Droehnlayer (train-engine.ogg) raus, Antriebs- und Radgeraeusch
-- dafuer 1.45x weiter hoerenbar -> schlanke, naeher am Vanilla-Brummen liegende Variante.
drop_idle_sound_layer(highspeed_locomk2)
set_sound_audible_distance(highspeed_locomk2, 1.45)

local highspeed_locomk3 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk3.color = {r = 0.85, g = 0.45, b = 0.10, a = 0.5}
highspeed_locomk3.weight = 1000
highspeed_locomk3.max_speed = 7 --860.km/h
highspeed_locomk3.quality_affects_max_speed = true
highspeed_locomk3.max_power = "7000kW"
highspeed_locomk3.reversing_power_modifier = 0.5 --no effect on automatic trains
highspeed_locomk3.braking_force = 130
highspeed_locomk3.friction_force = 1
highspeed_locomk3.air_resistance = 0.0005
highspeed_locomk3.max_health = 800
apply_energy_source(highspeed_locomk3)
-- Akustik Mk3: alle drei Vanilla-Layer bleiben, aber max_sounds_per_prototype 3 statt 2
-- laesst sie gleichzeitig spielen (druckvoller); das Antriebsgeraeusch pitcht mit der
-- Aktivitaet bis 1.2 statt 1.15 (Radgeraeusch hat in Vanilla bereits 1.2) und der Sound
-- ist 1.7x weiter hoerenbar.
highspeed_locomk3.working_sound.max_sounds_per_prototype = 3
set_sound_audible_distance(highspeed_locomk3, 1.7)
set_speed_pitch_ceiling(highspeed_locomk3, 1.2)

local highspeed_locomk4 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK4")
highspeed_locomk4.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk4.color = {r = 0.85, g = 0.10, b = 0.10, a = 0.5}
highspeed_locomk4.weight = 1000
highspeed_locomk4.max_speed = MK4_MAX_SPEED_REFERENCE * mk4_speed_percent / 100
highspeed_locomk4.quality_affects_max_speed = true
highspeed_locomk4.max_power = "7000kW"
highspeed_locomk4.reversing_power_modifier = 0.5 --no effect on automatic trains
highspeed_locomk4.braking_force = 250
highspeed_locomk4.friction_force = 1
highspeed_locomk4.air_resistance = 0.0005
highspeed_locomk4.max_health = 800
apply_energy_source(highspeed_locomk4)
-- Akustik Mk4 (50 m/s Referenztempo): Idle-Droehnen raus, dafuer Antrieb+Raeder bis 1.4
-- hochgepitcht und 2x hoerenbar - die markanteste Stufe, aber weiterhin reines
-- Vanilla-Soundmaterial ohne eigene Audiodatei.
drop_idle_sound_layer(highspeed_locomk4)
set_speed_pitch_ceiling(highspeed_locomk4, 1.4)
set_sound_audible_distance(highspeed_locomk4, 2)

local highspeed_cargo = copyPrototype("cargo-wagon", "cargo-wagon", "highspeed-cargo-wagon")
highspeed_cargo.braking_force = 50
highspeed_cargo.icon = "__base__/graphics/icons/cargo-wagon.png"
highspeed_cargo.inventory_size = 100;
highspeed_cargo.quality_affects_inventory_size = true
highspeed_cargo.max_health = 800

local highspeed_cargomk2 = copyPrototype("cargo-wagon", "cargo-wagon", "highspeed-cargo-wagonMK2")
highspeed_cargomk2.braking_force = 250
highspeed_cargomk2.icon = "__base__/graphics/icons/cargo-wagon.png"
highspeed_cargomk2.inventory_size = 100;
highspeed_cargomk2.quality_affects_inventory_size = true
highspeed_cargomk2.max_health = 800

-- Mk3: doppeltes Inventar (200 = 5x Vanilla-40). Bremskraft wie Mk2 (250), weil Wagen
-- in 2.1 keinen max_speed mehr haben. Auch hier setzt die Mod den
-- quality_affects_inventory_size-Flag selbst (base setzt ihn erst in data-updates.lua).
local highspeed_cargomk3 = copyPrototype("cargo-wagon", "cargo-wagon", "highspeed-cargo-wagonMK3")
highspeed_cargomk3.braking_force = 250
highspeed_cargomk3.icon = "__base__/graphics/icons/cargo-wagon.png"
highspeed_cargomk3.inventory_size = 200
highspeed_cargomk3.quality_affects_inventory_size = true
highspeed_cargomk3.max_health = 800

local highspeed_fluid = copyPrototype("fluid-wagon", "fluid-wagon", "highspeed-fluid-wagon")
highspeed_fluid.capacity = 37000 * 3
highspeed_fluid.quality_affects_capacity = true
highspeed_fluid.weight = 2500
highspeed_fluid.braking_force = 50
highspeed_fluid.icon = "__base__/graphics/icons/fluid-wagon.png";
highspeed_fluid.max_health = 800

local highspeed_fluidMK2 = copyPrototype("fluid-wagon", "fluid-wagon", "highspeed-fluid-wagonMK2")
highspeed_fluidMK2.capacity = 37000 * 3
highspeed_fluidMK2.quality_affects_capacity = true
highspeed_fluidMK2.weight = 2500
highspeed_fluidMK2.braking_force = 250
highspeed_fluidMK2.icon = "__base__/graphics/icons/fluid-wagon.png";
highspeed_fluidMK2.max_health = 800

-- Mk3: doppelte Kapazitaet (222000 = 2x der 111000 von Mk1/Mk2, 4.44x Vanilla-50000).
-- weight/braking_force/max_health wie Mk2 (2500/250/800), weil Wagen in 2.1 keinen
-- max_speed mehr haben. Auch hier setzt die Mod den quality_affects_capacity-Flag
-- selbst (base setzt ihn erst in data-updates.lua, nach unserer data.lua).
local highspeed_fluidMK3 = copyPrototype("fluid-wagon", "fluid-wagon", "highspeed-fluid-wagonMK3")
highspeed_fluidMK3.capacity = 37000 * 6 -- 222000
highspeed_fluidMK3.quality_affects_capacity = true
highspeed_fluidMK3.weight = 2500
highspeed_fluidMK3.braking_force = 250
highspeed_fluidMK3.icon = "__base__/graphics/icons/fluid-wagon.png";
highspeed_fluidMK3.max_health = 800

local highspeed_artillery = copyPrototype("artillery-wagon", "artillery-wagon", "highspeed-artillery-wagon")
highspeed_artillery.braking_force = 50
highspeed_artillery.icon = "__base__/graphics/icons/artillery-wagon.png"
highspeed_artillery.max_health = 1000
-- bewusst kein quality_affects_*: das Vanilla-Vorbild (artillery-wagon) hat keins


data:extend({
  highspeed_loco,
  highspeed_locomk2,
  highspeed_locomk3,
  highspeed_locomk4,
  highspeed_cargo,
  highspeed_cargomk2,
  highspeed_cargomk3,
  highspeed_fluid,
  highspeed_fluidMK2,
  highspeed_fluidMK3,
  highspeed_artillery
})
