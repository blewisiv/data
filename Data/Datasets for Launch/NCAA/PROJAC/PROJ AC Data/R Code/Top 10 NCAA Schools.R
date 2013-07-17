fb.bb<-read.csv(list.files()[1])
fb.bb$Men.Revenue<-as.numeric(gsub(",","",fb.bb$Men.Revenue))/1000000
fb.bb$Men.Expense<-as.numeric(gsub(",","",fb.bb$Men.Expense))/1000000
fb.bb$Men.Profit<-as.numeric(gsub(",","",fb.bb$Men.Profit))/1000000
dt<-data.table(fb.bb)
total<-dt[i=T,j=list(
	Revenue=sum(Men.Revenue)
	),
	 by=list(DOE.Institution_Name)]

total<-total[order(total$Revenue,decreasing=T),]
top10<-total[1:10]
school<-as.character(top10$DOE.Institution_Name)
top10<-fb.bb[fb.bb$DOE.Institution_Name %in% school, ]
schools<-read.cb()
names(schools)<-c('DOE.Institution_Name','School')
top10<-merge(top10,schools,all.x=T)
names(top10)
top10<-top10[,c(43,3:4,8:9)]
bball<-top10[top10$SportName %in% 'Basketball', ]
bball$SportName<-NULL
names(bball)[3:4]<-c('Basketball_Revenue','Basketball_Expense')
bball$Basketball_Profit<-bball$Basketball_Revenue-bball$Basketball_Expense

fball<-top10[top10$SportName %in% 'Football', ]
fball$SportName<-NULL
names(fball)[3:4]<-c('Football_Revenue','Football_Expense')
fball$Football_Profit<-fball$Football_Revenue-fball$Football_Expense
t.10<-merge(fball,bball)
t.10$Total_Revenue<-t.10$Football_Revenue+t.10$Basketball_Revenue
t.10$Total_Expense<-t.10$Football_Expense+t.10$Basketball_Expense
t.10$Total_Profit<-t.10$Football_Profit+t.10$Basketball_Profit
t.10<-cbind(t.10,colsplit(t.10$Year,"-",c('Start_Year','End_Year')))
t.10$Year<-NULL
t.10$End_Year<-NULL
names(t.10)[11]<-'Year'
t<-t.10[,c(11,1,8:11,2:7)]
names(t)<-gsub(" ","_",names(t))
t<-t[order(t$Year,decreasing=F),]
n2 <- nPlot(Total_Revenue ~ Year, data = t, group = "School", type = "stackedAreaChart")
n2$addControls("y", value = "Total_Revenue", values = names(t)[c(3,5,6,8,9,11)])
n2
n2$chart(color = c('Gold','Brown','Orange','Silver','Crimson','Blue','Red','Brown','Pink','Black'))

n2$params$xAxis=list(axisLabel = "Season")
n2
n2$publish("Top 10 Men's Football and Basketball Revenue Generators Area Chart",host='gist')

n3 <- nPlot(Total_Revenue ~ Year, data = t, group = "School", type = "multiBarChart")
n3$addControls("y", value = "Revenue", values = names(t)[c(3,5,6,8,9,11)])
n3$chart(color = c('Gold','Brown','Orange','Silver','Crimson','Blue','Red','Brown','Pink','Black'))
n3$params$xAxis=list(axisLabel = "Season")
n3
n3$publish("Top 10 Men's Football and Basketball Revenue Generators Bar Chart",host='gist')