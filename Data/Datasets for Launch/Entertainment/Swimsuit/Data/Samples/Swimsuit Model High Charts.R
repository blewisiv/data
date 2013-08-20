library(rCharts)
library(plyr)
library(reshape2)
library(data.table)
library(Kmisc)
library(rCharts)

list.files()
phot<-read.csv(list.files()[2])
q<-phot[!is.na(phot$PhotoURL),]
q<-merge(q,plot,all.x=T)
names(q)[2:15]<-gsub('Model','',names(q)[2:15])
names(q)
t<-q[,c(1,2,3,4,5,6,9:15)]
names(t)<-gsub("_in","",names(t))
names(t)<-gsub("_numeric","",names(t))
names(t)<-gsub("_US","",names(t))
models<-data.table(
	x=t$Height,
	y=t$Bust,
	name = sprintf("<table cellpadding='4' style='line-height:1.5'><tr><th colspan='3'>%1$s</th></tr><tr><td><img src='%4$s' height='300' width='300'></td><td align='left'>Model: %1$s<br>Cup Size: %2$s<br>Measurements: %3$s<br>Nationality: %5$s<br>Eye Color: %6$s<br>Hair Color: %7$s</td></tr></table>", 
								 t$Model,
								 t$CupSize,
								 t$Measurements,
								 t$PhotoURL,
								 t$Nationality,
								 t$EyeColor,
								 t$HairColor
	),
	url = t$WikipediaURL,
	model = t$Model,
	cupsize=t$CupSize,
	hair=t$HairColor,
	eye=t$EyeColor,
	nationality=t$Nationality
	
)

ModelsNationality <- lapply(split(models, models$nationality), function(x) {
	res <- lapply(split(x, rownames(x)), as.list)
	names(res) <- NULL
	return(res)
})


b <- rCharts::Highcharts$new()
invisible(sapply(ModelsCups, function(x) {
	b$series(data = x, type = ("scatter"), name = x[[1]]$cupsize)
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
b$xAxis(title = list(text = "Height (numeric feet)"), labels = list(format = "{value}"))
b$yAxis(title = list(text = "Bust in Inches"), labels = list(format = "{value}"))

b$tooltip(useHTML = T, formatter = "#! function() { return this.point.name; } !#")

b$title(text = "Sports Illustrated Swimsuit Model Explorer Mockup")
b$subtitle(text = "Aragorn Technologies and Alex Bresler")

b$params$width<-800
b$params$height<-500
b
b$save('Models by Cup Size.html')
b$publish('Sports Illustrated Swimsuit Explorer Aragorn Mockup by Nationality',host='gist')