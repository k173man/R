#joins using data frames
df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster",3), rep("Radio",3)))
df2 = data.frame(CustomerId = c(2,4,6), State = c(rep("Alabama",2), rep("Ohio",1)))

df12 <- merge(df1, df2, by.x = "CustomerId", by.y = "CustomerId")

# joins using data tables
dt1 <- data.table(df1,  key="CustomerId") 
dt2 <- data.table(df2, key="CustomerId")

dt1.joined.dt.2 <- dt1[dt2]

# using merge with data tables
merge(dt1, dt2)

# dplyr
df12 <- inner_join(df1, df2, by = c("CustomerId" = "CustomerId"))