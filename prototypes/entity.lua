local highspeed_loco = copyPrototype("locomotive", "locomotive", "highspeed-locomotive")
highspeed_loco.icon = "__base__/graphics/icons/locomotive.png"
highspeed_loco.color = {r = 0.10, g = 0.19, b = 0.80, a = 0.5}
highspeed_loco.weight = 1000
highspeed_loco.max_speed = 4 --860.km/h
highspeed_loco.max_power = "4000kW"
highspeed_loco.reversing_power_modifier = 0.5 --no effect on automatic trains
highspeed_loco.braking_force = 90
highspeed_loco.friction_force = 1
highspeed_loco.air_resistance = 0.0005
highspeed_loco.burner.effectivity = 0.73
highspeed_loco.burner.fuel_inventory_size = 8
highspeed_loco.max_health = 800


local highspeed_locomk2 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk2.color = {r = 0.10, g = 0.19, b = 0.80, a = 0.5}
highspeed_locomk2.weight = 1000
highspeed_locomk2.max_speed = 5 --860.km/h
highspeed_locomk2.max_power = "5000kW"
highspeed_locomk2.reversing_power_modifier = 0.5 --no effect on automatic trains
highspeed_locomk2.braking_force = 110
highspeed_locomk2.friction_force = 1
highspeed_locomk2.air_resistance = 0.0005
highspeed_locomk2.burner.effectivity = 0.63
highspeed_locomk2.burner.fuel_inventory_size = 8
highspeed_locomk2.max_health = 800

local highspeed_locomk3 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk3.color = {r = 0.10, g = 0.19, b = 0.80, a = 0.5}
highspeed_locomk3.weight = 1000
highspeed_locomk3.max_speed = 7 --860.km/h
highspeed_locomk3.max_power = "7000kW"
highspeed_locomk3.reversing_power_modifier = 0.5 --no effect on automatic trains
highspeed_locomk3.braking_force = 130
highspeed_locomk3.friction_force = 1
highspeed_locomk3.air_resistance = 0.0005
highspeed_locomk3.burner.effectivity = 0.5
highspeed_locomk3.burner.fuel_inventory_size = 12
highspeed_locomk3.max_health = 800

local highspeed_locomk4 = copyPrototype("locomotive", "locomotive", "highspeed-locomotiveMK4")
highspeed_locomk4.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk4.color = {r = 0.10, g = 0.19, b = 0.80, a = 0.5}
highspeed_locomk4.weight = 1000
highspeed_locomk4.max_speed = 50
highspeed_locomk4.max_power = "7000kW"
highspeed_locomk4.reversing_power_modifier = 0.5 --no effect on automatic trains
highspeed_locomk4.braking_force = 250
highspeed_locomk4.friction_force = 1
highspeed_locomk4.air_resistance = 0.0005
highspeed_locomk4.burner.effectivity = 0.2
highspeed_locomk4.burner.fuel_inventory_size = 36
highspeed_locomk4.max_health = 800

local highspeed_cargo = copyPrototype("cargo-wagon", "cargo-wagon", "highspeed-cargo-wagon")
highspeed_cargo.max_speed = 10
highspeed_cargo.braking_force = 50
highspeed_cargo.icon = "__base__/graphics/icons/cargo-wagon.png"
highspeed_cargo.inventory_size = 100;
highspeed_cargo.max_health = 800

local highspeed_fluid = copyPrototype("fluid-wagon", "fluid-wagon", "highspeed-fluid-wagon")
highspeed_fluid.total_capacity = 37000 * 3
highspeed_fluid.weight = 2500
highspeed_fluid.max_speed = 10
highspeed_fluid.braking_force = 50
highspeed_fluid.icon = "__base__/graphics/icons/fluid-wagon.png";
highspeed_cargo.max_health = 800


data:extend({
  highspeed_loco,
  highspeed_locomk2,
  highspeed_locomk3,
  highspeed_locomk4,
  highspeed_cargo,
  highspeed_fluid
})
