local free_mode = settings.startup["highspeedtrain-free-mode"].value

local function apply_recipe_mode(recipe)
  if free_mode then
    recipe.ingredients = {}
    recipe.enabled = true
  else
    recipe.enabled = false
  end
end

local function apply_tinted_icon(prototype, icon_path, tint)
  prototype.icon = nil
  prototype.icons = {
    {
      icon = icon_path,
      icon_size = 64,
      tint = tint
    }
  }
end

local highspeed_loco = copyPrototype("recipe", "locomotive", "highspeed-locomotive")
highspeed_loco.ingredients = {
  {type = "item", name = "locomotive", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10}
}
apply_recipe_mode(highspeed_loco)
apply_tinted_icon(highspeed_loco, "__base__/graphics/icons/locomotive.png", {r = 1.0, g = 0.82, b = 0.18, a = 1.0})

local highspeed_locomk2 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.ingredients = {
  {type = "item", name = "highspeed-locomotive", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_locomk2)
apply_tinted_icon(highspeed_locomk2, "__base__/graphics/icons/locomotive.png", {r = 0.93, g = 0.25, b = 0.23, a = 1.0})

local highspeed_locomk3 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.ingredients = {
  {type = "item", name = "highspeed-locomotiveMK2", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_locomk3)
apply_tinted_icon(highspeed_locomk3, "__base__/graphics/icons/locomotive.png", {r = 0.18, g = 0.45, b = 0.95, a = 1.0})

local highspeed_locomk4 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK4")
highspeed_locomk4.ingredients = {
  {type = "item", name = "highspeed-locomotiveMK3", amount = 3},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module-3", amount = 10}
}
apply_recipe_mode(highspeed_locomk4)
apply_tinted_icon(highspeed_locomk4, "__base__/graphics/icons/locomotive.png", {r = 0.20, g = 0.75, b = 0.35, a = 1.0})

local highspeed_cargo = copyPrototype("recipe", "cargo-wagon", "highspeed-cargo-wagon")
highspeed_cargo.ingredients = {
  {type = "item", name = "cargo-wagon", amount = 3},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10},
}
apply_recipe_mode(highspeed_cargo)
apply_tinted_icon(highspeed_cargo, "__base__/graphics/icons/cargo-wagon.png", {r = 1.0, g = 0.82, b = 0.18, a = 1.0})

local highspeed_cargomk2 = copyPrototype("recipe", "cargo-wagon", "highspeed-cargo-wagonMK2")
highspeed_cargomk2.ingredients = {
  {type = "item", name = "highspeed-cargo-wagon", amount = 5},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module", amount = 10},
}
apply_recipe_mode(highspeed_cargomk2)
apply_tinted_icon(highspeed_cargomk2, "__base__/graphics/icons/cargo-wagon.png", {r = 0.93, g = 0.25, b = 0.23, a = 1.0})

local highspeed_fluid = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagon")
highspeed_fluid.category = "crafting-with-fluid"
highspeed_fluid.ingredients = {
  {type = "item", name = "fluid-wagon", amount = 3},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
apply_recipe_mode(highspeed_fluid)
apply_tinted_icon(highspeed_fluid, "__base__/graphics/icons/fluid-wagon.png", {r = 0.18, g = 0.45, b = 0.95, a = 1.0})

local highspeed_fluidmk2 = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagonMK2")
highspeed_fluidmk2.category = "crafting-with-fluid"
highspeed_fluidmk2.ingredients = {
  {type = "item", name = "highspeed-fluid-wagon", amount = 5},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
apply_recipe_mode(highspeed_fluidmk2)
apply_tinted_icon(highspeed_fluidmk2, "__base__/graphics/icons/fluid-wagon.png", {r = 0.20, g = 0.75, b = 0.35, a = 1.0})

local highspeed_artillery = copyPrototype("recipe", "artillery-wagon", "highspeed-artillery-wagon")
highspeed_artillery.ingredients = {
  {type = "item", name = "artillery-wagon", amount = 1},
  {type = "item", name = "processing-unit", amount = 40},
  {type = "item", name = "electric-engine-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_artillery)
apply_tinted_icon(highspeed_artillery, "__base__/graphics/icons/artillery-wagon.png", {r = 0.58, g = 0.32, b = 0.86, a = 1.0})

data:extend({
  highspeed_loco,
  highspeed_locomk2,
  highspeed_locomk3,
  highspeed_locomk4,
  highspeed_cargo,
  highspeed_cargomk2,
  highspeed_fluid,
  highspeed_fluidmk2,
  highspeed_artillery
})
