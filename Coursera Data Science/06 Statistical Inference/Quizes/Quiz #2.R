# Q2 - units are expressed as mm Hg
## Diastolic blood pressures (DBPs) for men aged 35-44 are normally distributed (u = 80, sd = 10)
## What is the approx. probability that a random 35-44 year old has a DBP < 70?
u = 80
sd = 10
x = 70

pnorm(x, u, sd)

# Q3 - units are expressed as cc
## Brain volume for adult women is normally distributed (u = 1,100, sd = 75)
## What brain volume represents the 95th percentile?
u = 1100
sd = 75
p = .95

qnorm(p, u, sd)

# Q4 - refer to Q3
u = 1100
sd = 75
p = .95
n = 100

qnorm(p, u, sd/sqrt(n))

# Q5
## You flip a fair coin 5 times
## What's the probability of getting 4 or 5 heads?
p = .5
n = 5
x = 3

pbinom(x, n, p, lower.tail = F)

# Q6 - units are expressed as sleep events/hour
## Respiratory disturbance index (RDI) for a specific population is not normally distributed (u = 15, sd = 10)
## Give your best estimate of the probability that a sample mean RDI of 100 people is between 14 and 16 events per hour?
u = 15
sd = 10
n = 100
x = c(14, 16)

probs = pnorm(x, u, sd/sqrt(n))
probs[2]-probs[1]

# Q7
## Standard uniform density (u = .5, var = 1/12)
## You sample 1,000 observations from this distribution and take the sample mean
## what value would you expect it to be near?

## due to sample size, expect sample u = 1000

# Q8 - unit expressed in # of people/hour
## The number of people showing up at a bus stop is assumed to be Poisson (u = 5)
## You watch the bus stop for 3 hours
## About what's the probability of viewing 10 or fewer people?
u = 5
t = 3
x = 10

ppois(10, u * t)

