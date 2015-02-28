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

# quote() creates a call object from code
myls <- quote(ls())
eval(myls)

# parse() creates an expression, which is basically just a list of calls) from string
# the text parameter must be explicitly named, i.e. parse("ls()") will not work
myls <- parse(text = "ls()")
eval(myls)

# substitute() takes some code and returns a language object (usually a call); inverse of quote
    # this is similar to using quote, but occasionally it’s a name object (a special type that holds variable names)
# deparse() takes a language object & returns a string; inverse of parse
    # here we get a string representation of the name of the variable shane
shane <- "shane is my name"
deparse(substitute(shane))



