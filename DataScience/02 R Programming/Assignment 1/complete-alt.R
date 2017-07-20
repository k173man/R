# data frame constructed in a row-wise manor
complete <- function(directory, id = 1:332) {
    files <- list.files(path=directory, pattern=".csv", full.names=T)[id]
    df <- data.frame(numeric(), numeric())
    
    for (file in files) {
        data <- read.csv(file)
        cplt <- subset(data, !is.na(data$sulfate) & !is.na(data$nitrate))
        
        # appends new rows using rbind
        df <- rbind(df, c(cplt$ID[1], nrow(cplt)))
        
        ## appends new rows using RC notation
        #df[nrow(df)+1,] <- c(cplt$ID[1], nrow(cplt))
    }
    
    names(df) <- c("id", "nobs")
    df
}
