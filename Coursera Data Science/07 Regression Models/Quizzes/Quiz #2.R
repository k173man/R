# Q1
# Give a P-value for the two sided hypothesis test of whether B_1 from a linear regression model is 0 or not.
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

# Answer
fq1 <- lm(y ~ x)
summary(fq1)$coef[2, 4] # 0.05296

# Q2
# Consider the previous problem, give the estimate of the residual standard deviation.
# Answer - uses model from Q1 (fq1)
summary(fq1)$sigma # 0.2229981, or 0.223 (rounded)


# Q3
# In the mtcars data set, fit a linear regression model of weight (predictor) on mpg (outcome)
# Get a 95% confidence interval for the expected mpg at the average weight. What is the lower endpoint?
# Solution Notes
  # CI = B_i +/- (CV * SE for B_i)
    # _i = (0, 1), as in B_0, i.e. Beta subscript 0 (Beta Nought) and Beta subscript 1
  # CI = sc3[i + 1, 1] +/- (qt(1-(alpha/2), df = fq3$df) * sc3[i + 1, 2])
    # formula on previous line uses i + 1 b/c i = (0, 1); however, R indicies are 1 based hence the use of i + 1

# Answer
fq3 <- lm(mpg ~ I(wt - mean(wt)), data = mtcars)
sc3 <- summary(fq3)$coefficients

# print out confidence interval for beta0, which is what this question asks for:...expected mpg at the average weight...
sc3[1,1] + c(-1, 1) * qt(.975, df = fq3$df) * sc3[1, 2] # 18.99098, 21.19027
# print out confidence interval for beta1 (not needed for this question)
sc3[2,1] + c(-1, 1) * qt(.975, df = fq3$df) * sc3[2, 2]

# Alternate Method: the following 3 lines give the same results as line for bet0
# didn't mean center wt b/c I don't know how to set up the wt var in new data
fq3b <- lm(mpg ~ wt, data = mtcars)
# since we didn't mean center wt, we will use mean(wt) as the new data wt value; this will give the same answer as if it was mean centered
  # could have set up lm() using x <- mtcars$wt - mean(mtcars$wt) & y <- mtcars$mpg, then predict using new data = data.frame(x = 0)
muwt <- mean(mtcars$wt)
# use predict w/ interval = "confidence" (default level is 95% so no need to specify level = .95)
pq3b <- predict(fq3b, newdata = data.frame(wt = muwt), interval = "confidence")

# Q4
# Refer to the previous question. Read the help file for mtcars. What is the weight coefficient interpreted as?
head(mtcars)
?mtcars

# Answer
# wt (weight) is report in 1,000s of lbs., i.e. weight (lbs.)/1,000; e.g. 1.5K is stored as 1.5
# slope indicated change is MPG for each additional 1K lbs. in weight


# Q5
# Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (1,000 lbs)
# A new car is coming weighing 3000 pounds
# Construct a 95% prediction interval for its mpg. What is the upper endpoint? 

# Answer - using model from Q3; wt = 3000/1000 = 3
fq5 <- lm(mpg ~ wt, data = mtcars)
pq5 <- predict(fq5, newdata = data.frame(wt = 3), interval = "prediction")
pq5[1, "upr"] # 27.57355

# Q6
# Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (in 1,000 lbs)
# A "short" ton is defined as 2,000 lbs
# Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight
# Give the lower endpoint.
# mtcar$wt reports in lbs/1000, we need to convert to lbs/2000, i.e. mtcar$wt/2, or mtcar$wt*1000/2000

# Answer
mpg <- mtcars$mpg
wt <- mtcars$wt/2
fq6 <- lm(mpg ~ wt)
sc6 <- summary(fq6)$coefficients
sc6[2,1] + c(-1, 1) * qt(.975, df = fq6$df) * sc6[2, 2] # [-12.97262, -8.40527]


# Q7
# If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?
# Scaling, i.e. multiplication/division of X by a constant, changes slope, but doesn't change intercept
  # if X is multiplied by a constant, then the slope must be divided by the same constant
  # B_0 + B_1X => B_0 + (B_1/c)(X * c) = B_0 + (B_1 * X * C)/C
    # this results in a slope = B_1/C, but y doesn't change b/c the C's in the numerator & denominator, (B_1 * X * C)/C, cancel each other out
  # Conversely, if you divide X by a constant, C, the slope is multiplied by C

# Answer


# Q8
# I have an outcome, Y, and a predictor, X and fit a linear regression model with Y = B_0 + B_1X
# What would be the consequence to the subsequent slope and intercept if I were to refit the model with a new regressor, X+c for some constant, c?

# Shifting, i.e. addition/subtraction of a constant to/from X, changes intercept, but doesn't change slope
# if X is reduced by a constant, i.e. X - C, then a term, C*B_1 is added to equation to balance it out (net 0 effect)
  # B_0 + B_1X => B_0 + c * B_1 + B_1(X - C) = B_0 + C*B_1 + B_1*X - B_1*C
  # this results in an intercept = B_0 + C*B_1, but y doesn't change b/c C*B_1 & -C*B_1 = 0
# Conversely, increasing X by a constant, i.e. X + C, then a term C*B_1 is subtracted (or a -C*B_1 is added) to balance it out (net 0 effect)
  # this results in an intercept = B_0 - C*B_1

# Answer



# Q9
# Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor
# About what is the ratio of the the sum of the squared errors, Sum(Y_i - Y-hat_i)^2, when comparing a model with just an intercept (denominator) 
# to the model with the intercept and slope (numerator)? 

# This questions is asking what's the ratio of Sum(Y_i - Y-hat_i)^2/Sum(Y_i - mean(Y))^2, i.e. regression variation/total variation, or R^2 

# Answer
x <- mtcars$wt
y <- mtcars$mpg

# Intercept only (IO) model, i.e. mean(y); this is here for informational purposes
fq9IO <- lm(y ~ 1)
fq9 <- lm(y ~ x)

summary(fq9)$r.squared # 0.7528328

# Q10
# Do the residuals always have to sum to 0 in linear regression?

# Answer
# If an intercept is included



