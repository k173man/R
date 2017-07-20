# directory <- "specdata"
# pollutant <- "sulfate"
# pollutant <- "nitrate"
# id <- 1:10
# id <- 70:72
# id <- 23
# pollutantmean(directory, pollutant, id)

# directory <- "specdata"
# id <- 1
# id <- c(2, 4, 8, 10, 12)
# id <- 30:25
# id <- 3
# complete(directory, id)

# directory <- "specdata"
# threshold <- 150
# threshold <- 400
# threshold <- 5000
# cr <- corr(directory, threshold)
# cr <- corr(directory)
# head(cr)
# summary(cr)
# length(cr)
# source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")

h <- function(x, y = NULL, d = 3L) {
    z <- cbind(x, d)
    if(!is.null(y))
        z <- z + y
    else
        z <- z + f
    g <- x + y / z
    if(d == 3L)
        return(g)
    g <- g + 10
    g
}
