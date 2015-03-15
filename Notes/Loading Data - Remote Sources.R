setwd("Notes")

# Google search term: "data storage mechanism R package"

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

# +++++ Following code is from Getting Data (week 2, lecture 3) +++++
library(XML)

# 1st, 2nd & 3rd example differ slightly at first; once you have parsed HTML, the parsed HTML is used in the same way

# 1st example
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
# this code will return a string represenation of the HTML from the specified site, i.e. <DOCTYPE! html><html>...</html>
htmlCode = readLines(con)
close(con)
parsedHtml = htmlParse(htmlCode,asText=TRUE)

# 2nd example
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
parsedHtml <- htmlTreeParse(url, useInternalNodes=T)

# 3rd example - use 1st example for open websites
library(httr)

html2 = GET(url)
content2 = content(html2,as="text")
# at this point, parsedHtml looks exactly like htmlCode in 1st example, i.e. <DOCTYPE! html><html>...</html>
parsedHtml = htmlParse(content2,asText=TRUE)

# regardless of how we got parsedHtml var (1st, 2nd, or 3rd example), it is used the in the same way at this point, i.e. xpathSApply(...)
xpathSApply(parsedHtml, "//title", xmlValue)
xpathSApply(parsedHtml, "//td[@id='col-citedby']", xmlValue)

# Building on 3rd example (this is where httr is required)
# this code will return an error (Status 401) b/c a user/pw is required
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
# this code will authenticate a user/pw
pg2 = GET(
    "http://httpbin.org/basic-auth/user/passwd", 
    authenticate("user","passwd")
)

# creates a handle that preserves settings and cookies across multiple requests, i.e. saves authentication info
## this code demonstrates code, but not an actual authentication, which is shown in the previous example
google = handle("http://google.com")
# shows how you can change the path
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")

# +++++ Following code is from Getting Data (week 2, lecture 4) +++++
# need to register as a dev, add an app, etc.
myapp = oauth_app(
    "twitter", 
    key="yourConsumerKeyHere", 
    secret="yourConsumerSecretHere"
)
sig = sign_oauth1.0(
    myapp,
    token = "yourTokenHere", 
    token_secret = "yourTokenSecretHere"
)
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
# content(...) recognizes that homeTL is JSON data
json1 = content(homeTL)
# content(...) produces data that's hard to read, so this code reformats it
        ## :: operator is used to fully qualify a function with the package name (in this case fromJSON() & toJSON())
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

# +++++ Reading from a fixed width file (from Getting Data - Quiz 2)
 ++++require(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile = "data/wksst8110.for")
# there is 1 space before the 1st var & 5 spaces b/t the each of the remaing vars; B# is used for the Blank columns this creates
colNames <- c("B1", "Week", "B2", "Nino12SST", "Nino12SSTA", "B3", "Nino3SST", "Nino3SSTA", "B4", "Nino34SST", "Nino34SSTA", "B5", "Nino4SST", "Nino4SSTA")
# column widths
colWidths <- c(1, 9, 5, 4, 4, 5, 4, 4, 5, 4, 4, 5, 4, 4)
sst <- read.fwf("data/wksst8110.for", widths = colWidths, skip = 4, col.names = colNames)
# get rid of blank columns
sst <- select(sst, Week, Nino12SST, Nino12SSTA, Nino3SST, Nino3SSTA, Nino34SST, Nino34SSTA, Nino4SST, Nino4SSTA)


