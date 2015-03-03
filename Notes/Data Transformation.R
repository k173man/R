# data from Using R for Statistics (chap 4)

# +++++ Stacking & Unstacking data +++++
# grades1 is unstacked
    ## 5 rows x 3 columns
    ##      ClassA	ClassB	ClassC
    ## 1	87		83		80
    ## 2	64		97		86
grades1 <- read.csv('data/grades1.csv')

# stack() will exclude non-numeric values
grades2 <- stack(grades1)
# grades2 is stacked
## 15 rows x 2 columns
##        values     ind
## 1      87         ClassA
## ...
## 6      83         ClassB
## ...
## 11     80         ClassC
## ...

# this example only uses the ClassA & ClassC variables
grades2 <- stack(grades1, select = c("ClassA", "ClassC"))

# this is done to demonstrate the form arg below
names(grades2) <- c("Result", "Class")

# when using unstack(), you don't need to specify the form arg if:
    ## the dataset has only 2 variables
    ## the 1st var is the values
    ## the 2nd var is the group/description
# since grades2 meets all the criteria above, unstack(grades2) would work, too
unstack(grades2, form = Result~Class)


# +++++ Reshaping data +++++
    ## long form is useful if you want to build a model that includes the time point as an explanatory variable
    ## wide form is useful if you want to compare data from 2 or more time points or parameters, 
        ## or include them as distinct variables in the same model

# +++ reshape() wide to long +++
resistance <- read.csv('data/resistance.csv')
# resistance is wide/pivoted/x-tab
    ##     Formula Day3 Day7 Day14
    ## 1    A       10.8 18.5 41.3
    ## 2	B       20.1 29.2 37.0
    ## 3	C       3.7  17.5 28.9
    ## 4	D       18.1 27.2 37.6

# varying arg specifies the vars to be combined into a single column
# times arg gives the new time values or replicate numbers; can be alpha/numeric
# v.names & timevar args are optional and give the names for the new variables
resistance2 <- reshape(
    resistance, 
    direction="long", 
    varying=list(c("Day3", "Day7", "Day14")),
    times=c(3, 7, 14), 
    idvar="Formula", 
    v.names="Resistance", 
    timevar="Day"
)

# resistance2 is long/un-pivoted
    ## row.names Formula Day Resistance
    ## A.3       A       3   10.8
    ## ...
    ## D.3       D       3   18.1
    ## A.7       A       7   18.5
    ## ...
    ## D.7       D       7   27.2
    ## A.14      A       14  41.3
    ## ...
    ## D.14      D       14  37.6

# +++ reshape() long to wide +++
vitalsigns <- read.csv('data/vitalsigns.csv')
# vitalsigns is long
    ##      subject  test   result
    ## 1    1733     Pulse  120
    ## 2    1733     DiaBP  79
    ## 3    1733     SysBP  79
    ## ...
    ## 10   1736     Pulse  142
    ## 11   1736     DiaBP  99
    ## 12   1736     SysBP  87

# v.names arg specifies the var that you want to separate into different columns
# timevar arg specifies the var that indicates which column the value belongs to (i.e., the var giving the time point, replicate number, or category for the record)
# idvar arg specifies which var is used to group the records together
# varying arg specifies the names for the new vars created by splitting v.names
vitalsigns2 <- reshape(
    vitalsigns, 
    direction="wide", 
    v.names="result", 
    timevar="test", 
    idvar="subject", 
    varying=list(c("SysBP", "DiaBP", "Pulse"))
)

#       subject SysBP DiaBP Pulse
# 1     1733    120   79    79
# 4     1734    121   86    72
# 7     1735    130   94    74
# 10    1736    142   99    87
