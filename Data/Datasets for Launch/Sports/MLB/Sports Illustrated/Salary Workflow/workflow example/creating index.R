observations<-data.frame(id=rep(rep(c(1,2,3,4),each=5),5),
    time=c(rep(1:5,4),rep(6:10,4),rep(11:15,4),rep(16:20,4),rep(21:25,4)),
    measurement=rnorm(100,5,7))
sampletimes<-data.frame(location=letters[1:20],id=rep(1:4,5),
    time1=rep(c(2,7,12,17,22),each=4),time2=rep(c(4,9,14,19,24),each=4))
library(data.table)
OBS <- data.table(observations)
SAM <- data.table(sampletimes)
merge(OBS,SAM,allow.cartesian=TRUE,by='id')[time > time1 & time < time2]

MAJ <- data.table(major_contracts[,1:13])
names(all_merged_batting_data)
dt <- data.table(merged_batting_table)


stats_games <- dt[, list(
	total_games = sum(g))
	, by = list(player,season)]

stats_war <- 
	dt[ , war, by = list(player,season,g) ]
stats <- merge(stats_war,stats_games, allow.cartesian =TRUE, by = c('player','season'))
stats$ratio <- stats$g/stats$total_games
stats$real_war <- stats$ratio*stats$war

final_stats <- stats[ , list(games = total_games, war = sum(real_war)
	), by = list(player, season)
	]

salaries <- 
	dt [!is.na(salary) , list( salary = salary, inflation_adjusted_salary = inflation_adjusted_salary),
	by = list(season,player)]

all_player_data <- merge(salaries,final_stats, by = c('player','season'))
write.csv(all_player_data,'all_player_war_and_salary_data.csv')

major_contracts
MAJ$season <- NULL

merge(all_player_data,MAJ,allow.cartesian=TRUE,by=c('player','season'))[season <= contract_end_season & season >= contract_start_season]


key <- data.table(major_contracts)
player_data <- data.table(all_player_data)

#Adding another column called season to help in the merge later
key[,season := contract_start_season]
key[,year := contract_end_season]

# Index on which to merge
setkeyv(key, c("player","season"))
setkeyv(player_data, c("player","season"))

#the roll = Inf makes it like a closest merge, instead of an exact merge
test <- data.frame(key[player_data, roll = Inf])
test$war <- round(test$war,digits=3)
final_sample <-  
	test[!is.na(test$date),c('player','season','team','games','salary','inflation_adjusted_salary','war','new_contract_source','contract_term','contract_start_season','contract_end_season')]
final_sample <- final_sample[order(final_sample$season,decreasing=F),]
final_sample$year_into_contract <- (final_sample$season-final_sample$contract_start_season)+1
final_sample$contract_completion_percentage <- round(final_sample$year_into_contract/final_sample$contract_term,digits=2)
final_sample <- subset(final_sample,final_sample$contract_completion_percentage <=1)
cols <- c(5:6)
final_sample[,cols] <- 
		apply(final_sample[,cols], 2, function(x) sprintf("$%.004f",(as.numeric((x)/1000000))))
final_sample$contract_completion_percentage <- sprintf("%.2f%%",(100*final_sample$contract_completion_percentage))

write.csv(final_sample,'indexed_sample_players.csv')
