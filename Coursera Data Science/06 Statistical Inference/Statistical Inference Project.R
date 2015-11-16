library(ggplot2)

# rexp(n, lambda) where lambda is the rate parameter.
#     The mean of exponential distribution is 1/lambda
#     The standard deviation is also 1/lambda
# Set lambda = 0.2 for all of the simulations.
# You will investigate the distribution of averages of 40 exponentials.
# Note that you will need to do a thousand simulations.

# Illustrate, via simulation and associated explanatory text, the properties of the distribution of the mean of 40 exponentials.
# 1. Show the sample mean and compare it to the theoretical mean of the distribution.
# 2. Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.
# 3. Show that the distribution is approximately normal.
#     - the difference between the distribution of a large collection of random exponentials
#     - the distribution of a large collection of averages of 40 exponentials. 

noSim <- 1000
sampleSize <- 40
lambda <- .2
stdError <- function(lmbda, n) 1/(lmbda*sqrt(n))

theoreticalMean <- 1/lambda
theoreticalVariance <- stdError(lambda, sampleSize)^2
# using noSim * sampleSize so, for Q3, we are comparing the set of numbers
rv <- rexp(noSim * sampleSize, lambda)
randomExps <- data.frame(
  largeSample = sample(rv, noSim),
  sampleMeans = rowMeans(matrix(rv, noSim))
)

sampleMean <- mean(randomExps$sampleMeans)
sampleVariance <- var(randomExps$sampleMeans)

# Shows mean converging on theoretic mean as sample size increases
means <- cumsum(randomExps$sampleMeans) / (1 : noSim)
g <- ggplot(data.frame(x = 1 : noSim, y = means), aes(x = x, y = y))
g <- g + geom_hline(yintercept = theoreticalMean) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g

# Shows variance converging on theoretic variance as sample size increases
vars <- cumsum((randomExps$sampleMeans-sampleMean)^2) / (1 : noSim)
g <- ggplot(data.frame(x = 1 : noSim, y = vars), aes(x = x, y = y))
g <- g + geom_hline(yintercept = theoreticalVariance) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative variance")
g


g <- ggplot(randomExps, aes(x = largeSample)) + geom_histogram(colour = "black", aes(y = ..density..)) 
g + stat_function(fun = dexp, args = list(rate = lambda), size = 2) + geom_vline(xintercept=theoreticalMean)

g <- ggplot(randomExps, aes(x = sampleMeans)) + geom_histogram(colour = "blue", aes(y = ..density..)) 
g + stat_function(fun = dnorm, args = list(mean = theoreticalMean, sd = stdError(lambda, sampleSize)), size = 2)


