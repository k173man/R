library(ggplot2)

noSim <- 1000
sampleSize <- 40
lambda <- .2

rv <- rexp(noSim * sampleSize, lambda)

randomExps <- data.frame(
  sampleMeans = rowMeans(matrix(rv, noSim)), 
  largeSample = sample(rv, noSim) 
)

sampleMean <- mean(randomExps$sampleMeans)
theoreticalMean <- 1/lambda

stdError <- function(lmbda, n) 1/(lmbda*sqrt(n))

sampleVariance <- var(randomExps$sampleMeans)
theoreticalVariance <- stdError(lambda, sampleSize)^2

# Shows mean converging on theoretic mean as sample size increases
means <- cumsum(randomExps$sampleMeans) / (1 : noSim)
g <- ggplot(data.frame(x = 1 : noSim, y = means), aes(x = x, y = y))
g <- g + geom_hline(yintercept = theoreticalMean, size = 1, color = "red") + geom_line(size = 1, color = "blue")
g <- g + labs(x = "Number of Observations", y = "Cumulative Mean")
g

# Shows variance converging on theoretic variance as sample size increases
vars <- cumsum((randomExps$sampleMeans-sampleMean)^2) / (1 : noSim)
g <- ggplot(data.frame(x = 1 : noSim, y = vars), aes(x = x, y = y))
g <- g + geom_hline(yintercept = theoreticalVariance, color = "red") + geom_line(size = 1, color = "green")
g <- g + labs(x = "Number of Observations", y = "Cumulative Variance")
g

g <- ggplot(randomExps, aes(x = largeSample)) + geom_histogram(color = "black", aes(y = ..density.., fill = ..density..)) + guides(fill=FALSE)
g <- g + stat_function(fun = dexp, args = list(rate = lambda), size = 2)
g + labs(x = "Random Variable Value", y = "Density", title = "Single Large Sample (n = 1,000)")

g <- ggplot(randomExps, aes(x = sampleMeans)) + geom_histogram(colour = "black", aes(y = ..density.., fill = ..density..)) + guides(fill=FALSE)
g <- g + stat_function(fun = dnorm, args = list(mean = theoreticalMean, sd = stdError(lambda, sampleSize)), size = 2)
g <- g + geom_vline(xintercept = theoreticalMean, color = "green")
g <- g + geom_vline(xintercept = sampleMean, color = "red")
g + labs(x = "Mean", y = "Density", title = "Sampling Distribution of the Sample Mean\r\n (1,000 samples of n = 40)")



