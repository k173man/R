# project mpg, cyl, disp 
mtcars2 <- subset(mtcars, select = c(mpg, cyl, disp))
# project mpg, cyl, disp; i.e. variables 1, 2, 3
mtcars2 <- mtcars[c(1, 2, 3)]
# project mpg, cyl, disp; i.e. exclude variables 4-11
mtcars2 <- mtcars[c(-4, -5, -6, -7, -8, -9, -10, -11)]