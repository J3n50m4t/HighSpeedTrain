data:extend({
  {
    type = "technology",
    name = "highspeedtrain",
    icon = "__base__/graphics/technology/railway.png",
    icon_size = 128,
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
        {"automation-science-pack", 2},
        {"logistic-science-pack", 2},
        {"chemical-science-pack", 2},
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
    icon_size = 128,
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
  },

  {
    type = "technology",
    name = "highspeedtrainmk3",
    icon = "__base__/graphics/technology/railway.png",
    icon_size = 128,
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
  },

  {
    type = "technology",
    name = "highspeedtrainmk4",
    icon = "__base__/graphics/technology/railway.png",
    icon_size = 128,
    prerequisites = {"highspeedtrainmk3"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "highspeed-locomotiveMK4"
      }
    },
    unit =
    {
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
  },

  {
    type = "technology",
    name = "highspeedcargo",
    icon = "__base__/graphics/technology/railway.png",
    icon_size = 128,
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
        {"chemical-science-pack", 2},
        {"production-science-pack", 2},
        {"utility-science-pack", 2},
      },
      time = 30
    },
    order = "c-g-c"
  },
{
  type = "technology",
  name = "highspeedcargomk2",
  icon = "__base__/graphics/technology/railway.png",
  icon_size = 128,
  prerequisites = {"highspeedcargo"},
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "highspeed-cargo-wagonMK2"
    }
  },
  unit =
  {
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
},

  {
    type = "technology",
    name = "highspeedfluid",
    icon = "__base__/graphics/technology/railway.png",
    icon_size = 128,
    prerequisites = {"highspeedtrain"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "highspeed-fluid-wagon"
      }
    },
    unit =
    {
      count = 200,
      ingredients = {
        {"chemical-science-pack", 2},
        {"production-science-pack", 2},
        {"utility-science-pack", 2},
      },
      time = 30
    },
    order = "c-g-c"
  },

  {
    type = "technology",
    name = "highspeedfluidmk2",
    icon = "__base__/graphics/technology/railway.png",
    icon_size = 128,
    prerequisites = {"highspeedfluid"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "highspeed-fluid-wagonMK2"
      }
    },
    unit =
    {
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

})