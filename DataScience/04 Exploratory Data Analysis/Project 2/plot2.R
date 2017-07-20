library(dplyr)

setwd("/Docs/tmp/data")

if(file.exists("summarySCC_PM25.rds")){
    NEI <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds file is missing")
}

# Subset data, and then summarize Emissions by year
tebc <- NEI %>% 
    filter(fips == "24510") %>% 
    select(year, Emissions) %>% 
    group_by(year) %>% 
    summarize(TotalEmissions = sum(Emissions))

# plot data to determine if total emissions from PM2.5 have decreased in the Baltimore City, Maryland from 1999 to 2008
png(filename = "plot2.png")
with(tebc, plot(year, TotalEmissions, type = "l"))
dev.off()

