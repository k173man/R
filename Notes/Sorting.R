test <- data.frame(
    Name=c("shane", "shane", "shane", "Jen", "Jen", "Jen"), 
    Score=c(1, 2, 3, 1, 2, 3),
    stringsAsFactors = FALSE
)
# decreasing = T causes all vars to sort in descending order
    # the - operator on Score (-test$Score) negates the values of Score, i.e. 1 becomes -1
        # the - operator cannot be used on characters
    # this negates the decreasing option for the Score value
test[order(test$Name, -test$Score, decreasing = T),] # order by Name desc, Score asc
test[order(test$Name, -test$Score),] # order by Name asc, Score desc

# http://stackoverflow.com/questions/1296646/how-to-sort-a-dataframe-by-columns-in-r
dd <- data.frame(
    b = factor(c("Hi", "Med", "Hi", "Low"), 
    levels = c("Low", "Med", "Hi"), ordered = TRUE),
    x = c("A", "D", "A", "C"), 
    y = c(8, 3, 9, 9),
    z = c(1, 1, 1, 2)
)
# with() allows use of vars w/o qualification, e.g. dd$z
dd[with(dd, order(-z, b)), ]
# using column indexes
dd[ order(-dd[,4], dd[,1]), ]


# Other examples can be found at:
    # http://www.statmethods.net/management/sorting.html
    