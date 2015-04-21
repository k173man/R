library(dplyr)
library(data.table)

setwd("/Docs/tmp/data")

if(file.exists("Source_Classification_Code.rds")){
    SCC <- readRDS("Source_Classification_Code.rds")
} else {
    stop("Source_Classification_Code.rds file is missing")
}

if(file.exists("summarySCC_PM25.rds")){
    NEI <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds file is missing")
}

# Subset data for obs. related to coal & combustion, and select the associated codes
cc <- SCC %>% 
  filter(grepl("coal", Short.Name, ignore.case = T) & grepl("combustion", SCC.Level.One, ignore.case = T)) %>% 
  select(SCC)

# create data tables; the join is much faster
# factor(...) drops unused factors
dtScc <- data.table(SCC = factor(cc$SCC))
dtNEI <- data.table(SCC = NEI$SCC, Emissions = NEI$Emissions, year = NEI$year)

# Subset PM2.5 data by merging subset of SCC data; summarize Emissions by year
dtCC <- merge(dtNEI, dtScc, by = "SCC") %>% 
  select(year, Emissions) %>% 
  group_by(year) %>% 
  summarize(TotalEmissions = sum(Emissions))

# plot data to determine how emissions from coal combustion-related sources have changed from 1999-2008, across the U.S.
with(dtCC, plot(year, TotalEmissions, type = "l"))

