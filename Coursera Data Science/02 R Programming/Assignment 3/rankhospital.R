rankhospital <- function(state, outcome, num = "best") {
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
    stabb <-  unique(outcomeOfCare$State)
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
    if (!is.numeric(num) & num == "worst")
        st <- st[order(-st[, 2], st[, 1]), ]
    else
        st <- st[order(st[, 2], st[, 1]), ]
    
    num2 <- if (!is.numeric(num))
                1
            else
                num
    
    ## Return hospital name in that state with the given rank 30-day death rate
    st$Hospital.Name[num2]
}
