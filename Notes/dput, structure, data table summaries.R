df = dput(
    structure(
        list(
            sex = structure(c(1L, 1L, 2L, 2L), .Label = c("boy", "girl"), class = "factor"), 
            race = structure(c(1L, 1L, 2L, 2L), .Label = c("black", "white"), class = "factor"), 
            age = c(52L, 58L, 40L, 62L), 
            bmi = c(25L, 23L, 30L, 26L), 
            chol = c(187L, 220L, 190L, 204L)
        ), 
        .Names = c("sex", "race", "age", "bmi", "chol"), 
        row.names = c(NA, -4L), 
        class = "data.frame"
    )
)

DT <- data.table(df)
DT[, lapply(.SD, mean), by = c("sex", "race")]

dg <- group_by(df, sex)
# the names of the columns you want to summarize
cols <- names(dg)[-1]
# the dots component of your call to summarise
dots <- sapply(cols ,function(x) substitute(mean(x), list(x=as.name(x))))
do.call(summarise, c(list(.data=dg), dots))
