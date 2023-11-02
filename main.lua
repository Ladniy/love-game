require 'objects/character'
require 'objects/enemy'
require 'objects/weapon'
require 'movement'

function love.load()
  ArenaWidth = 800
  ArenaHeight = 600

  Debug = false

  WeaponsTable = {
    Weapon:new('Sword', 5, 1),
    Weapon:new('Stick', 1.5, 1/2),
    Weapon:new('Iron Rod', 3, 1),
    Weapon:new('Knuckle', 2, 1/2)
  }


  Player = Character:new(ArenaWidth / 2, ArenaHeight / 2 + 200, 100, WeaponsTable[Random(1, 4)])

  Enemies = {
    Enemy:new(ArenaWidth / 2 - 150, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 4)]),
    Enemy:new(ArenaWidth / 2, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 4)]),
    Enemy:new(ArenaWidth / 2 + 150, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 4)])
  }

  Score = 0



  function EnemiesAttack(player, damage)
    player.health = player.health - damage
  end

  function Attack(player, enemies)
    if player:getHealth() > 0 then
      local weapon = player:getWeapon()
    	for enemyIndex, enemy in pairs(enemies) do
      	if enemy:getX() == player:getX() then
        	enemy.health = enemy.health - weapon:getDamage()
        end
      end
    end
  end
end

function love.keypressed(key)
  if key == 'left' and GameState == 'combat' then
  	MoveToLeftEnemy(Player, Enemies)
  end

  if key == 'right' and GameState == 'combat' then
  	MoveToRightEnemy(Player, Enemies)
  end

  if key == 'space' and GameState == 'combat' then
  	PlayerAttack(Player, Enemies)
  end

  if key == 'f1' then
    if Debug then
    	Debug = false
    else
      Debug = true
    end
  end

  if key == 'f2' then
  	Player.health = 0
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

    -- Draw damage inside each enemy
    local weapon = enemy:getWeapon()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('AT: '..weapon:getDamage(), enemy:getX() - 15, enemy:getY() - 5)
  end

  -- Print a "GAME OVER" if player died
  if Player:getHealth() < 0 then
  	love.graphics.setColor(0, 0, 0, 1)
    local x, y = 200, 280
    local w, h = 400, 40
    love.graphics.rectangle('line', x, y, w, h)
    love.graphics.setColor(1, 0, 0)
    DrawCenteredText(x, y, w, h, 'GAME OVER')
  end

  -- Print score
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('Score: '..Score)

  -- Debug info
  if Debug == true then
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(table.concat({
    'FPS: '..love.timer.getFPS(),
  },'\n'), 0, 50)
  end
end

function love.update(dt)
  -- Remove enemy if enemy hp below 0
  for enemyIndex, enemy in pairs(Enemies) do
  	if enemy:getHealth() <= 0 then
    	table.remove(Enemies, enemyIndex)
      Score = Score + 10
    end
  end

  -- Attack player with given damage and attack speed
  for enemyIndex, enemy in pairs(Enemies) do
    local weapon =      enemy:getWeapon()
    local attackSpeed = weapon:getAttackSpeed()
    local damage =      weapon:getDamage()
  	enemy.timer = enemy.timer + dt
    if enemy:getTimer() >= attackSpeed then
    	EnemiesAttack(Player, damage)
      enemy.timer = 0
    end
  end

  -- Spawn new enemies
  if GetItemsCount(Enemies) == 0 then
  	for i = 1, 3, 1 do
      if i == 1 then
      	table.insert(Enemies, i, Enemy:new(ArenaWidth / 2 - 150, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 4)]))
      elseif i == 2 then
      	table.insert(Enemies, i, Enemy:new(ArenaWidth / 2, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 4)]))
      else
        table.insert(Enemies, i, Enemy:new(ArenaWidth / 2 + 150, ArenaHeight * 0.20, 100, 0, WeaponsTable[Random(1, 4)] ))
      end
    end
  end
end