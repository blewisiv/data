#New Names
library(plyr)
library(dplyr)
#Load and clean the data
names<-names[,c(2,4:6)]
totals<-ddply(names,c('Year','Sex'),summarise,total=sum(Count))
names(names)[1:4]<-tolower(names(names)[1:4])
names$sex<-gsub("\\F",'girl',names$sex)
names$sex<-gsub("\\M",'boy',names$sex)
names<-merge(names,totals,all.x=T)
names$percent<-round(names$percent,digits=10)

#Explore the Data

#1. Create a new dataframe that only includes years since 2000
newest <- subset(names, year >= 1980)

#2. Subset into boys and girls
girls <- subset(names, sex == "girl")
subset(girls, percent == max(percent))
boys <- subset(names, sex == "boy")
subset(boys, percent == max(percent))