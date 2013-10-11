#Pey_Schaub_Kap_Russell Framer

library(rCharts)
library(dplyr)
library(data.table)
setwd("/Users/alexbresler/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/schaub_manning_kaps_russell/data/tables")
list.files()

kap <- data.frame(read.csv(list.files()[1]),stringsAsFactors=F)
russell <- data.frame(read.csv(list.files()[2]),stringsAsFactors=F)
schaub <- data.frame(read.csv(list.files()[3]),stringsAsFactors=F)
pey <- data.frame(read.csv(list.files()[4]),stringsAsFactors=F)

russell_dt <- data.table(russell)
kap_dt <- data.table(kap)
schaub_dt <- data.table(schaub) 
pey_dt <- data.table(pey)


game_number <- 5 #ENTER GAME NUMBER

pey_1998_progession <- subset(pey, season == 1998 , season_game <= game_number)
pey_1998_progession <- subset(pey_1998_progession, season_game <= game_number)
russell_2008_progession <- subset(russell, season == 2008 , season_game <= game_number)
russell_2008_progession <- subset(russell_2008_progession, season_game <= game_number)
kap_2013_progession <- subset(kap, season == 2013 , season_game <= game_number)
schaub_2013_progession <- subset(schaub, season == 2013 , season_game <= game_number)



cols <- c("player","season","season_game","pass_completions","pass_attempts","passing_touchdowns","passing_yards","interceptions_thrown","qb_rating","rushing_touchdowns","outcome","team_score","opponent_score")


merged_df <- merge(kap_2013_progession[,cols],schaub_2013_progession[,cols],all.x=T,all.y=T)
merged_df <- merge(merged_df,russell_2008_progession[,cols],all.x=T,all.y=T)
merged_df <- merge(merged_df,pey_1998_progession[,cols],all.x=T,all.y=T)
merged_dt <- data.table(merged_df)

names(merged_dt)
ds <-data.frame( 
	merged_dt[, list( completions = sum(pass_completions), attempts = sum(pass_attempts), passing_yards = sum(passing_yards), passing_touchdowns = sum(passing_touchdowns), interceptions = sum(interceptions_thrown), rushing_touchdowns = sum(rushing_touchdowns), qb_rating = mean(qb_rating), team_points = sum(team_score) , opponent_points = sum(opponent_score)
		), 
		by = list(player,season)])

outcomes <- data.frame(merged_dt[, list( wins = .N),by = list (player, outcome)])
outcomes <- outcomes[!(outcomes$outcome %in% "L"),c('player','wins')]
outcomes$win_percentage <- 100*(round(outcomes$wins/game_number,digits=4))
attach(ds)
ds$completion_percentage <- 100*round(completions/attempts, digits=4)
ds$point_contribution_ratio <- 100*round(((passing_touchdowns+rushing_touchdowns)*6)/team_points,digits=4)
ds$interceptions_per_attempt <- 100*round((interceptions/attempts),digits=4)
ds$yards_per_completion <- round(passing_yards/completions,digits=2)
ds$yards_per_attempt <- round(passing_yards/attempts,digits=2)
ds$touchdowns_per_interception <- round(passing_touchdowns/interceptions,digits=2)
ds$touchdowns_per_attempt <- 100*round(passing_touchdowns/attempts,digits=4)
ds$touchdowns_per_completion <-100*round(passing_touchdowns/completions,digits=4)
ds$player_point_to_opponent_point_ratio <- 100*round(((passing_touchdowns+rushing_touchdowns)*6)/opponent_points,digits=4)

ds <- merge(ds,outcomes)

player_desc <- paste(player,' ',game_number,' Games into ',season," Season",sep="")
player_desc <- data.frame(player = as.character(outcomes$player),player_desc = player_desc,stringsAsFactors=F)
ds <- merge(player_desc,ds)
ds$season <- NULL
ds$player <- NULL
names(ds)[1] <- 'player'
names(ds)
ds <- ds[,c(1,8,4:5,2:3,11,7,6,21,20,9:10,14:15,17:18,12,19,16,13)]
ds <- ds[order(ds$qb_rating,decreasing=F),]
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/schaub_manning_kaps_russell/data/summaries")
write.csv(ds,paste('Week_',game_number,'_Schaub_Russell_Manning_Kap_Tracker','.csv',sep=""))
