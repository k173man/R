library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)
tail(carMelt,n=3)
cylData <- dcast(carMelt, cyl ~ variable)

cylData <- dcast(carMelt, cyl ~ variable,mean)

head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)
spIns =  split(InsectSprays$count,InsectSprays$spray)

sprCount = lapply(spIns,sum)

unlist(sprCount)
sapply(spIns,sum)
ddply(InsectSprays,.(spray),summarize,sum=sum(count))
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)
