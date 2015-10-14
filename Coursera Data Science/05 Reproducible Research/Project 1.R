library(dplyr)
library(ggplot2)

activity <- read.csv("activity.csv", stringsAsFactors = F, colClasses = c("integer", "Date", "integer"))

activityExcludingNAs <- activity %>% 
  filter(!is.na(steps))

activityNAs <- activity %>% 
  filter(is.na(steps))

rm(activity)

# +++++ Part 1 +++++
dailyStepsExcludingNAs <- activityExcludingNAs %>% 
  group_by(date) %>% 
  summarize(steps = sum(steps))

with (dailyStepsExcludingNAs, hist(steps))

# 10766
meanDailyStepsExcludingNAs <- mean(dailyStepsExcludingNAs$steps)
# 10765
medianDailyStepsExcludingNAs <- median(dailyStepsExcludingNAs$steps)

# +++++ Part 2 +++++
avgStepsByIntervalExcludingNAs <- activityExcludingNAs %>% 
  group_by(interval) %>% 
  summarize(AverageSteps = as.integer(round(mean(steps))))

with (avgStepsByIntervalExcludingNAs, plot(interval, AverageSteps, type="l"))

intervalWithMaxAvgStepsExcludingNAs = avgStepsByIntervalExcludingNAs[which.max(avgStepsByIntervalExcludingNAs$AverageSteps), ]$interval

# +++++ Part 3 +++++
countOfNAs <- nrow(activityNAs)

replaceNAs <- avgStepsByIntervalExcludingNAs$AverageSteps
names(replaceNAs) <- as.character(avgStepsByIntervalExcludingNAs$interval)

activityNAs$steps = as.integer(replaceNAs[as.character(activityNAs$interval)])

activity <- union(activityExcludingNAs, activityNAs)

dailySteps <- activity %>% 
  group_by(date) %>% 
  summarize(steps = sum(steps))

with (dailySteps, hist(steps))

# 10766 (rounded up)
meanDailySteps <- mean(dailySteps$steps)
# 10762
medianDailySteps <- median(dailySteps$steps)

#  +++++ Part 4 +++++
avgStepsByDayTypeInterval <- activity %>% 
  mutate(dayType = factor(ifelse(weekdays(date, T) %in% c("Sat", "Sun"), "Weekend", "Weekday"))) %>% 
  group_by(dayType, interval) %>% 
  summarize(steps = mean(steps))

g <- ggplot(avgStepsByDayTypeInterval, aes(interval, steps))
g + geom_line() + facet_grid(dayType ~ .)
