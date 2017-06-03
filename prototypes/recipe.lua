local highspeed_loco = copyPrototype("recipe", "locomotive", "highspeed-locomotive")
highspeed_loco.ingredients = {
  {"locomotive", 1},
  {"processing-unit", 20},
  {"speed-module", 10}
}
highspeed_loco.enabled = false

local highspeed_locomk2 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK2")
highspeed_locomk2.ingredients = {
  {"highspeed-locomotive", 1},
  {"processing-unit", 20},
  {"speed-module-2", 10}
}
highspeed_locomk2.enabled = false

local highspeed_locomk3 = copyPrototype("recipe", "locomotive", "highspeed-locomotiveMK3")
highspeed_locomk3.ingredients = {
  {"highspeed-locomotiveMK2", 1},
  {"processing-unit", 20},
  {"speed-module-3", 10}
}
highspeed_locomk3.enabled = false

local highspeed_wago = copyPrototype("recipe", "cargo-wagon", "highspeed-cargo-wagon")
highspeed_wago.ingredients = {
  {"cargo-wagon", 1},
  {"processing-unit", 20},
  {"speed-module", 10}
}
highspeed_wago.enabled = false

data:extend({
  highspeed_loco,
  highspeed_locomk2,
  highspeed_locomk3,
  highspeed_wago
})
