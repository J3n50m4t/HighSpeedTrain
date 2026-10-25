
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
local highspeed_loco = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotive")
apply_tinted_icon(highspeed_loco, "__base__/graphics/icons/locomotive.png", {r = 0.10, g = 0.19, b = 0.80, a = 1.0})
highspeed_loco.order = "a[train-system]-f[highspeed-locomotive]"

local highspeed_locomk2 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK2")
apply_tinted_icon(highspeed_locomk2, "__base__/graphics/icons/locomotive.png", {r = 0.05, g = 0.55, b = 0.75, a = 1.0})
highspeed_locomk2.order = "a[train-system]-f[highspeed-locomotiveMK2]"

local highspeed_locomk3 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK3")
apply_tinted_icon(highspeed_locomk3, "__base__/graphics/icons/locomotive.png", {r = 0.85, g = 0.45, b = 0.10, a = 1.0})
highspeed_locomk3.order = "a[train-system]-f[highspeed-locomotiveMK3]"

local highspeed_locomk4 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK4")
apply_tinted_icon(highspeed_locomk4, "__base__/graphics/icons/locomotive.png", {r = 0.85, g = 0.10, b = 0.10, a = 1.0})
highspeed_locomk4.order = "a[train-system]-f[highspeed-locomotiveMK4]"

local highspeed_cargo = copyPrototype("item-with-entity-data", "cargo-wagon", "highspeed-cargo-wagon")
apply_tinted_icon(highspeed_cargo, "__base__/graphics/icons/cargo-wagon.png", {r = 1.0, g = 0.82, b = 0.18, a = 1.0})
highspeed_cargo.order = "a[train-system]-f[highspeed-wagon]"

local highspeed_cargomk2 = copyPrototype("item-with-entity-data", "cargo-wagon", "highspeed-cargo-wagonMK2")
apply_tinted_icon(highspeed_cargomk2, "__base__/graphics/icons/cargo-wagon.png", {
  r = 0.93, g = 0.25, b = 0.23, a = 1.0
})
highspeed_cargomk2.order = "a[train-system]-f[highspeed-wagon]"

-- Mk3-Ton Magenta: hebt sich von allen bestehenden Toenen ab (Loks Blau/Cyan/Orange/Rot,
-- Cargo Mk1 Gelb und Mk2 Rot, Fluid Blau/Gruen, Artillerie Lila).
local highspeed_cargomk3 = copyPrototype("item-with-entity-data", "cargo-wagon", "highspeed-cargo-wagonMK3")
apply_tinted_icon(highspeed_cargomk3, "__base__/graphics/icons/cargo-wagon.png", {
  r = 0.92, g = 0.30, b = 0.70, a = 1.0
})
highspeed_cargomk3.order = "a[train-system]-f[highspeed-wagon]"

local highspeed_fluid = copyPrototype("item-with-entity-data", "fluid-wagon", "highspeed-fluid-wagon")
apply_tinted_icon(highspeed_fluid, "__base__/graphics/icons/fluid-wagon.png", {r = 0.18, g = 0.45, b = 0.95, a = 1.0})
highspeed_fluid.order = "a[train-system]-f[highspeed-cluid-wagon]"

local highspeed_fluidmk2 = copyPrototype("item-with-entity-data", "fluid-wagon", "highspeed-fluid-wagonMK2")
apply_tinted_icon(highspeed_fluidmk2, "__base__/graphics/icons/fluid-wagon.png", {
  r = 0.20, g = 0.75, b = 0.35, a = 1.0
})
highspeed_fluidmk2.order = "a[train-system]-f[highspeed-cluid-wagon]"

-- Mk3-Ton Teal: hebt sich von allen bestehenden Toenen ab (Loks Blau/Cyan/Orange/Rot,
-- Cargo Gelb/Rot/Magenta, Fluid Mk1 Blau und Mk2 Gruen, Artillerie Lila).
local highspeed_fluidmk3 = copyPrototype("item-with-entity-data", "fluid-wagon", "highspeed-fluid-wagonMK3")
apply_tinted_icon(highspeed_fluidmk3, "__base__/graphics/icons/fluid-wagon.png", {
  r = 0.05, g = 0.60, b = 0.50, a = 1.0
})
highspeed_fluidmk3.order = "a[train-system]-f[highspeed-cluid-wagon]"

local highspeed_artillery = copyPrototype("item-with-entity-data", "artillery-wagon", "highspeed-artillery-wagon")
apply_tinted_icon(highspeed_artillery, "__base__/graphics/icons/artillery-wagon.png", {
  r = 0.58, g = 0.32, b = 0.86, a = 1.0
})
highspeed_artillery.order = "a[train-system]-f[highspeed-artillery-wagon]"


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
  highspeed_artillery
})
