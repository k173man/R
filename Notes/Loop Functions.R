library(datasets)
data(iris)

# split: takes a vector or other objects and splits it into groups determined by a factor or list of factors
# lapply: Loop over a list and evaluate a function on each element
# sapply: Same as lapply but try to simplify the result
    # If the result is a list where every element is length 1, then a vector is returned
    # If the result is a list where every element is a vector of the same length (> 1), a matrix is returned
# apply: Apply a function over the margins, i.e. rows or columns, of an array
    # for MARGIN (2nd parameter), there are 2 possible values: 1 = row, 2 = column
    # rowSums = apply(x, 1, sum)
    # rowMeans = apply(x, 1, mean)
    # colSums = apply(x, 2, sum)
    # colMeans = apply(x, 2, mean)
# tapply: Apply a function over subsets of a vector
# mapply: Multivariate version of lapply

# +++++ Examples +++++

# +++++ lapply +++++
# coerces columns 1-4 of the iris dataset to a list of 4 elements, and then applies mean() to each element
# returns a list of 4 elements
lam <- lapply(iris[,1:4], mean)

# +++++ sapply +++++
# applies mean() to columns 1-4 of the iris dataset
# returns a Named vector (num[1:4])
sam <- sapply(iris[,1:4], mean)

# splits Sepal.Length by the Species; returns a list w/ 1 element for each species (element names = species names)
ssl <- split(iris$Sepal.Length, iris$Species)
# applies mean() to Sepal.Length grouped by the Species; same effect as tapply example below
# returns a Named vector (num[1:4])
ssam <- sapply(ssl, mean)

# +++++ apply +++++
# applies mean() to columns 1-4 of the iris dataset
# returns a Named vector (num[1:4])
am <- apply(iris[, 1:4], 2, mean)

# x is 20 x 10 matrix
x <- matrix(rnorm(200), 20, 10)
# applies quantile(probs = c(0.25, 0.75)) row-wise
# returns a 2 x 20 matrix: 1 row for each prob; 1 column for each row
qa <- apply(x, 1, quantile, probs = c(0.25, 0.75))

# +++++ tapply +++++
# applies mean() to Sepal.Length grouped by the Species
# returns a named array
tam <- tapply(iris$Sepal.Length, iris$Species, mean)

# +++++ mapply +++++
# calls rep() once each element of the parameters: rep(1,4), rep(2,3), rep(3,2), rep(4,1)
# this has the same effect as list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
# returns a list of 4 elements: vector("int", 4), vector("int", 3), vector("int", 2), vector("int", 1)
ma <- mapply(rep, 1:4, 4:1)