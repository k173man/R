setwd("Notes")

# Metadata
# read in 1st 100 rows
initial <- read.csv("data/ZipCodes.csv", nrows = 100)
# apply class() to the initial 100 rows to see default metadata
colClasses <- sapply(initial, class)

# zipColClasses is for use in following examples (declaring/initializing once to save space)
zipColClasses = c('character','factor',rep('numeric',17),rep('character',2),'factor','character','character',
               rep('character',5),'numeric','factor',rep('character',3),'factor',rep('character',2))

# +++++ CSV +++++
# unz() Unzips CSV file; provide full path to zip file & the name of the file to be extracted
zips <- read.csv(
    unz('data/ZipCodes.zip', 'ZipCodes.csv'), 
    colClasses = zipColClasses, 
    stringsAsFactors=F
)

# +++++ Table +++++
# read.table(), which is call by read.csv()
zips <- read.table(
    unz('data/ZipCodes.zip', 'ZipCodes.csv'), 
    sep = ',', 
    header = T, 
    colClasses = zipColClasses, 
    stringsAsFactors=F
)

# +++++ Fread +++++
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

# must pass a file path/name to fread() (cannot use unz(...) as in previous examples)
zips <- fread('data/ZipCodes.csv')
initial <- head(zips, nrow = 100)
sapply(initial, class)

# +++++ Scan +++++
# use scan() to read data into a vector or list from the console or file
# create test file with 3 line (title & 2 lines of data)
cat("FirstName LastName", "Shane Reed", "Jennifer Reed", file = "data/names.data", sep = "\n")
# using what = list(...), R assumes each line is a record with X # of fields (X = length of list(...))
    #nms is a list with a FirstName element & a LastName element
nms <- scan("data/names.data", what = list(FirstName="", LastName=""), skip = 1)
# returns Shane
nms$FirstName[1]

# readLines()
nms <- readLines("data/names.data")

# +++++ Excel +++++
# XLConnect & xlsx packages require a lot of processing (CPU) power (2 6-core Xeon processors w/ HT nearly maxed out)
# install.packages("XLConnect")
# options(...) increases memory available to JVM (Java VM), which is used by XLConnect
    ## default setting (~300MB) isn't enough to read Zip Codes file...we need 4G
    ## options(...) MUST be run before library(XLConnect)
    ## -Xmx is for setting the JVM heap size
    ## -Xms is for setting the JVM stack size
options (java.parameters = "-Xmx4g")
library(XLConnect)

zips <- readWorksheetFromFile(
    'data/ZipCodes.xlsx', 
    sheet = 'ZipCodes', 
    header = T
)
