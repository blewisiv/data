library(data.table)
library(lubridate)
library(reshape2)

athletes <- read.csv(list.files()[1])
athletes$X <- NULL
athletes <- merge(athletes,countries)
names(athletes)
countries <- unique(athletes$country)
countries <- countries[order(countries,decreasing=F)]
winter_athletes <- athletes[athletes$game_code %in% 'winter',]

grepl(pattern=winter_athletes$sport == "Short Track Speed Skating")

write.csv(winter_athletes,'winter_ussr_bloc_athletes.csv')
write.csv(athletes,'all_ussr_bloc_athletes_games.csv')
athletes[is.na(athletes$gold),'gold'] <- 0
athletes[is.na(athletes$total),'total'] <- 0
athletes[is.na(athletes$silver),'silver'] <- 0
athletes[is.na(athletes$bronze),'bronze'] <- 0

dt <- data.table(winter_athletes)
dt[ , list( gold = sum(gold)), by = list(year_code,country_code,sport)]
medals_sports_athletes <- dt[total > 0, list(athletes = length(athlete), total = sum(total), gold = sum(gold), silver = sum(silver) , bronze = sum(bronze)
	), by = list(year_code,country,sport)]
medals_years_athletes <- 
	dt[, list( athletes = length(athlete), total = sum(total), gold = sum(gold), silver = sum(silver) , bronze = sum(bronze)
	), by = list(year_code,country)]

count(athlete)