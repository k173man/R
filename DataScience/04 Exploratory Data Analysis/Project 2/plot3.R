library(ggplot2)
library(dplyr)

setwd("/Docs/tmp/data")

if(file.exists("summarySCC_PM25.rds")){
    NEI <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds file is missing")
}

# Subset data, and then summarize Emissions by year and type
tebc2 <- NEI %>% 
    filter(fips == "24510") %>% 
    select(year, type, Emissions) %>% 
    group_by(year, type) %>% 
    summarize(TotalEmissions = sum(Emissions))

# plot data to determine Which of the four sources have seen decreases in emissions from 1999-2008 for Baltimore City
png(filename = "plot3.png")
qplot(year, TotalEmissions, data = tebc2, geom = "line", color = type)
dev.off()

# qplot(year, TotalEmissions, data = tebc, geom = "line", facets = . ~ type)
