function PlayerAttack(player, enemies)
  if player:getHealth() > 0 then
    local weapon = player:getWeapon()
  	for _, enemy in pairs(enemies) do
    	if enemy:getX() == player:getX() then
      	enemy.health = enemy.health - weapon:getDamage()
      end
    end
  end
end


function EnemiesAttack(player, enemies, dt)
  for _, enemy in pairs(enemies) do
    local weapon =      enemy:getWeapon()
    local attackSpeed = weapon:getAttackSpeed()
    local damage =      weapon:getDamage()
  	enemy.timer = enemy.timer + dt
    if enemy:getTimer() >= attackSpeed then
    	player.health = player.health - damage
      enemy.timer = 0
    end
  end
end
