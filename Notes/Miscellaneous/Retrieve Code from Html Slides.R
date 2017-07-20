# Source Control for Slides: https://github.com/DataScienceSpecialization/courses
# A example of a slide URL (from course #3, Getting and Cleaning Data): http://jtleek.com/modules/03_GettingData/03_01_subsettingAndSorting
# Slides directory contains a directory for each course, which contains:
    ## A Code directory
    ## A SlideNames.txt file - this file contains the module names for a given course (must copy shortcut for each html slide)

setwd("Notes")

require(XML)
require(tools)

courseNum <- "04"

baseUrl <- "http://jtleek.com/modules"
courses <- list.dirs("Slides", recursive = F, full.names = F)
course <- courses[substr(courses, 1, 2) == courseNum]
courseDir <- file.path("Slides", course)
modules <- readLines(file.path(courseDir, "SlideNames.txt"))
URLs <- NULL

if (length(modules) == 0)
    stop("The SlideNames.txt file for selected course needs to be populated")

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
    cat(
        unlist(cs), 
        file = file.path(courseDir, "Code", paste0(modules[x], ".R"))
    )
})

