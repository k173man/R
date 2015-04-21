library(dplyr)

setwd("/Docs/tmp/data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

d <- NEI %>% 
    select(year, Emissions) %>% 
    group_by(year) %>% 
    summarize(TotalEmissions = sum(Emissions)) 

# format #s as #K
with(d, plot(year, TotalEmissions, type = "l"))

