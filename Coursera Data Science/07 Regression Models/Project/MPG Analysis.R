library(dplyr)
library(ggplot2)

data("mtcars")
# head(mtcars)

# factorLevels <- list(
#   cyl = paste(sort(unique(mtcars$cyl)), "Cylinder", sep = " "), 
#   vs = c("V", "Straight"), 
#   am = c("Automatic", "Manual"), 
#   gear = paste(sort(unique(mtcars$gear)), "Speed", sep = " "), 
#   carb = sort(unique(mtcars$carb))
# )
# 
# for(nm in names(factorLevels))
#   mtcars[, nm] <- factor(mtcars[, nm], labels = factorLevels[[nm]])

# Box Plot MPG vs. Transmission Type
ggplot(aes(am, mpg), data = mtcars) + 
  geom_boxplot(aes(fill = am)) + 
  labs(x = "Transmission", y = "M.P.G.", title = "M.P.G. vs. Transmission Type")

# Choose a model by AIC in a Stepwise Algorithm
slm <- step(lm(data = mtcars, mpg ~ .), direction = "both")
summary(slm)



