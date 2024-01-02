require 'utils'
require 'objects/character'
require 'objects/enemy'
require 'objects/weapon'
require 'movement'
require 'combat'
require 'graphics'

local lg = love.graphics

function love.load()
  Debug = false

  ArenaWidth = 800
  ArenaHeight = 600

  Player = Character:new(ArenaWidth / 2, ArenaHeight / 2 + 150, 100,
    WeaponsTable[Random(1, 3)], lg.newImage('assets/new-character.png'))

  GameState = 'combat'

  Score = 0
end

function love.keypressed(key)
  if key == 'left' and GameState == 'combat' then
  	MoveToLeftEnemy(Player, EnemiesTable)
  end

  if key == 'right' and GameState == 'combat' then
  	MoveToRightEnemy(Player, EnemiesTable)
  end

  if key == 'space' and GameState == 'combat' then
  	PlayerAttack(Player, EnemiesTable)
  end

  if key == 'f1' then
    if Debug then
    	Debug = false
    else
      Debug = true
    end
  end

  -- Instant players death for debug
  if key == 'f2' then
  	Player.health = 0
  end
end

function love.update(dt)
  SpawnEnemies(EnemiesTable)

  -- Call function for enemies attack
  EnemiesAttack(Player, EnemiesTable, dt)

  -- Remove enemy if enemy hp below 0
  RemoveEnemy(EnemiesTable)
end

function love.draw()
  -- Draw combat GUI if player in combat
  if GameState == 'combat' then
  	lg.draw(CombatGUI)
  end

  -- Player drawning
  if Player:getHealth() > 0 then
    -- Draw a player
    lg.draw(Player:getImage(), Player:getX() - 32, Player:getY() - 32)
    -- Draw a health bar
    lg.setColor(0, 1, 0)
    lg.rectangle('fill', Player:getX() - 25, Player:getY() + 40, Player:getHealth() * 0.5, 10)

    -- Print a health points
    lg.setColor(1, 1, 1)
    lg.print('HP: '..Player:getHealth(), Player:getX() - 25, Player:getY() + 40)
  end

  -- Enemy drawning
  for _, enemy in pairs(EnemiesTable) do
    -- Draw each enemy
  	lg.setColor(1, 1, 1, 1)
    lg.draw(enemy:getImage(), enemy:getX() - 32, enemy:getY() - 32)

    -- Draw a health bar for each enemy
    lg.setColor(0, 1, 0)
    lg.rectangle('fill', enemy:getX() - 25, enemy:getY() + 40, enemy:getHealth() * 0.5, 10)

    -- Print a health points for each enemy
    lg.setColor(1, 1, 1)
    lg.setFont(Font24)
    lg.print('HP: '..enemy:getHealth(), enemy:getX() - 25, enemy:getY() + 40)
  end

  -- Print a "GAME OVER" if player died
  if Player:getHealth() < 0 then
    lg.setFont(Font48)
  	lg.setColor(0, 0, 0, 1)
    local x, y = 200, 280
    local w, h = 400, 40
    lg.rectangle('line', x, y, w, h)
    lg.setColor(1, 0, 0)
    DrawCenteredText(x, y, w, h, 'GAME OVER')
  end

  -- Print score
  lg.setColor(1, 1, 1)
  lg.setFont(Font24)
  lg.print('Score: '..Score)

  -- Debug info
  if Debug == true then
    lg.setColor(1, 1, 1)
    lg.setFont(Font24)
    lg.print(table.concat({
    'FPS: '..love.timer.getFPS(),
  },'\n'), 0, 50)
  end
end
