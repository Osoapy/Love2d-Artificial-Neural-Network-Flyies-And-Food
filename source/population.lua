-- Importing
require("source.fly")
require("source.functions")

-- Create population function
function newPopulation(numFlies, maxSteps, maxSpeed, food, mutationRate)
    -- Creating the object
    local population = {

        -- Atributtes
        fitnessSum = 0,
        generation = 1,
        bestFlyIndex = 0,

        -- Tables
        flies = {},

        -- Functions
        show = function(self, flyImage)
            for i = 1, numFlies, 1 do
                self.flies[i]:show(flyImage)
            end
        end,

        populate = function(self, size)
            for i = 1, size, 1 do
                table.insert(self.flies, i, newFly(maxSteps, maxSpeed)) 
            end
        end,

        update = function(self) 
            for i = 1, #self.flies, 1 do
                if self.flies[i].brain.step > maxSteps then -- if the dot has already taken more steps than the best dot has taken to reach the goal kill him
                    self.flies[i].dead = true; 
                else
                    self.flies[i]:update(food)
                end
            end
        end,

        calculateFitness = function(self, food)
            for i = 1, #self.flies, 1 do
                self.flies[i]:calculateFitness(food)
            end
        end,

        allFlyiesDead = function(self)
            for i = 1, #self.flies, 1 do
                if not self.flies[i].dead and not self.flies[i].reachedFood then
                    return false
                end
            end

            return true
        end,

        naturalSelection = function(self)
            local newFlies = {}
            self:setBestFly()
            self:calculateFitnessSum()
        
            newFlies[1] = newFly(maxSteps, maxSpeed) -- Recreates the best fly
            newFlies[1].brain = self.flies[self.bestFlyIndex].brain:getBrain() -- Copyies the best fly brain
            newFlies[1].isBest = true -- Better fly = true
        
            for i = 2, #self.flies, 1 do
                local flyParent = self:selectParent()
                newFlies[i] = newFly(maxSteps, maxSpeed) -- Creates new fly
                newFlies[i].brain = flyParent.brain:getBrain() -- Copy the father's brain
            end
        
            clearTable(self.flies)
            copyTable(self.flies, newFlies)
        
            self.generation = self.generation + 1
        end,

        calculateFitnessSum = function(self, food)
            self.fitnessSum = 0

            for i = 1, #self.flies, 1 do
                self.fitnessSum = self.fitnessSum + self.flies[i].fitness
            end
        end,

        selectParent = function(self)
            self:calculateFitnessSum()
        
            if self.fitnessSum == 0 then
                return self.flies[math.random(1, #self.flies)] -- Return random fly if fitness = 0
            end
        
            local rand = math.random() * self.fitnessSum
            local runningSum = 0
        
            for i = 1, #self.flies, 1 do
                runningSum = runningSum + self.flies[i].fitness
                if runningSum >= rand then
                    return self.flies[i]
                end
            end
        
            -- Caso ocorra algum erro e o pai não seja selecionado
            error("No parent selected, something went wrong in the fitness or selection...")
        end,

        mutateFlies = function(self)
            for i = 2, #self.flies, 1 do
                self.flies[i].brain:mutate(mutationRate)
            end
        end,

        setBestFly = function(self)
            local max = 0
            local maxIndex = 0

            for i = 1, #self.flies, 1 do
                if self.flies[i].fitness > max then
                    max = self.flies[i].fitness;
                    maxIndex = i;
                end
            end

            self.bestFlyIndex = maxIndex

            if self.flies[self.bestFlyIndex].reachedFood then
                maxSteps = self.flies[self.bestFlyIndex].brain.step
            end
        end
    }

    -- Populating the test
    population:populate(numFlies)

    -- Returning the object
    return population
end

-- Returning the "new" function
return newPopulation