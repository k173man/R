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



