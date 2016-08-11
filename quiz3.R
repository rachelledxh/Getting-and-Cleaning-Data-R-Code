### Quiz 3

## Problem 1
setwd("/Users/xiuhongdu/Desktop/quiz 3")
house <- read.csv("./house.csv", header=TRUE)
house.subset<- house[which(house$ACR>=3 & house$AGS>=6),]
head(house.subset)

##problem 2
install.packages("jpeg")
library(jpeg)
img <- readJPEG("./getdata-jeff.jpg", native=TRUE)
img_new<- quantile(img, probs=c(0, 0.3, 0.8,1), na.rm = TRUE)

## problem 3
GDP <- read.csv("./Desktop/quiz3/GDP.csv", header=TRUE)
GDP$GDP<- as.numeric(GDP$GDP)
FED <- read.csv("./Desktop/quiz3/FEDSTATS_Country.csv", header=TRUE)
mergeData<- merge(GDP,FED,by.x="CountryCode",by.y="CountryCode", all=TRUE)
 ## mergeData<- merge(GDP,FED, all=TRUE,by = c("CountryCode"))
sum(!is.na(unique(mergeData$Ranking)))

library(plyr)
## GDP_ASC<- arrange(mergeData,GDP)
setnames(mergeData, c( "X.1"), c("rankingGDP"))
GDP_ASC<- mergeData[order(rankingGDP, decreasing = TRUE)][13]
mergeData[order(rankingGDP, decreasing = TRUE)][13, ]
mergeData[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]

library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
 file <- file.path(getwd(), "GDP.csv")
download.file(url, file, method = "curl")
 dtGDP <- data.table(read.csv(file, skip = 4, nrows = 215))
 dtGDP <- dtGDP[X != ""]
 dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
 setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
 url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
 file <- file.path(getwd(), "EDSTATS_Country.csv")
 download.file(url, file, method = "curl")
 dtEd <- data.table(read.csv(file))
 dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))
dt[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]

