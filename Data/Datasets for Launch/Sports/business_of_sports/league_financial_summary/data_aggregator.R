#
library(data.table)
library(rCharts)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/business_of_sports/league_financial_summary")
mlb_data <- read.csv(file='~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Franchises/Values/MLB Values 1991-2013.csv')
nba_data <-read.csv('~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NBA/Franchises/nba_franchise_values_1991_2012.csv')
nfl_data <- read.csv('~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Franchises/Values/NFL_Values_1991-2013.csv')
uefa_data <- read.csv('~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/UEFA/Franchises/Values/UEFA Values 2004-2013.csv')
nhl_data <- read.csv('~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NHL/Franchises/Values/NHL Values 1991 to 2012.csv')
cols <- c('year','league','team','value','revenue','expense','ebitda','revenue_multiple','ebitda_multiple')

mlb <- mlb_data[,cols]
nhl <- nhl_data[,cols]
nba <- nba_data[,cols]
nfl <- nfl_data[,cols]
uefa <- uefa_data[,cols]
uefa$league <- c('UEFA_top')
ds <- merge(mlb,nhl,all.x=T,all.y=T)
ds <- merge(ds,nba,all.x=T,all.y=T)
ds <- merge(ds,nfl,all.x=T,all.y=T)
ds <- merge(ds,nfl,all.x=T,all.y=T)
ds <- merge(ds,uefa,all.x=T,all.y=T)
ds <- replace(ds, is.na(ds), 0) 

dt <- data.table(ds)
names(dt)
key <- c('league','year')
setkeyv(dt,cols=key)
data <- data.frame(
dt[ , list(
	value_aggregate= sum(value,na.rm=T),
	revenue_aggregate = sum(revenue,na.rm=T),
	expense_aggregate = sum(expense,na.rm=T),
	ebitda_aggregate = sum(ebitda,na.rm=T),
	value_max = max(value, na.rm =T ),
	value_mean = mean(value,na.rm=T),
	value_median = median(value,na.rm=T),
	value_minimum = min(value,na.rm=T),
	revenue_max = max(revenue, na.rm =T ),
	revenue_mean = mean(revenue,na.rm=T),
	revenue_median = median(revenue,na.rm=T),
	revenue_minimum = min(revenue,na.rm=T),
	ebitda_max = max(ebitda, na.rm =T ),
	ebitda_mean = mean(ebitda,na.rm=T),
	ebitda_median = median(ebitda,na.rm=T),
	ebitda_minimum = min(ebitda,na.rm=T),
	multiple_revenue_max = max(revenue_multiple, na.rm =T ),
	multiple_revenue_mean = mean(revenue_multiple,na.rm=T),
	multiple_revenue_median = median(revenue_multiple,na.rm=T),
	multiple_revenue_minimum = min(revenue_multiple,na.rm=T),
	multiple_ebitda_max = max(ebitda_multiple, na.rm =T ),
	multiple_ebitda_mean = mean(ebitda_multiple,na.rm=T),
	multiple_ebitda_median = median(ebitda_multiple,na.rm=T),
	multiple_ebitda_minimum = min(ebitda_multiple,na.rm=T)
	),by = list(
		year,league
		) ]
)
data <- data[order(data$year,decreasing=F) , ]
write.csv(data,'Major Sports League Financial Data Summary.csv')
data$year <- as.factor(data$year)
data$year
p <- nPlot(value_aggregate ~ league, group = 'year', data = data, type = 'multiBarChart')
p$chart(showControls = F)
p$addControls("y", value = "value_aggregate", values = names(data)[c(3:26)])

p
p$chart(tooltip = "#! function(key, x, y, e, graph) {
  return '<h3><b>' + e.point.year + '</b></h3>' +
    '<p><b>' + y + '</b></p>' +
		'<p>' + x + '</p>'
}!#")
p

p$publish('The Landscape of Sports', host= 'gist')
