# subset mpg, cyl, disp 
mtcars2 <- subset(mtcars, select = c(mpg, cyl, disp))
# subset mpg, cyl, disp; i.e. variables 1, 2, 3
mtcars2 <- mtcars[c(1, 2, 3)]
# subset mpg, cyl, disp; i.e. exclude variables 4-11
mtcars2 <- mtcars[-4:-11]
# subset mpg, cyl, disp for rows 1-10
mtcars[1:10, 1:3]
# subset mpg, cyl, disp excluding rows 22-32
mtcars[-22:-32, 1:3]

# You can also subset data by removing columns (rather than specifying the columns you want)
rowcriteria <- iris$Species=="setosa"
# %in% returns a logical vector; in this case: F F T T F
columncriteria <- names(iris) %in% c("Petal.Length","Petal.Width")
mysubset <- iris[rowcriteria,!(columncriteria)]

