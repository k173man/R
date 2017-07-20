# +++++ Plot the 30-day mortality rates for heart attack +++++
# setwd("Assignment 3")
outcome <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")
# head(outcome)
# ncol(outcome)
# nrow
# names(outcome)

# histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset)
outcome[, 11] <- as.numeric(outcome[, 11])
# You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])

# There is nothing to submit for this part