-- Importing
require("data.functions.drawLayout")
require("source.population")

-- Recieving proportions
local screenHeight, screenWidth = love.graphics.getHeight(), love.graphics.getWidth()

-- Path variables
local fontPath = "data/assets/jetBrains.ttf"
local backgroundPath = "data/assets/background.png"

-- Global variables
test = nil
debugParameter = nil

--[[
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
]]

-- ENVIRORMENT VARIABLES

local title = "Better And Better Flyies" -- Window title

local food = { -- Food coords
    x = screenWidth * 0.65,
    y = screenHeight * 0.2,
    radius = 10
}

local numFlyies = 500 -- Number of flyies
local maxSteps = 300 -- Max of steps
local maxSpeed = 50 -- Max of speed
local mutationRate = 0.01 -- Mutation rate

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
    -- Setting a pseudo-randomic seed 
    math.randomseed(os.time())

    -- Setting the title
    love.window.setTitle(title)

    -- Load the font
    myFont = love.graphics.newFont(fontPath, 26)
    love.graphics.setFont(myFont)

    -- Load the background
    background = love.graphics.newImage(backgroundPath)
    assert(background, "Loading error on background.png!")

    -- Load the population
    test = newPopulation(numFlyies, maxSteps, maxSpeed, food, mutationRate) -- Object population
end

function love.update(dt)
    if test:allFlyiesDead() then
        test:calculateFitness(food);
        test:naturalSelection();
        test:mutateFlyies();
    else 
        -- if any of the dots are still alive then update and then show them
        test:update();
        test:show();
    end
    debugParameter = tostring("Generation: " .. tostring(test.generation))
end

function love.draw()
    -- Layer 0 (background)
    drawBackground(background)

    -- Layer 1 (food)
    love.graphics.setColor(1, 1, 1) -- Green
    love.graphics.circle("fill", food.x, food.y, food.radius)

    -- Layer 2 (Flyies)
    test:show();

    -- Final layer (Debug)
    if debugParameter then
        debug(debugParameter)
    end
end