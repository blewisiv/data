#Create Sumamry Tables and Analyze the  Data
library(gdata)
library(data.table)

files<-list.files()

ipeds<-read.csv(files[1])
grad<-read.csv(files[2])
scholar<-read.csv(files[2])

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

schools.scholarhips<-data.frame((scholar[,j=list(Total=sum(Total)),by=list(Year,ID_School,DOE.Institution_Name,ID_Conference)] ))

names(schools.scholarhips)[3]<-"School"
write.csv(schools.scholarhips,'Summary Total Scholarships 1997-2006.csv')
gsub('Louisiana State University and Agricultural & Mechanical College','LSU',schools.scholarhips$DOE.Institution_Name)
subset(schools.scholarhips,schools.scholarhips$ID_School=='UOFM')
levels(schools.scholarhips$ID_School)

allscholarships<-data.frame(scholar[j=list(Males=sum(M),Females=sum(W),White.Males=sum(C.M),White.Females=sum(C.W),Black.Males=sum(AA.M),Black.Females=sum(AA.W),Hispanic.Males=sum(H.M),Hispanic.Females=sum(H.W)),by=list(Year,Sport,ID_School)])
write.csv(allscholarships,'All Scholarship by Sport-Race-Gender 07-06.csv')

footballscholar<-data.frame(scholar[i=Sport=='Football',j=list(Males=sum(M),Females=sum(W),White.Males=sum(C.M),White.Females=sum(C.W),Black.Males=sum(AA.M),Black.Females=sum(AA.W),Hispanic.Males=sum(H.M),Hispanic.Females=sum(H.W)),by=list(Year,Sport,ID_School)])
footballscholar$Other.Males<-footballscholar$Males-footballscholar$Black.Males-footballscholar$Hispanic.Males-footballscholar$White.Males
footballscholar$Males<-NULL
footballscholar$Other.Females<-footballscholar$Females-footballscholar$Black.Females-footballscholar$Hispanic.Females-footballscholar$White.Females
footballscholar$Females<-NULL
footballscholar<-remove.vars(footballscholar,c('Black.Females','White.Females','Other.Females','Hispanic.Females'))
write.csv(racestotals,'Football Scholarships by Race-Year 97-06.csv')
levels(racestotals$ID_School)
subset(racestotals,racestotals$ID_School==c('LOUIS'))

basketballscholar<-data.frame(scholar[i=Sport=='Basketball',j=list(Males=sum(M),Females=sum(W),White.Males=sum(C.M),White.Females=sum(C.W),Black.Males=sum(AA.M),Black.Females=sum(AA.W),Hispanic.Males=sum(H.M),Hispanic.Females=sum(H.W)),by=list(Year,Sport,ID_School)])
basketballscholar$Other.Males<-basketballscholar$Males-basketballscholar$Black.Males-basketballscholar$Hispanic.Males-basketballscholar$White.Males
basketballscholar$Males<-NULL
basketballscholar$Other.Females<-basketballscholar$Females-basketballscholar$Black.Females-basketballscholar$Hispanic.Females-basketballscholar$White.Females
basketballscholar$Females<-NULL
write.csv(basketballscholar,'Basketball Scholarships by Race-Year 97-06.csv')
levels(racestotals$ID_School)
subset(racestotals,racestotals$ID_School==c('LOUIS'))

names(DTIPEDS)
IPEDSKeys<-c('Year','ID_School','CIP_Family')
setkeyv(DTIPEDS,cols=IPEDSKeys)

IPEDSSummary<-data.frame(DTIPEDS[j=list(
	Total.Men=sum(M),
							 Total.Women=sum(W),
	White.Men=sum(C.M),
																				Foreign.Men=sum(NON.M),
																				Foreign.Women=sum(NON.W),
																				Asian.Islander.Men=sum(AS.PI.M),
																				Asian.Islander.Women=sum(AS.PI.W),
							 White.Women=sum(C.W),
							 Hispanic.Men=sum(H.M),
							 Hispanic.Women=sum(H.W),
							 Black.Men=sum(AA.M),
							 Black.Women=sum(AA.W)),
				by=list(CIP_Classificaiton,Year)])

IPEDSSummary$Other.Men<-IPEDSSummary$Total.Men-IPEDSSummary$White.Men-IPEDSSummary$Hispanic.Men-IPEDSSummary$Black.Men-IPEDSSummary$Foreign.Men-IPEDSSummary$Asian.Islander.Men
IPEDSSummary$Total.Men<-NULL
IPEDSSummary$Other.Women<-IPEDSSummary$Total.Women-IPEDSSummary$White.Women-IPEDSSummary$Hispanic.Women-IPEDSSummary$Black.Women-IPEDSSummary$Foreign.Women-IPEDSSummary$Asian.Islander.Women
IPEDSSummary$Total.Women<-NULL

levels(IPEDSSummary$CIP_Classificaiton)

IPEDSSchoolCIP<-data.frame(DTIPEDS[j=list(
	Total.Men=sum(M),
	Total.Women=sum(W),
	White.Men=sum(C.M),
	Foreign.Men=sum(NON.M),
	Foreign.Women=sum(NON.W),
	Asian.Islander.Men=sum(AS.PI.M),
	Asian.Islander.Women=sum(AS.PI.W),
	White.Women=sum(C.W),
	Hispanic.Men=sum(H.M),
	Hispanic.Women=sum(H.W),
	Black.Men=sum(AA.M),
	Black.Women=sum(AA.W)),
																 by=list(CIP_Classificaiton,Year,ID_School)])

IPEDSSummary<-na.omit(IPEDSSummary)
write.csv(IPEDSSummary,'IPEDS Summary by CIP-Race-Gender.csv')

IPEDSSchoolCIP$Other.Men<-IPEDSSchoolCIP$Total.Men-IPEDSSchoolCIP$White.Men-IPEDSSchoolCIP$Hispanic.Men-IPEDSSchoolCIP$Black.Men-IPEDSSchoolCIP$Foreign.Men-IPEDSSchoolCIP$Asian.Islander.Men
IPEDSSchoolCIP$Total.Men<-NULL
IPEDSSchoolCIP$Other.Women<-IPEDSSchoolCIP$Total.Women-IPEDSSchoolCIP$White.Women-IPEDSSchoolCIP$Hispanic.Women-IPEDSSchoolCIP$Black.Women-IPEDSSchoolCIP$Foreign.Women-IPEDSSchoolCIP$Asian.Islander.Women
IPEDSSchoolCIP$Total.Women<-NULL

IPEDSSchoolCIP<-na.omit(IPEDSSchoolCIP)
write.csv(IPEDSSchoolCIP,'IPEDS Summary by CIP-Race-Gender-School.csv')

gradDT<-data.table(gradrates)
names(gradDT)
subsetgrad<-gradDT[,list(Year,ID_School,ID_Conference,Sport,Variable,Total,M,W,C.M,C.W,AA.M,AA.W,H.M,H.W)]
names(subsetgrad)
subsetgrad<-transform(subsetgrad,O.M=M-C.M-AA.M-H.M)
subsetgrad<-transform(subsetgrad,O.W=W-C.W-AA.W-H.W)
str(head(subsetgrad))