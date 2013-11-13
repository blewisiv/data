#Pey_Tom Visualizer
library(rCharts)

#Summary Bar Chart
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data/weekly_viz_data")
list.files()
ds <- 
	read.csv(list.files()[1])
ds$X <- NULL
ds <-
	ds[order(ds$passing_touchdowns,decreasing = T),]
colors <- ds$color
p1 <- 
	nPlot(passing_touchdowns ~ player, group = 'label', data = ds, type = 'multiBarChart')
p1$chart(showControls = F)
p1$chart(color=colors)
p1$addControls("y", value = "passing_touchdowns", 
	values = names(ds)[c(3,5,4,7,6,8,9,17:14,10:18,12,13,10,11)]
	)
p1
p1$addControls("x", value = "player", 
	values = names(ds)[c(1,2,23,13,12)]
	)
p1
p1$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )
p1$chart(tooltip = "#! function(key, x, y, e, graph) {
  return '<p>' + e.point.detail + '</p>' +
    '<p>' + ''  + '</p>'
}!#")
p1

p1$publish('Peyton Quest Game 9 Summary', host = 'gist')

#line chart
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data/series_data")

list.files()
ds_week <- 
	read.csv(list.files()[1])
ds_week$X <- NULL
names(ds_week)[7] <- 'game_number'


colors <- unique(ds_week$color)
labels <- unique(ds_week$label)
labels[1]


ds_week$game_number <- as.factor(ds_week$game_number)
p2 <- 
	nPlot(passing_touchdowns ~ game_number, group = 'label', data = ds_week, type = 'lineWithFocusChart')

p2$chart(color=colors)

p2$addControls("y", value = "passing_touchdowns", 
	values = names(ds_week)[c(13,12,16,11,10,14,19:26,17:18)]
	)
p2$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )
p2$chart(tooltipContent = "#! function(key, x, y, e){
return '<p>' + e.point.detail + '</p>' 
'<p><b>'+ 'yAxis: '+ '</b>' + y +'</p>'
} !#")

p2$addControls("group", value = "label", 
	values = names(ds_week)[c(4,2,1)]
	)
p2
p2$publish('Peyton Quest Game 9 by Game Summary', host = 'gist')
