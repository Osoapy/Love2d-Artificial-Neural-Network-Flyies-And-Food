-- Initializing assets
local myFont = nil
local background = nil
-- Recieving proportions
local screenHeight, screenWidth = love.graphics.getHeight(), love.graphics.getWidth()

-- Importing
require("functions.drawLayout")

-- Window configuration
love.window.setMode(600, 600, {
    resizable = false,
    minwidth = 600,   
    minheight = 600
})

function love.load()
    -- Setting the title
    love.window.setTitle("Better And Better Flyies")

    -- Load the background
    background = love.graphics.newImage("assets/background.png")
    assert(background, "Loading error on background.png!")

    -- Load the font
    myFont = love.graphics.newFont("assets/jetBrains.ttf", 26)
    love.graphics.setFont(myFont)
end

function love.update(dt)
end

function love.draw()
    drawBackground(background)
end