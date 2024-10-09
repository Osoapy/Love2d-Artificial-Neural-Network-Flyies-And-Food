function drawBackground(background)
    love.graphics.setColor(1, 1, 1)
    local screenHeight, screenWidth = love.graphics.getHeight(), love.graphics.getWidth()
    love.graphics.draw(background, 0, 0, 0, screenWidth / background:getWidth(), screenHeight / background:getHeight())
end