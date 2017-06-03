
local highspeed_loco = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotive")
highspeed_loco.icon = "__base__/graphics/icons/diesel-locomotive.png"
highspeed_loco.order = "a[train-system]-f[highspeed-locomotive]"

local highspeed_locomk2 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.icon = "__base__/graphics/icons/diesel-locomotive.png"
highspeed_locomk2.order = "a[train-system]-f[highspeed-locomotiveMK2]"

local highspeed_locomk3 = copyPrototype("item-with-entity-data", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.icon = "__base__/graphics/icons/diesel-locomotive.png"
highspeed_locomk3.order = "a[train-system]-f[highspeed-locomotiveMK3]"


local highspeed_cargo = copyPrototype("item-with-entity-data", "cargo-wagon", "highspeed-cargo-wagon")
highspeed_cargo.icon = "__base__/graphics/icons/cargo-wagon.png"
highspeed_cargo.order = "a[train-system]-f[highspeed-wagon]"

data:extend({
  highspeed_loco,
  highspeed_locomk2,
  highspeed_locomk3,
  highspeed_cargo
})
