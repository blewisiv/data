players <- c('Albert Belle','Reggie Jackson', 'Reggie Jackson')
    contract_start_season <- c(1999,1977,1982)
    contract_end_season <- c(2003, 1981, 1985)
    key <- data.frame (player = players, contract_start_season, contract_end_season)

    player_data <- data.frame( season = c(seq(1975,1985), seq(1997,2003)) , player = c(rep('Reggie Jackson',times=10),rep('Albert Belle', times=6)))

player_data[player_data$season >= key$contract_start_season&player_data$season <= key$contract_end_season,]
player_data <- data.frame( season = c(seq(1975,1985),seq(1997,2003)), player = c(rep('Reggie Jackson',times=11),rep('Albert Belle', times=7)))

   player_data[
   	(player_data[player_data$season >= key$contract_start_season&player_data$season <= key$contract_end_season,]),]


library(data.table)

key <- data.table(key)
player_data <- data.table(player_data)

#Adding another column called season to help in the merge later
key[,season := contract_start_season]

# Index on which to merge
setkeyv(key, c("player","season"))
setkeyv(player_data, c("player","season"))

#the roll = Inf makes it like a closest merge, instead of an exact merge
test <- data.frame(key[player_data, roll = Inf])
test <-  test[!is.na(test$contract_start_season),c('player','season')]

