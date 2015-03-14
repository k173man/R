plot(iris$Petal.Length, iris$Petal.Width, type="n")
points(iris$Petal.Length, iris$Petal.Width, pch=19, col=iris$Species)


# cc (column classes) is a vector of classes; replace findClass with replaceClass
# parseClasses <- function(colClasses, findClass, replaceClass) {
#     classes <- NULL
#     
#     for(i in 1:length(cc)) {
#         # cc is a char vect; each element contains a variable name & class, separated by \r\n              
#         tc <- unlist(strsplit(cc[[i]], "\r\n"))
#         
#         if (tc == findClass)
#             tc <- replaceClass
#         
#         classes <- c(classes, tc)
#     }
#     
#     classes
# }

# example using parseClasses
# read in 1st 100 rows
initial <- read.csv("data/family.csv", nrows = 100)
# apply class() to the initial 100 rows
colClasses <- sapply(initial, class)
newColClasses <- parseClasses(colClasses, 'factor', 'character')


