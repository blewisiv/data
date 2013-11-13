library(XML)
library(RCurl)
library(data.table)
library(plyr)

ap <- 
	x[,c('player','active_player')]
ds$active_player <- NULL
y <- merge(ds,ap, all.x = T, by = 'player')
active_players <- subset(y, active_player == T)
inactive_players <- subset(y, active_player == F)

write.csv(active_players,'active_player_gamelogs.csv')
write.csv(inactive_players,'inactive_player_gamelogs.csv')

urls <- unique(active_players$player_sports_ref_gamelog_url)
players <- unique(active_players$player)
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
ignore <- c(' ','Rk')
for(i in ignore){
	p <- all_p_stats[!grepl(i,all_p_stats$stats_playoffs.Rk),]
}

for(i in ignore){
	r <- all_rs_stats[!grepl(i,all_rs_stats$stats.Rk),]
}
names(r) <- tolower(gsub('stats.', '', names(r)))
names(p) <- tolower(gsub('stats_playoffs.', '', names(p)))
names(p)[7] <- 'game_location'
names(r)[7] <- 'game_location'
p$table_name <- 'P'
r$table_name <- 'RS'
as <- rbind.fill(r,p)
results <- as[!is.na(as$result), c('result')]
as <- cbind(as,colsplit(as$result,"\\ ", c('outcome','score')))
as <- cbind(as,colsplit(as$score,"-",c('team_points','opponent_points')))
as$score <- gsub("-"," to ",as$score)
as[as$game_location %in% '','game_location'] <- 'H'
missing <- as[as$score %in% '',]
names(missing)
as$missing_gamelog_data <- grepl(0,as$rk)
as$result <- NULL

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/tables")
game_log_names <- read.csv(list.files()[2])
names <- game_log_names$ds
names_as <- names(as)
names(game_log_names)
names_as <- 
	data.frame(sports_ref = names_as)
n <- 
	join(names_as,game_log_names[,c('sports_ref','ds')])
n[28,2] <- 'two_pt_conversions'
names(as) <- n[,2]

aways <- (as$game_location)[2]
as[grepl(aways,as$game_location),'game_location'] <- 'A'
started <- as$started_game[3907]
as[grepl('',as$started_game),'started_game']
as$started_game <- gsub("\\*",TRUE,as$started_game)
ig <- 
	as[3591,'started_game']
as[as$started_game %in% ig,'started_game'] <- FALSE

active <- as[!is.na(as$season),]
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/gamelog_data")
cols <- c(10:11,13:29,32:42,46,47)
active[,cols] <- 
	apply(active[,cols], 2, function(x) as.numeric((x)))
write.csv(active,'active_player_gamelogs.csv')
inactive_players$V1 <- NULL
z <- rbind.fill(active,inactive_players)
names(z)
z <- z[,c(30,1:29,32:59,31,60)]
z$date
z <- z[order(z$player,decreasing=F),]
write.csv(z,'all_game_log_data.csv')


