library(ggplot2)
library(dplyr)

setwd("/Docs/tmp/data")

# if(file.exists("Source_Classification_Code.rds")){
#     SCC <- readRDS("Source_Classification_Code.rds")
# } else {
#     stop("Source_Classification_Code.rds file is missing")
# }

if(file.exists("summarySCC_PM25.rds")){
    NEI <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds file is missing")
}

# Subset data for Baltimore City, Maryland, and then summarize Emissions by year and type
tebc <- NEI %>% 
    filter(fips == "24510") %>% 
    select(year, type, Emissions) %>% 
    group_by(year, type) %>% 
    summarize(TotalEmissions = sum(Emissions))

# plot data to determine Which of the four sources have seen decreases in emissions from 1999-2008 for Baltimore City
qplot(year, TotalEmissions, data = tebc, geom = "line", color = type)

# qplot(year, TotalEmissions, data = tebc, geom = "line", facets = . ~ type)
