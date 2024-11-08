
local highspeed_loco = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotive")
highspeed_loco.icon = "__base__/graphics/icons/locomotive.png"
highspeed_loco.order = "a[train-system]-f[highspeed-locomotive]"

local highspeed_locomk2 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk2.order = "a[train-system]-f[highspeed-locomotiveMK2]"

local highspeed_locomk3 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk3.order = "a[train-system]-f[highspeed-locomotiveMK3]"

local highspeed_locomk4 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK4")
highspeed_locomk4.icon = "__base__/graphics/icons/locomotive.png"
highspeed_locomk4.order = "a[train-system]-f[highspeed-locomotiveMK4]"

local highspeed_cargo = copyPrototype("item-with-entity-data", "cargo-wagon", "highspeed-cargo-wagon")
highspeed_cargo.icon = "__base__/graphics/icons/cargo-wagon.png"
highspeed_cargo.order = "a[train-system]-f[highspeed-wagon]"

local highspeed_cargomk2 = copyPrototype("item-with-entity-data", "cargo-wagon", "highspeed-cargo-wagonMK2")
highspeed_cargomk2.icon = "__base__/graphics/icons/cargo-wagon.png"
highspeed_cargomk2.order = "a[train-system]-f[highspeed-wagon]"

local highspeed_fluid = copyPrototype("item-with-entity-data", "fluid-wagon", "highspeed-fluid-wagon")
highspeed_fluid.icon = "__base__/graphics/icons/fluid-wagon.png"
highspeed_fluid.order = "a[train-system]-f[highspeed-cluid-wagon]"

local highspeed_fluidmk2 = copyPrototype("item-with-entity-data", "fluid-wagon", "highspeed-fluid-wagonMK2")
highspeed_fluidmk2.icon = "__base__/graphics/icons/fluid-wagon.png"
highspeed_fluidmk2.order = "a[train-system]-f[highspeed-cluid-wagon]"


data:extend({
  highspeed_loco,
  highspeed_locomk2,
  highspeed_locomk3,
  highspeed_locomk4,
  highspeed_cargo,
  highspeed_cargomk2,
  highspeed_fluid,
  highspeed_fluidmk2
})
