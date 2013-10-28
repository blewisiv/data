setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/data/prosports_transactions")
all_5_year_contracts <- read.csv(list.files()[2])
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/data/baseball_reference")
players_urls <- read.csv(list.files()[1])
names <- c('Lenny Dykstra','Jeff Samardzija','CC Sabathia','Hyun-jin Ryu')
all_5_year_contracts[(!all_5_year_contracts[,'player'] %in% players_urls[,'player']),]
all_5_year_contracts[(!all_5_year_contracts[,'player'] %in% players_urls[,'player']),'player'] <- names
merged_contracts <- merge(all_5_year_contracts,players_urls)
names(merged_contracts)
merged_contracts$minor_league_player <- 
	grepl('minors',merged_contracts$player_bref_url)
merged_contracts$X <- NULL
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/data/merged_data/player_index")
merged_contracts$bref_directory_url <- NULL
write.csv(merged_contracts,'all_5_year_contract_players.csv')
contracts_ex_minors <- 
	merged_contracts[!grepl('minor',merged_contracts$player_bref_url) , ]
write.csv(contracts_ex_minors,'all_5_year_contracts_no_minors.csv')
