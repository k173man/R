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