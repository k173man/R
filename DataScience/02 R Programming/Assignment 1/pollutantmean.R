pollutantmean <- function(directory, pollutant, id = 1:332) {
    files <- list.files(path=directory, pattern=".csv", full.names=T)[id]
    obs <- vector("numeric")
    
    for (file in files) {
        data <- read.csv(file)
        obs <- c(obs, data[pollutant][!is.na(data[pollutant])])
    }
    
    mean(obs)
}