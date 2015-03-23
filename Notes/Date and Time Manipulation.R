# install.packages("lubridate")
require(lubridate)

# parsing the character date object and convert to valid date
hetero_date <- c("second chapter due on 2013, august, 24", "first chapter submitted on 2013, 08, 18", "2013 aug 23")
# the sequence of year, month, and day should be similar across all values within the same object
ymd(hetero_date)
# demonstrates what happens with differing sequences
hetero_date <- c("second chapter due on 2013, august, 24", "first chapter submitted on 2013, 08, 18", "23 aug 2013")
ymd(hetero_date)

# Creating date object using based R functionality
date <- as.POSIXct("23-07-2013",format = "%d-%m-%Y", tz = "UTC")
# extracting month from the date object
as.numeric(format(date, "%m"))
# manipulating month by replacing month 7 to 8
date <- as.POSIXct(format(date,"%Y-8-%d"), tz = "UTC")

# The same operation is done using lubridate package 
date <- dmy("23-07-2013")
month(date)
month(date) <- 8

# accessing system date and time 
current_time <- now()
# changing time zone to "GMT"
current_time_gmt <- with_tz(current_time,"GMT")
# rounding the date to nearest day
round_date(current_time_gmt,"day")
# rounding the date to nearest month
round_date(current_time_gmt,"month")
# rounding date to nearest year
round_date(current_time_gmt,"year")

