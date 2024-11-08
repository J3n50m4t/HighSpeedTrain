local highspeed_loco = copyPrototype("recipe", "locomotive", "highspeed-locomotive")
highspeed_loco.ingredients = {
  {type = "item", name = "locomotive", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10}
}
highspeed_loco.enabled = false

local highspeed_locomk2 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.ingredients = {
  {type = "item", name = "highspeed-locomotive", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}

highspeed_locomk2.enabled = false

local highspeed_locomk3 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.ingredients = {
  {type = "item", name = "highspeed-locomotiveMK2", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
highspeed_locomk3.enabled = false

local highspeed_locomk4 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK4")
highspeed_locomk4.ingredients = {
  {type = "item", name = "highspeed-locomotiveMK3", amount = 3},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module-3", amount = 10}
}
highspeed_locomk4.enabled = false

local highspeed_cargo = copyPrototype("recipe", "cargo-wagon", "highspeed-cargo-wagon")
highspeed_cargo.ingredients = {
  {type = "item", name = "cargo-wagon", amount = 3},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10},
}
highspeed_cargo.enabled = false

local highspeed_cargomk2 = copyPrototype("recipe", "cargo-wagon", "highspeed-cargo-wagonMK2")
highspeed_cargomk2.ingredients = {
  {type = "item", name = "highspeed-cargo-wagon", amount = 5},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module", amount = 10},
}
highspeed_cargomk2.enabled = false

local highspeed_fluid = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagon")
highspeed_fluid.category = "crafting-with-fluid"
highspeed_fluid.ingredients = {
  {type = "item", name = "fluid-wagon", amount = 3},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
highspeed_fluid.enabled = false

local highspeed_fluidmk2 = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagonMK2")
highspeed_fluidmk2.category = "crafting-with-fluid"
highspeed_fluidmk2.ingredients = {
  {type = "item", name = "highspeed-fluid-wagon", amount = 5},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
highspeed_fluidmk2.enabled = false


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
