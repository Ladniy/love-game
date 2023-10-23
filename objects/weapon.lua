Weapon = {}

function Weapon:new(name, damage, attackSpeed)

  local obj = {}
    obj.name = name
    obj.damage = damage
    obj.attackSpeed = attackSpeed

  function obj:getName()
    return self.name
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