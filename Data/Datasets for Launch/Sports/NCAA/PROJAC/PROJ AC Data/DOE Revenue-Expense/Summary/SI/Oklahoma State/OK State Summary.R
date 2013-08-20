library(rCharts)
library(stringr)
library(plyr)
library(reshape2)
setwd('/Users/alexbresler/Desktop/Github/Aragorn/AragornData/Categories/Data/Datasets for Launch/NCAA/PROJAC/PROJ AC Data/DOE Revenue-Expense/Summary')
list.files()
fb<-read.csv(list.files()[1])
names(fb)
names<-unique(fb$DOE.Institution_Name)
names<-data.frame(names)
names==[3]
ok<-as.character(names[grepl('Oklahoma State',names$names),])
t<-ok[3]
oks<-fb[fb$DOE.Institution_Name%in%t,]
oks$X<-NULL
names(oks)


oks.sub<-oks[,c(1:3,7:9)]
names(oks.sub)[3]<-'Sport'
oks.sub<-oks.sub[,c(9,1:8)]
oks.sub$Men.Revenue<-oks.sub$Men.Revenue/1000000
oks.sub$Men.Expense<-oks.sub$Men.Expense/1000000
oks.sub$Men.Profit<-oks.sub$Men.Profit/1000000
names(oks.sub)


oks.sub<-oks.sub[order(oks.sub$Year,decreasing=F),]
oks.sub$School<-'Oklahoma State'
oks.sub$DOE.Institution_Name<-NULL
oks.sub
data<-oks.sub
names(data)
library(rCharts)
str_split(data$Year,"\\-",c('Start','End'))
data<-cbind(data,colsplit(data$Year,"\\-",c('Start','End')))
names(data)
d<-data
names(d)[7]<-'Season'

d.f<-d[d$Sport%in%'Football',]
d.b<-d[d$Sport%in%'Basketball',]
d$Season
d.b.r<-d.b$Men.Revenue
d.b$Revenue.Index<-
	dbr<-list()
for(i in 1:length(d.b.r)){
	dbr[i]<-print(d.b.r[i]/d.b.r[1])
}
dbr<-matrix(dbr)
dbr<-data.frame(dbr)
names(dbr)[1]<-'Revenue.Index'
d.b<-cbind(d.b,dbr)


d.f.r<-d.f$Men.Revenue

dfr<-list()
for(i in 1:length(d.f.r)){
	dfr[i]<-print(d.f.r[i]/d.f.r[1])
}
dfr<-matrix(dfr)
dfr<-data.frame(dfr)
names(dfr)[1]<-'Revenue.Index'
d.f<-cbind(d.f,dfr)

d.c<-rbind(d.f,d.b)




d<-d.c
d<-d[order(d$Year,decreasing=F),]
n2 <- nPlot(Men.Revenue ~ Season, data = d, group = "Sport", type = "multiBarChart")
n2$chart(color=c('#d48824','#000000'))
n2$addControls("y", value = "Revenue", values = names(d)[c(3,9,4,5)])
n2
n2$params$xAxis=list(axisLabel = "Season")
n2$publish("Oklahoma State Men's Football & Basketball Revenue Per Right to Know Act",host='gist')