setwd("Notes")

# compared to data frames, data tables are faster & more memory efficient
# data frames are 'by value'; data tables are 'by reference', i.e. assigning a DF to a var copies the DF; w/ a DT the var refs the DT

# install.packages("data.table")
library(data.table)

DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))

# the following head(...) statement produce results that look nearly identical
head(DF,3)
head(DT,3)

# tables() lists all DTs in memory + associated info (NAME, NROW, NCOL, MB, COLS, KEY)
tables()

# row subsetting is similar to a DF
# 2nd row
DT[2,]
# rows where DT$y=="a"
DT[DT$y=="a",]

# with DFs, subsetting w/o a comma subsets columns; DF[c(2,3)] returns the 2nd & 3rd columns for all rows
# with DTs, subsetting w/o a comma subsets rows; DT[c(2,3)] returns all columns for the 2nd & 3rd rows 
DT[c(2,3)]

# The subsetting function is modified for data.table; the arg after the comma is called an "expression"
    ## In R an expression is a collection of statements enclosed in curley brackets, e.g. { print(10); 5 }

# the following statements print 10, and then sets k to 5
k = { print(10); 5 }
# this print 5
print(k)

# in addition to expressions, you can pass a list of functions (to the right of the comma)
DT[,list(mean(x),sum(z))]

# or a single function
DT[,table(y)]

# you can add a new column using := 
DT[,w:=z^2]

# demonstrates by ref issue
DT2 <- DT
# now all instance of the y var in both DT & DT2 will be set to 2
DT[, y:= 2]
# as demonstrated by the following head(...) statements
head(DT,n=3)
head(DT2,n=3)

# using expression: x & z are summed into tmp, and then the log2() of tmp + 5 is returned & assign to a new var m
DT[, m:= { tmp <- (x + z); log2(tmp + 5) }]


# plyr like operations
# create a new boolean var, a, based on x
DT[, a:= x > 0]
# create a new var, b, and set it to mean(x + w), grouping by a
DT[, b:= mean(x + w), by=a]


# Special variable, .N, which is an integer of length 1 (that's what the lecture says?); .N = count(*)
set.seed(123);
# DT with 100K rows
DT <- data.table(x = sample(letters[1:3], 1E5, TRUE))
# this statement is equivalent to: select x, count(*) as N from DT group by x
DT[, .N, by = x]

# Keys
DT <- data.table(x = rep(c("a","b","c"), each=100), y = rnorm(300))
# set the PK
setkey(DT, x)
# once a key is set, when a value is place b/t [...], the default behavior is to subset on the key
# this statement is equivalent to: select * from DT where x = 'a'
DT["a"]

# Joins are much faster than with a DF; key in each table must have the same name, i.e. be based on the same var
# create DTs
DT1 <- data.table(x = c('a', 'a', 'b', 'dt1'), y = 1:4)
DT2 <- data.table(x = c('a', 'b', 'dt2'), z = 5:7)
#set keys; key for both DTs is the x var
setkey(DT1, x)
setkey(DT2, x)
# merge
merge(DT1, DT2)
# this statement is the same as merge(DT1, DT2)
DT1[DT2]





