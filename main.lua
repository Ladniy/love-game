require 'objects/character'
require 'objects/enemy'

function love.load()
  ArenaWidth = 800
  ArenaHeight = 600

  Player = Character:new(ArenaWidth / 2, ArenaHeight / 2 + 200, 100, 10)

  Enemies = {
    Enemy:new(ArenaWidth / 2 - 150, ArenaHeight * 0.20, 100, 2, false),
    Enemy:new(ArenaWidth / 2, ArenaHeight * 0.25, 100, 3, true),
    Enemy:new(ArenaWidth / 2 + 150, ArenaHeight * 0.20, 100, 1, false)
  }

  CurrentDelta = 0

  function GetItemsCount(table)
    local count = 0
    for itemIndex, item in pairs(table) do
    	count = count + 1
    end
    return count
  end

  function EnemiesAttack(object)
    local sumOfDamage = 0
  	if GetItemsCount(Enemies) ~= 0 then
      for enemyIndex, enemy in pairs(Enemies) do
      	sumOfDamage = sumOfDamage + enemy:getDamage()
      end
    	object.health = object.health - sumOfDamage
    end
  end

  function MoveToLeft(player, enemies)
    if player:getHealth() > 0 then
    	local currentX = player:getX()
      for itemIndex, item in pairs(enemies) do
        if item:getX() < currentX then
        	local leftX = item:getX()
          player.x = leftX
        end
      end
    end
  end

  function MoveToRight(player, enemies)
    if player:getHealth() > 0 then
    	for itemIndex, item in pairs(enemies) do
        if item:getX() > player:getX() then
        	local rightX = item:getX()
          player.x = rightX
          break
        end
      end
    end
  end

  function Attack(player, enemies)
    if player:getHealth() > 0 then
    	for itemIndex, item in pairs(enemies) do
      	if item:getX() == player:getX() then
        	item.health = item.health - player:getDamage()
        end
      end
    end
  end
end

function love.keypressed(key)
  if key == 'left' then
  	MoveToLeft(Player, Enemies)
  end

  if key == 'right' then
  	MoveToRight(Player, Enemies)
  end

  if key =='space' then
  	Attack(Player, Enemies)
  end
end

function love.draw()
  -- Player drawning
  if Player:getHealth() > 0 then
    -- Draw a player
  	love.graphics.setColor(0, 0, 1)
    love.graphics.circle('fill', Player:getX(), Player:getY(), 30)

    -- Draw a health bar
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', Player:getX() - 25, Player:getY() + 40, Player:getHealth() * 0.5, 10)

    -- Print a health points
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('HP: '..Player:getHealth(), Player:getX() - 25, Player:getY() + 40)
  end

  -- Enemy drawning
  for enemyIndex, enemy in pairs(Enemies) do
    -- Draw each enemy
  	love.graphics.setColor(1, 0, 0)
    love.graphics.circle('fill', enemy:getX(), enemy:getY(), 30)

    -- Draw a health bar for each enemy
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', enemy:getX() - 25, enemy:getY() + 40, enemy:getHealth() * 0.5, 10)

    -- Print a health points for each enemy
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('HP: '..enemy:getHealth(), enemy:getX() - 25, enemy:getY() + 40)
  end

  -- Print a "GAME OVER" if player died
  if Player:getHealth() < 0 then
  	love.graphics.setColor(1, 0, 0)
    love.graphics.print('GAME OVER', ArenaHeight / 2, ArenaWidth / 2)
  end

    -- Debug info
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(table.concat({
    'dt: '..CurrentDelta,
    'fps: '..love.timer.getFPS()
  },'\n'))
end

function love.update(dt)
  -- Remove enemy if enemy hp below 0
  for enemyIndex, enemy in pairs(Enemies) do
  	if enemy:getHealth() <= 0 then
    	table.remove(Enemies, enemyIndex)
    end
  end

  CurrentDelta = math.ceil(CurrentDelta + (dt * 100))
  if CurrentDelta % 100 == 1 then
  	EnemiesAttack(Player)
  end
end