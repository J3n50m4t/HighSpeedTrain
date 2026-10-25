local free_mode = settings.startup["highspeedtrain-free-mode"].value

-- Eigene Tech-Icons: jedes Tech zeigt das Icon des Fahrzeugs, das es freischaltet,
-- im Stufen-Ton der Farb-Rampe (Mk1 Blau, Mk2 Cyan, Mk3 Orange, Mk4 Rot; Wagen:
-- Cargo Gelb/Rot/Magenta, Fluid Blau/Gruen/Teal, Artillerie Lila). Identische RGB wie die
-- Icon-Tints in item.lua/recipe.lua und die color-Werte in entity.lua, damit
-- Icon-Ton == Fahrzeugfarbe ist. technology.lua wird in data.lua ZUERST require't,
-- darf also nicht auf Variablen der spaeteren Dateien zugreifen -> eigene Rampe.
local locomotive_icon = "__base__/graphics/icons/locomotive.png"
local cargo_wagon_icon = "__base__/graphics/icons/cargo-wagon.png"
local fluid_wagon_icon = "__base__/graphics/icons/fluid-wagon.png"
local artillery_wagon_icon = "__base__/graphics/icons/artillery-wagon.png"

-- Die __base__-Fahrzeugicons sind 120x64 px. Vanilla laesst icon_size dort weg
-- (Default ist 64, siehe Base-Dump der Items locomotive/cargo-wagon/...), genauso
-- deklariert es auch item.lua/recipe.lua -> 64 ist der korrekte Wert.
local tech_icon_size = 64

local tech_tints = {
  locomotive_mk1 = {r = 0.10, g = 0.19, b = 0.80, a = 1.0},
  locomotive_mk2 = {r = 0.05, g = 0.55, b = 0.75, a = 1.0},
  locomotive_mk3 = {r = 0.85, g = 0.45, b = 0.10, a = 1.0},
  locomotive_mk4 = {r = 0.85, g = 0.10, b = 0.10, a = 1.0},
  cargo_wagon_mk1 = {r = 1.0, g = 0.82, b = 0.18, a = 1.0},
  cargo_wagon_mk2 = {r = 0.93, g = 0.25, b = 0.23, a = 1.0},
  cargo_wagon_mk3 = {r = 0.92, g = 0.30, b = 0.70, a = 1.0},
  fluid_wagon_mk1 = {r = 0.18, g = 0.45, b = 0.95, a = 1.0},
  fluid_wagon_mk2 = {r = 0.20, g = 0.75, b = 0.35, a = 1.0},
  fluid_wagon_mk3 = {r = 0.05, g = 0.60, b = 0.50, a = 1.0},
  artillery_wagon = {r = 0.58, g = 0.32, b = 0.86, a = 1.0}
}

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
  icons = {
    {icon = locomotive_icon, icon_size = tech_icon_size, tint = tech_tints.locomotive_mk1}
  },
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
  icons = {
    {icon = locomotive_icon, icon_size = tech_icon_size, tint = tech_tints.locomotive_mk2}
  },
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
  icons = {
    {icon = locomotive_icon, icon_size = tech_icon_size, tint = tech_tints.locomotive_mk3}
  },
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
  icons = {
    {icon = locomotive_icon, icon_size = tech_icon_size, tint = tech_tints.locomotive_mk4}
  },
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
  icons = {
    {icon = cargo_wagon_icon, icon_size = tech_icon_size, tint = tech_tints.cargo_wagon_mk1}
  },
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
  icons = {
    {icon = cargo_wagon_icon, icon_size = tech_icon_size, tint = tech_tints.cargo_wagon_mk2}
  },
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

-- Mk3 haengt an Mk2 und an der Vanilla-Technik "speed-module-3", damit die Zutaten des
-- Rezepts (10x speed-module-3) zum Freischaltzeitpunkt schon herstellbar sind. Das
-- Unit-Muster von highspeedcargomk2 ist um 25 % erhoeht (count 200 -> 250, je Pack 20 -> 25).
local highspeedcargomk3 = {
  type = "technology",
  name = "highspeedcargomk3",
  icons = {
    {icon = cargo_wagon_icon, icon_size = tech_icon_size, tint = tech_tints.cargo_wagon_mk3}
  },
  prerequisites = {"highspeedcargomk2", "speed-module-3"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-cargo-wagonMK3"
    }
  },
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 25},
      {"logistic-science-pack", 25},
      {"chemical-science-pack", 25},
      {"military-science-pack", 25},
      {"production-science-pack", 25},
      {"utility-science-pack", 25},
      {"space-science-pack", 25}
    },
    time = 30
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedcargomk3)

local highspeedfluid = {
  type = "technology",
  name = "highspeedfluid",
  icons = {
    {icon = fluid_wagon_icon, icon_size = tech_icon_size, tint = tech_tints.fluid_wagon_mk1}
  },
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
  icons = {
    {icon = fluid_wagon_icon, icon_size = tech_icon_size, tint = tech_tints.fluid_wagon_mk2}
  },
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

-- Mk3 haengt an Mk2 und an der Vanilla-Technik "speed-module-3", damit die Zutaten des
-- Rezepts (10x speed-module-3) zum Freischaltzeitpunkt schon herstellbar sind. Das
-- Unit-Muster von highspeedfluidmk2 ist um 25 % erhoeht (count 200 -> 250, je Pack 20 -> 25).
local highspeedfluidmk3 = {
  type = "technology",
  name = "highspeedfluidmk3",
  icons = {
    {icon = fluid_wagon_icon, icon_size = tech_icon_size, tint = tech_tints.fluid_wagon_mk3}
  },
  prerequisites = {"highspeedfluidmk2", "speed-module-3"},
  effects = {
    {
      type = "unlock-recipe",
      recipe = "highspeed-fluid-wagonMK3"
    }
  },
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 25},
      {"logistic-science-pack", 25},
      {"chemical-science-pack", 25},
      {"military-science-pack", 25},
      {"production-science-pack", 25},
      {"utility-science-pack", 25},
      {"space-science-pack", 25}
    },
    time = 30
  },
  order = "c-g-c"
}
apply_technology_mode(highspeedfluidmk3)

local highspeedartillery = {
  type = "technology",
  name = "highspeedartillery",
  icons = {
    {icon = artillery_wagon_icon, icon_size = tech_icon_size, tint = tech_tints.artillery_wagon}
  },
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
  highspeedcargomk3,
  highspeedfluid,
  highspeedfluidmk2,
  highspeedfluidmk3,
  highspeedartillery
})
