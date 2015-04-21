library(ggplot2)
library(dplyr)

setwd("/Docs/tmp/data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

d <- NEI %>% 
    filter(fips = "24510") %>% 
    select(year, Emissions) %>% 
    group_by(year, type) %>% 
    summarize(TotalEmissions = sum(Emissions))
