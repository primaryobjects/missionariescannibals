#
# Missionaries and Cannibals
# in R
# by Kory Becker 2015 http://primaryobjects.com/kory-becker
# 
# This program solves the Missionaries and Cannibals AI problem. See http://www.aiai.ed.ac.uk/~gwickler/missionaries.html
#
# Rules: On one bank of a river are three missionaries and three cannibals.
# There is one boat available that can hold up to two people and that they would like to use to cross the river.
# If the cannibals ever outnumber the missionaries on either of the river’s banks, the missionaries will get eaten. 
# How can the boat be used to safely carry all the missionaries and cannibals across the river?
#

# Define starting state: 3 missionaries on left, 3 cannibals on left, boat on left.
startState <- data.frame(m = c(3,0), c = c(3,0), boat = 'left', row.names = c('left', 'right'))

# Define goal state: 3 missionaries on right, 3 cannibals on right, boat on right.
goalState <- data.frame(m = c(0,3), c = c(0,3), boat = 'right', row.names = c('left', 'right'))

# Define valid operators: m1c0, m2c0, m0c1, m0c2, m1c1.
operators <- data.frame(m = c(1, 2, 0, 0, 1), c = c(0, 0, 1, 2, 1), row.names = c('m1c0', 'm2c0', 'm0c1', 'm0c2', 'm1c1'))

getStateName <- function(state) {
  # Converts state to a friendly string.
  paste(paste('L:m', state['m'][1,], 'c', state['c'][1,], sep = ''), paste('R:m', state['m'][2,], 'c', state['c'][2,], sep = ''), paste('B:', state[1, 'boat'], sep = ''))
}

action <- function(state, operator) {
  # Transition to next state by applying operator to current state. For example: operators['m1c0',].
  if (state['boat'][1,] == 'left') {
    # Boat is on left side, so move missionaries and cannibals to the right (subtract from left, add to right). Change boat to right side.
    leftMissionaries <- state['m']['left',] - operator$m
    leftCannibals <- state['c']['left',] - operator$c
    rightMissionaries <- state['m']['right',] + operator$m
    rightCannibals <- state['c']['right',] + operator$c
    
    newState <- data.frame(m = c(leftMissionaries, rightMissionaries), c = c(leftCannibals, rightCannibals), boat = 'right', row.names = c('left', 'right'))
  }
  else {
    # Boat is on right side, so move missionaries and cannibals to the left (add to left, subtract from right). Change boat to left side.
    leftMissionaries <- state['m']['left',] + operator$m
    leftCannibals <- state['c']['left',] + operator$c
    rightMissionaries <- state['m']['right',] - operator$m
    rightCannibals <- state['c']['right',] - operator$c
    
    newState <- data.frame(m = c(leftMissionaries, rightMissionaries), c = c(leftCannibals, rightCannibals), boat = 'left', row.names = c('left', 'right'))    
  }
  
  if (isValid(newState)) {
    return (newState)
  }
  else {
    return (NULL)
  }
}
  
isGoal <- function(state) {
  # Check if the current state is the goal state.
  return (identical(state, goalState))
}

isValid <- function(state) {
  # Check if the current state is valid. A state is valid if the number of missionaries is >= the number of cannibals on the same side.
  return (state['m']['left',] >= 0 && state['c']['left',] >= 0 &&
           (state['m']['left',] >= state['c']['left',] || state['m']['left',] == 0) &&
         state['m']['right',] >= 0 && state['c']['right',] >= 0 &&
           (state['m']['right',] >= state['c']['right',] || state['m']['right',] == 0))
}

transitions <- function(state, parentState = NULL, depth = 0) {
  # Find all valid transitions from the state.
  paths <- c()
  
  # Run each operator on the current state.
  for (index in 1:nrow(operators)) {
    # Get operator.
    operator <- operators[index,]
    
    # Apply operator to state.
    nextState <- action(state, operator)
    
    if (!is.null(nextState) && !identical(nextState, parentState)) {
      # This is a valid transition.
      paths <- rbind(paths, c(operator = row.names(operator), nextState = getStateName(nextState)))
    }
  }
  
  return (paths)
}

findSolution <- function(state, parentState = NULL, depth = 0, solution = NULL) {
  # Finds all possible solutions from a starting state, within a depth of 15. Uses recursion to evaluate a depth-first search across the transition paths.
  # Example: findSolution(startState)
  if (depth < 15) {
    #print('')
    #print(paste('Depth', depth))
    #print(paste('Current:', getStateName(state)))
    #print('Paths:')
    
    # Run each operator on the current state.
    for (index in 1:nrow(operators)) {
      # Get operator.
      operator <- operators[index,]
      
      # Apply operator to state.
      nextState <- action(state, operator)
      
      if (!is.null(nextState) && !identical(nextState, parentState)) {
        # This is a valid transition.
        #print(paste(row.names(operator), getStateName(nextState)))
        
        if (isGoal(nextState)) {
          # Append last operator to solution.
          solution <- c(solution, row.names(operator))
          
          print(paste('*********************** Solution found in', length(solution), 'steps!'))
          sapply(solution, print)
        }
        else {
          # Find transitions from new state (append operator to solution path).
          findSolution(nextState, state, depth + 1, c(solution, row.names(operator)))
        }
      }
    }
  }
}