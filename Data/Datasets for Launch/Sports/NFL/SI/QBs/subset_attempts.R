library(data.table)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/gamelog_data")
ds <- fread(list.files()[1])
names(ds)
keys <- c('player','date','season','table_name','player_sports_ref_gamelog_url')
setkeyv(ds, cols=keys)	
qbs_data <- data.frame(
	ds[!is.na(season),list(career = paste(min(season),"-",max(season),sep = ''), rookie_season = min(season), final_season = max(season), 
		total_attempts = sum(passing_attempts, na.rm = T), total_completions = sum(completions,na.rm=T), total_passing_yards = sum(passing_yards, na.rm=T), total_touchdowns = sum(passing_touchdowns,na.rm=T),
		total_starts = length(started_game == T), total_games = length(game_number), total_seasons = (length(unique(season)))
	), by = list(player
		)]
)
qbs_subset <- qbs_data[qbs_data$total_attempts > 100,]
qbs_subset <- merge(qbs_subset,qbs, all.x = T)
qbs_subset$X <- NULL
qbs_subset <- qbs_subset[order(qbs_subset$total_attempts,decreasing=T),]
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/subset_data")
write.csv(qbs_subset,'qbs_greater_100_attempts_subset.csv')

