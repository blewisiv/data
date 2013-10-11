#Pey_Tomin Scraper
library(XML)
library(stringr)
library(reshape2)

tom_url <- "http://www.pro-football-reference.com/players/B/BradTo00/gamelog//"
pey_url <- "http://www.pro-football-reference.com/players/M/MannPe00/gamelog//"
aaron_url <- "http://www.pro-football-reference.com/players/R/RodgAa00/gamelog//"
marino_url <- "http://www.pro-football-reference.com/players/M/MariDa00.htm/gamelog//"
brees_url <- "http://www.pro-football-reference.com/players/B/BreeDr00.htm/gamelog//"
	
options(stringsAsFactors=F)
skip <- "Rk"

#Tom Brady
tom_tables <- readHTMLTable(tom_url,trim=T,as.data.frame=T)
tom_rs <- data.frame((tom_tables[1]))
tom_reg <- na.exclude(tom_rs)
tom_reg <- tom_reg[!tom_reg$stats.Rk %in% skip,]
names(tom_reg) <- c('player_game_number','season','season_game','game_date','age','team','game_location','opponent','game_result','game_started','pass_completions','pass_attempts','completion_percentage','passing_yards','passing_touchdowns','interceptions_thrown','qb_rating','yards_per_pass','adjusted_yards_per_pass','rushing_attempts','rushing_yards','rushing_yards_per_attempt','rushing_touchdowns','receiptions','receiving_yards','yards_per_receiption','receiving_touchdowns','receiving_rushing_touchdowns','receiving_rushing_points','punt_attempts','punting_yards','yards_per_punt','punts_blocked')
tom_reg$player <- "Tom Brady"
tom_reg$started <- grepl("[//*]",tom_reg$game_started)
tom_reg <- cbind(tom_reg,colsplit(tom_reg$game_result,"\\ ",names=c('outcome','score')))
tom_reg <- cbind(tom_reg,colsplit(tom_reg$score,"\\-",names=c('team_score','opponent_score')))
names(tom_reg)
cols = c(1:3, 11:12,14:33,38:39)
tom_reg[,cols] = apply(tom_reg[,cols], 2, function(x) as.numeric((x)))
tom_reg$completion_percentage <- round(tom_reg$pass_completions/(tom_reg$pass_completions+tom_reg$pass_attempts),digits=3)
names(tom_reg)
tom_reg <- tom_reg[ ,-c(10)]


#Peyton Manning
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

#Aaron Rodgers
aaron_tables <- readHTMLTable(aaron_url,trim=T,as.data.frame=T)
aaron_rs <- data.frame((aaron_tables[1]))
aaron_reg <- na.exclude(aaron_rs)
aaron_reg <- aaron_reg[!aaron_reg$stats.Rk %in% skip,]
names(aaron_reg) <- c('player_game_number','season','season_game','game_date','age','team','game_location','opponent','game_result','game_started','pass_completions','pass_attempts','completion_percentage','passing_yards','passing_touchdowns','interceptions_thrown','qb_rating','yards_per_pass','adjusted_yards_per_pass','rushing_attempts','rushing_yards','rushing_yards_per_attempt','rushing_touchdowns','receiptions','receiving_yards','yards_per_receiption','receiving_touchdowns','receiving_rushing_touchdowns','two_point_conversions','receiving_rushing_points')
aaron_reg$player <- "Aaron Rodgers"
aaron_reg$started <- grepl("[//*]",aaron_reg$game_started)
aaron_reg <- cbind(aaron_reg,colsplit(aaron_reg$game_result,"\\ ",names=c('outcome','score')))
aaron_reg <- cbind(aaron_reg,colsplit(aaron_reg$score,"\\-",names=c('team_score','opponent_score')))
names(aaron_reg)
cols = c(1:3, 11:12,14:30,35:36)
aaron_reg[,cols] = apply(aaron_reg[,cols], 2, function(x) as.numeric((x)))
aaron_reg$completion_percentage <- round(aaron_reg$pass_completions/(aaron_reg$pass_completions+aaron_reg$pass_attempts),digits=3)

#Dan Marino

marino_tables <- readHTMLTable(marino_url,trim=T,as.data.frame=T)
marino_rs <- data.frame((marino_tables[1]))
marino_reg <- na.exclude(marino_rs)
marino_reg <- marino_reg[!marino_reg$stats.Rk %in% skip,]
names(marino_reg) <- c('player_game_number','season','season_game','game_date','age','team','game_location','opponent','game_result','game_started','pass_completions','pass_attempts','completion_percentage','passing_yards','passing_touchdowns','interceptions_thrown','qb_rating','yards_per_pass','adjusted_yards_per_pass','rushing_attempts','rushing_yards','rushing_yards_per_attempt','rushing_touchdowns','receiptions','receiving_yards','yards_per_receiption','receiving_touchdowns','receiving_rushing_touchdowns','receiving_rushing_points')
marino_reg$player <- "Dan Marino"
marino_reg$started <- grepl("[//*]",marino_reg$game_started)
marino_reg <- cbind(marino_reg,colsplit(marino_reg$game_result,"\\ ",names=c('outcome','score')))
marino_reg <- cbind(marino_reg,colsplit(marino_reg$score,"\\-",names=c('team_score','opponent_score')))
names(marino_reg)
cols = c(1:3, 11:12,14:29,34:35)
marino_reg[,cols] = apply(marino_reg[,cols], 2, function(x) as.numeric((x)))
marino_reg$completion_percentage <- round(marino_reg$pass_completions/(marino_reg$pass_completions+marino_reg$pass_attempts),digits=3)

#Drew Brees
brees_tables <- readHTMLTable(brees_url,trim=T,as.data.frame=T)
brees_rs <- data.frame((brees_tables[1]))
brees_reg <- na.exclude(brees_rs)
brees_reg <- brees_reg[!brees_reg$stats.Rk %in% skip,]
names(brees_reg) <- c('player_game_number','season','season_game','game_date','age','team','game_location','opponent','game_result','game_started','pass_completions','pass_attempts','completion_percentage','passing_yards','passing_touchdowns','interceptions_thrown','qb_rating','yards_per_pass','adjusted_yards_per_pass','rushing_attempts','rushing_yards','rushing_yards_per_attempt','rushing_touchdowns','receiptions','receiving_yards','yards_per_receiption','receiving_touchdowns','receiving_rushing_touchdowns','receiving_rushing_points')
brees_reg$player <- "Drew Brees"
brees_reg$started <- grepl("[//*]",brees_reg$game_started)
brees_reg <- cbind(brees_reg,colsplit(brees_reg$game_result,"\\ ",names=c('outcome','score')))
brees_reg <- cbind(brees_reg,colsplit(brees_reg$score,"\\-",names=c('team_score','opponent_score')))
names(brees_reg)
cols = c(1:3, 11:12,14:29,34:35)
brees_reg[,cols] = apply(brees_reg[,cols], 2, function(x) as.numeric((x)))
brees_reg$completion_percentage <- round(brees_reg$pass_completions/(brees_reg$pass_completions+brees_reg$pass_attempts),digits=3)



setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data")
write.csv(pey_reg,'Peyton Manning Regular Season Data.csv')
write.csv(tom_reg,'Tom Brady Regular Season Data.csv')
write.csv(aaron_reg,'Aaron Rodgers Regular Season Data.csv')
write.csv(marino_reg,'Dan Marino Regular Season Data.csv')
write.csv(brees_reg,'Drew Brees Regular Season Data')
