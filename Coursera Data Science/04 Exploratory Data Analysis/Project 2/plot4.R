library(dplyr)
library(data.table)

setwd("/Docs/tmp/data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

cc <- SCC %>% 
  filter(grepl("coal", Short.Name, ignore.case = T) & grepl("combustion", SCC.Level.One, ignore.case = T)) %>% 
  select(SCC)

# factor(...) drops unused factors
dtScc <- data.table(SCC = factor(cc$SCC))
dtNEI <- data.table(SCC = NEI$SCC, Emissions = NEI$Emissions, year = NEI$year)

dtCC <- merge(dtNEI, dtScc, by = "SCC") %>% 
  select(year, Emissions) %>% 
  group_by(year) %>% 
  summarize(TotalEmissions = sum(Emissions))

with(dtCC, plot(year, TotalEmissions, type = "l"))
