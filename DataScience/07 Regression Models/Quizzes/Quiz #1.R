# Q1 
# Give the value of u, i.e. mu, that minimizes the least squares equation sum(w_i(x_i - u)^2) <- this equation was written using summary notation; _i = subscript i
# values
x <- c(0.18, -1.54, 0.42, 0.95)
# weights
w <- c(2, 1, 3, 1)
# Answer
# Typically, the value that minimizes the sum of least squares is simply the average of your values, in this case x
# However, the weights indicated the # of times the corresponding x value is repeated
# The sum(w) = n, i.e. n != 4, n = 7

# x expanded
x2 <- rep(x, w)
ans1 <- mean(x2) #0.1471429

# Additional Info
# you can use the optimize() function to perform minimization
fx <- function(u) { sum(w*(x-u)^2) }
minFx <- optimize(fx, interval=c(-100,100))
minFx$minimum # the value that minimizes the objective function, in this case fx
minFx$objective # the y-value for the x-value that minimizes the objective function

# Here we define a function of u (we use sapply because otherwise the sum() would collapse the results when running the function for multiple points) 
# Then plot it using curve()
obj <- function(U){sapply(U, fx)}
curve(obj, from=-2, to=2)


# Q2
# Fit the regression through the origin and get the slope treating y as the outcome and x as the regressor
# Hint, do not center the data since we want regression through the origin, not through the means of the data
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

fitQ2 <- lm(y ~ x - 1)
# Answer
coef(fitQ2)
# Alternative way of calculating slope of a line through the origin
sum(x*y)/sum(x^2)

# Q3
# Using mtcars fit the regression model with mpg as the outcome and weight as the predictor. Give the slope coefficient

data(mtcars)

fitQ3 <- lm(mpg ~ wt, data = mtcars)
coef(fitQ3)[2]

# Q4
# Y = outcome & X = predictor
# The standard deviation of the predictor is one half that of the outcome
# The correlation between the two variables is .5. 
# What value would the slope coefficient?

# Answer
# slope = cor(Y, X)*sd(Y)/sd(X)
corYX <- .5
sdY <- 100
sdX <- .5 * sdY
corYX*sdY/sdX
corYX*(sdY/sdX)

# Q6
# What is the value of the first measurement if x were normalized (to have mean 0 and variance 1)?
xQ6 <- c(8.58, 10.46, 9.01, 9.64, 8.86)
stdX <- (xQ6 - mean(xQ6))/sd(xQ6)

# Answer
stdX[1]

# Q7
# Consider the following data set (used above as well). What is the intercept for fitting the model with x as the predictor and y as the outcome?
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

fitQ7 <- lm(y ~ x)
# Answer
coef(fitQ7)[1]

# Q8
# You know that both the predictor and response have mean 0. What can be said about the intercept when you fit a linear regression?
# Answer
# Intercept = Y-bar ??? ??-hat*X-bar
# if Y-bar = 0 & X-bar = 0, then the intercept is 0

# Q9
# What value minimizes the sum of the squared distances between these points and itself?
xQ9 <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(xQ9)

# Q10
# Part 1: Y = outcome & X = predictor; slope that fits Y to X = B_1 (beta_1)
# Part 2: X = outcome & Y = predictor; slope that fits X to Y = R_1 (rho_1)
# Part 1 & 2 basically flip the outcome & predictor variables, i.e. y = x becomes x = y
# Suppose that you divide B_1 by R_1; in other words B_1/R_1
# What is this ratio always equal to?

# Answer
# B_1 = cor(Y, X)*(sd(Y)/sd(X))
# R_1 = cor(X, Y)*(sd(X)/sd(Y))
# B_1/R_1 = [cor(Y, X)*(sd(Y)/sd(X))] / [cor(X, Y)*(sd(X)/sd(Y))]
# cor(Y, X) = cor(X, Y), so the 2 terms cancel out & we're left with:
    # [(sd(Y)/sd(X))] / [(sd(X)/sd(Y))] = sd(Y)^2/sd(X)^2 = Var(Y)/Var(X)



