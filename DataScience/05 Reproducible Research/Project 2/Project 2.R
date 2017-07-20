library(dplyr)
library(ggplot2)
library(lattice)
library(data.table)
library(stringr)
library(lubridate)

setwd("/Docs/DataSci/GitHub/R/Coursera Data Science/05 Reproducible Research/Project 2")

# stormData <- fread("data/repdata_data_StormData.csv")
stormData <- read.csv("data/repdata_data_StormData.csv", stringsAsFactors = F) 
# save(stormData, file="data/stormData.RData", compress="bzip2") 
# load("data/stormData.RData") 

keep <- (stormData$FATALITIES > 0) | (stormData$INJURIES > 0) | (stormData$PROPDMG > 0) | (stormData$CROPDMG > 0)
stormData <- stormData[keep, ]

events <- read.csv("data/Events.csv", stringsAsFactors = F)
events = data.frame(EventId = 1:length(events$EventName), EventName = events$EventName, stringsAsFactors = F)

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

stormData$BGN_DATE <- toDate(stormData$BGN_DATE)
stormData$EVTYPE <- str_to_upper(removeExtraSpaces(stormData$EVTYPE))

multiplierLetters <- c("H", "K", "M", "B")
multiplier <- c(10^2, 10^3, 10^6, 10^9)
names(multiplier) <- multiplierLetters

stormData$PROPDMGEXP <- toupper(stormData$PROPDMGEXP)
validMultipliers <- stormData$PROPDMGEXP %in% multiplierLetters
stormData$PROPDMGEXP[!validMultipliers] <- NA
stormData$PROPDMG[!validMultipliers] <- NA

stormData$CROPDMGEXP <- toupper(stormData$CROPDMGEXP)
validMultipliers <- stormData$CROPDMGEXP %in% multiplierLetters
stormData$CROPDMGEXP[!validMultipliers] <- NA
stormData$CROPDMG[!validMultipliers] <- NA

uniqueEvents <- data.frame(EVTYPE = unique(stormData$EVTYPE), stringsAsFactors = F) %>% 
    arrange(EVTYPE)
uniqueEvents$Id <- 1:length(uniqueEvents$EVTYPE)
uniqueEvents$EventType <- NA_character_


for (e in events$EventName) {
    idx <- grep(paste0("^", e), uniqueEvents$EVTYPE)
    
    if(length(idx) > 0)
        uniqueEvents$EventType[idx] = e
}

