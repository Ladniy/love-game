require 'objects/player'
require 'objects/enemy'

function love.load()
  ArenaWidth = 800
  ArenaHeight = 600

  PlayerOne = Player:new(ArenaWidth / 2, ArenaHeight / 2 + 200, 100)

  Enemies = {
    Enemy:new(ArenaWidth / 2 - 150, ArenaHeight * 0.20, 100, 2, false),
    Enemy:new(ArenaWidth / 2, ArenaHeight * 0.25, 100, 3, true),
    Enemy:new(ArenaWidth / 2 + 150, ArenaHeight * 0.20, 100, 1, false)
  }

  EnemyCount = 3

  function EnemiesAttack()
    EnemySumOfAttack = 0
  	if EnemyCount ~= 0 then
      for enemyIndex, enemy in pairs(Enemies) do
      	EnemySumOfAttack = EnemySumOfAttack + enemy:getAttack()
      end
    	PlayerOne.hp = PlayerOne.hp - EnemySumOfAttack
    end
  end

  function SetRandomTarget(table)
    RandomIndex = love.math.random(1, EnemyCount)
    for itemIndex, item in pairs(table) do
    	if item:getIsTarget() == true then
      	item.target = false
      end
      table[RandomIndex].target = true
    end
  end

  CurrentDelta = 0
end

function love.keypressed(key)
  if key == 'space' then
    for enemyIndex, enemy  in pairs(Enemies) do
    	if enemy:getIsTarget() == true then
      	enemy.hp = enemy.hp - 10
      end
    end
  end
end

function love.draw()
  -- Draw a player
  love.graphics.setColor(0, 0, 1)
  love.graphics.circle('fill', PlayerOne:getX(), PlayerOne:getY(), 30)
  love.graphics.setColor(0, 1, 0)
  love.graphics.rectangle('fill', PlayerOne:getX() - 25, PlayerOne:getY() + 40, PlayerOne:getHP() * 0.5, 10)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('HP: '..PlayerOne:getHP(), PlayerOne:getX() - 25, PlayerOne:getY() + 40)

  for enemyIndex, enemy in pairs(Enemies) do
    -- Draw each enemy
  	love.graphics.setColor(1, 0, 0)
    love.graphics.circle('fill', enemy:getX(), enemy:getY(), 30)

    -- Draw hp bar under each enemy
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', enemy:getX() - 25, enemy:getY() + 40, enemy:getHP() * 0.5, 10)

    -- Draw hp count on hp bar
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('HP: '..enemy:getHP(), enemy:getX() - 25, enemy:getY() + 40)
  end

    -- Debug
    love.graphics.print(table.concat({
    'random: '..RandomIndex,
    'dt: '..CurrentDelta
  },'\n'))
end

function love.update(dt)
  SetRandomTarget(Enemies)

  -- Remove enemy if enemy hp below 0
  for enemyIndex, enemy in pairs(Enemies) do
  	if enemy:getHP() <= 0 then
    	table.remove(Enemies, enemyIndex)
      EnemyCount = EnemyCount - 1
    end
  end

  CurrentDelta = math.ceil(CurrentDelta + (dt * 100))
  if CurrentDelta % 100 == 1 then
  	EnemiesAttack()
  end
end