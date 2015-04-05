# Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "data/ss06hid.csv")
ss06hid = read.csv("data/ss06hid.csv")
nms = names(ss06hid)
splitNms = strsplit(nms, "wgtp")
splitNms[123]

# Q2 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "data/GDP.csv")
gdp = read.table("data/GDP.csv", sep = ",", skip = 5, quote = "\"", nrows =190, stringsAsFactors = F)
names(gdp) = c("Code", "Rank", "V3", "countryNames", "GDP", rep(paste0("V", 6:10)), "GDP2")
gdp$GDP2 = as.numeric(gsub(",", "", gdp$GDP))
mean(gdp$GDP2)

# Q3
grep("^United", gdp$countryNames)

# Q4
require(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "data/EDSTATS_Country.csv")
ed = read.csv("data/EDSTATS_Country.csv", stringsAsFactors = F)
gdp2 = inner_join(gdp, ed, by = c("Code" = "CountryCode")) 
length(grep("^Fiscal year end: June", gdp2$Special.Notes))

# Q5
# install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
require(lubridate)
dt = ymd(sampleTimes)
length(dt[year(dt) == 2012])
length(dt[year(dt) == 2012 & weekdays(dt) == "Monday"])

