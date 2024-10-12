-- Importing
require("source.functions")

-- Create fly's brain function
function newBrain(numSteps)
    local brain = {
        -- Atributtes
        directions = {},
        step = 1,
        size = numSteps,

        -- Functions
        initialize = function(self)
            for i = 1, self.size do
                self.directions[i] = {
                    x = 0,
                    y = 0
                }
                self.directions[i].x, self.directions[i].y = randomVector()
            end
        end,

        getBrain = function(self)
            local clone = newBrain(numSteps)
            for i = 1, #self.directions do
                clone.directions[i].x = self.directions[i].x
                clone.directions[i].y = self.directions[i].y
            end
            return clone
        end,

        -- Mutates the brain
        mutate = function(self, mutationRate)
            for i = 1, #self.directions do
                local rand = love.math.random()
                if rand < mutationRate then
                    -- Define uma direção aleatória
                    self.directions[i].x, self.directions[i].y = randomVector()
                end
            end
        end
    }

    -- Initializing the brain
    brain:initialize()

    -- Returning the object
    return brain
end

-- Returning the "new" function
return newBrain