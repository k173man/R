best <- function(state, outcome) {
    possibleOutcomes <- c("heart attack", "heart failure", "pneumonia")
    ocIndexes <- c(11, 17, 23) 
    names(ocIndexes) <- possibleOutcomes
    
    # Check that outcome is valid
    if(!any(possibleOutcomes == outcome))
        stop("invalid outcome")
    
    # Read outcome data
    outcomeOfCare <- read.csv(
        "data/outcome-of-care-measures.csv", 
        colClasses = "character", 
        na.strings = "Not Available"
    )
    
    # Check that state is valid
    stabb <- unique(outcomeOfCare$State)
    if(!any(stabb == state))
        stop("invalid state")
    
    st <- subset(
        outcomeOfCare, 
        outcomeOfCare$State == state & !is.na(outcomeOfCare[, ocIndexes[[outcome]]])
    )
    
    # select hosital name & selected outcome variables
    st <- st[c(2, ocIndexes[[outcome]])]
    # convert outcome variable to numeric
    st[, 2] <- as.numeric(st[, 2])
    # order by outcome, hospital name
    st <- st[order(st[, 2], st[, 1]), ]
    
    st$Hospital.Name[1]
}
