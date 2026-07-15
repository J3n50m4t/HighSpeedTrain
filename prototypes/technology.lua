local free_mode = settings.startup["highspeedtrain-free-mode"].value

local function apply_technology_mode(technology)
  if free_mode then
    technology.hidden = true
    technology.prerequisites = {}
    technology.effects = {}
    technology.unit = {
      count = 1,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 1
    }
  end
end

local highspeedtrain = {
  type = "technology",
  name = "highspeedtrain",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"braking-force-2"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-locomotive"
    }
  },
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 2},
      {"logistic-science-pack", 2},
      {"chemical-science-pack", 2},
      {"military-science-pack", 2},
      {"production-science-pack", 2},
    },
    time = 30
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedtrain)

local highspeedtrainmk2 = {
  type = "technology",
  name = "highspeedtrainmk2",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedtrain"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-locomotiveMK2"
    }
  },
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 2},
      {"logistic-science-pack", 2},
      {"chemical-science-pack", 2},
      {"military-science-pack", 2},
      {"production-science-pack", 2},
      {"utility-science-pack", 2},
    },
    time = 45
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedtrainmk2)

local highspeedtrainmk3 = {
  type = "technology",
  name = "highspeedtrainmk3",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedtrainmk2"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-locomotiveMK3"
    }
  },
  unit = {
    count = 100,
    ingredients = {
      {"automation-science-pack", 2},
      {"logistic-science-pack", 2},
      {"chemical-science-pack", 2},
      {"military-science-pack", 2},
      {"production-science-pack", 2},
      {"utility-science-pack", 2},
      {"space-science-pack", 2}
    },
    time = 60
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedtrainmk3)

local highspeedtrainmk4 = {
  type = "technology",
  name = "highspeedtrainmk4",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedtrainmk3"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-locomotiveMK4"
    }
  },
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 20},
      {"logistic-science-pack", 20},
      {"chemical-science-pack", 20},
      {"military-science-pack", 20},
      {"production-science-pack", 20},
      {"utility-science-pack", 20},
      {"space-science-pack", 20}
    },
    time = 100
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedtrainmk4)

local highspeedcargo = {
  type = "technology",
  name = "highspeedcargo",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedtrain"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-cargo-wagon"
    }
  },
  unit = {
    count = 200,
    ingredients = {
      {"chemical-science-pack", 2},
      {"production-science-pack", 2},
      {"utility-science-pack", 2},
    },
    time = 30
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedcargo)

local highspeedcargomk2 = {
  type = "technology",
  name = "highspeedcargomk2",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedcargo"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-cargo-wagonMK2"
    }
  },
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 20},
      {"logistic-science-pack", 20},
      {"chemical-science-pack", 20},
      {"military-science-pack", 20},
      {"production-science-pack", 20},
      {"utility-science-pack", 20},
      {"space-science-pack", 20}
    },
    time = 30
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedcargomk2)

local highspeedfluid = {
  type = "technology",
  name = "highspeedfluid",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedtrain"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-fluid-wagon"
    }
  },
  unit = {
    count = 200,
    ingredients = {
      {"chemical-science-pack", 2},
      {"production-science-pack", 2},
      {"utility-science-pack", 2},
    },
    time = 30
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedfluid)

local highspeedfluidmk2 = {
  type = "technology",
  name = "highspeedfluidmk2",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedfluid"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-fluid-wagonMK2"
    }
  },
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 20},
      {"logistic-science-pack", 20},
      {"chemical-science-pack", 20},
      {"military-science-pack", 20},
      {"production-science-pack", 20},
      {"utility-science-pack", 20},
      {"space-science-pack", 20}
    },
    time = 30
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedfluidmk2)

local highspeedartillery = {
  type = "technology",
  name = "highspeedartillery",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedtrain", "artillery"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-artillery-wagon"
    }
  },
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 2},
      {"logistic-science-pack", 2},
      {"chemical-science-pack", 2},
      {"military-science-pack", 2},
      {"production-science-pack", 2},
      {"utility-science-pack", 2}
    },
    time = 45
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedartillery)

data:extend({
  highspeedtrain,
  highspeedtrainmk2,
  highspeedtrainmk3,
  highspeedtrainmk4,
  highspeedcargo,
  highspeedcargomk2,
  highspeedfluid,
  highspeedfluidmk2,
  highspeedartillery
})
