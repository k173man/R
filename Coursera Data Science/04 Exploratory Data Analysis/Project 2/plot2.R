library(dplyr)

setwd("/Docs/tmp/data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

d <- NEI %>% 
    filter(fips = "24510") %>% 
    select(year, Emissions) %>% 
    group_by(year) %>% 
    summarize(TotalEmissions = sum(Emissions))

with(d, plot(year, TotalEmissions, type = "l"))