Character = {}

function Character:new(x, y, health, weapon, image)

  local obj = {}
    obj.x = x
    obj.y = y
    obj.health = health
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

  function obj:getWeapon()
  	return self.weapon
  end

  function obj:getImage()
    return self.image
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end