#Create Tables
library(plyr)
ds<-subset(x=fds,subset=fds$Unknown_Undisclosed_Major==F)
names(ds)
fballcipbyrace<-data.frame(ddply(ds,c('School_Label','CIPFamily','CIPFamilyTitle','ID_Race'),function(x) count=nrow(x)))
races<-data.frame(ddply(ds,c('School_Label','ID_Race'),function(x) count=nrow(x)))
names(races)[3]<-"Total"
testfb<-merge(fballcipbyrace,races,all.x=T)
testfb$Percent_Race<-testfb$V1/testfb$Total
names(testfb)[5]<-"Value"
testfb$Variable<-"College Major"
names(fballcip[6])<-"Variable"
write.csv(fballcip,"Summary of Football Majors by School.csv")
write.csv(testfb,"Summary of Football Players by Race and School.csv")

#Summaries by Position
poscip<-data.frame(ddply(ds,c('ID_Position','CIPFamily','CIPFamilyTitle'),function(x) count=nrow(x)))
names(poscip)[4]<-"Value"
pos<-data.frame(ddply(ds,c('ID_Position'),function(x) count=nrow(x)))
poscip<-merge(poscip,pos,all.x=T)
poscip$Percentage_Position<-poscip$Value/poscip$V1
poscip$V1<-NULL
poscip$Variable<-"College Major"
write.csv(poscip,"Summary of Football Majors by Position.csv")

#Summaries by Position and Race
rposcip<-data.frame(ddply(ds,c('ID_Position','CIPFamily','CIPFamilyTitle','ID_Race'),function(x) count=nrow(x)))
names(rposcip)[5]<-"Value"
rpos<-data.frame(ddply(ds,c('ID_Position','ID_Race'),function(x) count=nrow(x)))
rposcip<-merge(rposcip,rpos,all.x=T)
rposcip$Percentage_Position<-rposcip$Value/rposcip$V1
rposcip$V1<-NULL
rposcip$Variable<-"College Major"
names(rposcip)[6]<-"Percentage_Position_Race"
write.csv(rposcip,"Summary of Football Majors by Position and Race.csv")

#Summaries by School, Position and Race
rsposcip<-data.frame(ddply(ds,c('School_Label','ID_Position','CIPFamily','CIPFamilyTitle','ID_Race'),function(x) count=nrow(x)))
names(rsposcip)[6]<-"Value"
rspos<-data.frame(ddply(ds,c('School_Label','ID_Position','ID_Race'),function(x) count=nrow(x)))
rsposcip<-merge(rsposcip,rspos,all.x=T)
rsposcip$Percentage_Position<-rsposcip$Value/rsposcip$V1
rsposcip$V1<-NULL
rsposcip$Variable<-"College Major"
names(rsposcip)[7]<-"Percentage_School_Position_Race"
write.csv(rsposcip,"Summary of Football Majors by School, Position and Race.csv")

#Summaries by Code, School, Position and Race
csposcip<-data.frame(ddply(ds,c('School_Label','CIPCode','CIPTitle','CIPFamilyTitle','ID_Race','ID_Position'),function(x) count=nrow(x)))
names(csposcip)[7]<-"Value"
cspos<-data.frame(ddply(ds,c('School_Label','CIPFamilyTitle','ID_Race'),function(x) count=nrow(x)))
csposcip<-merge(csposcip,cspos,all.x=T)
csposcip$Percentage_Position<-csposcip$Value/csposcip$V1
csposcip$V1<-NULL
csposcip$Variable<-"College Major"
names(csposcip)[8]<-"Percentage_Race"
write.csv(csposcip,"Summary of Football Majors by School, Position and Race.csv")