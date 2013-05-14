#Summarizing and Grouping Data in R examples
#Main Example at http://www.slideshare.net/jeffreybreen/grouping-summarizing-data-in-r
#Load packages
library(doBy)
library(plyr)
library(data.table)
library(ggplot2)
ncaa <- read.csv("~/Desktop/Github/Aragorn/AragornData/Categories/Data/Datasets for Launch/NCAA/Football/2012/Top 25 NCAA Football Schools Majors 2012 Draft 1.csv") #load NCAA data
df<-ncaa #change to df
rm(ncaa) #remove NCAA
nrow(df) #check number of rows
tail(df) #show the last 10
unique(df$DBPediaCollege_Name) #show unique schools

#Bad Way to Split -- Subsetting
um<-subset(df,DBPediaCollege_Name=='University of Michigan') #create subsets using subset function
fsu<-subset(df,DBPediaCollege_Name=='Florida State University') #create subsets using subset function
#Creating a summary data frame
results=data.frame()
for(major in unique(df$College_Major_Group)){
	tmp<-subset(df,College_Major_Group==major)
	count<-nrow(tmp)
	results<-rbind(results,data.frame(major))
}

#Using Apply Functions
tapply(df$Height.Inches,df$DBPediaCollege_Name,FUN=length) #summarizes the numbers of each
tapply(df$Height.Inches,df$DBPediaCollege_Name,FUN=mean) #summarizes the mean height
testmatrix<-as.matrix(tapply(df$Height.Inches,df$DBPediaCollege_Name,FUN=mean)) #summarizes the mean height in matrix form

#Using doBy package's summaryBy()
CollegesHeightSummaryDoBy<-summaryBy(Height.Inches~DBPediaCollege_Name,data=df,FUN=function(x) c(count=length(x), mean=mean(x),median=median(x)))#summarize count,median, mean

#Using Plyr's DDPLY function
CollegesHeightPlyrDDPLY<-ddply(df,'DBPediaCollege_Name',function(x) c(count=nrow(x),mean=mean(x$Height.Inches),median=median(x$Height.inches)))
#Using PLYR's DDPLY for faceted Tables
FacetedCollegesHeightPlyrDDPLY<-ddply(df,c('DBPediaCollege_Name','Position','ID_Player_Race'),function(x) c(count=nrow(x),mean=mean(x$Height.Inches),median=median(x$Height.inches)))

#Using Data Table
dt<-data.table(df)
CountedUsingDatatable<-dt[,length(Height.Inches),by=list(DBPediaCollege_Name,ID_Player_Race)]
