#rCharts for NCAA
library(reshape2)
library(plyr)
recast
library(data.table)
fbvs <- read.csv("~/Desktop/Github/Aragorn/AragornData/Categories/Data/Datasets for Launch/NCAA/Project Academia/Final Data/Summaries/Football/Football versus School Majors.csv")
ncaads <- read.csv("~/Desktop/Github/Aragorn/AragornData/Categories/Data/Datasets for Launch/NCAA/Project Academia/Final Data/Datasets/Final 2012-13 Top 25 Major and Player Data.csv")

fbdt<-data.table(fbvs)
fbdtkeys<-c("ID_School","CIPF.Code")
setkeyv(fbdt,cols=fbdtkeys)

fbdt[,table(list(ID_School,CIPF.Code,Category,Value))]


fbdts<-data.frame(fbdt[,list(Percentage),by=list(ID_School,Category,CIPF.Code)])
school<-subset(fbdts,Category=='School')
names(school)[4]<-'School.Percentage'
school$Category<-NULL
football<-subset(fbdts,Category=='Football')
football$Category<-NULL
names(football)[3]<-'Football.Percentage'
ds<-merge(school,football,all=T)
ds$School.Percentage[is.na(ds$School.Percentage)]<-0
ds$Football.Percentage[is.na(ds$Football.Percentage)]<-0

ND.s<-subset(x=ds,subset=ds$ID_School=='ND')

dsSeries<-lapply(split(ds, ds$ID_School), function(x) {
	res <- lapply(split(x, rownames(x)), as.list)
	names(res) <- NULL
	return(res)
})

b <- rCharts::Highcharts$new()
invisible(sapply(dsSeries, function(x) {
	b$series(data = ND.s,x='School.Percentage',y='Football.Percentage', type = "scatter", name = ND.s[[1]]$ID_School)
}
))
z$plotOptions(
	scatter = list(
		cursor = "pointer", 
		point = list(
			events = list(
				click = "#! function() { window.open(this.options.url); } !#")), 
		marker = list(
			symbol = "circle", 
			radius = 5
		)
	)
)

z<-hPlot(x = 'School.Percentage', y = "Football.Percentage", data = ND.s, 
				 type = c("line", "bubble", "scatter"), group = "CIPF.Code", size = "Football.Percentage")
z$legend(
	align = 'right', 
	verticalAlign = 'middle', 
	layout = 'vertical', 
	title = list(text = "Major ID")
)
z
z$xAxis(title = list(text = "2011-2012 Notre Dame % of Bachelor Degrees Conferred"), labels = list(format = "{value} %"))
z
z$yAxis(title = list(text = "2012-2013 Percentage of ND Football Stated Majors"), labels = list(format = "{value} %"))
z
z$title(text = "Notre Dame Football vs School Major Comparison")
z$subtitle(text = "Draft Visualization Using Data from Aragorn Technologies")
z
# Plot it!
z$publish('ND vs School Major Comparison -- Aragorn Alpha',host='gist')

ds<-data.table(ncaads)
nd<-ds[ds$ID_School=='ND']
nd<-nd[nd$ID_Major_Type=='A']
nd<-data.frame(nd[i=!is.na(nd$CIPF.Code),j=list(Number=.N),by=list(ID_School,ID_Race,CIPF.Code)])
names(nd)[3]<-'Major.Code'
nPlot(Number ~ CIPF.Code, group = "ID_Race", data = nd, 
			type = 'multiBarChart')
n1

p<-hPlot(Number ~ Major.Code, data = nd,type = 'bar', group = 'ID_Race')

p$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
p$xAxis(list(text='Number of Players'),labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
p$title(text = "Notre Dame Football: Breakdown of 2012-2013 Stated Majors by Race")
p$subtitle(text = "Draft Visualization Using Data from Aragorn Technologies")
p$legend(
	align = 'right', 
	verticalAlign = 'middle', 
	layout = 'vertical', 
	title = list(text = "Race")
)
p$publish('Notre Dame 2012-2013 Football Player Stated Majors by Race -- Aragorn Alpha',host='gist')