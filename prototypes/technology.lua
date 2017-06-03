data:extend({
  {
    type = "technology",
    name = "highspeedtrain",
    icon = "__base__/graphics/technology/railway.png",
    prerequisites = {"braking-force-2"},
    effects =
    {
     
      {
        type = "unlock-recipe",
        recipe = "highspeed-locomotive"
      }
    },
    unit =
    {
      count = 200,
      ingredients = {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 2},
        {"military-science-pack", 2},        
        {"production-science-pack", 2},
      },
      time = 30
    },
    order = "c-g-c"
  },
  {
    type = "technology",
    name = "highspeedtrainmk2",
    icon = "__base__/graphics/technology/railway.png",
    prerequisites = {"highspeedtrain"},
    effects =
    {
     
      {
        type = "unlock-recipe",
        recipe = "highspeed-locomotiveMK2"
      }
    },
    unit =
    {
      count = 200,
      ingredients = {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 2},
        {"military-science-pack", 2},        
        {"production-science-pack", 2},
        {"high-tech-science-pack", 2},
      },
      time = 45
    },
    order = "c-g-c"
  },

{
    type = "technology",
    name = "highspeedtrainmk3",
    icon = "__base__/graphics/technology/railway.png",
    prerequisites = {"highspeedtrainmk2"},
    effects =
    {
     
      {
        type = "unlock-recipe",
        recipe = "highspeed-locomotiveMK3"
      }
    },
    unit =
    {
      count = 100,
      ingredients = {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 2},
        {"military-science-pack", 2},        
        {"production-science-pack", 2},
        {"high-tech-science-pack", 2},
        {"space-science-pack", 2}
      },
      time = 60
    },
    order = "c-g-c"
  },

  {
    type = "technology",
    name = "highspeedcarwo",
    icon = "__base__/graphics/technology/railway.png",
    prerequisites = {"highspeedtrain"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "highspeed-cargo-wagon"
      }
    },
    unit =
    {
      count = 200,
      ingredients = {
        {"science-pack-3", 2},
        {"production-science-pack", 2},
        {"high-tech-science-pack", 2},
      },
      time = 30
    },
    order = "c-g-c"
  }
})