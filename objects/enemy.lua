Enemy = {}

function Enemy:new(x, y, health, timer, weapon)

  local obj = {}
    obj.x = x
    obj.y = y
    obj.health = health
    obj.timer = timer
    obj.weapon = weapon

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

  setmetatable(obj, self)
  self.__index = self; return obj
end