### Pipe Operator in R
## https://www.datacamp.com/community/tutorials/pipe-r-tutorial
###


## Meta
# Chaining: pass an intermediate result onto the next function
# invoke multiple method calls
# Pipeline: standardized chain of processing actions
##


## Libraies
library(magrittr)
##


### Ex: showcase simplicity

## Data
x <- c(0.109, 0.359, 0.63, 0.996, 0.515, 0.142, 0.017, 0.829, 0.907)

## Typical example of nested code
round(exp(diff(log(x))), 1)

## Same code as a pipeline
x %>%
  log() %>%
  diff() %>%
  exp() %>%
  round(1)

## Benefits of using pipes in R
# Structure is left to right; vs. inside to out
# Avoid nested function calls
# Minimize local variables and function definitions
# Easy to add steps anywhere in the sequence of operations

## Notice how
# h(g(f(x)))
# x %>% g %>% h
##
###


### Building Unary Functions

## Definition
# functions that take one argument
# can be used later if you want to apply it to values
##

## Ex1
# Assign a function
f <- . %>% cos %>% sin