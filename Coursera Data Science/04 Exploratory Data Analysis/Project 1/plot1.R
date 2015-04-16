library(sqldf)

f <- file("data/household_power_consumption.txt")
hpc <- sqldf(
    "select * from f where Date = '1/2/2007' or Date = '2/2/2007'", 
    dbname = tempfile(), 
    file.format = list(sep = ";", header = T, row.names = F)
)
close(f)

hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

png(filename = "plot1.png")
hist(
    hpc$Global_active_power, 
    main = "Global Active Power", 
    xlab = "Global Active Power (kilowatts)", 
    col = "red"
)
dev.off()