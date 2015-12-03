# Q1
# A pharmaceutical company is interested in testing a potential blood pressure lowering medication
# Their first examination considers only subjects that received the medication at baseline then two weeks later
# The data are as follows (SBP in mmHg); t1 is baseline, t2 is retest
# 
# Consider testing the hypothesis that there was a mean reduction in blood pressure? 
# Give the P-value for the associated two sided T test. 

t1 <- c(140, 138, 150, 148, 135)
t2 <- c(132, 135, 151, 146, 130)

t.test(t2, t1, paired = T)

# Q2
# A sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc
# What is the complete set of values of μ0 that a test of H0:μ=μ0 would fail to reject the null hypothesis 
# in a two sided 5% Students t-test?

mu <- 1100
stddev <- 30
n <- 9
se <- 30/sqrt(n)

mu + c(-1, 1) * qt(.975, n-1) * se

# Q3
# Pepsi Challenge: Each of four people was asked which of two blinded drinks given in random order that they preferred
# The data was such that 3 of the 4 people chose Coke
# Assuming that this sample is representative, report a P-value for a test of the hypothesis 
# that Coke is preferred to Pepsi using a one sided exact test.

ans <- round(pbinom(3, prob = .5, size = 4, lower.tail = FALSE),4)

# Q4
# Infection rates at a hospital above 1 infection per 100 person days at risk are believed to be too high and are used as a benchmark
# A hospital that had previously been above the benchmark recently had 10 infections over the last 1,787 person days at risk
# About what is the one sided P-value for the relevant test of whether the hospital is *below* the standard? 

lbaseline <- 1/100
l2 <- 10/1787

ppois(l2, lbaseline, lower.tail = F)


# Q5
# 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo
# Subjects’ BMIs were measured at a baseline and again after having received the treatment or placebo for four weeks
# The average difference from follow-up to the baseline (followup - baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group
# The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group
# Does the change in BMI appear to differ between the treated and placebo groups?
# Assuming normality of the underlying data and a common population variance, give a pvalue for a two sided t test.

# m1 <- 10; m2 <- 11
# n1 <- n2 <- 100
# s <- 4
# se <- s * sqrt(1 / n1 + 1 / n2)
# ts <- (m2 - m1) / se
# pv <- 2 * pnorm(-abs(ts))

m1 <- -3; m2 <- 1
n1 <- n2 <- 9
s <- 4
pooledS < (1.5^2 + 1.8^2)/2
se <- sqrt(pooledS)/sqrt(1 / n1 + 1 / n2)
# se <- s * sqrt(1 / n1 + 1 / n2)
ts <- (m2 - m1) / se
pv <- 2 * pnorm(-abs(ts))
pt(ts, 16)

pnorm(1, lower.tail = F)


# Q6
# Researchers would like to conduct a study of 100 healthy adults to detect a four year mean brain volume loss of .01 mm3. 
# Assume that the standard deviation of four year volume loss in this population is .04 mm3. 
# About what would be the power of the study for a 5% one sided test versus a null hypothesis of no volume loss?

n <- 100
delta <- .01
stddev <- .04
a <- .05

power.t.test(n = n, delta = delta, sd = stddev, type = "one.sample", alternative = "one.sided")

# Q7
power.t.test(delta = delta, sd = stddev, power = .9, type = "one.sample", alternative = "one.sided")


# Q8
power.t.test(n = n, delta = delta, sd = stddev, sig.level = .1, type = "one.sample", alternative = "one.sided")