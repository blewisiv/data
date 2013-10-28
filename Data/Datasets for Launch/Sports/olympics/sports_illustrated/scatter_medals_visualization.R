library(rCharts)
library(data.table)
library(reshape2)

dt
olympic_keys <- c('year_code','country_code','total')
setkeyv(dt,cols=olympic_keys)
medals <- data.frame(
	dt[total > 0, list(athletes = length(athlete), total = sum(total), gold = sum(gold), silver = sum(silver) , bronze = sum(bronze)
	), by = list(year_code,country_code)]
)
medals_athletes <- data.frame(
	dt[length(athlete) > 0, list(athletes = length(athlete), total = sum(total), gold = sum(gold), silver = sum(silver) , bronze = sum(bronze)
	), by = list(year_code,country_code)]
)
medals <- medals[order(medals$year_code,decreasing=F),]
medals_athletes <- medals_athletes[order(medals_athletes$year_code,decreasing=F),]

ds <- merge(medals_athletes,countries)
ds <- ds[order(ds$year_code,decreasing=F),]
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

ds$date <- paste(ds$year_code,"-","02-","10",sep="")
ds$date <- as.Date(ds$date, "%Y-%m-%d")
ds$pos_date <- as.numeric(as.POSIXct(ds$date)) * 1000
names(ds)[4:7] <- paste(names(ds)[4:7],"_medals",sep = '')
ds <- ds[order(ds$pos_date,decreasing=F),]
country <-unique(ds$country)
c_c <- merge(d,c)
countries[,c('country','rgb_color')]
c_c <- c_c[c(8,4,9,14,1,3,5,6,7,10,11,13,15,2,12),]
colors <- c_c$rgb_color

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
p1

