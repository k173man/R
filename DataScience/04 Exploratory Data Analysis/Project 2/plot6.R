library(ggplot2)
library(dplyr)

setwd("/Docs/tmp/data")

if(file.exists("summarySCC_PM25.rds")){
    NEI <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds file is missing")
}

# Subset data, and then summarize Emissions by year
BcLAMv <- NEI %>% 
    filter(fips %in% c("06037", "24510") & type == "ON-ROAD") %>% 
    mutate(County = ifelse(fips == "06037", "Los Angeles", "Baltimore City")) %>% 
    select(fips, County, year, Emissions) %>% 
    group_by(fips, County, year) %>% 
    summarize(TotalEmissions = sum(Emissions))

# get the PM2.5 values for each location for 1999 & 2008
Bc1999 <- BcLAMv$TotalEmissions[BcLAMv$fips == "24510" & BcLAMv$year == 1999]
LA1999 <- BcLAMv$TotalEmissions[BcLAMv$fips == "06037" & BcLAMv$year == 1999]
Bc2008 <- BcLAMv$TotalEmissions[BcLAMv$fips == "24510" & BcLAMv$year == 2008]
LA2008 <- BcLAMv$TotalEmissions[BcLAMv$fips == "06037" & BcLAMv$year == 2008]
# net change over time
BcDelta <- Bc2008 - Bc1999
LADelta <- LA2008 - LA1999

# helper function; used to label the facets
labelr <- function (variable, value) {
    ifelse(value == "Los Angeles", paste0("LA had a net change of ", round(LADelta, 0)), paste0("BC had a net change of ", round(BcDelta, 0)))
}

# plot data to determine which county, Baltimore City or Los Angeles County, has seen greater changes over time in motor vehicle emissions
png(filename = "plot6.png")
g <- ggplot(BcLAMv, aes(year, TotalEmissions))
g + geom_line(aes(color = County)) + facet_grid(County ~ ., scales = "free_y", labeller = labelr)
dev.off()

# g <- ggplot(BcLAMv, aes(year, TotalEmissions))
# g + geom_point(aes(color = County)) + facet_grid(County ~ ., scales = "free_y", labeller = labelr) + geom_smooth(aes(color = County), method = "lm", se = F)
