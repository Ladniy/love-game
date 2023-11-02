Weapon = {}

function Weapon:new(name, damage, attackSpeed, image)

  local obj = {}
    obj.name = name
    obj.damage = damage
    obj.attackSpeed = attackSpeed
    obj.image = image

  function obj:getName()
    return self.name
  end

  function obj:getDamage()
  	return self.damage
  end

  function obj:getAttackSpeed()
    return self.attackSpeed
  end

  function obj:getImage()
    return self.image
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end