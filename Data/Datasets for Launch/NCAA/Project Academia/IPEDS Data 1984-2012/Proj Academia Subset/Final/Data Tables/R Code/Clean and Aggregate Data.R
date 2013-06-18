#Create Sumamry Tables and Analyze the  Data
library(gdata)
library(data.table)

files
ipeds<-read.csv(files[1])
grad<-read.csv(files[2])
scholar<-read.csv(files[3])
names(scholar)[10]<-"Tot"

names(ipeds)<-gsub("T.","",names(ipeds))
names(grad)<-gsub("T.","",names(grad))
names(scholar)<-gsub("T.","",names(scholar))

dts<-c('grad','ipeds','scholar')
grad<-data.table(grad)
ipeds<-data.table(ipeds)
scholar<-data.table(scholar)

#Set Keys
ipedskeys<-c('Year','ID_School','CIPFamily')
setkeyv(ipeds,cols=ipedskeys)
names(scholar)
sportkeys<-c('Year','ID_School','Sport')
setkeyv(scholar,cols=sportkeys)

names(grad)
gradkeys<-c('Year','ID_School','Sport','Variable')
setkeyv(grad,cols=gradkeys)

summary(scholar[,list(White.Men=sum(C.M),White.Women=sum(C.F),Black.Men=sum(AA.M),Black.Women=sum(AA.F)),by=list(Year,ID_School)])
