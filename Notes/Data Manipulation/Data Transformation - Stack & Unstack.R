# data from Using R for Statistics (chap 4)

# +++++ Stacking & Unstacking data +++++
grades1 <- read.csv('data/grades1.csv')
# grades1 is unstacked
## 5 rows x 3 columns
##      ClassA    ClassB	ClassC
## 1	87		83		80

# stack() will exclude non-numeric values
grades2 <- stack(grades1)
# grades2 is stacked
## 15 rows x 2 columns
##        values     ind
## 1      87         ClassA

# this example uses the select arg to exlude the ClassB var
grades2 <- stack(grades1, select = c("ClassA", "ClassC"))

# this is done to demonstrate the form arg below
names(grades2) <- c("Result", "Class")

# when using unstack(), you don't need to specify the form arg if:
    ## the dataset has only 2 variables
    ## the 1st var is the values
    ## the 2nd var is the group/description
# since grades2 meets all the criteria above, unstack(grades2) would work, too
unstack(grades2, form = Result~Class)
