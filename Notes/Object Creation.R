# Modes describe the type of information an object contains; possible modes:
    ## NULL, logical, numeric, complex, raw, character, list, expression, name, function, pairlist, language, char, ..., 
    ## environment, externalptr, weakref, closure, bytecode, promise,S4
    ## call (an unevaluated function), name

# Classes tell something about how an object is structured; possible classes:
    ## matrix, array, ts & mts (time series), factor, data.frame, 
    ## Date, POSIXct, POSIXlt, and difftime (date & time classes)

# +++++ Sequences (Vectors) +++++
colonOp <- 1:10
seqFx <- seq(1, 10) # same as 1:10
seqFx <- seq(1, 10, .5)  # increment by .5
seqFx <- seq(1, 10, length=30) # sequence of 30 #s ranging from 1 to 10
seqFx2 <- seq(along.with = seqFx) # create a seq based on the length of another seq
seqFx2 <- seq_along(seqFx) # same as seq(along.with...)
repSeq <- rep(1, 10) # repeat 1, 10 times
rep(c(0, 1, 2), times = 10) # repeat 0, 1, 2 10 times
rep(c(0, 1, 2), each = 10) # repeat 0 10 times, 1 10 times, 2 10 times

# +++++ Lists +++++
# "pre-allocate" alist of 5 empty element
lst <- vector("list", 5)
lst2 <- list(FName = c("Shane", "Jen"), LName = c("Reed", "Tierney-Reed"))
# add items to a list element
lst2$FName <- c(lst2$FName, "kobie")
lst2$LName <- c(lst2$LName, "Reed")

# +++++ Data Frames +++++
# lst2 from above to a data frame
lst2df <- as.data.frame(lst2, stringsAsFactors = FALSE)

# by default, character data is created as factors, so must use stringsAsFactors = FALSE
test <- data.frame(
    Name=c("shane", "shane", "shane", "Jen", "Jen", "Jen"), 
    Score=c(1, 2, 3, 1, 2, 3),
    stringsAsFactors = FALSE
)




