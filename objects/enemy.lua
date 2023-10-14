Enemy = {}

function Enemy:new(x, y, hp, attack, target)

  local obj = {}
    obj.x = x
    obj.y = y
    obj.hp = hp
    obj.attack = attack
    obj.target = target

  function obj:getX()
  	return self.x
  end

  function obj:getY()
  	return self.y
  end

  function obj:getHP()
  	return self.hp
  end

  function obj:getAttack()
  	return self.attack
  end

  function obj:getIsTarget()
  	return self.target
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end