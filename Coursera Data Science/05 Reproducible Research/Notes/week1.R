install.packages("kernlab")
library(kernlab)

data(spam)
set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)
trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

# names(spam)
# summary(spam)
# head(spam)

table(trainSpam$type)

plot(trainSpam$capitalAve ~ trainSpam$type)
# use log ...+1 b/c of zeroes
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type) ◾



# perform exploratory analysis (clustering)
# relationships between predictors using ◾log transformations diagrams between pairs of variables
plot(log10(trainSpam[, 1:4] + 1)) 

hCluster = hclust(dist(t(trainSpam[, 1:57])))

hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)