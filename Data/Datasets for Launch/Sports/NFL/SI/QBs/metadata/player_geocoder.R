library(ggmap)
library(data.table)
library(lubridate)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/metadata")
players_data <- read.csv(list.files()[1])
players_locations <- 
	na.exclude(
		players_data[,c('player','location','player_sportsref_url')]
		)
locations <- unique(players_locations[grepl(",",players_locations$location),'location'])
geocoded_locations <- geocode(locations)
location <- data.frame(cbind(locations,geocoded_locations))
names(location)[1:3] <- c('location','longitude','latitude')
names(players_locations)
pl <- merge(players_locations,location, all.x = T)
pl <- merge(players_data,pl,all.x = T)
pl$X <- NULL
write.csv(pl,'all_player_metadata.csv')

players_season <- data.frame(
	ds[!is.na(season),list(last_season = max(season)), by = player
	]
)
z <- merge(pl, players_season, all.x = T)
x <- z[!is.na(z$last_season),]
x <- merge(players_season,pl, all.x = T)
x$active_player <- grepl(2013,x$last_season)
write.csv(x,'scrapeable_player_data.csv')
