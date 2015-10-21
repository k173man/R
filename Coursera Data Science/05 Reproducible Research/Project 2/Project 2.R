library(dplyr)
library(ggplot2)
library(lattice)
library(data.table)
library(stringr)

setwd("~/DataSci/R/Coursera Data Science/05 Reproducible Research/Project 2")

# stormData <- read.csv("data/repdata_data_StormData.csv")
# save(stormData, file="data/stormData.RData", compress="bzip2")
# load("data/stormData.RData")

stormData <- fread("data/repdata_data_StormData.csv")
keep <- (stormData$FATALITIES > 0) | (stormData$INJURIES > 0) | (stormData$PROPDMG > 0) | (stormData$CROPDMG > 0)
stormData <- stormData[keep]

getDate <- function (dateTime) {
  # dateTime: a string vector (format: MM/DD/YYYY 0:00:00)
  # split dateTime, which results in a list of char vectors (length = 2), then extract 1st element of each list element
  sapply(
    strsplit(dateTime, " "), 
    function(dt) dt[1]
  )
}
# separate cast from getDate; casting string to date while using sapply returns an integer, i.e. offset from Jan 1, 1970
stringToMMDDYYYY <- function(dateStrings) as.Date(dateStrings, "%m/%d/%Y")
toDate <- function(dateTime) stringToMMDDYYYY(getDate(dateTime))
# remove consecutive & leading/trailing space
removeExtraSpaces <- function(x) str_trim(gsub(" +", " ", x), "both")

# sd100 <- stormData[1:100]

events <- data.table(Events = unique(str_to_upper(removeExtraSpaces(stormData$EVTYPE)))) %>% 
  arrange(Events)

