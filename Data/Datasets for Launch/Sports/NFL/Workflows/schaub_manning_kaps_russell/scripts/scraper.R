#Pey_Schaub_Kap_Russell Scraper
library(XML)
library(stringr)
library(reshape2)


pey_url <- "http://www.pro-football-reference.com/players/M/MannPe00/gamelog//"
schaub_url <- "http://www.pro-football-reference.com/players/S/SchaMa00/gamelog/"
kap_url <- "http://www.pro-football-reference.com/players/K/KaepCo00/gamelog/"	
russell_url <- "http://www.pro-football-reference.com/players/R/RussJa00/gamelog/"

options(stringsAsFactors=F)


skip <- "Rk"

pey_tables <- readHTMLTable(pey_url,trim=T,as.data.frame=T)
pey_rs <- data.frame((pey_tables[1]))
pey_reg <- na.exclude(pey_rs)
pey_reg <- pey_reg[!pey_reg$stats.Rk %in% skip,]
names(pey_reg) <- c('player_game_number','season','season_game','game_date','age','team','game_location','opponent','game_result','game_started','pass_completions','pass_attempts','completion_percentage','passing_yards','passing_touchdowns','interceptions_thrown','qb_rating','yards_per_pass','adjusted_yards_per_pass','rushing_attempts','rushing_yards','rushing_yards_per_attempt','rushing_touchdowns','receiptions','receiving_yards','yards_per_receiption','receiving_touchdowns','receiving_rushing_touchdowns','receiving_rushing_points')
pey_reg$player <- "Peyton Manning"
pey_reg$started <- grepl("[//*]",pey_reg$game_started)
pey_reg <- cbind(pey_reg,colsplit(pey_reg$game_result,"\\ ",names=c('outcome','score')))
pey_reg <- cbind(pey_reg,colsplit(pey_reg$score,"\\-",names=c('team_score','opponent_score')))
names(pey_reg)
cols = c(1:3, 11:12,14:29,34:35)
pey_reg[,cols] = apply(pey_reg[,cols], 2, function(x) as.numeric((x)))
pey_reg$completion_percentage <- round(pey_reg$pass_completions/(pey_reg$pass_completions+pey_reg$pass_attempts),digits=3)

schaub_tables <- readHTMLTable(schaub_url,trim=T,as.data.frame=T)
schaub_rs <- data.frame((schaub_tables[1]))
schaub_reg <- na.exclude(schaub_rs)
schaub_reg <- schaub_reg[!schaub_reg$stats.Rk %in% skip,]
schaub_reg[,1:29]
names(schaub_reg) <- c('player_game_number','season','season_game','game_date','age','team','game_location','opponent','game_result','game_started','pass_completions','pass_attempts','completion_percentage','passing_yards','passing_touchdowns','interceptions_thrown','qb_rating','yards_per_pass','adjusted_yards_per_pass','rushing_attempts','rushing_yards','rushing_yards_per_attempt','rushing_touchdowns','receiptions','receiving_yards','yards_per_receiption','receiving_touchdowns','receiving_rushing_touchdowns','two_point_conversions','receiving_rushing_points')
schaub_reg$player <- "Matt Schaub"
schaub_reg$started <- grepl("[//*]",schaub_reg$game_started)
schaub_reg <- cbind(schaub_reg,colsplit(schaub_reg$game_result,"\\ ",names=c('outcome','score')))
schaub_reg <- cbind(schaub_reg,colsplit(schaub_reg$score,"\\-",names=c('team_score','opponent_score')))
names(schaub_reg)
cols = c(1:3, 11:12,14:30,35:36)
schaub_reg[,cols] = apply(schaub_reg[,cols], 2, function(x) as.numeric((x)))
schaub_reg$completion_percentage <- round(schaub_reg$pass_completions/(schaub_reg$pass_completions+schaub_reg$pass_attempts),digits=3)

kap_tables <- readHTMLTable(kap_url,trim=T,as.data.frame=T)
kap_rs <- data.frame((kap_tables[1]))
kap_reg <- na.exclude(kap_rs)
kap_reg <- kap_reg[!kap_reg$stats.Rk %in% skip,]
names(kap_reg) <- c('player_game_number','season','season_game','game_date','age','team','game_location','opponent','game_result','game_started','pass_completions','pass_attempts','completion_percentage','passing_yards','passing_touchdowns','interceptions_thrown','qb_rating','yards_per_pass','adjusted_yards_per_pass','rushing_attempts','rushing_yards','rushing_yards_per_attempt','rushing_touchdowns','receiving_rushing_touchdowns','receiving_rushing_points')
kap_reg$player <- "Colin Kaepernick"
kap_reg$started <- grepl("[//*]",kap_reg$game_started)
kap_reg <- cbind(kap_reg,colsplit(kap_reg$game_result,"\\ ",names=c('outcome','score')))
kap_reg <- cbind(kap_reg,colsplit(kap_reg$score,"\\-",names=c('team_score','opponent_score')))
names(kap_reg)
cols = c(1:3, 11:12,14:25,30:31)
kap_reg[,cols] = apply(kap_reg[,cols], 2, function(x) as.numeric((x)))
kap_reg$completion_percentage <- round(kap_reg$pass_completions/(kap_reg$pass_completions+kap_reg$pass_attempts),digits=3)

russell_tables <- readHTMLTable(russell_url,trim=T,as.data.frame=T)
russell_rs <- data.frame((russell_tables[1]))
russell_reg <- na.exclude(russell_rs)
russell_reg <- russell_reg[!russell_reg$stats.Rk %in% skip,]
names(russell_reg) <- c('player_game_number','season','season_game','game_date','age','team','game_location','opponent','game_result','game_started','pass_completions','pass_attempts','completion_percentage','passing_yards','passing_touchdowns','interceptions_thrown','qb_rating','yards_per_pass','adjusted_yards_per_pass','rushing_attempts','rushing_yards','rushing_yards_per_attempt','rushing_touchdowns','receiving_rushing_touchdowns','receiving_rushing_points')
russell_reg$player <- "JaMarcus Russell"
russell_reg$started <- grepl("[//*]",russell_reg$game_started)
russell_reg <- cbind(russell_reg,colsplit(russell_reg$game_result,"\\ ",names=c('outcome','score')))
russell_reg <- cbind(russell_reg,colsplit(russell_reg$score,"\\-",names=c('team_score','opponent_score')))
names(russell_reg)
cols = c(1:3, 11:12,14:25,30:31)
russell_reg[,cols] = apply(russell_reg[,cols], 2, function(x) as.numeric((x)))
russell_reg$completion_percentage <- round(russell_reg$pass_completions/(russell_reg$pass_completions+russell_reg$pass_attempts),digits=3)


setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/schaub_manning_kaps_russell/data/tables")
write.csv(pey_reg,'Peyton Manning Regular Season Data.csv')
write.csv(schaub_reg,'Matt Schaub Regular Season Data.csv')
write.csv(kap_reg,'Colin Kaepernick Regular Season Data.csv')
write.csv(russell_reg,'JaMarcus Russell Regular Season Data.csv')
