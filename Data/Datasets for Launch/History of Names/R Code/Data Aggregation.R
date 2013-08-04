#Names Functions
library(stringr)
library(plyr)

# We're assuming you've downloaded the SSA files into your R project directory.

#National
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/History of Names/SSA/National/By Year")
list.files()
file_listing = list.files()[1:133]
file_listing <- list.files()[1:133]
names(file_listing) <- file_listing
name_data <- ldply(file_listing, read.csv, header = FALSE)
names(name_data)[2:4]<-c('Name','Sex','Count')
name_data$Year<-gsub("\\.txt",'',name_data$.id)
name_data$Year<-as.numeric(gsub("yob","",name_data$Year))
name_data$Location_ID<-'USA'
names(name_data)
name_data<-name_data[,c(6,5,1,2,3,4)]
name_data$Source_ID<-'SSA'

#National
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/History of Names/SSA/State/By State")
list.files()
file_listing = list.files()[1:51]
file_listing <- list.files()[1:51]
names(file_listing) <- file_listing
state_name_data <- ldply(file_listing, read.csv, header = FALSE)
names(state_name_data)
head(state_name_data)
names(state_name_data)[2:6]<-c('Location_ID','Sex','Year','Name','Count')
state_name_data<-state_name_data[,c(2,4,1,5,6)]
state_name_data$Source_ID<-'SSA'
