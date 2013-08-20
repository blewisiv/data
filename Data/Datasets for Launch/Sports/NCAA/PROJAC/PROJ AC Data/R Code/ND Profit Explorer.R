fb.bb<-read.csv(list.files()[1])

nd<-fb.bb[fb.bb$DOE.Institution_Name=='University of Notre Dame',]
nd<-nd[order(nd$Year,decreasing=F),]
nd.viz<-nd[,c(3,4,8:10)]
nd.viz<-cbind(nd.viz,colsplit(as.character(nd.viz$Year),"-",c("Season","End_Year")))
names(nd.viz)[2:5]<-c('Sport','Revenue','Expense','Profit')
nd.viz$Revenue<-as.numeric(gsub(",","",nd.viz$Revenue))
nd.viz$Revenue<-nd.viz$Revenue/1000000


a<-nPlot(Revenue ~ Season, group =  'Sport', data = nd.viz, type = 'stackedAreaChart', id = 'chart')
a$chart(color = c('Gold','Navy'))
a$params$width<-800
a$params$height<-550
a
a$publish('ND Mens Football and Basketball Revenues in Millions',host='gist')

names(nd.viz)
nd.m<-melt(nd.viz,id.vars=,c('Season','Year','Sport'))
names(nd.m)
names(nd.viz)
nd.viz$Year<-NULL
nd.viz$Expense<-as.numeric(gsub(",","",nd.viz$Expense))/1000000
nd.viz$Profit<-as.numeric(gsub(",","",nd.viz$Profit))/1000000
n1 <- nPlot(Revenue ~ Season, data = nd.viz, group = "Sport", type = "Stac")
n1
n1$addControls("y", value = "Revenue", values = names(nd.viz)[c(2:4)])
n1$chart(color = c('Gold','Navy'))
n1
n1$publish('Notre Dame Mens Sports Profitability Explorer',host='gist')

n1 <- nPlot(Revenue ~ Season, data = nd.viz, group = "Sport", type = "stackedAreaChart")
n1
n1$addControls("y", value = "Revenue", values = names(nd.viz)[c(2:4)])
n1$addControls("y", value = "Revenue", values = list('Revenue','Expense'))
n1
n1$chart(color = c('Gold','Navy'))
n1
n1$publish('Notre Dame Mens Sports Profitability Explorer',host='gist')