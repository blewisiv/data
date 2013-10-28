library(rCharts)
library(lubridate)
library(data.table)
library(XML)
library(Kmisc)
options(stringsAsFactors=F)
sample <- read.csv('http://aragorn.org/visualization/si/mlb/2013/salary_war/sample/indexed_sample_players.csv')
war_value <- 6
sample$war_6M_value <- sample$war*war_value

players_images <- unique(sample[,c('player','team')])
image_urls <- c(
	'http://3.bp.blogspot.com/-2yC1QvTcoS8/UdDsQZfg-5I/AAAAAAAAN-E/wqhA_7CwpFU/s354/rj.png',
	'http://cdn.bleacherreport.net/images_root/slides/photos/001/302/201/52446705_display_image.jpg?1316006255',
	'http://assets.sbnation.com/imported_assets/1540/p1_belle_pensinger2.jpg',
	'http://www4.pictures.zimbio.com/gi/Carlos+Beltran+New+York+Mets+Photo+Day+tV5v0vaHXfdl.jpg',
	'http://www.clevescene.com/binary/8085/1297283990-grady-sizemore.jpg',
	'http://www.gannett-cdn.com/-mm-/f40f3606fa7f520417c0c9e02d7aa7a371d004ba/r=x513&c=680x510/local/-/media/USATODAY/USATODAY/2012/10/18/10-17-2012-alex-rodriguez-4_3.jpg')

players_images$image_url <- image_urls
sample <- merge(sample,players_images)
dt <- data.table(sample)
dt$over_under_payment <- dt$war_6M_value-dt$X.13_salary_m
summary(dt$over_under_payment)
detach(dt)
attach(dt)
dt$label <- paste(dt$player,dt$team,sep='-')
dt$detail <- 
	sprintf("<table cellpadding='3' style='line-height:1.25'><tr><th colspan='2.5'>%1$s</th></tr><tr><td><img src='%2$s' height='125' width='100'></td><td align='left'>Season: %3$s<br>Year of Contract: %4$s<br>WAR: %5$s<br>Salary (m): $%6$s<br>2013 Salary (m): $%7$s<br>Value at $6M WAR: $%8$s<br>Over/Underpayment (m): $%9$s</td></tr></table>",
		dt$label,
		dt$image_url,
		dt$season,
		dt$year,
		dt$war,
		dt$salary_m,
		dt$X.13_salary_m,
		dt$war_6M_value,
		dt$over_under_payment)

t <- data.frame(dt[order(dt$season,decreasing=F),])
t$X <- NULL
t$image_url <- NULL
t$date <- paste(t$season,"-","11-","15",sep="")
t$date <- as.Date(t$date, "%Y-%m-%d")
t$pos_date <- as.numeric(as.POSIXct(t$date)) * 1000
names(t)[6] <- 'salary_2013_m'
names(t)[12] <- 'year_of_contract'
p1 <- nPlot(war ~ season, group = 'label', data = t, type = 'multiBarChart')
p1$xAxis(tickFormat = "#!function(d) {return d3.time.format('%Y')(new Date(d))}!#")
p1$chart(showControls = F)
color <- c('#1C2841','#B71234','#000000','#FB4F14', '#003366', '#808080')
p1$chart(color=color)
p1
names(t)
p1$addControls("y", value = "war", values = names(t)[c(7,15,17,4:6,14)])
p1$yAxis( tickFormat="#!function(d) {return d3.format('.02f')(d)}!#" )
p1
p1$chart(tooltip = "#! function(key, x, y, e, graph) {
  return '<p>' + e.point.detail + '</p>' +
    '<p>' + ''  + '</p>'
}!#")
p1
p1$publish('WAR Sample', host = 'gist')


p <- nPlot(war ~ pos_date, data = t, group = "label", type = "lineWithFocusChart")
p$xAxis(tickFormat = "#!function(d) {return d3.time.format('%Y')(new Date(d))}!#")
p$chart(color=color)
names(t)
p$addControls("y", value = "war", values = names(t)[c(7,15,17,4:6,14)])
p$addControls("group", value = "label", values = names(t)[c(16,8,12,13)])
p
p$publish('WAR Sample', host = 'gist')
