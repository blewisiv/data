#Merge in the Actual Number of Graduates
library(gdata)
SchoolsMajors<-read.xls(xls='Common Data Set Data Top 25 Schools.xlsx',sheet=1)
names(SchoolsMajors)[4]<-"BD_C_Percent"
SchoolsMajors$Variable<-NULL
summary(SchoolsMajors)
BD_C<-read.xls(xls='Common Data Set Data Top 25 Schools.xlsx',sheet=2)
names(BD_C)[3]<-"BD_C"
BD_C$Variable<-NULL
mergeddata<-merge(SchoolsMajors,BD_C,all.x=T)
mergeddata$BD_Conferred<-round(mergeddata$BD_C_Percent*mergeddata$BD_C)
CIP<-read.xls(xls='Common Data Set Data Top 25 Schools.xlsx',sheet=3)
summary(CIP)
mergeddata<-merge(mergeddata,CIP,all.x=T)
data<-mergeddata[mergeddata$BD_Conferred>0,]
ddply()
dt<-data.table(mergeddata[mergeddata$BD_Conferred>0,])
write.csv(data,"Top 25 Schools by Major.csv")
names(data)
MajorsSummarySchool<-ddply(data,c('CIPTitle','DBPediaCollege_Name'),function(x) sum(x$BD_Conferred))
write.csv(MajorsSummarySchool,"Summary of Majors by School.csv")