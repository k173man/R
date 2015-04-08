setwd("Notes")

# sqldf allows you to read data into a SqlLite DB & subset before reading it into R
# household_power_consumption.txt is a semi-colon delimited file; date format is dd/mm/yyyy
f <- file("household_power_consumption.txt")
bigdf <- sqldf(
    "select * from f where Date = '1/2/2007' or Date = '2/2/2007'", 
    dbname = tempfile(), 
    file.format = list(sep = ";", header = T, row.names = F)
)
close(f)


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

# fread() performance test/demo; fread() is ~4x faster
# create DF w/ 1M rows
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
# create temp file connection for use in write.table()
file <- tempfile()
write.table(
    big_df, 
    file = file, 
    row.names = FALSE, 
    col.names = TRUE, 
    sep="\t", 
    quote=FALSE
)
# fread() test
system.time(fread(file))
# read.table() test
system.time(read.table(file, header=TRUE, sep="\t"))


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
    ## XLConnect & xlsx packages require:
        ### a lot of processing (CPU) power (2 6-core Xeon processors w/ HT nearly maxed out)
        ### a lot of memory
            #### options(...) increases memory available to JVM (Java VM), which is used by XLConnect & xlsx
            #### default setting (~300MB for XLC) isn't enough to read Zip Codes file...we need 4G
            #### options(...) MUST be run before library(XLConnect)
                ##### -Xmx is for setting the JVM heap size
                ##### -Xms is for setting the JVM stack size
            #### Memory diagnostics - functions below are from XLConnect, but can be used with xlsx (must load XLConnect)
            #### use xlcMemoryReport() to check available memory
            #### use xlcFreeMemory() to release memory

# +++ XLConnect +++
# install.packages("XLConnect")
options (java.parameters = "-Xmx4g")
library(XLConnect)

# zipColClasses is for use in following examples (declaring/initializing once to save space)
zipColTypes = c(rep(XLC$DATA_TYPE.STRING,2),rep(XLC$DATA_TYPE.NUMERIC,17),rep(XLC$DATA_TYPE.STRING,10),
                  XLC$DATA_TYPE.NUMERIC, rep(XLC$DATA_TYPE.STRING,2))

# sheet arg can be a name or an index
# other useful args: startRow, startCol, endRow, endCol 
zips <- readWorksheetFromFile(
    'data/ZipCodes.xlsx', 
    sheet = 'ZipCodes', 
    header = T, 
    colTypes = zipColTypes
)

# +++ xlsx +++
options (java.parameters = "-Xmx4g")
library(xlsx)

# read.xlsx2() does more work in Java, resulting in better performance than read.xlsx()
    ## performance increase w/ xls2 is an order of magnitude for sheets with > 100K cells
    ## xlsx & xlsx2 can return different results; xlsx2 uses readColumns()
    ## xlsx2 can be unstable for row subsetting, e.g. it throws an error when using rowIndex
# sheet can be specified using sheetIndex or sheetName
# other useful args: startRow, endRow, keepFormulas, colClasses

colIdx <- 1:5
rowIdx <- 1:50

zips <- read.xlsx(
    'data/ZipCodes.xlsx', 
    sheetName = 'ZipCodes', 
    header = T, 
    rowIndex = rowIdx, 
    colIndex = colIdx
)
# read.xlsx2() w/o rowIndex arg to avoid an error
zips <- read.xlsx2(
    'data/ZipCodes.xlsx', 
    sheetName = 'ZipCodes', 
    header = T, 
    colIndex = colIdx
)
