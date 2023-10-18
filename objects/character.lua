Character = {}

function Character:new(x, y, health, damage)

  local obj = {}
    obj.x = x
    obj.y = y
    obj.health = health
    obj.damage = damage

  function obj:getX()
  	return self.x
  end

  function obj:getY()
  	return self.y
  end

  function obj:getHealth()
  	return self.health
  end

  function obj:getDamage()
  	return self.damage
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end