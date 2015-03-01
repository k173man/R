setwd("Notes")

# Metadata
# read in 1st 100 rows
initial <- read.csv("data/ZipCodes.csv", nrows = 100)
# apply class() to the initial 100 rows to see default metadata
colClasses <- sapply(initial, class)

# Example from Practical Data Science Cookbook (chap 5, Importing Employment Data into R section)

# unz() Unzips CSV file; provide full path to zip file & the name of the file to be extracted
# read csv file; NOTE this takes a very long time with this file (> 200MB); see alt. method below
# zips <- read.csv(unz('data/ZipCodes.zip', 'ZipCodes.csv'), stringsAsFactors=F)

# install.packages('data.table')
# install.packages('bit64')

library(data.table)
# bit64 package is needed for fread()
require(bit64) 

# An alternative is to import the data directly into R, using fread() from the data.table package
# fread() uses an underlying C-level function to figure out, from the file, the following metadata:
    ## the length
    ## number of fields
    ## data types
    ## delimiters
# fread() then reads the file using the parameters it has learned

# must pass a file path/name to fread()
zips <- fread('data/ZipCodes.csv')
initial <- head(zips, nrow = 100)
sapply(initial, class)

# use scan() to read data into a vector or list from the console or file
#create test file with 3 line (title & 2 lines of data)
cat("FirstName LastName", "Shane Reed", "Jennifer Reed", file = "data/names.data", sep = "\n")
# using what = list(...), R assumes each line is a record with X # of fields (X = length of list(...))
    #nms is a list with a FirstName element & a LastName element
nms <- scan("data/names.data", what = list(FirstName="", LastName=""), skip = 1)
# returns Shane
nms$FirstName[1]

# readLines()
nms <- readLines("data/names.data")
