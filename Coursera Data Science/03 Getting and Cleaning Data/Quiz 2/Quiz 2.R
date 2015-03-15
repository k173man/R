# Q1 find the time that the datasharing repo was created
# API tutorial: https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
# Client ID: 88700c69e8c50cc71de7
# Client Secret: 689f4527f84c3ee722aba7025434c7b479fb21ad

install.packages("httpuv")
library(httr)
library(httpuv)
# Find OAuth settings for github: http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# Register an application at https://github.com/settings/applications;
    ## Use any URL you would like for the homepage URL (http://github.com is fine)
    ## Callback url: http://localhost:1410
    ## Insert your client ID and secret below - if secret is omitted, it will look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github", "88700c69e8c50cc71de7", "689f4527f84c3ee722aba7025434c7b479fb21ad")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
info <- content(req)
str(info)
lapply(info, function(repo) {
    if(repo$name == "datasharing")
        return(repo$created_at)
})
# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

# Q2
# install.packages("sqldf")
require(sqldf)
require(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "data/ss06pid.csv")
acs <- fread(input = "data/ss06pid.csv")
ans <- sqldf("select pwgtp1 from acs where AGEP < 50") 

# Q3
ans <- sqldf("select distinct AGEP from acs") 

# Q4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con, n = 100)
close(con)
nchar(htmlCode[c(10, 20, 30, 100)])

# Q5
require(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile = "data/wksst8110.for")
# there is 1 space before the 1st var & 5 spaces b/t the each of the remaing vars; B# is used for the Blank columns this creates
colNames <- c("B1", "Week", "B2", "Nino12SST", "Nino12SSTA", "B3", "Nino3SST", "Nino3SSTA", "B4", "Nino34SST", "Nino34SSTA", "B5", "Nino4SST", "Nino4SSTA")
# column widths
colWidths <- c(1, 9, 5, 4, 4, 5, 4, 4, 5, 4, 4, 5, 4, 4)
sst <- read.fwf("data/wksst8110.for", widths = colWidths, skip = 4, col.names = colNames)
# get rid of blank columns
sst <- select(sst, Week, Nino12SST, Nino12SSTA, Nino3SST, Nino3SSTA, Nino34SST, Nino34SSTA, Nino4SST, Nino4SSTA)

sum(sst$Nino3SST)





