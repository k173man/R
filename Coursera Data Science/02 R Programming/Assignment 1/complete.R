complete <- function(directory, id = 1:332) {
    files <- list.files(path=directory, pattern=".csv", full.names=T)[id]
    statId <- vector("numeric")
    obsCnt <- vector("numeric")
    
    for (file in files) {
        data <- read.csv(file)
        cplt <- subset(data, !is.na(data$sulfate) & !is.na(data$nitrate))
        
        statId <- c(statId, cplt$ID[1])
        obsCnt <- c(obsCnt, nrow(cplt))
    }
    
    data.frame(id = statId, nobs = obsCnt)
}