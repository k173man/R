library(dplyr)
library(ggplot2)

data("mtcars")
head(mtcars)
# [, 1]	 mpg	 Miles/(US) gallon
# [, 9]	 am	 Transmission (0 = automatic, 1 = manual)

mtc <- mtcars %>% 
    mutate(MakeModel = row.names(mtcars), MPG = mpg, Transmission = factor(ifelse(am, "Manual", "Automatic"))) %>% 
    select(MakeModel, MPG, Transmission)
    
ggplot(aes(Transmission, MPG), data = mtc) + 
    geom_boxplot(aes(fill = Transmission)) + 
    labs(x = "Transmission", y = "MPG", title = "M.P.G. as a Function of Type of Transmission")
