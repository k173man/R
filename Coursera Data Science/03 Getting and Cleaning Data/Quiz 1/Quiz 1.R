library(data.table)
library(dplyr)
# bit64 package is needed for fread()
require(bit64)

# +++++ Question 1 +++++
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "data/ss06hid.csv")
ss06hid <- fread(input = "data/ss06hid.csv")

# Q1: count(*), where VAL == 24; A1: 53
ss06hid[VAL == 24, .N]

# +++++ Question 3 +++++
install.packages("xlsx")
library(xlsx)

# read in rows 18-23 & columns 7-15
dat <- read.xlsx(
    file = "data/NGAP.xlsx", 
    sheetIndex = 1, 
    rowIndex = 18:23, 
    colIndex = 7:15
)

# Q3: sum(dat$Zip*dat$Ext,na.rm=T) 
sum(dat$Zip*dat$Ext,na.rm=T) 


# +++++ Question 4 +++++
library(XML)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile = "data/restaurants.xml")
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"
doc <- xmlTreeParse(file = "data/restaurants.xml", useInternal = TRUE)
# get all of the zipcode node values, i.e. get all of the Zip Codes
dt <- data.table(zips = xpathSApply(doc, "//zipcode", xmlValue))

# Q4: how many restaurants are in zipcode == 21231
dt[zips == "21231", .N]


# +++++ Question 5 +++++
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "data/ss06pid.csv")
DT <- fread(input = "data/ss06pid.csv")

# fastest way to calc mean(pwgtp15) by sex
system.time(DT[,mean(pwgtp15),by=SEX])

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

system.time({
        mean(DT[DT$SEX==1,]$pwgtp15)
        mean(DT[DT$SEX==2,]$pwgtp15)
    })

system.time(mean(DT$pwgtp15,by=DT$SEX))

# error
# system.time({
#     rowMeans(DT)[DT$SEX==1]
#     rowMeans(DT)[DT$SEX==2]
# })

system.time(tapply(DT$pwgtp15, DT$SEX, mean))

