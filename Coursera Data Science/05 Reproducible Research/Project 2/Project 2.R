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

events <- read.csv("data/Events.csv", stringsAsFactors = F)
events$Events <- str_to_upper(events$Events)
names(events) <- c("EventName")
events$EventId <- 1:length(events$EventName)

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
# dirty & clean are vectors, i.e. columns from a df or dt
cleanseEvents <- function(dirty, clean, max.distance) {
  matches <- sapply(clean, agrep, dirty, max.distance)
  d2 <- data.frame(dirty = dirty, clean = NA_character_, stringsAsFactors = F)

  for (i in 1:length(matches)) {
    if(length(matches[i]) > 0)
      d2$clean[unlist(matches[i])] <- names(matches[i])
    
  }
  
  d2
}

uniqueEvents <- data.frame(EventType = unique(str_to_upper(removeExtraSpaces(stormData$EVTYPE))), stringsAsFactors = F) %>% 
  arrange(EventType)
uniqueEvents$Id <- 1:length(uniqueEvents$EventType)
uniqueEvents$EventType2 <- NA_character_


for (e in events$EventName) {
  idx <- grep(paste0("^", e), uniqueEvents$EventType)

  if(length(idx) > 0)
    uniqueEvents$EventType2[idx] = e
}

afterForLoop <- length(uniqueEvents$Id[!is.na(uniqueEvents$EventType2)])

idx <- grep("^TSTM WIND|^TSTMW|^THUNDERSTORM WIN|^THUNDERSTORMS WIN|^THUNDERSTORMSW|^THUNDERSTORMW", uniqueEvents$EventType) 
uniqueEvents$EventType2[idx] <- "THUNDERSTORM WIND"
idx <- NULL
afterTStormWind <- length(uniqueEvents$Id[!is.na(uniqueEvents$EventType2)])


idx <- grep("^HURRICANE|^TYPHOON", uniqueEvents$EventType)
uniqueEvents$EventType2[idx] <- "HURRICANE (TYPHOON)"
idx <- NULL
afterHT <- length(uniqueEvents$Id[!is.na(uniqueEvents$EventType2)])

<<<<<<< HEAD

=======
>>>>>>> origin/master
