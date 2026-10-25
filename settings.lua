data:extend({
  {
    type = "bool-setting",
    name = "highspeedtrain-no-fuel",
    setting_type = "startup",
    default_value = false,
    order = "a"
  },
  {
    type = "bool-setting",
    name = "highspeedtrain-free-mode",
    setting_type = "startup",
    default_value = false,
    order = "b"
  },
  {
    type = "int-setting",
    name = "highspeedtrain-mk4-speed-percent",
    setting_type = "startup",
    order = "c",
    default_value = 100,
    min_value = 20,
    max_value = 100
  }
})
