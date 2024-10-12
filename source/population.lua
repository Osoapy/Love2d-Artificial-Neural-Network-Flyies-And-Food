-- Importing
require("source.fly")
require("source.functions")

-- Create population function
function newPopulation(numFlyies, numSteps, maxSpeed, food, mutationRate)
    -- Creating the object
    local population = {

        -- Atributtes
        fitnessSum = 0,
        generation = 1,
        bestFlyIndex = 0,
        maxSteps = numSteps,

        -- Tables
        flyies = {},

        -- Functions
        show = function(self)
            for i = 1, numFlyies, 1 do
                self.flyies[i]:show()
            end
        end,

        populate = function(self, size)
            for i = 1, size, 1 do
                table.insert(self.flyies, i, newFly(self.maxSteps, maxSpeed)) 
            end
        end,

        update = function(self) 
            for i = 1, #self.flyies, 1 do
                if self.flyies[i].brain.step > self.maxSteps then -- if the dot has already taken more steps than the best dot has taken to reach the goal kill him
                    self.flyies[i].dead = true; 
                else
                    self.flyies[i]:update(food)
                end
            end
        end,

        calculateFitness = function(self, food)
            for i = 1, #self.flyies, 1 do
                self.flyies[i]:calculateFitness(food)
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
            self:setBestFly()
            self:calculateFitnessSum()
        
            newFlyies[1] = newFly(self.maxSteps, maxSpeed) -- Recreates the best fly
            newFlyies[1].brain = self.flyies[self.bestFlyIndex].brain:getBrain() -- Copyies the best fly brain
            newFlyies[1].isBest = true -- Better fly = true
        
            for i = 2, #self.flyies, 1 do
                local flyParent = self:selectParent()
                newFlyies[i] = newFly(self.maxSteps, maxSpeed) -- Creates new fly
                newFlyies[i].brain = flyParent.brain:getBrain() -- Copy the father's brain
            end
        
            clearTable(self.flyies)
            copyTable(self.flyies, newFlyies)
        
            self.generation = self.generation + 1
        end,

        calculateFitnessSum = function(self, food)
            self.fitnessSum = 0

            for i = 1, #self.flyies, 1 do
                self.fitnessSum = self.fitnessSum + self.flyies[i].fitness
            end
        end,

        selectParent = function(self)
            self:calculateFitnessSum()

            if self.fitnessSum == 0 then
                return self.flyies[math.random(1, #self.flyies)] -- Return random fly if fitness = 0
            end
        
            local rand = math.random(self.fitnessSum)
            local runningSum = 0
        
            for i = 1, #self.flyies, 1 do
                runningSum = runningSum + self.flyies[i].fitness
                if runningSum >= rand then
                    return self.flyies[i]
                end
            end

            -- Shouldn't go here
            return self.flyies[math.random(1, #self.flyies)]
        end,

        mutateFlyies = function(self)
            for i = 2, #self.flyies, 1 do
                self.flyies[i].brain:mutate(mutationRate)
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

            if self.flyies[self.bestFlyIndex].reachedFood then
                self.maxSteps = self.flyies[self.bestFlyIndex].brain.steps
            end
        end
    }

    -- Populating the test
    population:populate(numFlyies)

    -- Returning the object
    return population
end

-- Returning the "new" function
return newPopulation