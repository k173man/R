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

# Subset data for Baltimore City, Maryland, and then summarize Emissions by year
tebc <- NEI %>% 
    filter(fips == "24510") %>% 
    select(year, Emissions) %>% 
    group_by(year) %>% 
    summarize(TotalEmissions = sum(Emissions))

# plot data to determine if total emissions from PM2.5 have decreased in the Baltimore City, Maryland from 1999 to 2008
with(tebc, plot(year, TotalEmissions, type = "l"))

