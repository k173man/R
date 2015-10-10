# install.packages("reshape2")
require(reshape2)

data(airquality)
names(airquality) <- tolower(names(airquality))
# melt() is like unpivot
melt(airquality, id=c("month", "day"))

data(mtcars)
mtcars

narrow <- mtcars[, c("cyl", "gear", "vs", "mpg")]
narrow

# dcast() is like pivot
# Summarize the data, maximum value of mpg for each combination of cyl, gear, and vs
wide1 <- tidied <- dcast(narrow, cyl + gear ~ vs, max)
wide1

# Putting aside that when there isn't an entry, max goes to -Inf; we should probably fix that, replacing with NA
wide2 <- tidied <- dcast(narrow, cyl + vs ~ gear, max)
# That is the same data, arranged differently.
wide2
# There is also
wide3 <- tidied <- dcast(narrow, gear + vs ~ cyl, max)
Same data, arranged differently.
wide3

# Not reshape2; however, aggregate removed the -Inf entries
notverywide <- aggregate(mpg ~ gear + vs + cyl, data = narrow, max)
notverywide

# Now, lets thrown in a clearly untidy result (though up until now we have only been talking long and wide rather than tidy)
untidy <- with(narrow, tapply(mpg, list(cyl, vs, gear), max))
untidy
