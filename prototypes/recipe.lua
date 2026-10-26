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

-- Die vier Lok-Tints folgen der Mk-Rampe aus entity.lua (identische RGB, hier alpha 1.0),
-- damit Icon-Ton == Fahrzeugfarbe auf der Karte ist. Wagen-Tints bleiben unveraendert.
local highspeed_loco = copyPrototype("recipe", "locomotive", "highspeed-locomotive")
highspeed_loco.ingredients = {
  {type = "item", name = "locomotive", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10}
}
apply_recipe_mode(highspeed_loco)
apply_tinted_icon(highspeed_loco, "__base__/graphics/icons/locomotive.png", {r = 0.10, g = 0.19, b = 0.80, a = 1.0})

local highspeed_locomk2 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.ingredients = {
  {type = "item", name = "highspeed-locomotive", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_locomk2)
apply_tinted_icon(highspeed_locomk2, "__base__/graphics/icons/locomotive.png", {r = 0.05, g = 0.55, b = 0.75, a = 1.0})

local highspeed_locomk3 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.ingredients = {
  {type = "item", name = "highspeed-locomotiveMK2", amount = 1},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_locomk3)
apply_tinted_icon(highspeed_locomk3, "__base__/graphics/icons/locomotive.png", {r = 0.85, g = 0.45, b = 0.10, a = 1.0})

local highspeed_locomk4 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK4")
highspeed_locomk4.ingredients = {
  {type = "item", name = "highspeed-locomotiveMK3", amount = 3},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module-3", amount = 10}
}
apply_recipe_mode(highspeed_locomk4)
apply_tinted_icon(highspeed_locomk4, "__base__/graphics/icons/locomotive.png", {r = 0.85, g = 0.10, b = 0.10, a = 1.0})

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
apply_tinted_icon(highspeed_cargomk2, "__base__/graphics/icons/cargo-wagon.png", {
  r = 0.93, g = 0.25, b = 0.23, a = 1.0
})

-- Mk3 baut auf Mk2 auf; die 10x speed-module-3 passen zur Tech-Voraussetzung
-- "speed-module-3". energy_required 10 s statt der geerbten 1 s: der Aufwand fuer vier
-- Mk2-Waggons plus 500 Processing Units soll in der Fertigungszeit sichtbar sein.
local highspeed_cargomk3 = copyPrototype("recipe", "cargo-wagon", "highspeed-cargo-wagonMK3")
highspeed_cargomk3.ingredients = {
  {type = "item", name = "highspeed-cargo-wagonMK2", amount = 4},
  {type = "item", name = "processing-unit", amount = 500},
  {type = "item", name = "speed-module-3", amount = 10},
}
highspeed_cargomk3.energy_required = 10
apply_recipe_mode(highspeed_cargomk3)
apply_tinted_icon(highspeed_cargomk3, "__base__/graphics/icons/cargo-wagon.png", {
  r = 0.92, g = 0.30, b = 0.70, a = 1.0
})

local highspeed_fluid = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagon")
highspeed_fluid.categories = { "crafting-with-fluid" }  -- 2.1: category/additional_categories merged into categories
highspeed_fluid.ingredients = {
  {type = "item", name = "fluid-wagon", amount = 3},
  {type = "item", name = "processing-unit", amount = 20},
  {type = "item", name = "speed-module", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
apply_recipe_mode(highspeed_fluid)
apply_tinted_icon(highspeed_fluid, "__base__/graphics/icons/fluid-wagon.png", {r = 0.18, g = 0.45, b = 0.95, a = 1.0})

local highspeed_fluidmk2 = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagonMK2")
highspeed_fluidmk2.categories = { "crafting-with-fluid" }
highspeed_fluidmk2.ingredients = {
  {type = "item", name = "highspeed-fluid-wagon", amount = 5},
  {type = "item", name = "processing-unit", amount = 250},
  {type = "item", name = "speed-module", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
apply_recipe_mode(highspeed_fluidmk2)
apply_tinted_icon(highspeed_fluidmk2, "__base__/graphics/icons/fluid-wagon.png", {
  r = 0.20, g = 0.75, b = 0.35, a = 1.0
})

-- Mk3 baut auf Mk2 auf und bleibt beim crafting-with-fluid-Muster der Fluid-Stufen
-- (100 Lubricant wie Mk1/Mk2). Die 10x speed-module-3 passen zur Tech-Voraussetzung
-- "speed-module-3". energy_required 10 s statt der geerbten 1.5 s: der Aufwand fuer
-- vier Mk2-Waggons plus 500 Processing Units soll in der Fertigungszeit sichtbar sein.
local highspeed_fluidmk3 = copyPrototype("recipe", "fluid-wagon", "highspeed-fluid-wagonMK3")
highspeed_fluidmk3.categories = { "crafting-with-fluid" }
highspeed_fluidmk3.ingredients = {
  {type = "item", name = "highspeed-fluid-wagonMK2", amount = 4},
  {type = "item", name = "processing-unit", amount = 500},
  {type = "item", name = "speed-module-3", amount = 10},
  {type = "fluid", name = "lubricant", amount = 100}
}
highspeed_fluidmk3.energy_required = 10
apply_recipe_mode(highspeed_fluidmk3)
apply_tinted_icon(highspeed_fluidmk3, "__base__/graphics/icons/fluid-wagon.png", {
  r = 0.05, g = 0.60, b = 0.50, a = 1.0
})

local highspeed_artillery = copyPrototype("recipe", "artillery-wagon", "highspeed-artillery-wagon")
highspeed_artillery.ingredients = {
  {type = "item", name = "artillery-wagon", amount = 1},
  {type = "item", name = "processing-unit", amount = 40},
  {type = "item", name = "electric-engine-unit", amount = 20},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_artillery)
apply_tinted_icon(highspeed_artillery, "__base__/graphics/icons/artillery-wagon.png", {
  r = 0.58, g = 0.32, b = 0.86, a = 1.0
})

-- Artillerie Mk2: baut wie bei den anderen Stufen auf dem Vorgaenger auf (1 Mk1-Wagen).
-- processing-unit und electric-engine-unit gegenueber dem Mk1-Rezept verdoppelt
-- (40 -> 80 bzw. 20 -> 40), speed-module-2 bleibt bei 10. Das Vanilla-Artilleriewagen-
-- Rezept aus dem Dump (engine-unit 60, tungsten-plate 60, refined-concrete 60,
-- iron-gear-wheel 40, processing-unit 10) kennt selbst keine Module, die Steigerung ist
-- also mod-intern wie bei den anderen Mk2-Stufen.
local highspeed_artillerymk2 = copyPrototype("recipe", "artillery-wagon", "highspeed-artillery-wagonMK2")
highspeed_artillerymk2.ingredients = {
  {type = "item", name = "highspeed-artillery-wagon", amount = 1},
  {type = "item", name = "processing-unit", amount = 80},
  {type = "item", name = "electric-engine-unit", amount = 40},
  {type = "item", name = "speed-module-2", amount = 10}
}
apply_recipe_mode(highspeed_artillerymk2)
apply_tinted_icon(highspeed_artillerymk2, "__base__/graphics/icons/artillery-wagon.png", {
  r = 0.55, g = 0.10, b = 0.35, a = 1.0
})

-- Mk2-Granate: Zutaten ausschliesslich aus dem Vanilla-artillery-shell-Rezept aus dem
-- Base-Dump abgeleitet (radar 1, calcite 1, tungsten-plate 4, explosives 8; 15 s). Die
-- Mk2-Munition hat die doppelte Sprengladung (siehe highspeed-artillery-projectile-mk2),
-- also genau dort die doppelte Menge explosives (8 -> 16). radar (Zuendung und
-- Zielfuehrung), calcite und die Wolfram-Huelse bleiben unveraendert, weil Zuendung und
-- Huelle dieselben bleiben - eine zusaetzliche oder ausgetauschte Zutat waere erfunden
-- und bleibt deshalb draussen. energy_required 30 s = 2x Vanilla, weil die doppelte
-- Ladung auch den doppelten Mischaufwand bedeutet.
local highspeed_artillery_shellmk2 = copyPrototype("recipe", "artillery-shell", "highspeed-artillery-shell-mk2")
highspeed_artillery_shellmk2.ingredients = {
  {type = "item", name = "radar", amount = 1},
  {type = "item", name = "calcite", amount = 1},
  {type = "item", name = "tungsten-plate", amount = 4},
  {type = "item", name = "explosives", amount = 16}
}
highspeed_artillery_shellmk2.energy_required = 30
apply_recipe_mode(highspeed_artillery_shellmk2)
apply_tinted_icon(highspeed_artillery_shellmk2, "__base__/graphics/icons/artillery-shell.png", {
  r = 0.55, g = 0.10, b = 0.35, a = 1.0
})

data:extend({
  highspeed_loco,
  highspeed_locomk2,
  highspeed_locomk3,
  highspeed_locomk4,
  highspeed_cargo,
  highspeed_cargomk2,
  highspeed_cargomk3,
  highspeed_fluid,
  highspeed_fluidmk2,
  highspeed_fluidmk3,
  highspeed_artillery,
  highspeed_artillerymk2,
  highspeed_artillery_shellmk2
})
