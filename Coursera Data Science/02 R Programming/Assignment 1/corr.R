corr <- function(directory, threshold = 0) {
    files <- list.files(path=directory, pattern=".csv", full.names=T)
    corrs <- vector("numeric", 0)
    
    for (file in files) {
        data <- read.csv(file)
        cplt <- subset(data, !is.na(data$sulfate) & !is.na(data$nitrate))
        
        if(nrow(cplt) > threshold) {
            corrs <- c(corrs, cor(cplt$nitrate, cplt$sulfate))
        }
    }
    
    corrs
}
