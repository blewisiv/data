#project baseball salary template for SI
library(XML)
library(RCurl)
library(data.table)
library(reshape2)
library(stringr)
library(lubridate)
options(stringsAsFactors=F)

#create list
players <- c('Reggie Jackson','Grady Sizemore','Albert Belle','Alex Rodriguez','Carlos Beltran')
player_baseball_ref_url <- c('http://www.baseball-reference.com/players/j/jacksre01.shtml','http://www.baseball-reference.com/players/s/sizemgr01.shtml','http://www.baseball-reference.com/players/b/belleal01.shtml','http://www.baseball-reference.com/players/r/rodrial01.shtml','http://www.baseball-reference.com/players/b/beltrca01.shtml')

players_urls <- data.frame( player = players, baseball_reference_url = player_baseball_ref_url
	)
row.names(players_urls) <- players_urls$player

a <- 'http://www.prosportstransactions.com/baseball/Search/SearchResults.php?Player='
b <- '&Team=&BeginDate=&EndDate=&PlayerMovementChkBx=yes&submit=Search'
players_urls$pro_sports_transactions_url <- paste(a,gsub('\\ ','+',players_urls$player),b,sep='')
attach(players_urls)

salaries_table <- data.frame()
batting_value_table <- data.frame()

baseball_reference_url <- bbref_urls
bref_tables <- readHTMLTable(bbref_urls[5],trim=T)
batting <- data.frame(bref_tables['batting_value'])
batting$player <- row.names(players_urls)[5]
batting_value_table <- rbind(batting,batting_value_table)
salaries <-data.frame(bref_tables['salaries'])
salaries$player <- row.names(players_urls)[5]
salaries_table <- rbind(salaries,salaries_table)
rm(salaries)
rm(batting)

names(batting_value_table) <- tolower(gsub("batting_value.",'',names(batting_value_table)))
names(salaries_table) <- tolower(gsub("salaries.",'',names(salaries_table)))
salaries_table <- salaries_table[-1,]

cleaned_salaries_table <- salaries_table[!grepl("Career to date (may be incomplete)",salaries_table$year),]
cleaned_salaries_table <- cleaned_salaries_table[!grepl("Year",cleaned_salaries_table$year),]
cleaned_salaries_table <- cleaned_salaries_table[!grepl("Career",cleaned_salaries_table$year),]
cleaned_salaries_table <- cleaned_salaries_table[!is.na(cleaned_salaries_table$team),]
cleaned_salaries_table <- cleaned_salaries_table[!is.na(cleaned_salaries_table$salary),]

skip <- as.character(cleaned_salaries_table[37,'salary'])
cleaned_salaries_table <- cleaned_salaries_table[!cleaned_salaries_table$salary %in% skip,]
cleaned_salaries_table$salary <- gsub("\\*","",cleaned_salaries_table$salary)
cleaned_salaries_table$salary <- gsub("\\$","",cleaned_salaries_table$salary)
cleaned_salaries_table$salary <- as.numeric(gsub("\\,","",cleaned_salaries_table$salary))

batting_value_table$salary <- gsub("\\*","",batting_value_table$salary)
batting_value_table$salary <- gsub("\\$","",batting_value_table$salary)
batting_value_table$salary <- gsub("\\,","",batting_value_table$salary)

pro_urls <- players_urls$pro_sports_transactions_url
pro_data <- data.frame()
pro_tables <- readHTMLTable(pro_urls[5],trim=T,header=F)
table <- data.frame(pro_tables[1])
table$player <- row.names(players_urls)[5]
pro_data <- rbind(table,pro_data)
rm(table)

pro_data <- pro_data[!pro_data$NULL.V3 %in% skip,]
skip2 <- 'Date'
pro_data <- pro_data[!pro_data$NULL.V1 %in% skip2,]
names(pro_data)[1:5] <- c('date','team','acquired','relinquished','pro_sports_transactions_notes')

pro_data$date <- as.Date(pro_data$date,"%Y-%m-%d")
pro_data$year <- year(pro_data$date)
pro_data$month <- month(pro_data$date)
pro_data$season <- pro_data$year
pro_data[pro_data$month >=11,'season'] <- pro_data[pro_data$month >=11,'season']+1 #adjust for when the season ends

write.csv(pro_data,'All Pro Sports Transaction Data.csv')
pro_data$pro_sports_transactions_notes
hitwords <- c('sign')
pro_data_contract <- pro_data[grepl(hitwords,pro_data$pro_sports_transactions_notes),]
write.csv(pro_data_contract,'Subsetted Pro Sports Transaction Subsetted Contract Data.csv')


names(pro_data_contract)
pdc <- pro_data_contract[,c('date','player','pro_sports_transactions_notes','year','month','season')]
test_salaries <- merge(cleaned_salaries_table,pdc,all.x=T)
test_salaries <- test_salaries[order(test_salaries$player,decreasing=F),]
write.csv(test_salaries,'Merged Salary Table.csv')

test_batting <- merge(batting_value_table,pdc,all.x=T)
test_batting <- test_batting[order(test_salaries$player,decreasing=F),]
write.csv(test_batting,'Merged Test Batting Stats.csv')

for(player in players){

}
