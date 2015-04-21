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

# Subset data for Baltimore City, Maryland, Los Angeles County and ON-ROAD types of emission, and then summarize Emissions by year
BcLAMv <- NEI %>% 
    filter(fips %in% c("06037", "24510") & type == "ON-ROAD") %>% 
    mutate(County = ifelse(fips == "06037", "Los Angeles", "Baltimore City")) %>% 
    select(County, year, Emissions) %>% 
    group_by(County, year) %>% 
    summarize(TotalEmissions = sum(Emissions))

# plot data to determine which county, Baltimore City or Los Angeles County, has seen greater changes over time in motor vehicle emissions
qplot(year, TotalEmissions, data = BcLAMv, geom = "line", color = County)

# LOOK @ PLOT 5 TO SEE IF BC #s MATCH