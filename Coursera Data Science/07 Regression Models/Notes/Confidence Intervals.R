library(UsingR)

data(diamond)

y <- diamond$price
x <- diamond$carat
n <- length(y)

# Manaully calculate coefficient table
beta1 <- cor(y, x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
# residuals
e <- y - beta0 - beta1 * x
# sum(e^2) = sum of the squared error/residual (SSE) for the linear model/residual variation
# sigma = the residual variation of a fit model or the unbiased Root Mean Squared Error (RMSE)
sigma <- sqrt(sum(e^2) / (n-2)) 
ssx <- sum((x - mean(x))^2)
seBeta0 <- (1 / n + mean(x) ^ 2 / ssx) ^ .5 * sigma 
seBeta1 <- sigma / sqrt(ssx)
# numerator of t-value is beta0, as opposed to beta0 - true value (i.e. the true intercept) b/c we're assuming true value is 0
tBeta0 <- beta0 / seBeta0
# numerator of t-value is beta1, as opposed to beta1 - true value (i.e. the true slope) b/c we're assuming true value is 0
tBeta1 <- beta1 / seBeta1
pBeta0 <- 2 * pt(abs(tBeta0), df = n - 2, lower.tail = FALSE)
pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = FALSE)
coefTable <- rbind(c(beta0, seBeta0, tBeta0, pBeta0), c(beta1, seBeta1, tBeta1, pBeta1))
colnames(coefTable) <- c("Estimate", "Std. Error", "t value", "P(>|t|)")
rownames(coefTable) <- c("(Intercept)", "x")

# Compare manual coefficient table to a coefficient table created using lm()
coefTable
fit <- lm(y ~ x); 
summary(fit)$coefficients

# Getting a confidence interval
sumCoef <- summary(fit)$coefficients
# Estimate [#, 1] +/- Critical Value * SE [#, 2], where # is a row number (1 for intercept, 2 for slope)
# C.I. for the intercept
sumCoef[1,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[1, 2]
# C.I. for the slope
(sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[2, 2]) / 10