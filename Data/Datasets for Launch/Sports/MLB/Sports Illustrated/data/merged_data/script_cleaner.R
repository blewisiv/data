library(lubridate)
library(qdap)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Players")
all_data <- read.csv(list.files()[2])
all_data$url <- NULL
all_data$date <- as.Date(all_data$date,"%m/%d/%y")
all_data$year <- year(all_data$date)
all_data$month <- month(all_data$date)
all_data$season <- all_data$year
all_data[all_data$month >=10,'season'] <- all_data[all_data$month >=10,'season']+1 #adjust for when the season ends

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/data/prosports_transactions")
hitwords <- c('sign')
contracts <- all_data[grepl(hitwords,all_data$notes),]

ignore <- c('assign','GM','VP','coach','president','CEO','manager','minor league','pick')
for(i in ignore){
	contracts <- contracts[!grepl(i,contracts$notes),]
}
acquired <- contracts[,'acquired']
players <- data.frame(colsplit(acquired," / ",c('player','nickname')))
players$player <- gsub("(James) Kevin Brown","Kevin Brown",players$player)
p <- players$player
n <- colsplit(p,"\\(",c('name_1','name_2'))
n$name_2 <- gsub(") ",' ',n$name_2)
n[!n$name_2 %in% '',]
n$name_1 <- gsub('Philip Dean','P.J. Dean',n$name_1)
n[grepl(")",n$name_2),'name_2'] <-n[grepl(")",n$name_2),'name_1']
n[n$name_1 %in% '','name_1'] <- n[n$name_1 %in% '','name_2']
n$name_1 <- trim(n$name_1)
player <- n$name_1
contracts <- cbind(player,contracts)


contracts$new_contract_source <- ''
contracts[grepl('re-signed',contracts$notes),'new_contract_source'] <- 're-signinging'
contracts[!grepl('re-signed',contracts$notes),'new_contract_source'] <- 'free agency'
contracts$pst_contract_value_millions <- 
	as.character((genXtract(contracts$notes, "$", " ")))
contracts[is.na(contracts$pst_contract_value_millions),'pst_contract_value_millions'] <- 0
contracts$contract_term <- as.numeric(as.character(genXtract(contracts$notes, "to a ", "-year")))
contracts[is.na(contracts$contract_term),'contract_term'] <- 0

contracts$contract_option <- ''
contracts[grepl("option",contracts$notes)&grepl("team",contracts$notes),'contract_option'] <- 'team'
contracts[grepl("option",contracts$notes)&grepl("player",contracts$notes),'contract_option'] <- 'player'
test <- colsplit(contracts$notes,' through',c('a','b'))
test$a<-NULL
names(test) <- 'contract_end_season'
test <- colsplit(test$contract_end_season,' with a ',c('contract_end_season','contract_option'))

merged_contracts <- 
	cbind(contracts,test)
attach(merged_contracts)
merged_contracts[merged_contracts$contract_term == 0,'contract_term'] <- 1
merged_contracts$contract_start_season <- merged_contracts$season
merged_contracts[merged_contracts$contract_end_season %in% ""&merged_contracts$contract_term > 0,'contract_end_season'] <-
merged_contracts[merged_contracts$contract_end_season %in% ""&merged_contracts$contract_term > 0,'contract_term'] +merged_contracts[merged_contracts$contract_end_season %in% ""&merged_contracts$contract_term > 0,'contract_start_season']
names(merged_contracts)
all_free_agents <- merged_contracts[,c(2,1,9,3,6,10,11,12,16,14,15,7)]
write.csv(all_free_agents,'all_free_agents_since_1975.csv')

all_5_year_contracts <- all_free_agents[all_free_agents$contract_term >= 5,]
write.csv(all_5_year_contracts,'all_5_year_contracts_since_1975.csv')
all_since_1990 <- all_5_year_contracts[all_5_year_contracts$year >= 1990 , ]
length(all_5_year_contracts$date)
write.csv(all_since_1990	,'all_5_year_contracts_since_1990.csv')
length(all_since_1990$date)
