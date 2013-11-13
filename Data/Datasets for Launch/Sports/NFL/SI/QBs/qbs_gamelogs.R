options(stringsAsFactors=F)
library(XML)
library(RCurl)
library(plyr)
library(stringr)
library(reshape2)
library(Kmisc)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/tables")
qbs <- read.csv(list.files()[1])

urls <- qbs$player_sports_ref_gamelog_url
players <- qbs$player
names(urls) <- players
all_rs_stats <- data.frame()
all_p_stats <- data.frame()

for(player in players){
	tables <- readHTMLTable(urls[player],as.data.frame=T,trim=T)
	ifelse(length(data.frame(tables['stats'])) >= 1,
	stats <- data.frame(tables['stats']),
	stats <- data.frame(stats.Rk = c(0))
	)
	ifelse(length(data.frame(tables['stats_playoffs'])) >= 1,
	playoff_stats <- data.frame(tables['stats_playoffs']),
	playoff_stats <- data.frame(stats_playoffs.Rk = c(0))
	)
	stats <- na.exclude(stats)
	stats$player <- player
	stats$player_sports_ref_gamelog_url <- urls[player]
	all_rs_stats <- rbind.fill(all_rs_stats,stats)
	playoff_stats <- na.exclude(playoff_stats)
	playoff_stats$player <- player
	playoff_stats$player_sports_ref_gamelog_url <- urls[player]
	all_p_stats <- rbind.fill(all_p_stats,playoff_stats)
	rm(tables)
	rm(playoff_stats)
	rm(stats)
}

for(i in ignore){
	p <- all_p_stats[!grepl(i,all_p_stats$stats_playoffs.Rk),]
}
ignore <- c(' ','Rk')
for(i in ignore){
	r <- all_rs_stats[!grepl(i,all_rs_stats$stats.Rk),]
}
names(r) <- tolower(gsub('stats.', '', names(r)))
names(p) <- tolower(gsub('stats_playoffs.', '', names(p)))

ds <- rbind.fill(r,p)
results <- ds[!is.na(ds$result), c('result')]
ds <- cbind(ds,colsplit(ds$result,"\\ ", c('outcome','score')))
ds <- cbind(ds,colsplit(ds$score,"-",c('team_points','opponent_points')))
ds$score <- gsub("-"," to ",ds$score)
ds[ds$game_location %in% '','game_location'] <- 'H'
missing <- ds[ds$score %in% '',]
names(missing)
ds$missing_gamelog_data <- grepl(0,ds$rk)
write.cb(names(ds))

str(ds$td.2)
head(
	na.exclude(
	ds[ds$punt_return_touchdowns > 0, ]
)
)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/tables")
game_log_names <- read.csv(list.files()[2])
names <- game_log_names$ds
names(ds) <- names
write.csv(ds,'all_game_log_data.csv')
