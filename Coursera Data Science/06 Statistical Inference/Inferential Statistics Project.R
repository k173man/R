# Distribution of 1000 random exponentials
hist(rexp(1000, .2))


# Distribution of 1000 averages of 40 random exponentials
means = NULL

for (i in 1:1000)
  means = c(means, mean(rexp(40, .2)))

hist(means)
