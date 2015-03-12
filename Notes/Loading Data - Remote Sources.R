setwd("Notes")

# +++++ File Downloads +++++
# Speed camera locations in Baltimore
url <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD'
download.file(url, destfile = 'data/Baltimore_Fixed_Speed_Cameras.xlsx')
# method = 'curl' arg is required for https on Mac, but not on Windows; causes error on Windows
# download.file(url, destfile = 'data/Baltimore_Fixed_Speed_Cameras.xlsx', method = 'curl')

# for documentation purposes
dateDownloaded <- date()

# +++++ XML +++++
# install.packages("XML")
library(XML)

# +++ Example 1 +++
    ## XML document structure
    ## <breakfast_menu>
    ##     <food>
    ##         <name></name>
    ##         <price></price>
    ##         <description></description>
    ##         <calories></calories>
    ##     </food>
    ## </breakfast_menu>
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
# doc includes everything, i.e. XML declaration + root node
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
# root node (breakfast_menu)
rootNode <- xmlRoot(doc)
# returns breakfast_menu
xmlName(rootNode)
# returns the names of child elements
names(rootNode)
# returns a list containing the 1st food node
rootNode[1]
# returns the 1st food node
rootNode[1]$food
# returns the 1st food node
rootNode[[1]]
# returns the 1st node of the food node, which is name
rootNode[[1]][[1]]

# recursively applys xmValue to rootNode; basically, dumps all values
xmlSApply(rootNode, xmlValue)

# X-Path 
    ## Top level node: /node
    ## Node at any level: //node
    ## Node with an attribute name: node[@attr-name]
    ## Node with attribute name attr-name='bob': node[@attr-name='bob']

# applys xmValue to name nodes located @ any level of rootNode 
xpathSApply(rootNode, "//name", xmlValue)
# applys xmValue to price nodes located @ any level of rootNode 
xpathSApply(rootNode, "//price", xmlValue)

# +++ Example 2 +++
fileUrl <- "http://espn.go.com/nfl/team/schedule/_/name/bal/year/2013"
# use htmlTreeParse() b/c we're parsing an HTML page
doc <- htmlTreeParse(fileUrl, useInternal = T)
# applys xmValue to li nodes, w/ class attr = 'score', located @ any level of doc
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
# applys xmValue to li nodes, w/ class attr = 'team-name', located @ any level of doc
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)

# +++++ Slides +++++
# ms = MySQL
msUrl <- "http://jtleek.com/modules/03_GettingData/02_01_readingMySQL"
msdoc <- htmlTreeParse(msUrl, useInternal = T)
# slide id="slide-10"
msslides <- xpathSApply(msdoc, "//slide[@id]//code[@class='r']", xmlValue)

# +++++ JSON +++++
library(jsonlite)

# fromJSON returns a data frame
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
# returns names
names(jsonData)
# owner is actually a nested object; it is also a data frame
names(jsonData$owner)
# login is a variable in the owner data frame
jsonData$owner$login

# data frame to JSON
myjson <- toJSON(iris, pretty=TRUE)
# print out JSON
cat(myjson)
# fromJSON can read from a URL or a string, such as myjson
iris2 <- fromJSON(myjson)
head(iris2)





