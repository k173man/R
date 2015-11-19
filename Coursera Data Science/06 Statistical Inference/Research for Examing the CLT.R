library(ggplot2)

# rexp(n, lambda) where lambda is the rate parameter.
#     The mean of exponential distribution is 1/lambda
#     The standard deviation is also 1/lambda
# Set lambda = 0.2 for all of the simulations.
# You will investigate the distribution of averages of 40 exponentials.
# Note that you will need to do a thousand simulations.
# 
# Illustrate, via simulation and associated explanatory text, the properties of the distribution of the mean of 40 exponentials.
# 1. Show the sample mean and compare it to the theoretical mean of the distribution.
# 2. Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.
# 3. Show that the distribution is approximately normal.
#     - the difference between the distribution of a large collection of random exponentials
#     - the distribution of a large collection of averages of 40 exponentials. 

nosim <- 1000
sampleSize <- 40
lambda <- .2
stdError <- function(l, n) 1/(l*sqrt(n))

# same as efunc below, just written differently
# efunc <- function(x, l, n) l * sqrt(n) * (mean(x) - (1/l))
efunc <- function(x, l, n) (mean(x) - (1/l))/stdError(l, n)

theoreticalMean <- 1/lambda
theoreticalVariance <- stdError(lambda, sampleSize)^2
# using nosim * sampleSize so, for Q3, we are comparing the set of numbers
rv <- rexp(nosim * sampleSize, lambda)
randomExps <- data.frame(
  largeSample = sample(rv, nosim),
  standardizedAveragesOf40 = apply(matrix(rv, nosim), 1, efunc, lambda, sampleSize), 
  averagesOf40RM = rowMeans(matrix(rv, nosim))
)

sampleMean <- mean(randomExps$averagesOf40RM)
sampleVariance <- var(randomExps$averagesOf40RM)

# # Shows mean converging on theoretic mean as sample size increases
# means <- cumsum(rowMeans(matrix(rv, nosim))) / (1 : nosim)
# g <- ggplot(data.frame(x = 1 : nosim, y = means), aes(x = x, y = y))
# g <- g + geom_hline(yintercept = theoreticalMean) + geom_line(size = 2)
# g <- g + labs(x = "Number of obs", y = "Cumulative mean")
# g
# 
# # Shows variance converging on theoretic variance as sample size increases
# vars <- cumsum((rowMeans(matrix(rv, nosim))-sampleMean)^2) / (1 : nosim)
# g <- ggplot(data.frame(x = 1 : nosim, y = vars), aes(x = x, y = y))
# g <- g + geom_hline(yintercept = theoreticalVariance) + geom_line(size = 2)
# g <- g + labs(x = "Number of obs", y = "Cumulative variance")
# g

# with(randomExps, (max(largeSample)-min(largeSample))/30)
# with(randomExps, (max(averagesOf40)-min(averagesOf40))/30)
# randomExps <- data.frame(
#     x = c(
#         sample(rv, nosim), 
#         rowMeans(matrix(rv, nosim))
#     ),
#     size = factor(rep(c(1000, 40), rep(nosim, 2)))
# )

# do we need to use something comparable to cfunc (see Coin toss example)?

# with(randomExps, hist(largeSample))
# with(randomExps, hist(averagesOf40))

g <- ggplot(randomExps, aes(x = largeSample)) + geom_histogram(colour = "black", aes(y = ..density..)) 
g + stat_function(fun = dexp, args = list(rate = lambda), size = 2) + geom_vline(xintercept=theoreticalMean)

g <- ggplot(randomExps, aes(x = standardizedAveragesOf40)) + geom_histogram(colour = "blue", aes(y = ..density..)) 
g + stat_function(fun = dnorm, size = 2)

g <- ggplot(randomExps, aes(x = averagesOf40RM)) + geom_histogram(colour = "blue", aes(y = ..density..)) 
g + stat_function(fun = dnorm, args = list(mean = theoreticalMean, sd = stdError(lambda, sampleSize)), size = 2)

# # Coin toss example
# nosim <- 1000
# cfunc <- function(x, n) 2 * sqrt(n) * (mean(x) - 0.5) 
# dat <- data.frame(
#   x = c (
#     apply(matrix(sample(0:1, nosim * 10, replace = TRUE), nosim), 1, cfunc, 10),
#     apply(matrix(sample(0:1, nosim * 20, replace = TRUE), nosim), 1, cfunc, 20),
#     apply(matrix(sample(0:1, nosim * 30, replace = TRUE), nosim), 1, cfunc, 30)
#   ),
#   size = factor(rep(c(10, 20, 30), rep(nosim, 3)))
# )
# 
# g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(binwidth=.3, colour = "black", aes(y = ..density..)) 
# g <- g + stat_function(fun = dnorm, size = 2)
# g + facet_grid(. ~ size)

# # Distribution of 1000 random exponentials
# hist(rexp(1000, .2))
# 
# # Distribution of 1000 averages of 40 random exponentials
# means = NULL
# 
# for (i in 1:1000)
#   means = c(means, mean(rexp(40, .2)))
# 
# hist(means)

