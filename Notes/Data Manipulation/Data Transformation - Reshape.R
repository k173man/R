setwd("C:/Users/Shane/Dropbox/Data Science/GitHub/R/Notes")
# data from Using R for Statistics (chap 4)
# +++++ Reshaping data +++++
    ## long form is useful if you want to build a model that includes the time point as an explanatory variable
    ## wide form is useful if you want to compare data from 2 or more time points or parameters, 
        ## or include them as distinct variables in the same model

# +++ reshape() wide to long +++
resistance <- read.csv('data/resistance.csv')
# resistance is wide/pivoted/x-tab
    ##      Formula Day3 Day7 Day14
    ## 1    A       10.8 18.5 41.3

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

# +++ reshape() long to wide +++
vitalsigns <- read.csv('data/vitalsigns.csv')
# vitalsigns is long
    ##      subject  test   result
    ## 1    1733     Pulse  120
    ## 2    1733     DiaBP  79
    ## 3    1733     SysBP  79

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
