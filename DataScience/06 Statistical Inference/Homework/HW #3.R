data("mtcars")

# Q1
# Load the data set mtcars; calculate a 95% CI to the nearest MPG for the variable mpg
round(t.test(mtcars$mpg)$conf.int)

# Q2
# Suppose that sd of 9 paired differences is 1
# What value would the average difference have to be so that the lower endpoint of a 95% students t confidence interval touches zero?
## Use .975 (.025 on the lower end + .025 on the upper end = .05 => 1 - .05 = .95)
## If the average = ME (t * SE), then the average - ME = 0
round(qt(.975, df = 8) * 1/3, 2)

# Q4
# Using mtcars dataset
# Construct a 95% T interval for MPG comparing 4 to 6 cylinder cars (subtracting in the order of 4 - 6) assume a constant variance.
c4 <- mtcars$mpg[mtcars$cyl == 4]
c6 <- mtcars$mpg[mtcars$cyl == 6]

t.test(c4, c6, var.equal = T)

# Q6 - Refers to the setup of, and answer for, Q4
## Since c4 is the 1st parameter, and c6 is the 2nd parameter, the t.test() subtracted c4 from c6
## Since the CI is entirely above 0, the test suggests that c4 > c6, i.e. 4-cyl MPG > 6-cyl MPG


# Q7
# Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo
# Subjects' BMIs were measured at a baseline and again after having received the treatment or placebo for four weeks
# The average difference from follow-up to the baseline (followup - baseline) was 3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. 
# The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. 
# The study aims to answer whether the change in BMI over the four week period appear to differ between the treated and placebo groups. 
## since the sample sizes are the same, we can calculate a simple average (as opposed to a weighted average)

(1.5^2 + 1.8^2)/2

## Weighted pool variance formula
## ((n1 - 1) * s1^2 + (n2 - 1) * s2^2) / (n1 + n2 - 2)
