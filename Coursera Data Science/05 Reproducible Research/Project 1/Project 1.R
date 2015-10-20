library(dplyr)
library(ggplot2)
library(lattice)

setwd("~/DataSci/R/Coursera Data Science/05 Reproducible Research/Project 1")

if(!dir.exists("data"))
  dir.create("data")

if (!file.exists("data/repdata_data_activity.zip")) {
  url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
  download.file(url, "data/repdata_data_activity.zip")
}

if (!file.exists("data/activity.csv"))
    unzip("data/activity.zip", overwrite = T)

activity <- read.csv("data/activity.csv", stringsAsFactors = F, colClasses = c("integer", "Date", "integer"))

# +++++ Part 1 +++++
dailyStepsXcludNAs <- activity %>% 
  filter(!is.na(steps)) %>% 
  group_by(date) %>% 
  summarize(steps = sum(steps))

with (dailyStepsXcludNAs, hist(steps))

# 10766
meanDailyStepsXcludNAs <- mean(dailyStepsXcludNAs$steps)
# 10765
medianDailyStepsXcludNAs <- median(dailyStepsXcludNAs$steps)

# +++++ Part 2 +++++
avgStepsByInterval <- activity %>% 
  filter(!is.na(steps)) %>% 
  group_by(interval) %>% 
  summarize(AverageSteps = as.integer(round(mean(steps))))

with (avgStepsByInterval, plot(interval, AverageSteps, type="l"))

maxAvgStepsInterval = avgStepsByInterval[which.max(avgStepsByInterval$AverageSteps), ]$interval

# +++++ Part 3 +++++
countOfNAs <- activity %>% 
  filter(is.na(steps)) %>% 
  nrow

imputedActivity <- left_join(activity, avgStepsByInterval, by = c("interval" = "interval")) %>%
  mutate(steps = ifelse(is.na(steps), AverageSteps, steps)) %>% 
  select(steps, date, interval) %>% 
  arrange(date, interval)

dailySteps <- imputedActivity %>% 
  group_by(date) %>% 
  summarize(steps = sum(steps))

with (dailySteps, hist(steps))

# 10766 (rounded up)
meanDailySteps <- mean(dailySteps$steps)
# 10762
medianDailySteps <- median(dailySteps$steps)

#  +++++ Part 4 +++++
avgStepsByDayTypeInterval <- imputedActivity %>% 
  mutate(dayType = factor(ifelse(weekdays(date, T) %in% c("Sat", "Sun"), "Weekend", "Weekday"))) %>% 
  group_by(dayType, interval) %>% 
  summarize(steps = mean(steps))

xyplot(
  steps ~ interval | dayType, 
  data = avgStepsByDayTypeInterval, 
  layout = c(1, 2), 
  type = "l"
)

g <- ggplot(avgStepsByDayTypeInterval, aes(interval, steps))
# g + geom_line() + facet_grid(dayType ~ ., as.table = F) 
g + geom_line(aes(color = dayType)) 
