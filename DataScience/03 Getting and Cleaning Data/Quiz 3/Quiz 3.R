# Q1
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products
# Assign that logical vector to the variable agricultureLogical
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE
    ## which(agricultureLogical)
# What are the first 3 values that result?

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "data/ss06hid.csv")
ss06hid = read.csv("data/ss06hid.csv")
agricultureLogical = ss06hid$ACR == 3 & ss06hid$AGS == 6
which(agricultureLogical)[1:3]
rm("agricultureLogical", "ss06hid")

#Q2
# Using the jpeg package read in the following picture of your instructor into R 
# Use the parameter native=TRUE
# What are the 30th and 80th quantiles of the resulting data?
# install.packages("jpeg")
require(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile = "data/jeff.jpg", mode = "wb")
jeff = readJPEG("data/jeff.jpg", native = T)
quantile(jeff, c(.3, .8))
rm(jeff)

#Q3
# Load the Gross Domestic Product & educational datasets for the 190 ranked countries
# Match the data based on the country shortcode
# How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last)
# What is the 13th country in the resulting data frame?
require(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "data/GDP.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "data/EDSTATS_Country.csv")
gdp = read.table("data/GDP.csv", sep = ",", skip = 5, quote = "\"", nrows =190, stringsAsFactors = F)
names(gdp) = c("Code", "Rank", "V3", "Name", "GDP", rep(paste0("V", 6:10)))
gdp = gdp %>% select(Code, Rank, Name, GDP)
ed = read.csv("data/EDSTATS_Country.csv", stringsAsFactors = F)
gdp2 = inner_join(gdp, ed, by = c("Code" = "CountryCode")) %>% 
    select(Rank, Code, Name, Income.Group) %>% 
    arrange(desc(Rank))
nrow(gdp2)
gdp2[13, ]

#Q4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 
gdp2 %>% 
    filter(Income.Group %in% c("High income: OECD", "High income: nonOECD")) %>% 
    select(Income.Group, Rank) %>% 
    group_by(Income.Group) %>% 
    summarise(mean(Rank))

#Q5
# Cut the GDP ranking into 5 separate quantile groups
# Make a table versus Income.Group
# How many countries are Lower middle income but among the 38 nations with highest GDP?
# ( or ) = not included, [ or ]= included; e.g. (4, 6] is the same as > 4 and <= 6
table(cut(gdp2$Rank, 5), gdp2$Income.Group)


rm("gdp", "gdp2", "ed")
