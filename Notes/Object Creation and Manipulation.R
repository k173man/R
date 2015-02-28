# +++++ Sequences (Vectors) +++++
colonOp <- 1:10
seqFx <- seq(1, 10) # increment by .5
seqFx <- seq(1, 10, .5) # sequence of 30 #s ranging from 1 to 10
seqFx <- seq(1, 10, length=30) # create a seq based on the length of another seq
seqFx2 <- seq(along.with = seqFx) # or use seq_along()
seqFx2 <- seq_along(seqFx)
repSeq <- rep(1, 10) # repeat 1, 10 times
rep(c(0, 1, 2), times = 10)
rep(c(0, 1, 2), each = 10)

# +++++ Vectors +++++

# +++++ Lists +++++
# "pre-allocate" alist of 5 empty element
lst <- vector("list", 5)
lst2 <- list(FName = c("Shane", "Jen"), LName = c("Reed", "Tierney-Reed"))


# +++++ Data Frames +++++
# lst2 from above to a data frame
lst2df <- as.data.frame(lst2, stringsAsFactors = FALSE)

# by default, character data is created as factors, so must use stringsAsFactors = FALSE
test <- data.frame(
    Name=c("shane", "shane", "shane", "Jen", "Jen", "Jen"), 
    Score=c(1, 2, 3, 1, 2, 3),
    stringsAsFactors = FALSE
)







