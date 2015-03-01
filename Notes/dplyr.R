# Find more info on dplyr @ http://blog.rstudio.org/2014/01/17/introducing-dplyr/
# The dplyr package allows piping the results of one operation as input for the next, using the %>% operator
# The dplyr package provides five basic functions, which are as follows:
    ## filter: This creates subsets of the data based on specified criteria
    ## select: This selects columns or variables from the dataset
    ## mutate: This creates variables in a dataset (derived from other variables in the dataset)
    ## group_by: This splits the data by a variable or set of variables
        ### subsequent functions operate on each component defined by a unique variable value or combination
    ## arrange: This rearranges the data (or sorts it) according to variable(s) in the dataset
# Each of these functions can operate on a data.frame, data.table, or tbl object, which is part of dplyr.

## install.packages("dplyr")
# library(dplyr)
# library(data.table)
# bit64 package is needed for fread()
require(bit64)

zips <- fread(
    'data/ZipCodes.csv', 
    colClasses = c('character','factor',rep('numeric',17),rep('character',2),'factor','character','character',
                    rep('character',5),'numeric','factor',rep('character',3),'factor',rep('character',2))
    )

# get CA Zip Codes
# create CountyCd variable by concatenating State & County Codes
# project, i.e. select, CountyCd, County, MalePopulation, FemalePopulation variables
# group by CountyCd, County
# sum MalePopulation & sum FemalePopulation to create 2 new variables: Males & Females
# arrange() sorts on CountyCd; only sorts in ascending order (can't figure out why)
CA.GenderByCnty <- filter(zips, State=="CA") %>% 
    mutate(CountyCd = paste(StateFIPS, CountyFIPS, sep = '')) %>% 
    select(CountyCd, County, MalePopulation, FemalePopulation) %>% 
    group_by(CountyCd, County) %>% 
    summarise(Males = sum(MalePopulation), Females = sum(FemalePopulation)) %>% 
    arrange(CountyCd)

# arrange() with desc() doesn't work on the type of object returned by group_by() and/or summarise (see below)
# casting as a data frame allows arrange() with desc() to work correctly
CA.GenderByCnty2 <- arrange(as.data.frame(CA.GenderByCnty), desc(CountyCd))

# str(CA.GenderByCnty) returns: 
    ## Classes ‘grouped_dt’, ‘tbl_dt’, ‘tbl’, ‘tbl_dt’, ‘tbl’, ‘data.table’ and 'data.frame'...
# str(CA.GenderByCnty2) returns: 
    ## 'data.frame'...


# dplyr also handles joins (see Joins.R)