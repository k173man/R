r <- round(rnorm(2), 1)
x <- r[1] / r[2]

# apparently, the else if branches must be written on the same line as the closing curly brace of the preceding if/else if, e.g. } else if (...) {
if(is.nan(x)) {
    message("x is missing")
} else if(is.infinite(x)) {
    message("x is infinite")
} else if(x > 0) {
    message("x is positive")
} else if(x < 0) {
    message("x is negative")
} else {
    message("x is zero")
}

# coinTosses10 holds the results of 10 simulated coin tossess, i.e. 10 random binomial vars w/ a 50/50 chance of being 0 or 1
coinTosses <- rbinom(10, 1, 0.5)
# vectorized if: the ifelse(...) below is effectively the same as:
    ## if (coinTosses[1])
    ##      "Heads"
    ## else
    ##      "Tails"
    ## ...
    ## if (coinTosses[10])
    ##      "Heads"
    ## else
    ##      "Tails"
ifelse(coinTosses, "Head", "Tail")

heads <- sapply(1:10, function (i) sprintf("Heads %02d", i))
tails <- sapply(1:10, function (i) sprintf("Tails %02d", i))
# the 2nd & 3rd args to ifelse(...) can be vectors
ifelse(coinTosses, heads, tails)

# switch(...) - the 1st arg is the expression to evaluate & subsequent args are the list of alternatives to return
    ## in this implementation the testVar indicates whether the 1st, 2nd, 3rd, etc. 
testVar <- 3
switch(testVar, "first", "second", "third", "fourth")
# an alternative form of switch(...): the 1st arg is the expression to evaluate
    ## subsequent args are the list of alternatives to return, which are assigned to labels; if not assigned to a label, the last arg is the default
testVar <- "gamma"
switch(testVar,
    alpha = 1, 
    beta  = sqrt(4), 
    gamma = {
        a <- sin(pi / 3)
        4 * a ^ 2
    }
)




