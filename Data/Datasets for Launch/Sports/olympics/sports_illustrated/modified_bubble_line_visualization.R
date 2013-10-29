
medals_sports <- read.csv(list.files()[2])
library(rCharts)
library(data.table)
library(reshape2)

medals_sports[medals_sports$sport %in% 'Ice Hockey'&medals_sports$gold > 0, 'gold'] <- 1
medals_sports[medals_sports$sport %in% 'Ice Hockey'&medals_sports$silver > 0, 'silver'] <- 1
medals_sports[medals_sports$sport %in% 'Ice Hockey'&medals_sports$bronze > 0, 'bronze'] <- 1
attach(medals_sports)
medals_sports$total <- gold + silver + bronze

dt <- data.table(medals_sports)
detach(medals_sports)
olympic_keys <- c('year_code','country')
setkeyv(dt,cols=olympic_keys)
medals <- data.frame(
	dt[total > 0, list(athletes = sum(athletes), total = sum(total), gold = sum(gold), silver = sum(silver) , bronze = sum(bronze)
	), by = list(year_code,country)]
)
medals_athletes <- data.frame(
	dt[length(athlete) > 0, list(athletes = length(athlete), total = sum(total), gold = sum(gold), silver = sum(silver) , bronze = sum(bronze)
	), by = list(year_code,country_code)]
)
medals <- medals[order(medals$year_code,decreasing=F),]
medals_athletes <- medals_athletes[order(medals_athletes$year_code,decreasing=F),]
images <- medals_sports[,c('country','image_url')]
images <- unique(images)

ds <- merge(medals_athletes,countries)
ds <- ds[order(ds$year_code,decreasing=F),]
ds <- medals
ds <- merge(ds,images)
ds$detail <- 
	sprintf("<table cellpadding='3' style='line-height:1.25'><tr><th colspan='2.5'>%1$s</th></tr><tr><td><img src='%2$s' height='125' width='100'></td><td align='left'>Year: %3$s<br>Total Medals: %4$s<br>Gold Medals: %5$s<br>Silver Medals: %6$s<br>Bronze Medals: %7$s<br>Athletes: %8$s</td></tr></table>",
		ds$country,
		ds$image_url,
		ds$year_code,
		ds$total,
		ds$gold,
		ds$silver,
		ds$bronze,
		ds$athletes
		)

ds$date <- 
	paste(ds$year_code,"-","02-","10",sep="")
ds$date <- 
	as.Date(ds$date, "%Y-%m-%d")
ds$pos_date <- 
	as.numeric(as.POSIXct(ds$date)) * 1000
names(ds)[4:7] <- 
	paste(names(ds)[4:7],"_medals",sep = '')
ds <- 
	ds[order(ds$pos_date,decreasing=F),]
ds <- merge(ds,countries)
#Scatter Chart
p1 <- 
	nPlot(total_medals ~ pos_date, group = 'country', data = ds, type = 'scatterChart')
p1$chart(color=colors)
p1$addControls("y", value = "total_medals", values = names(ds)[c(4:7,3)])

p1$xAxis(tickFormat = "#!function(d) {return d3.time.format('%Y')(new Date(d))}!#")
p1$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )
p1$chart(tooltipContent = "#! function(key, x, y, e){
return '<p>' + e.point.detail + '</p>'
'<p><b>'+ 'yAxis: '+ '</b>' + y +'</p>'
	} !#")
ds$year_code <- as.numeric(ds$year_code)

b <- hPlot(total_medals ~ year_code, data =ds, type = "bubble", title = " ", subtitle = " ", size = "total_medals", group = "country")
color_country <- unique(ds[,c('country','rgb_color')])
color_country <- color_country[order(color_country$country, decreasing = F),]
colors <- color_country$rgb_color
b$chart(zoomType = "xy")
b$exporting(enabled = T)
b$colors(colors)
b$plotOptions(line=list(marker=list(enabled = F))) 
b$xAxis(title = list(text = "Year",style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif', color = 'black')), labels = list(format = "{value}"))
b$yAxis(title = list(text = "Total Winter Medals [Hockey Adjustment]",style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif', color = 'black')), labels = list(format = "{value}"))
b$legend(align = 'right', verticalAlign = 'middle', layout = 'vertical')
b$params$height <- 500
b$params$width <-850
b$publish('USSR medal bubble chart', host = 'gist')



fs <- data.table(ds)
fs <- data.table(
	x = ds$year_code,
	y = ds$total_medals,
	name = ds$detail,
	country = ds$country
	)
countrySeries <- lapply(split(fs, fs$country), function(x) {
	res <- lapply(split(x, rownames(x)), as.list)
	names(res) <- NULL
	return(res)
})

c <- rCharts::Highcharts$new()
invisible(sapply(countrySeries, function(x) {
	c$series(data = x, type = ("line"), name = x[[1]]$country, size = "x")
}
))

c$tooltip(useHTML = T, formatter = "#! function() { return this.point.name; } !#")
c
c$chart(zoomType = "xy")
c$exporting(enabled = T)
c$colors(colors)
c
c$plotOptions(line=list(marker=list(enabled = F))) 
c$xAxis(title = list(text = "Year",style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif', color = 'black')), labels = list(format = "{value}"))
c$yAxis(title = list(text = "Total Winter Medals [Hockey Adjustment]",style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif', color = 'black')), labels = list(format = "{value}"))
c$legend(align = 'right', verticalAlign = 'middle', layout = 'vertical')
c$params$height <- 500
c$params$width <-850
c$publish('modified USSR line chart', host = 'gist')
c
