#Pey_Tom Visualizer
library(rCharts)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data/weekly_viz_data")
list.files()
ds <- read.csv(list.files()[3])
ds$X <- NULL
color=c('#DF6108','#0D254C','#005E6A','#313F36','#163F83','#C0001D','#C9B074')
label <- c("Manning '13","Brady '07","Marino '84","Rodgers '11","Manning '04","Brady '11","Brees '11")
players_colors <- data.frame(cbind(label,color),stringsAsFactors=F)
players_colors$player <- c('Peyton Manning','Tom Brady', 'Dan Marino', 'Aaron Rodgers', 'Peyton Manning','Tom Brady','Drew Brees')
players_colors$season <- c(2013,2007,1984,2011,2004,2011,2011)
t <- cbind(players_colors,ds)
t <- t[ , -c(5,6,26)]
names(t)
t <- t[order(t$passing_touchdowns,decreasing=T),]
p1 <- nPlot(passing_touchdowns ~ player, group = 'label', data = t, type = 'multiBarChart')
p1$chart(showControls = F)
colors <- as.character(ds$color)
p1$chart(color=color)
names(t)
p1$addControls("y", value = "passing_touchdowns", values = names(t)[c(5:23)])
p1$addControls("x", value = "player", values = names(t)[c(3,6:14,4,15:23,5,6)])
p1$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )
p1
p1$chart(tooltip = "#! function(key, x, y, e, graph) {
  return '<p>' + e.point.detail + '</p>' +
    '<p>' + ''  + '</p>'
}!#")
p1

	p1$publish('Peyton Quest Week 6', host = 'gist')


