local myFont = nil

-- Window config
love.window.setMode(800, 800, {
    resizable = false,
    minwidth = 800,   
    minheight = 800 
})

function love.load()
    -- Load the font
    myFont = love.graphics.newFont("assets/jetBrains.ttf", 26)
    love.graphics.setFont(myFont)
end

function love.update(dt)
end

function love.draw()
end