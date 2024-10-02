require("source.fly")
require("source.functions")

function newPopulation()
    -- Creating the object
    local population = {
        -- Atributtes
        fitnessSum = 0,
        genetarion = 1,
        bestFlyIndex = 0,
        minSteps = 0,

        -- Variables
        flyies = {},

        -- Functions
        populate = function (self, size)
            for i = 1, size, 1 do
                table.insert(self.flyies, i, newFly()) 
            end
        end,

        update = function (self) 
            for i, fly in ipairs(self.flyies) do
                if (fly.brain.step > self.minSteps) then--if the dot has already taken more steps than the best dot has taken to reach the goal
                    fly.dead = true; --then it dead
                else
                    fly.update()
                end
            end
        end,

        calculateFitness = function(self)
            for i, fly in ipairs(self.flyies) do
                fly.calculateFitness()
            end
        end,

        allFlyiesDead = function(self)
            for i = 1, #self.flyies, 1 do
                if not self.flyies[i].dead and not self.flyies[i].reachedFood then
                    return false
                end
            end

            return true
        end,

        naturalSelection = function(self)
            local newFlyies = {}
            self.setBestFly()
            self.calculateFitnessSum()

            newFlyies[1] = self.flyies[self.bestFly].getBrain()
            newFlyies[1].isBest = true

            for i = 2, #self.flyies, 1 do
                local flyParent = self.selectParent()

                newFlyies[i] = flyParent.getBrain()
            end

            clearTable(self.flyies)
            copyTable(self.flyies, newFlyies)

            self.generation = self.generation + 1
        end,

        calculateFitnessSum = function(self)
            self.fitnessSum = 0

            for i = 1, #self.flyies, 1 do
                self.fitnessSum = self.fitnessSum + self.flyies[i].fitness
            end
        end,

        selectParent = function(self)
            local rand = math.random(self.fitnessSum)
            local runningSum = 0

            for i = 1, #self.flyies, 1 do
                runningSum = runningSum + self.flyies[i].fitness
                if runningSum >= rand then
                    return self.flyies[i]
                end
            end

            return nil
        end,

        mutateFlyies = function(self)
            for i = 2, #self.flyies, 1 do
                self.flyies[i].mutate()
            end
        end,

        setBestFly = function(self)
            local max = 0
            local maxIndex = 0

            for i = 1, #self.flyies, 1 do
                if self.flyies[i].fitness > max then
                    max = self.flyies[i].fitness;
                    maxIndex = i;
                end
            end

            self.bestFlyIndex = maxIndex

            if self.flyies[self.bestFlyIndex].reachedFood() then
                self.minSteps = self.flyies[self.bestFlyIndex].brain.steps
            end
        end
    }

    -- Returning the object
    return population
end

-- Returning the "new" function
return newPopulation