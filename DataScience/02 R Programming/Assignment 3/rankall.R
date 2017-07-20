rankall <- function(outcome, num = "best") {
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
    
    ococ <- subset(
        outcomeOfCare, 
        !is.na(outcomeOfCare[, ocIndexes[[outcome]]])
    )
    
    # select hosital name, state & selected outcome variables
    ococ <- ococ[c(2, 7, ocIndexes[[outcome]])]
    names(ococ) <- c("Hospital", "State", "Outcome")
    # convert outcome variable to numeric
    ococ$Outcome <- as.numeric(ococ$Outcome)
    
    # order by outcome, hospital name
    if (!is.numeric(num) & num == "worst")
        ococ <- ococ[order(ococ$State, -ococ$Outcome, ococ$Hospital), ]
    else
        ococ <- ococ[order(ococ$State, ococ$Outcome, ococ$Hospital), ]
    
    num2 <- if (!is.numeric(num))
        1
    else
        num

    state <- NULL
    hospital <- NULL
    stabb <- unique(outcomeOfCare$State)
    stabb <- stabb[order(stabb)]
    
    for(st in stabb) {
        tmp <- subset(ococ, ococ$State == st)
        tmp <- tmp$Hospital[num2]
        hospital <- c(hospital, tmp)
        state <- c(state, st)
    }
    
    data.frame(
        hospital = hospital, 
        state = state, 
        row.names = stabb, 
        stringsAsFactors = FALSE
    )
}