idx <- grep("(?!THUNDERSNOW)(?=.*THUN)(?=.*W).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "THUNDERSTORM WIND"
idx <- NULL

idx <- grep("(?=.*^TSTM)(?=.*W).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "THUNDERSTORM WIND"
idx <- NULL

idx <- grep("GUSTNADO|BURST", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "THUNDERSTORM WIND"
idx <- NULL

idx <- grep("(?=.*MARINE)(?=.*TSTM|THUND)(?=.*W).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "MARINE THUNDERSTORM WIND"
idx <- NULL

idx <- grep("MARINE STRONG WIND", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "MARINE HIGH WIND"
idx <- NULL

idx <- grep("^HURRICANE|^TYPHOON", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "HURRICANE (TYPHOON)"
idx <- NULL

idx <- grep("LOW TIDE", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "ASTRONOMICAL LOW TIDE"
idx <- NULL

idx <- grep("AVALAN", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "AVALANCHE"
idx <- NULL

idx <- grep("BLIZZARD", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "BLIZZARD"
idx <- NULL

idx <- grep("(?=.*COASTAL|CSTL).*(?=.*FLOOD).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "COASTAL FLOOD"
idx <- NULL

idx <- grep("(?=.*DEBRIS FLOW|MUD|LAND|ROCK).*(?=.*SLIDE|SLUMP).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "DEBRIS FLOW"
idx <- NULL

idx <- grep("(?=.*FLASH)(?=.*FLOOD).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "FLASH FLOOD"
idx <- NULL

idx <- grep("FLOOD", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "FLOOD"
idx <- NULL

idx <- grep("^DROUGHT", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "DROUGHT"
idx <- NULL

idx <- grep("(?=.*EXCESSIVE|EXTREME|RECORD|WAVE|HYPERTHERMIA)(?=.*HEAT).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "EXCESSIVE HEAT"
idx <- NULL

idx <- grep("HYPERTHERMIA", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "EXCESSIVE HEAT"
idx <- NULL

idx <- grep("HEAT|UNSEASONABLY WARM|WARM WEATHER", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "HEAT"
idx <- NULL

idx <- grep("SURGE|HIGH TIDE|BEACH EROSION", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "STORM SURGE/TIDE"
idx <- NULL

idx <- grep("TORN", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "TORNADO"
idx <- NULL

idx <- grep("^TROPICAL STORM", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "TROPICAL STORM"
idx <- NULL

idx <- grep("^WATERSPOUT", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "WATERSPOUT"
idx <- NULL

idx <- grep("FIRE", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "WILDFIRE"
idx <- NULL

idx <- grep("(?=.*HEAVY).*(?=.*ICE|SNOW|MIX).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "WINTER STORM"
idx <- NULL

idx <- grep("WINTER WEATHER|WINTRY MIX|ICE|SNOW", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "WINTER WEATHER"
idx <- NULL

idx <- grep("(?=.*EXTREME).*(?=.*WIND).*(?=.*CHILL).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "EXTREME COLD/WIND CHILL"
idx <- NULL

idx <- grep("COLD|UNSEASONABLY COLD|HYPOTHERMIA", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "COLD/WIND CHILL"
idx <- NULL

idx <- grep("FROST|FREEZE|GLAZE|FREEZING DRIZZLE|FREEZING RAIN|FREEZING SPRAY|ICY", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "FROST/FREEZE"
idx <- NULL

idx <- grep("COASTAL EROSION|HEAVY SURF|HAZARDOUS SURF|ROUGH SEAS|ROUGH SURF|HIGH WAVES|HIGH SWELLS|HEAVY SWELLS", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "HIGH SURF"
idx <- NULL

idx <- grep("WIND", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[is.na(uniqueEvents$EventType)][uniqueEvents$Id == idx] <- "HIGH WIND"
idx <- NULL

idx <- grep("LIGHTING|LIGNTNING", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "LIGHTNING"
idx <- NULL

idx <- grep("(?=HEAVY|HVY|EXCESS|UNSEASONAL|TORRENTIAL).*(?=.*PRECIPITATION|RAIN|SHOWER).*", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[idx] <- "HEAVY RAIN"
idx <- NULL

idx <- grep("HAIL", perl = T, uniqueEvents$EVTYPE)
uniqueEvents$EventType[is.na(uniqueEvents$EventType)][uniqueEvents$Id == idx] <- "HAIL"
idx <- NULL

uniqueEvents$EventType[is.na(uniqueEvents$EventType)] <- "MISCELLANEOUS"

stormData2 <- stormData %>% 
    inner_join(uniqueEvents, by = c("EVTYPE" = "EVTYPE")) %>% 
    mutate(EventType = EventType, BeginYear = year(BGN_DATE)) %>% 
    group_by(BeginYear, EventType) %>% 
    summarize(Fatalities = sum(FATALITIES), Injuries = sum(INJURIES), 
              PropertyDamage = sum(PROPDMG * multiplier[PROPDMGEXP], na.rm = T), 
              CropDamage = sum(CROPDMG * multiplier[CROPDMGEXP], na.rm = T)) %>% 
    select (BeginYear, EventType, Fatalities, Injuries,  PropertyDamage, CropDamage)

damagesByEvent <- stormData2 %>% 
    group_by(EventType) %>% 
    summarize(EconomicDamage = sum(PropertyDamage + CropDamage), HealthDamage = sum(Fatalities + Injuries))

topEconomonic <- damagesByEvent %>% 
    arrange(-EconomicDamage) %>% 
    select(EventType)

top3Ecomonic <- topEconomonic$EventType[1:3]

topHealth <- damagesByEvent %>% 
    arrange(-HealthDamage) %>% 
    select(EventType)

top3Health <- topHealth$EventType[1:3]

topEcon <- stormData2 %>% 
    filter(EventType %in% top3Ecomonic) %>% 
    mutate(EconomicDamage = PropertyDamage + CropDamage) %>% 
    select(BeginYear, EventType, EconomicDamage) %>% 
    arrange(-EconomicDamage, BeginYear)


topHlth <- stormData2 %>% 
    filter(EventType %in% top3Health) %>% 
    mutate(HealthDamage = Fatalities + Injuries) %>% 
    select(BeginYear, EventType, HealthDamage) %>% 
    arrange(-HealthDamage, BeginYear)

xyplot(
    EconomicDamage ~ BeginYear | EventType, 
    data = topEcon, 
    layout = c(1, 3), 
    type = "l"
)

xyplot(
    HealthDamage ~ BeginYear | EventType, 
    data = topHlth, 
    layout = c(1, 3), 
    type = "l"
)


