library(rCharts)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/visualizations")
source(list.files()[1])
label <- unique(d[order(d$label,decreasing=F),'label'])
labels <- data.frame(label = label)
labels <- merge(labels,d[,c('label','team_pfbr_id')])

colors <- c(
	"#213D30",
	"#000000",
	"#0088CE",
	"#0C371D",
	"#006DB0",
	"#AF1E2C",
	'#006666',
	"#3B0160",
	"#26201E",
	"#FB4F14",
	"#00338D",
	'#648FCC',
	'#FB4F14',
	'#192F6B',
	'#E6BE8A',
	'#773141',
	'#13264B',
	'#C9AF74',
	'#773141',
	'#BD0D18',
	'#E34912',
	'#003B48',
	'#002244',
	'#EEC607',
	'#5B92E5',
	'#FFB612',
	'#4EAE47',
	'#708090',
	'#FB4F14',
	'#280353'
	)
labels <- cbind(labels,colors)

names(d)
names(d)[19] <- 'name'
d1 <- hPlot(total_touchdowns ~ qb_rating , data = d, type = "bubble", title = "Top Performing Quarterbacks After 14 Games Since 1950", subtitle = "Weighted by QB Rating", size = "touchdown_to_interception_ratio", group = "label")
d1
d2 <- hPlot(touchdown_to_interception_ratio ~ total_touchdowns , data = d, type = "bubble", title = "Top Performing Quarterbacks After 14 Games Since 1950", subtitle = "Weighted by QB Rating", size = "total_passing_yards", group = "label")
d2$colors(colors)
d2$chart(zoomType = "xy")
d2$exporting(enabled = T)

d2$yAxis(title = list(text = "TD to Int Ratio",style = list(fontSize = '10px', fontFamily = 'Verdana, sans-serif', color = 'black')), labels = list(format = "{value}"))
d2$xAxis(title = list(text = "TDs After 14 Games [Zoomable by Click and Drag]",style = list(fontSize = '10px', fontFamily = 'Verdana, sans-serif', color = 'black')), labels = list(format = "{value}"))
d2$title(text = "Top Performing Quarterbacks After 14 Games Since 1950", 
	style = list(
		fontSize = '16px', fontFamily = 'Verdana, sans-serif', color = 'black', fontWeight = 'bold'
		)
	)

d2$subtitle(text = "Bubbles Size: Total Passing Yards", 
	style = list(fontSize = '12px', fontFamily = 'Verdana, sans-serif', color = 'black', fontWeight = 'italic'
		)
	)
d2$params$width <- 860
d2$params$height <- 610
d2
d2
d2$publish('foles',host='gist')

d2
d2$plotOptions(
	scatter = list(
		cursor = "pointer", 
		 
		marker = list(
			symbol = "circle", 
			radius = 5
		)
	)
)
d2
write.csv(fs,'qb_data_less_than_14_games.csv')
