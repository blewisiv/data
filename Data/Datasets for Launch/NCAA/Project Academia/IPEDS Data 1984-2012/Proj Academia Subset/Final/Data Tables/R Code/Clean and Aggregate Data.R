#Create Sumamry Tables and Analyze the  Data
library(gdata)
library(data.table)

files<-list.files()

ipeds<-read.csv(files[1])
grad<-read.csv(files[2])
scholar<-read.csv(files[3])

names(ipeds)
names(grad)
names(scholar)

grad<-data.table(grad)
ipeds<-data.table(ipeds)
scholar<-data.table(scholar)

#Set Keys & Dat Tables
names(ipeds)
ipedskeys<-c('Year','ID_School','CIP_Family')
setkeyv(ipeds,cols=ipedskeys)
sportkeys<-c('Year','ID_School','Sport')
setkeyv(scholar,cols=sportkeys)
gradkeys<-c('Year','ID_School','Sport','Variable')
setkeyv(grad,cols=gradkeys)

#Create Subset Tables
#Scholarships
names(scholar)
schools.scholarhips<-data.frame((scholar[,j=list(Total=sum(Total)),by=list(Year,ID_School)] ))
write.csv(schools.scholarhips,'Summary Total Scholarships 1997-2006.csv')
subset(schools.scholarhips,schools.scholarhips$ID_School=='UOFM')
levels(schools.scholarhips$ID_School)

racestotals<-data.frame(scholar[,j=list(Males=sum(M),Females=sum(W),White.Males=sum(C.M),White.Females=sum(C.W),Black.Males=sum(AA.M),Black.Females=sum(AA.W),Hispanic.Males=sum(H.M),Hispanic.Females=sum(H.W)),by=list(Year,ID_School)] )
racestotals$Other.Males<-racestotals$Males-racestotals$Black.Males-racestotals$Hispanic.Males-racestotals$White.Males
racestotals$Males<-NULL
racestotals$Other.Females<-racestotals$Females-racestotals$Black.Females-racestotals$Hispanic.Females-racestotals$White.Females
racestotals$Females<-NULL
write.csv(racestotals,'Scholarships by Race and Year 1997-2006.csv')
levels(racestotals$ID_School)
subset(racestotals,racestotals$ID_School==c('LOUIS'))

scholar$Sport
football.basketball<-data.frame(scholar[Sport==list('Football','Basketball'),j=list(Males=sum(M),Females=sum(W),White.Males=sum(C.M),White.Females=sum(C.W),Black.Males=sum(AA.M),Black.Females=sum(AA.W),Hispanic.Males=sum(H.M),Hispanic.Females=sum(H.W)),by=list(Year,ID_School,Sport)])
football.basketball$Other.Males<-football.basketball$Males-football.basketball$Black.Males-football.basketball$Hispanic.Males-football.basketball$White.Males
football.basketball$Males<-NULL
football.basketball$Other.Females<-football.basketball$Females-football.basketball$Black.Females-football.basketball$Hispanic.Females-football.basketball$White.Females
football.basketball$Females<-NULL
write.csv(football.basketball,"Football-Basketball Scholarships by Race.csv")

football<-subset(football.basketball,football.basketball$Sport=='Football')
football<-remove.vars(football,c('White.Females','Hispanic.Females','Black.Females','Other.Females'))
write.csv(football,"Football Scholarships by Race 1997-2006.csv")

basketball<-subset(football.basketball,football.basketball$Sport=='Basketball')
write.csv(basketball,"Basketball Scholarships by Race 1997-2006.csv")