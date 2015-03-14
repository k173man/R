# repeat - if a break condition is not specified, results in an infinate loop

repeat {
    message("Happy Groundhog Day!")
    action <- sample(
        c("Learn French", "Make an ice statue", "Rob a bank", "Win heart of Andie McDowell"), 
        1
    )
    message("action = ", action)
    
    if(action == "Rob a bank") {
        message("Quietly skipping to the next iteration")
        next
    }
    
    if(action == "Win heart of Andie McDowell")
        break
}

while(action != "Win heart of Andie McDowell") {
    message("Happy Groundhog Day!")
    action <- sample(
        c("Learn French", "Make an ice statue", "Rob a bank", "Win heart of Andie McDowell"), 
        1
    )
    message("action = ", action)
}

for(i in 1:5) {
    j <- i ^ 2
    message("j = ", j)
}

for(month in month.name)
    message("The month of ", month)
