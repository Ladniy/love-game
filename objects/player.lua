Player = {}

function Player:new(x, y, hp)

  local obj = {}
    obj.x = x
    obj.y = y
    obj.hp = hp

  function obj:getX()
  	return self.x
  end

  function obj:getY()
  	return self.y
  end

  function obj:getHP()
  	return self.hp
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end