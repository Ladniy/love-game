Enemy = {}

function Enemy:new(x, y, health, timer, weapon, image)

  local obj = {}
    obj.x = x
    obj.y = y
    obj.health = health
    obj.timer = timer
    obj.weapon = weapon
    obj.image = image

  function obj:getX()
  	return self.x
  end

  function obj:getY()
  	return self.y
  end

  function obj:getHealth()
  	return self.health
  end

  function obj:getTimer()
  	return self.timer
  end

  function obj:getWeapon()
  	return self.weapon
  end

  function obj:getImage()
    return self.image
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end