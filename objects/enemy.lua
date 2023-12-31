Enemy = {}

function Enemy:new(x, y, health, damage, attackSpeed)

  local obj = {}
    obj.x = x
    obj.y = y
    obj.health = health
    obj.damage = damage
    obj.attackSpeed = attackSpeed

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

  function obj:getAttackSpeed()
    return self.attackSpeed
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end