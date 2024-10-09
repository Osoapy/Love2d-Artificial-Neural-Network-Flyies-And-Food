function newFly()
    local fly = {
        -- Default atributtes
        position = {
            x = 0,
            y = 0
        },
        vel = 0,
        acc = 0,
        fitness = 0,

        brain = newBrain(1000),

        -- Boolean atributtes
        dead = false,
        reachedGoal = false,
        isBest = false,

        -- Functions
        show = function(self)
            if self.isBest then
                love.graphics.setColor(0, 1, 0) -- Verde
                love.graphics.circle("fill", self.pos.x, self.pos.y, 8)
            else
                love.graphics.setColor(0, 0, 0) -- Preto
                love.graphics.circle("fill", self.pos.x, self.pos.y, 4)
            end
        end,

        move = function(self)
            if self.brain.step < #self.brain.directions then
                self.acc = self.brain.directions[self.brain.step]
                self.brain.step = self.brain.step + 1
            else
                self.dead = true
            end

            self.vel.x = self.vel.x + self.acc.x
            self.vel.y = self.vel.y + self.acc.y

            local maxSpeed = 5
            if self.vel.x > maxSpeed then self.vel.x = maxSpeed end
            if self.vel.y > maxSpeed then self.vel.y = maxSpeed end

            self.pos.x = self.pos.x + self.vel.x
            self.pos.y = self.pos.y + self.vel.y
        end,

        update = function(self, goal)
            if not self.dead and not self.reachedGoal then
                self:move()

                if self.pos.x < 2 or self.pos.y < 2 or self.pos.x > love.graphics.getWidth() - 2 or self.pos.y > love.graphics.getHeight() - 2 then
                    self.dead = true
                elseif dist(self.pos.x, self.pos.y, goal.x, goal.y) < 5 then
                    self.reachedGoal = true
                elseif self.pos.x < 600 and self.pos.y < 310 and self.pos.x > 0 and self.pos.y > 300 then
                    self.dead = true
                end
            end
        end,

        calculateFitness = function(self, goal)
            if self.reachedGoal then
                self.fitness = 1.0 / 16.0 + 10000.0 / (self.brain.step * self.brain.step)
            else
                local distanceToGoal = dist(self.pos.x, self.pos.y, goal.x, goal.y)
                self.fitness = 1.0 / (distanceToGoal * distanceToGoal)
            end
        end,

        clone = function()
            local baby = Dot:new()
            baby.brain = self.brain:clone()
            return baby
        end,

        dist = function(x1, y1, x2, y2)
            return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
        end
    }

    return fly
end

return newFly