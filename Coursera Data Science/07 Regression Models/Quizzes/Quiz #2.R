# Q1
# Give a P-value for the two sided hypothesis test of whether ??1 from a linear regression model is 0 or not.
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

# Answer
fq1 <- lm(y ~ x)
summary(fq1)

# Q2
# Consider the previous problem, give the estimate of the residual standard deviation.


# Answer



# Q3
# In the mtcars data set, fit a linear regression model of weight (predictor) on mpg (outcome)
# Get a 95% confidence interval for the expected mpg at the average weight. What is the lower endpoint?


# Answer



# Q4
# Refer to the previous question. Read the help file for mtcars. What is the weight coefficient interpreted as?


# Answer



# Q5
# Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (1,000 lbs)
# A new car is coming weighing 3000 pounds
# Construct a 95% prediction interval for its mpg. What is the upper endpoint? 


# Answer



# Q6
# Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (in 1,000 lbs)
# A "short" ton is defined as 2,000 lbs
# Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight
# Give the lower endpoint.


# Answer



# Q7
# If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?


# Answer


# Q8
# I have an outcome, Y, and a predictor, X and fit a linear regression model with Y=??0+??1X+?? to obtain ??^0 and ??^1
# What would be the consequence to the subsequent slope and intercept if I were to refit the model with a new regressor, X+c for some constant, c?


# Answer



# Q9
# Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor
# About what is the ratio of the the sum of the squared errors, ???ni=1(Yi ??? Y-hati)2 when comparing a model with just an intercept (denominator) 
# to the model with the intercept and slope (numerator)? 


# Answer



# Q10
# Do the residuals always have to sum to 0 in linear regression?


# Answer



