local lg = love.graphics

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

EnemiesTable = {}

function SpawnEnemies(targetTable)
  if #targetTable == 0 then
    for i = 1, 3, 1 do
      if i == 1 then
        table.insert(targetTable, i, Enemy:new(ArenaWidth / 2 - 150, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 3)],
           lg.newImage('assets/demon.png')))
      elseif i == 2 then
        table.insert(targetTable, i, Enemy:new(ArenaWidth / 2, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 3)],
           lg.newImage('assets/demon.png')))
      else
        table.insert(targetTable, i, Enemy:new(ArenaWidth / 2 + 150, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 3)],
           lg.newImage('assets/demon.png')))
      end
    end
  end
end

function RemoveEnemy(targetTable)
  for enemyIndex, enemy in pairs(targetTable) do
  	if enemy:getHealth() <= 0 then
    	table.remove(targetTable, enemyIndex)
      Score = Score + 10
    end
  end
end
