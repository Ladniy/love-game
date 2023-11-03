function Random(min, max)
  return love.math.random(min, max)
end

function DrawCenteredText(rectX, rectY, rectWidth, rectHeight, text)
 local font       = love.graphics.getFont()
 local textWidth  = font:getWidth(text)
 local textHeight = font:getHeight()
 love.graphics.print(text, rectX+rectWidth/2, rectY+rectHeight/2, 0, 3, 3, textWidth/2, textHeight/2)
end

function GetItemsCount(table)
  local count = 0
  for _, item in pairs(table) do
  	count = count + 1
  end
  return count
end
