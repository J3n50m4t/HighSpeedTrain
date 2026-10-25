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
highspeed_loco.icon_size = 32
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


local highspeed_locomk2 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk2.icon_size = 32
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

local highspeed_locomk3 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk3.icon_size = 32
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

local highspeed_locomk4 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK4")
highspeed_locomk4.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk4.icon_size = 32
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
  highspeed_artillery
})
