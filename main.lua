-- Importing
require("data.functions.drawLayout")
require("source.population")

-- Recieving proportions
local screenHeight, screenWidth = love.graphics.getHeight(), love.graphics.getWidth()

-- Path variables
local fontPath = "data.assets/jetBrains.ttf"
local backgroundPath = "data.assets/background.png"

--[[
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
]]

-- ENVIRORMENT VARIABLES

local food = {
    x = screenWidth * 0.65,
    y = screenHeight * 0.2,
    radius = 10
}

local test = newPopulation()

--[[
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
]]--

-- Initializing assets
local myFont = nil
local background = nil

-- Window configuration
love.window.setMode(600, 600, {
    resizable = false,
    minwidth = 600,   
    minheight = 600
})

function love.load()
    -- Setting the title
    love.window.setTitle("Better And Better Flyies")

    -- Load the font
    myFont = love.graphics.newFont(fontPath, 26)
    love.graphics.setFont(myFont)

    -- Load the background
    background = love.graphics.newImage(backgroundPath)
    assert(background, "Loading error on background.png!")
end

function love.update(dt)
end

function love.draw()
    -- Layer 0 (background)
    drawBackground(background)

    -- Layer 1
    love.graphics.circle("fill", food.x, food.y, food.radius)
end