#Pey_Tom Visualizer
library(rCharts)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data/weekly_viz_data")
list.files()[2]
ds <- read.csv(list.files()[2])

p1 <- nPlot(passing_touchdowns ~ label, group = 'player', data = ds, type = 'multiBarChart')
p1$chart(showControls = F)
p1$chart(color=c('#DF6108','#0D254C','#005E6A','#313F36','#C9B074'))
p1
p1$addControls("y", value = "passing_touchdowns", values = names(ds)[c(4:22)])
p1$addControls("group", value = "passing_touchdowns", values = names(ds)[c(2,3,13,14)])
p1$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )

p1$chart(tooltip = "#! function(key, x, y, e, graph) {
  return '<h3><b>' + e.point.player + '</b></h3>' +
    '<p><b>' + y + '</b></p>'
'<p><b>' + 'After 5 Games' + '</b></p>'
}!#")
p1


p1$publish('Peyton Quest Week 5', host = 'gist')


