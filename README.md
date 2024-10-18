# Love2d-Neural-Network-Flyies-And-Food
Learning genetic algorithms...
Well, I will make a "game" for neural networks (my flies) to try to find the best path for the food. It will use the best one of the flies as the base for the next generation...

# Main
## In the main, we'll have:
- Draw everything
- Verify if every fly is dead
- Mutate every fly
- Restart

# Population
## Parameters
- Number of flies
- Maximum of steps
- Max speed
- Food coordinates
- The mutation rate
## Internal Atributtes:
- General fitness
- Generation count
- Best fly index
- All flies
## Functions:
- Show flies
- Create flies
- Update flies
- Calculate fitness
- Read if all flies are dead
- Mutate the flies using the best one

# Fly
## Parameters
- Maximum of steps
- Max speed
## Normal Atributtes:
- Position
- Velocity
- Acceleration
- Fly radius
- Fitness
## Boolean Atributtes:
- Is dead
- Reached goal
- Is best
## Functions:
- Move
- Update
- Calculate fitness
- Clone

# Brain
## Default Atributtes:
- Directions
- Present step
- Size
## Functions:
- Randomize
- Get clone
- Mutate

# Functions
## dist
- Distance between 2 dots
## randomVector
- Random directions
## Debug
- Used for debugging code