state <- "NJ"
outcome <- "heart attack"

possibleOutcomes <- c("heart attack", "heart failure", "pneumonia")
ocIndexes <- c(11, 17, 23) 
names(ocIndexes) <- possibleOutcomes

## Check that state and outcome are valid
if(!any(state.abb == state))
    stop("invalid outcome")

if(!any(possibleOutcomes == outcome))
    stop("invalid outcome")

# Read outcome data
outcomeOfCare <- read.csv(
    "data/outcome-of-care-measures.csv", 
    colClasses = "character", 
    na.strings = "Not Available"
)

st <- subset(
    outcomeOfCare, 
    outcomeOfCare$State == state & !is.na(outcomeOfCare[, ocIndexes[[outcome]]])
    )
st <- st[c(2, ocIndexes[[outcome]])]
st[, 2] <- as.numeric(st[, 2])
st <- st[order(st[, 2], st[, 1]), ]
st

# # replace specific class
# parseClasses <- function(cc, findClass, replaceClass) {
#     classes <- NULL
#     
#     for(i in 1:length(cc)) {
#         tc <- unlist(strsplit(cc[[i]], "\r\n"))
#         
#         if (tc == findClass)
#             tc <- replaceClass
#         
#         classes <- c(classes, tc)
#     }
#     
#     classes
# }

df <- data.frame(State = c("CA", "CO", "NJ", "TX"), Pop = c(10, 10, 30, 40), stringsAsFactors = FALSE)

state <- vector("character")
hospital <- vector("character")

for(st in state.abb) {
    tmp <- df$State[df$State == st]
    if (length(tmp) == 0)
        hospital <- c(hospital, NA_character_)
    else
        hospital <- c(hospital, st)
    
    state <- c(state, st)
}

df2 <- data.frame(Hospital = hospital, State = state, stringsAsFactors = FALSE)

state.abb[state.abb == "DC"]

outcomeOfCare <- read.csv(
    "data/outcome-of-care-measures.csv", 
    colClasses = "character", 
    na.strings = "Not Available"
)

unique(outcomeOfCare$State)
