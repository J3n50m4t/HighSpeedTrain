local free_mode = settings.startup["highspeedtrain-free-mode"].value

local function apply_recipe_mode(recipe)
  if free_mode then
    recipe.ingredients = {}
    recipe.enabled = true
  else
    recipe.enabled = false
  end
end

local highspeed_loco = copyPrototype("recipe", "locomotive", "highspeed-locomotive")
highspeed_loco.ingredients = {
  {type = "item", name = "locomotive", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10}
}
apply_recipe_mode(highspeed_loco)

local highspeed_locomk2 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.ingredients = {
  {type = "item", name = "highspeed-locomotive", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_locomk2)

local highspeed_locomk3 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.ingredients = {
  {type = "item", name = "highspeed-locomotiveMK2", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_locomk3)

local highspeed_locomk4 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK4")
highspeed_locomk4.ingredients = {
  {type = "item", name = "highspeed-locomotiveMK3", amount = 3},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module-3", amount = 10}
}
apply_recipe_mode(highspeed_locomk4)

local highspeed_cargo = copyPrototype("recipe", "cargo-wagon", "highspeed-cargo-wagon")
highspeed_cargo.ingredients = {
  {type = "item", name = "cargo-wagon", amount = 3},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10},
}
apply_recipe_mode(highspeed_cargo)

local highspeed_cargomk2 = copyPrototype("recipe", "cargo-wagon", "highspeed-cargo-wagonMK2")
highspeed_cargomk2.ingredients = {
  {type = "item", name = "highspeed-cargo-wagon", amount = 5},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module", amount = 10},
}
apply_recipe_mode(highspeed_cargomk2)

local highspeed_fluid = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagon")
highspeed_fluid.category = "crafting-with-fluid"
highspeed_fluid.ingredients = {
  {type = "item", name = "fluid-wagon", amount = 3},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
apply_recipe_mode(highspeed_fluid)

local highspeed_fluidmk2 = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagonMK2")
highspeed_fluidmk2.category = "crafting-with-fluid"
highspeed_fluidmk2.ingredients = {
  {type = "item", name = "highspeed-fluid-wagon", amount = 5},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
apply_recipe_mode(highspeed_fluidmk2)

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
