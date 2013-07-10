library(rCharts)
library(plyr)
library(reshape2)
library(data.table)
library(Kmisc)
ndm<-read.csv(list.files()[1])
names(ndm)
test<-ndm[,c(2:4,6:7,12,17,22,23)]

t<-cbind(test,colsplit(as.character(test$Graduation_Year),"-",c('Start_Year','Year')))
t$Start_Year<-NULL
test<-t
test<-test[order(test$Year,decreasing=F),]

names
t<-test
t<-test[!is.na(ndm$CIPCode),]
str(t)
levels(t$Player_Stated_Major)
nd<-data.table(
	x=t$Year,
	y=t$Weight,
	name = sprintf("<table cellpadding='4' style='line-height:1.5'><tr><th colspan='3'>%1$s</th></tr><tr><td><img src='%2$s' height='100' width='75'></td><td align='left'>Player: %1$s<br>Position: %4$s<br>Race: %3$s<br>Major: %7$s<br>Height: %5$s<br>Weight: %6$s</td></tr></table>", 
								 t$Player,
								 t$Player_Image_URL,
								 t$ID_Race,
								 t$ID_Position,
								 t$Height_Feet,
								 t$Weight,
								 t$Player_Stated_Major
	),
	url = t$Player_URL,
	player = t$Player,
	major=t$Player_Stated_Major
)

str(nd)
nd$name
ndSeries <- lapply(split(nd, nd$major), function(x) {
	res <- lapply(split(x, rownames(x)), as.list)
	names(res) <- NULL
	return(res)
})
ndSeries

b <- rCharts::Highcharts$new()
invisible(sapply(ndSeries, function(x) {
	b$series(data = x, type = ("scatter"), name = x[[1]]$major)
}
))


b$plotOptions(
	scatter = list(
		cursor = "pointer", 
		point = list(
			events = list(
				click = "#! function() { window.open(this.options.url); } !#")), 
		marker = list(
			symbol = "circle", 
			radius = 6
		)
	)
)
b
b$xAxis(title = list(text = "Graduation Year"), labels = list(format = "{value}"))
b$yAxis(title = list(text = "Weight"), labels = list(format = "{value}"))

b$tooltip(useHTML = T, formatter = "#! function() { return this.point.name; } !#")

b$title(text = "Notre Dame Football Majors by Year and Weight")
b$subtitle(text = "Aragorn Technologies and Alex Bresler")

b$params$width<-800
b$params$height<-500
b
b$publish('Notre Dame Majors by Weight',host='gist')
colors()