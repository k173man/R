# +++++ create metadata for a DT (same thing can be done for a DF, using a DF) +++++
# create DT version of mtcars
mtcarsdt <- as.data.table(mtcars)

# create DT to contain mtcars metadata
colNms <- data.table(
    Index = seq_along(colnames(mtcarsdt)), 
    Name = colnames(mtcarsdt), 
    DataType = {
        dt <- NULL
        tt <- mtcarsdt[1:10]
        colClasses <- sapply(tt, class)
        
        for(cc in colClasses)
            dt <- c(dt, cc)
        
        # clean up
        rm(list = c("tt", "cc", "colClasses"))
        dt
    }
)

# clean up (couldn't rm() dt in expression b/c it was the return statement)
rm(dt)


# how-to access attributes; rx has 2 attributes: match.length & useBytes
rx <- regexpr("Thomas", "Shane Thomas Reed", fixed = T)
# attributes(...) returns a list of attributes for specified object
attributes(rx)$match.length
# ...or
for(attr in attributes(rx)) {
    print(attr)
}

# display datasets in specified package
try(data(package = "mapdata"))

# display datasets in all loaded packages
data()

# search() gives a list of attached packages & R objects
search()

# searchpath() gives a similar character vector, with the entries for packages being the path to the package used to load the code
searchpaths()

# args() displays the argument names and corresponding default values of a function or primitive
args(ls)

# str() compactly, i.e. a function signature) displays the internal structure an object
str(ls)

# dput() displays the source code for an object
dput(ls)

# ls() and objects() return a vector of character strings giving the names of the objects in the specified environment
ls(airquality)

# specify a package to see info about that package
ls("package:utils")

# ls.str() and lsf.str() are variations of ls() applying str() to each matched name; lsf.str() only returns functions
ls.str("package:utils")
lsf.str("package:utils")
