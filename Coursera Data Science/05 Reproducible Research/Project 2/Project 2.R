library(dplyr)
library(ggplot2)
library(lattice)

setwd("~/DataSci/R/Coursera Data Science/05 Reproducible Research/Project 2")

# stormData <- read.csv("data/repdata_data_StormData.csv.bz2")
# save(stormData, file="data/stormData.RData", compress="bzip2")
load("data/stormData.RData")
