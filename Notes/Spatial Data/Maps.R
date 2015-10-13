library(rworldmap)
library(mapdata)
library(maps)


# try(data(package = "mapdata"))
# try(data(package = "maps"))

data(us.cities)
head(us.cities)

map("state")