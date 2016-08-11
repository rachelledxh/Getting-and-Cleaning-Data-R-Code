## Quiz 4

## pr1
setwd("./Desktop/quiz4/")
pr1<- read.csv(file="pr1.csv", header = TRUE)
splitNames= strsplit(names(pr1),"wgtp")
splitNames[[123]]

## pr2

pr2<- read.csv(file="GDP.csv", skip=4)
mydata<- c("X","X.1","X.3","X.4")
pr2<- pr2[mydata]
pr2$X.4<- as.numeric(gsub(",","",pr2$X.4))
mean(pr2$X.4[1:190],na.rm=TRUE)

## pr 3
library(plyr)
rename(pr2, c("X"="CountryCode", "X.1"="Ranking","X.3"="countryNames","X.4"="GDP"))
grep("^United",as.character(pr2$X.3[1:190]))

## pr 4
Country<- read.csv(file="Country.csv", header=TRUE)
country_code_list<- unique(as.character(pr2$X[1:190]))
Country_subset<- subset(Country,Country$CountryCode %in% country_code_list)
grep("June.30",as.character(Country_subset[,10]))

## pr 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
x<-grep("^2012",as.character(sampleTimes))
y<-format(sampleTimes,"%Y-%m-%d")
y<- as.Date(y)
z<- weekdays(y)
sum(format(as.Date(sampleTimes, format = "%Y-%m-%d"), "%Y%a") == "2012Mon")