library(sqldf)

f <- file("data/household_power_consumption.txt")
hpc <- sqldf(
    "select * from f where Date = '1/2/2007' or Date = '2/2/2007'", 
    dbname = tempfile(), 
    file.format = list(sep = ";", header = T, row.names = F)
)
close(f)

hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png")
par(mfrow = c(2, 2))
# plot 1 of 4
with(hpc, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
# plot 2 of 4
with(hpc, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
# plot 3 of 4
with(hpc, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(hpc, lines(DateTime, Sub_metering_1, col = "black"))
with(hpc, lines(DateTime, Sub_metering_2, col = "red"))
with(hpc, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")
# plot 4 of 4
with(hpc, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()