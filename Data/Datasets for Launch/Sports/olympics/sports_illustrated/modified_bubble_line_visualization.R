options(stringsAsFactors=F)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/olympics/sports_illustrated/visualization")
medals_sports <- 
	read.csv(list.files()[2])
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
countries <- c('Armenia', 'Azerbaijan','Belarus','Estonia','Georgia','Kazakhstan','Kyrgyzstan','Latvia','Lithuania','Moldova','Russia','Tajikistan','Turkmenistan','Ukraine','USSR','Uzbekistan')
images <- c('http://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_Armenia.svg/200px-Flag_of_Armenia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Azerbaijan.svg/200px-Flag_of_Azerbaijan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Flag_of_Belarus.svg/200px-Flag_of_Belarus.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Flag_of_Estonia.svg/200px-Flag_of_Estonia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/200px-Flag_of_Georgia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kazakhstan.svg/200px-Flag_of_Kazakhstan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Flag_of_Kyrgyzstan.svg/200px-Flag_of_Kyrgyzstan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Latvia.svg/200px-Flag_of_Latvia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Lithuania.svg/200px-Flag_of_Lithuania.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Moldova.svg/200px-Flag_of_Moldova.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/200px-Flag_of_Russia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Tajikistan.svg/200px-Flag_of_Tajikistan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Turkmenistan.svg/200px-Flag_of_Turkmenistan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Ukraine.svg/200px-Flag_of_Ukraine.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Flag_of_Russian_SFSR_%281918-1937%29.svg/200px-Flag_of_Russian_SFSR_%281918-1937%29.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Uzbekistan.svg/200px-Flag_of_Uzbekistan.svg.png'
)
country_color <- c(
	'rgb(239, 154, 0)',
	'rgb(0, 133, 84)',
	'rgb(58, 154, 66)',
	'rgb(55, 122, 11)',
	'rgb(226,0,28)',
	'rgb(0,159,191)',
	'rgb(245,154,0)',
	'rgb(130,40,42)',
	'rgb(3,90,51)',
	'rgb(255,204,0)',
	'rgb(0,31,152)',
	'rgb(4,87,0)',
	'rgb(31,163,81)',
	'rgb(255,208,0)',
	'rgb(193,0,0)',
	'rgb(0,135,168)'
	)
images <- data.frame(country = countries, rgb_color = country_color, image_url = images)

ds <- medals
ds <- ds[order(ds$year_code,decreasing=F),]
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
write.csv(ds,'olympic_data.csv')
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
b$tooltip(useHTML = T, formatter = "#! function() { return this.point.detail; } !#")
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
