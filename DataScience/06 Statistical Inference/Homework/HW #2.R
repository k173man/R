# Q1
## Prob. a manuscript accepted to journal is 12%
## However, given a revision is requested, the prob. accepted is 90%
## Is it possible the prob. a manuscript has a revision asked for is 20%?

# P(A) = Prob. Accepted = .12
# P(A|B) = Prob. Accepted Given a Revision is Request = .9
# P(B) = Prob. a Revision is Request = ? (however, question asks if .2 is a valid value, so we'll plug in .2)
# Solution: P(A intersects B) = P(A|B) * P(B) = .9 * .2 = .18
# Answer: Not possible; P(A intersects B) must be <= P(A) (or P(B))

# Q2 - units expressed as hits/day
## Number of web hits to a site are approx. normally distributed (u = 100, sd = 10)
## What's the prob. a given day has < 93 hits, expressed as a percentage?
u = 100
sd = 10
x = 93
pnorm(x, u, sd)

# Q3 - Notation: A = Asbestos, Ac = Compliment of A, Tn = Negative Test
## Suppose 5% of housing projects have issues with asbestos
### P(A) = .05, therefore P(Ac) = 1 - P(A) = 1 - .05 = .95
## Sensitivity of a test for asbestos is 93%
### Sensitivity = P(+|A)
## Specificity is 88%
### Specificity = P(-|Ac) = P(Tn|Ac)
## What is the probability that a housing project has no asbestos given a negative test expressed as a percentage to the nearest percentage point?

#                   P(Tn|Ac)P(Ac)                         Specificity * (1 - P(A))                           .88 * .95
# P(Ac|Tn) = --------------------------- = ------------------------------------------------------- = ------------------------- = .9958
#            P(Tn|Ac)P(Ac) + P(Tn|A)P(A)   [Specificity * (1 - P(A))] + [(1 - Sensitivity) * P(A)]   [.88 * .95] + [.07 * .05]

# Q4 - units expressed as hits/day
## Number of web hits to a site are approx. normally distributed (u = 100, sd = 10)
## What number of web hits per day represents the number so that only 5% of days have more hits?
### use p = .95 b/c x where only 5% of days have # of hits > x = 95% of days where # of hits is < x
### alternatively, use p = .05, and specify lower.tail = F
u = 100
sd = 10
p = .95
qnorm(p, u, sd)
# alternative method
p = .05
qnorm(p, u, sd, lower.tail = F)

# Q5 - units expressed as hits/day
## Number of web hits to a site are approx. normally distributed (u = 100, sd = 10)
## Take a random sample of 50 days
## What # of web hits would be the point so that only 5% of averages of 50 days of web traffic have more hits?
u = 100
sd = 10
p = .95
n = 50
qnorm(p, u, sd/sqrt(n))

# Q6 - Taste test to determine if testee can distinguish b/t cheap & expensive wines, i.e. binomial, where p =.5
## Blind test where you randomize 6 paired varieties of cheap and expensive wines
## What is the chance that she gets 5 or 6 right expressed as a percentage to one decimal place?
### 5 or 6 correct = x > 4
x = 4
n = 6
p = .5
pbinom(x, n, p, lower.tail = F)

# Q7 - uniform distribution will use xnorm() functions
## If we were to sample 100 draws from a a uniform distribution (u = 0.5, var = 1/12) and take their mean
## What is the approximate probability of getting as large as 0.51 or larger expressed to 3 decimal places?
u = .5
var = 1/12
n = 100
x = .51
pnorm(x, u, sqrt(var/n), lower.tail = F)

# Q8
## If you roll ten standard dice, take their average, then repeat this process over and over and construct a histogram
## what would it be centered at?

# Answer: 3.5 b/c 3.5 is the average; since we have large n, it will converge on population mean

# Q9
# If you roll ten standard dice, take their average, then repeat this process over and over and construct a histogram, 
# what would be its variance expressed to 3 decimal places

mean((1 : 6 - 3.5)^2 / 10)


# Q10
# The number of web hits to a site is Poisson with mean 16.5 per day. 
# What is the probability of getting 20 or fewer in 2 days expressed as a percentage to one decimal place?
interval = 2
lambda = 16.5
x = 20
ppois(x, interval * lambda)

