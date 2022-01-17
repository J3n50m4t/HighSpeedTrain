for i, force in pairs(game.forces) do 
  force.reset_recipes()
  force.reset_technologies()
  
  if force.technologies["highspeedtrain"].researched then
    force.recipes["highspeed-locomotive"].enabled = true
  else
    force.recipes["highspeed-locomotive"].enabled = false
  end
  if force.technologies["highspeedtrainmk2"].researched then
    force.recipes["highspeed-locomotiveMK2"].enabled = true
  else
    force.recipes["highspeed-locomotiveMK2"].enabled = false
  end
  if force.technologies["highspeedtrainmk3"].researched then
    force.recipes["highspeed-locomotiveMK3"].enabled = true
  else
    force.recipes["highspeed-locomotiveMK3"].enabled = false
  end
  if force.technologies["highspeedtrainmk4"].researched then
    force.recipes["highspeed-locomotiveMK4"].enabled = true
  else
    force.recipes["highspeed-locomotiveMK4"].enabled = false
  end
  if force.technologies["highspeedcarwo"].researched then
    force.recipes["highspeed-cargo-wagon"].enabled = true
  else
    force.recipes["highspeed-cargo-wagon"].enabled = false
  end
  
end
