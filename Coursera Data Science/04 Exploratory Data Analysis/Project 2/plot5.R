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

# Subset data for Baltimore City, Maryland and ON-ROAD types of emission, and then summarize Emissions by year
BcMv <- NEI %>% 
  filter(fips == "24510" & type == "ON-ROAD") %>% 
  select(year, Emissions) %>% 
  group_by(year) %>% 
  summarize(TotalEmissions = sum(Emissions))

# plot data to determine how emissions from motor vehicle sources have changed from 1999-2008 in Baltimore City
with(BcMv, plot(year, TotalEmissions, type = "l"))

