
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

local highspeed_loco = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotive")
apply_tinted_icon(highspeed_loco, "__base__/graphics/icons/locomotive.png", {r = 1.0, g = 0.82, b = 0.18, a = 1.0})
highspeed_loco.order = "a[train-system]-f[highspeed-locomotive]"

local highspeed_locomk2 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK2")
apply_tinted_icon(highspeed_locomk2, "__base__/graphics/icons/locomotive.png", {r = 0.93, g = 0.25, b = 0.23, a = 1.0})
highspeed_locomk2.order = "a[train-system]-f[highspeed-locomotiveMK2]"

local highspeed_locomk3 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK3")
apply_tinted_icon(highspeed_locomk3, "__base__/graphics/icons/locomotive.png", {r = 0.18, g = 0.45, b = 0.95, a = 1.0})
highspeed_locomk3.order = "a[train-system]-f[highspeed-locomotiveMK3]"

local highspeed_locomk4 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK4")
apply_tinted_icon(highspeed_locomk4, "__base__/graphics/icons/locomotive.png", {r = 0.20, g = 0.75, b = 0.35, a = 1.0})
highspeed_locomk4.order = "a[train-system]-f[highspeed-locomotiveMK4]"

local highspeed_cargo = copyPrototype("item-with-entity-data", "cargo-wagon", "highspeed-cargo-wagon")
apply_tinted_icon(highspeed_cargo, "__base__/graphics/icons/cargo-wagon.png", {r = 1.0, g = 0.82, b = 0.18, a = 1.0})
highspeed_cargo.order = "a[train-system]-f[highspeed-wagon]"

local highspeed_cargomk2 = copyPrototype("item-with-entity-data", "cargo-wagon", "highspeed-cargo-wagonMK2")
apply_tinted_icon(highspeed_cargomk2, "__base__/graphics/icons/cargo-wagon.png", {r = 0.93, g = 0.25, b = 0.23, a = 1.0})
highspeed_cargomk2.order = "a[train-system]-f[highspeed-wagon]"

local highspeed_fluid = copyPrototype("item-with-entity-data", "fluid-wagon", "highspeed-fluid-wagon")
apply_tinted_icon(highspeed_fluid, "__base__/graphics/icons/fluid-wagon.png", {r = 0.18, g = 0.45, b = 0.95, a = 1.0})
highspeed_fluid.order = "a[train-system]-f[highspeed-cluid-wagon]"

local highspeed_fluidmk2 = copyPrototype("item-with-entity-data", "fluid-wagon", "highspeed-fluid-wagonMK2")
apply_tinted_icon(highspeed_fluidmk2, "__base__/graphics/icons/fluid-wagon.png", {r = 0.20, g = 0.75, b = 0.35, a = 1.0})
highspeed_fluidmk2.order = "a[train-system]-f[highspeed-cluid-wagon]"

local highspeed_artillery = copyPrototype("item-with-entity-data", "artillery-wagon", "highspeed-artillery-wagon")
apply_tinted_icon(highspeed_artillery, "__base__/graphics/icons/artillery-wagon.png", {r = 0.58, g = 0.32, b = 0.86, a = 1.0})
highspeed_artillery.order = "a[train-system]-f[highspeed-artillery-wagon]"


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
