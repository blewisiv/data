#Schaub_Russell_Manning_Visualizer
library(rCharts)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/schaub_manning_kaps_russell/data/summaries")
ds <- read.csv(list.files()[1])



ds$label <- c('Manning 1998 Season','Russell 2008 Season','Schaub 2013 Season','Kaepernick 2013 Season')
	

p1 <- nPlot(qb_rating ~ label, group = 'player', data = ds, type = 'multiBarChart')
p1$chart(showControls = F)
p1$chart(color=c('#163F83','#000000','#B20032','#C9B074'))
p1$addControls("y", value = "qb_rating", values = names(ds)[c(3:22)])
p1$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )
p1$addControls("group", value = "player", values = c('player','season','win_percentage','team_points','opponent_points'))
p1$addControls("x", value = "label", values = c('label','season','wins'))
p1
p1$chart(tooltip = "#! function(key, x, y, e, graph) {
  return '<h3><b>' + e.point.player + '</b></h3>' +
    '<p><b>' + y + '</b></p>' +
'<p><b>' + 'After 5 Games' + '</b></p>'
}!#")
p1

p1$publish(paste('Week:',game_number,' Schaub, Manning, Russell and Kaepernick Tracker',sep=''), host = 'gist')

