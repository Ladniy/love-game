function MoveToLeft(player, enemies)
	if player:getHealth() > 0 then
	  for enemyIndex, enemy in pairs(enemies) do
	    if enemy:getX() < player:getX() then
	    	local smallerX = enemy:getX()
	      player.x = smallerX
	    end
	  end
	end
end

function MoveToRight(player, enemies)
	if player:getHealth() > 0 then
		for enemyIndex, enemy in pairs(enemies) do
	    if enemy:getX() > player:getX() then
	    	local largerX = enemy:getX()
	      player.x = largerX
	      break
	    end
	  end
	end
end
