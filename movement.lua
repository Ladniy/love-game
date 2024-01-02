function MoveToLeftEnemy(player, enemies)
	local currentX = player:getX()
	for _, enemy in ipairs(enemies) do
		if enemy:getX() < currentX then
	  	local smallerX = enemy:getX()
			player.x = smallerX
	  end
	end
end

function MoveToRightEnemy(player, enemies)
	local currentX = player:getX()
	for _, enemy in ipairs(enemies) do
		if enemy:getX() > currentX then
	  	local largerX = enemy:getX()
			player.x = largerX
			break
	  end
	end
end
