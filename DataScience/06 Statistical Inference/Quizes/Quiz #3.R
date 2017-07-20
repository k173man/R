# Q1
# Sample size of 9 men
# Sample average brain volume of 1,100cc
# Sample standard deviation of 30cc
# What is a 95% Student's T confidence interval for the mean brain volume in this new population?

n <- 9
mu <- 1100
sd <- 30
mu + c(-1, 1) * qt(.975, 8) * (sd/sqrt(n))

# Q2
n <- 9
mu <- -2
qt(.975, df = 8) *
# 0 = mu + qt(.975, df = 8) * sd/sqrt(n)

# Q3

# Q4
mudiff <- (3 - 5)
sp <- (.68 + .6)/2
se <- sqrt(sp) * sqrt(2/10)
t <- qt(.975, 18)
ci <- mudiff + c(-1, 1) * t * se

# Q5
mn <- 4
sn <- .5
mo <- 6
so <- 2
mu <- mo - mn
pooledS <- (sn+so)/2
se <- sqrt((sn/100) + (so/100))
z <- qnorm(.975, mu, sqrt(pooledS))
ci <- mu + c(-1, 1) * z * se

# Q6


# Q7
mu <- -3-1
pooledS < (1.5^2 + 1.8^2)/2
se <- sqrt(pooledS)/sqrt(18)
t <- qt(.95, 16)
mu + c(-1, 1) * t * se



