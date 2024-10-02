# Love2d-Neural-Network-Flyies-And-Food
Learning genetic algorithms...
Well, I will make a "game" for neural networks (my flyies) to try to find the best path for the food. It will use the best one of the flyies as the base for the next generation...

# Main
## In the main, we'll have:
- Draw all flyies, food, walls (if any)
- Verify if the generation has ended
- Restart

# Population
## Atributtes:
- Best fly index
- Generation count
- Atributte max
## Functions:
- Create flyies
- Update flyies
- Mutate the flyies using the best one

# Fly
## Default Atributtes:
- Position
- Velocity
- Atributte max
## Boolean Atributtes:
- Is dead
- Reached goal
- Is best
## Functions:
- Move
- Update
- Calculate fitness

# Brain
## Default Atributtes:
- Present step
## Functions:
- Randomize
- Get clone
- Mutate