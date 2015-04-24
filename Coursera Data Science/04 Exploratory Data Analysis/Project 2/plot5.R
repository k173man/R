library(dplyr)

setwd("/Docs/tmp/data")

if(file.exists("summarySCC_PM25.rds")){
    NEI <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds file is missing")
}

# Subset data, and then summarize Emissions by year
BcMv <- NEI %>% 
  filter(fips == "24510" & type == "ON-ROAD") %>% 
  select(year, Emissions) %>% 
  group_by(year) %>% 
  summarize(TotalEmissions = sum(Emissions))

# plot data to determine how emissions from motor vehicle sources have changed from 1999-2008 in Baltimore City
png(filename = "plot5.png")
with(BcMv, plot(year, TotalEmissions, type = "l"))
dev.off()

