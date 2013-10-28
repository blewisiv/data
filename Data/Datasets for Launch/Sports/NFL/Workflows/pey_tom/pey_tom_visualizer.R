#Pey_Tom Visualizer
library(rCharts)

#Summary Bar Chart
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data/weekly_viz_data")
list.files()
ds <- 
	read.csv(list.files()[5])
ds$X <- NULL
ds <-
	ds[order(ds$passing_touchdowns,decreasing = T),]
colors <- ds$color
p1 <- 
	nPlot(passing_touchdowns ~ player, group = 'label', data = ds, type = 'multiBarChart')
p1$chart(showControls = F)
p1$chart(color=colors)
p1$addControls("y", value = "passing_touchdowns", 
	values = names(ds)[c(3,5,4,6:21)]
	)
p1
p1$addControls("x", value = "player", 
	values = names(ds)[c(1,2,8,12,13)]
	)
p1
p1$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )
p1$chart(tooltip = "#! function(key, x, y, e, graph) {
  return '<p>' + e.point.detail + '</p>' +
    '<p>' + ''  + '</p>'
}!#")
p1

p1$publish('Peyton Quest Week 8 Summary', host = 'gist')

#line chart
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data/series_data")

list.files()
ds_week <- 
	read.csv(list.files()[1])
ds_week$X <- NULL
names(ds_week)[5] <- 'game_number'


colors <- unique(ds_week$color)
labels <- unique(ds_week$label)
labels[1]


ds_week$game_number <- as.factor(ds_week$game_number)
p2 <- 
	nPlot(passing_touchdowns ~ game_number, group = 'label', data = ds_week, type = 'lineWithFocusChart')

p2$chart(color=colors)

p2$addControls("y", value = "passing_touchdowns", 
	values = names(ds_week)[c(11,10,9,8,14,12,17,20,21,22,23,18,19,15,16,13)]
	)
p2$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )
p2$chart(tooltipContent = "#! function(key, x, y, e){
return '<p>' + e.point.detail + '</p>'
'<p><b>'+ 'yAxis: '+ '</b>' + y +'</p>'
} !#")

p2$addControls("group", value = "game_number", 
	values = names(ds_week)[c(25,7,2)]
	)
p2
p2$publish('Peyton Quest Week 8 Game by Game Summary', host = 'gist')
