library(dplyr)

setwd("/Docs/tmp/data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BcMv <- NEI %>% 
  filter(fips == "24510" & type == "ON-ROAD") %>% 
  select(year, Emissions) %>% 
  group_by(year) %>% 
  summarize(TotalEmissions = sum(Emissions))

with(BcMv, plot(year, TotalEmissions, type = "l"))
