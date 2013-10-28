t <- read.csv(list.files()[3])
b <- read.csv(list.files()[1])
p <- read.csv(list.files()[2])

merged_contracts <- read.csv(list.files()[2])
MAJ <-  data.table(merged_contracts)

names(all_merged_batting_data)
db <- data.table(b)
dp <- data.table(p)

stats_games_b <- 
	db[, list(
	total_games = sum(g))
	, by = list(player,season)]

stats_games_p <- 
	dp[, list(
	total_games = sum(g))
	, by = list(player,season)]


stats_war_b <- 
	db[ , war, by = list(player,season,g) ]

stats_war_p <- 
	dp[ , war, by = list(player,season,g) ]

stats_b <- 
	merge(stats_war_b,stats_games_b, allow.cartesian =TRUE, by = c('player','season'))

stats_p <- 
	merge(stats_war_p,stats_games_p, allow.cartesian =TRUE, by = c('player','season'))


stats_b$ratio <- 
	stats_b$g/stats_b$total_games
stats_b$real_war <- stats_b$ratio*stats_b$war

stats_p$ratio <- 
	stats_p$g/stats_p$total_games
stats_p$real_war <- stats_p$ratio*stats_p$war


final_stats_b <- 
	stats_b[ , list(games = total_games, war = sum(real_war)
	), by = list(player, season)
	]
final_stats_p <- 
	stats_p[ , list(games = total_games, war = sum(real_war)
	), by = list(player, season)
	]

final_stats <- rbind(final_stats_b,final_stats_p)

salaries_b <- 
	db [!is.na(salary) , list( salary = salary, inflation_adjusted_salary = salary_2013),
	by = list(season,player)]
salaries_p <- 
	dp [!is.na(salary) , list( salary = salary, inflation_adjusted_salary = salary_2013),
	by = list(season,player)]

salaries <- rbind(salaries_b,salaries_p)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/data/merged_data/visualization_data")
all_player_data <- 
	merge(salaries,final_stats, by = c('player','season'))
write.csv(all_player_data,'all_player_war_and_salary_data.csv')

major_contracts
MAJ$season <- NULL
MAJ$X <- NULL
merge(all_player_data,MAJ,allow.cartesian=TRUE,by=c('player','season'))[season <= contract_end_season & season >= contract_start_season]

merged_contracts$data_season <- merged_contracts$contract_start_season-1
key <- data.table(merged_contracts)
player_data <- data.table(all_player_data)
player_data$season <- as.numeric(player_data$season)
#Adding another column called season to help in the merge later
str(key)
key[,season := data_season]
key[,year := contract_end_season]

# Index on which to merge
names(key)
key$X <- NULL
setkeyv(key, c("player","season"))
setkeyv(pd, c("player","season"))

#the roll = Inf makes it like a closest merge, instead of an exact merge
pd <- unique(player_data)
test <- 
	data.frame(key[pd, roll = Inf,allow.cartesian=TRUE,])
test$war <- round(test$war,digits=3)
final_sample <-  
	test[!is.na(test$date),c('player','season','team','games','salary','inflation_adjusted_salary','war','new_contract_source','contract_term','contract_start_season','contract_end_season')]
final_sample <- final_sample[order(final_sample$season,decreasing=F),]
final_sample$year_into_contract <- (final_sample$season-final_sample$contract_start_season)+1
final_sample$contract_completion_percentage <- round(final_sample$year_into_contract/final_sample$contract_term,digits=2)
final_sample <- subset(final_sample,final_sample$contract_completion_percentage <=1)
names(final_sample)
cols <- c(5:6)
f <- final_sample
f <- merge(fs,t[ , c('player','position')],all.x=T)
f <- unique(f)
f <- f[order(f$season,decreasing=F),]
fs <- f

fs <- unique(fs)

names(fs)
cols <- 5:6
fs[,cols] <- 
		apply(fs[,cols], 2, function(x) sprintf("$%.004f",(as.numeric((x)))))
fs$contract_completion_percentage <- sprintf("%.2f%%",(100*fs$contract_completion_percentage))

write.csv(f,'indexed_player_contracts.csv')
write.csv(merged_contracts,'all_major_contracts_5_years.csv')
names(fs)
fs <- fs[,c(1:3,14,7,5:6,9,13)]
names(fs)
d1<-dTable(fs,aoColumnDefs=
					 	(list(
					 		list(
					 			aTargets=list(4),
					 			fnCreatedCell="#! function(nTd,sData, oData, iRow, iCol){
					 			if (sData < 3.10){
					 			$(nTd).css('color','red');
					 			}
					 			} !#"
					 			))))
d1
d1$publish('5_year_contracts', host = 'gist')

names(fs)
