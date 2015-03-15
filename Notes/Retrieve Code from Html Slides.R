setwd("Notes/data/Slides")

require(XML)
require(tools)

baseUrl <- "http://jtleek.com/modules"
courseNum <- "03"
URLs <- NULL
files <- list.files()
file <- list.files()[substr(files, 1, 2) == courseNum]
modules <- readLines(file)
course <- file_path_sans_ext(file)

for(m in modules)
    URLs <- c(URLs, paste(baseUrl, course, m, sep = .Platform$file.sep))

URLs <- as.list(URLs)

codeSnippets <- lapply(URLs, function(URL){
    msdoc <- htmlTreeParse(URL, useInternal = T)
    xpathSApply(msdoc, "//slide[@id]//code[@class='r']", xmlValue)
})

keepCode <- vapply(codeSnippets, function(cs) length(cs) > 0, logical(1))
codeSnippets <- codeSnippets[keepCode]
modules <- modules[keepCode]

x <- 0
lapply(codeSnippets, function(cs) {
    x <<- x + 1
    cat(unlist(cs), file = paste0(modules[x], ".R"))
})