library(XML)
library(RCurl)
library(data.table)
library(reshape2)
library(stringr)
library(lubridate)
library(qdap)
options(stringsAsFactors=F)

fed_url <- 'http://www.minneapolisfed.org/community_education/teacher/calc/hist1800.cfm'
fed_tables <- readHTMLTable(fed_url)
inflation_tables <- data.frame(fed_tables[1])
inflation_tables <- inflation_tables[3:214,1:2]
inflation_tables <- data.frame(inflation_tables[1:210,1:2])
names(inflation_tables) <- c('year','cpi_index')
inflation_tables$year <- gsub('\\*','',inflation_tables$year)
cols <- inflation_tables[,1:2]
inflation_tables[,1:2] = apply(inflation_tables[,1:2], 2, function(x) as.numeric((x)))
inflation_tables$inflator_2013 <- 701.5/inflation_tables$cpi_index
inflation_tables$cpi_index <- NULL

players <- c('Reggie Jackson','Grady Sizemore','Albert Belle','Alex Rodriguez','Carlos Beltran')
player_baseball_ref_url <- c('http://www.baseball-reference.com/players/j/jacksre01.shtml','http://www.baseball-reference.com/players/s/sizemgr01.shtml','http://www.baseball-reference.com/players/b/belleal01.shtml','http://www.baseball-reference.com/players/r/rodrial01.shtml','http://www.baseball-reference.com/players/b/beltrca01.shtml')

players_urls <- data.frame( player = players, baseball_reference_url = player_baseball_ref_url
	)
row.names(players_urls) <- players_urls$player

a <- 'http://www.prosportstransactions.com/baseball/Search/SearchResults.php?Player='
b <- '&Team=&BeginDate=&EndDate=&PlayerMovementChkBx=yes&submit=Search'
players_urls$pro_sports_transactions_url <- paste(a,gsub('\\ ','+',players_urls$player),b,sep='')

#PRO-SPORTS-TRANSACTIONS SCRAPER
pro_url <- players_urls$pro_sports_transactions_url
urls <- pro_url
names(urls) <- players
pro_data<-data.frame()
for(player in players){
tables <- readHTMLTable(urls[player],trim=T,header=F)
	table_data <- data.frame(tables[1],stringsAsFactors=F)
	table_data$player <- player
	pro_data <- rbind(pro_data,table_data)
	rm(table_data)
}
skip <- ''
pro_data <- pro_data[!pro_data$NULL.V3 %in% skip,]
skip2 <- 'Date'
pro_data <- pro_data[!pro_data$NULL.V1 %in% skip2,]
names(pro_data)[1:5] <- c('date','team','acquired','relinquished','pro_sports_transactions_notes')
pro_data$date <- as.Date(pro_data$date,"%Y-%m-%d")
pro_data$year <- year(pro_data$date)
pro_data$month <- month(pro_data$date)
pro_data$season <- pro_data$year
pro_data[pro_data$month >=11,'season'] <- pro_data[pro_data$month >=11,'season']+1 #adjust for when the season ends
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/Salary Workflow/test/Pro-Sports Transactions") #set correct WD
write.csv(pro_data,'All Pro Sports Transaction Data.csv')
pro_data$pro_sports_transactions_notes
hitwords <- c('sign')
pro_data_contract <- pro_data[grepl(hitwords,pro_data$pro_sports_transactions_notes),]
ignore <- c('pick')
attach(pro_data_contract)
pro_data_contract <- pro_data_contract[!grepl(ignore,pro_data_contract$pro_sports_transactions_notes),]
pro_data_contract$new_contract_source <- ''
pro_data_contract[grepl('re-signed',pro_sports_transactions_notes),'new_contract_source'] <- 're-signinging'
pro_data_contract[!grepl('re-signed',pro_sports_transactions_notes),'new_contract_source'] <- 'free agency'
pro_data_contract$pst_contract_value_millions <- as.numeric(genXtract(pro_sports_transactions_notes, "$", "M"))
pro_data_contract$contract_term <- as.numeric(genXtract(pro_data_contract$pro_sports_transactions_notes, "to a ", "-year"))
pro_data_contract$contract_option <- ''
pro_data_contract[grepl("option",pro_data_contract$pro_sports_transactions_notes)&grepl("team",pro_data_contract$pro_sports_transactions_notes),'contract_option'] <- 'team'
pro_data_contract[grepl("option",pro_data_contract$pro_sports_transactions_notes)&grepl("player",pro_data_contract$pro_sports_transactions_notes),'contract_option'] <- 'player'
test <- colsplit(pro_sports_transactions_notes,' through',c('a','b'))
test$a<-NULL
names(test) <- 'contract_end_season'
test <- colsplit(test$contract_end_season,' with a ',c('contract_end_season','contract_option'))

merged_contracts <- cbind(pro_data_contract,test)
attach(merged_contracts)
merged_contracts$contract_start_season <- merged_contracts$season
merged_contracts[is.na(contract_end_season)&!is.na(contract_term),'contract_end_season'] <-
	(merged_contracts[is.na(contract_end_season)&!is.na(contract_term),'contract_start_season'] + merged_contracts[is.na(contract_end_season)&!is.na(contract_term),'contract_term'])-1
names(merged_contracts)
final_contracts <- merged_contracts[,c(1,9,6,2,5,4,3,10,17,13,12,15,14,7,8)]
final_contracts[is.na(final_contracts$contract_term),'contract_term'] <- 1
write.csv(final_contracts,'Subsetted Pro Sports Transaction Subsetted Contract Data.csv')


#BREF Scraper

bref_url <- players_urls$baseball_reference_url
urls <- bref_url
names(urls) <- players

salaries_table <- data.frame()
batting_table <- data.frame()
for(player in players){
tables <- readHTMLTable(urls[player],trim=T,header=F)
	batting_data <- data.frame(tables['batting_value'],stringsAsFactors=F)
	batting_data$player <- player
	batting_table <- rbind(batting_table,batting_data)
	salary_data <- data.frame(tables['salaries'],stringsAsFactors=F)
	salary_data$player <- player
	salaries_table <- rbind(salary_data,salaries_table)
	rm(salary_data)
	rm(batting_data)
}

skip_bref1 <- "Year"
skip_bref2 <- "2013 Status"
names(batting_table)  <- c("year","age", "tm", "lg","g", "pa", "rbat","rbaser","rdp", "rfield", "rpos","raa", "waa", "rrep","rar", "war", "waawl." , "X162wl.", "owar","dwar","orar","salary","pos", "awards",  "player")
names(salaries_table) <- tolower(gsub("salaries.",'',names(salaries_table)))
names(salaries_table) <- c('year','age','team','salary','sources','notes.other.sources','player')
cleaned_salaries_table <- salaries_table[!salaries_table$salary %in% skip,]
cleaned_salaries_table <- cleaned_salaries_table[!cleaned_salaries_table$team %in% skip,]
cleaned_salaries_table <- cleaned_salaries_table[!cleaned_salaries_table$year %in% skip,]
cleaned_salaries_table <- cleaned_salaries_table[!cleaned_salaries_table$year %in% skip_bref1,]
cleaned_salaries_table <- cleaned_salaries_table[!cleaned_salaries_table$year %in% skip_bref2,]
cleaned_salaries_table$disputed_salary <- grepl("\\*",cleaned_salaries_table$salary)
cleaned_salaries_table$salary <- gsub("\\*","",cleaned_salaries_table$salary)
cleaned_salaries_table$salary <- gsub("\\$","",cleaned_salaries_table$salary)
cleaned_salaries_table$salary <- as.numeric(gsub("\\,","",cleaned_salaries_table$salary))
cleaned_salaries_table$year <- as.numeric(cleaned_salaries_table$year)
inflation_adjusted_salaries <- merge(cleaned_salaries_table,inflation_tables)
inflation_adjusted_salaries$inflation_adjusted_salary <- inflation_adjusted_salaries$inflator_2013*inflation_adjusted_salaries$salary
final_cleaned_salaries_table <- merge(cleaned_salaries_table,inflation_adjusted_salaries[,c('year','inflation_adjusted_salary')],all.x=T)
write.csv(final_cleaned_salaries_table,'Final BBREF Inflation Adjusted Salaries.csv')
write.csv(inflation_adjusted_salaries,'BBREF Historic Inflation Adjusted Salaries.csv')

batting_table$disputed_salary <- grepl("\\*",batting_table$salary)
batting_table$salary <- gsub("\\*","",batting_table$salary)
batting_table$salary <- gsub("\\$","",batting_table$salary)
batting_table$salary <- gsub("\\,","",batting_table$salary)
names(batting_table)
cols <- c(1:2,5:22)
batting_table[,cols] = 
	apply(batting_table[,cols], 2, function(x) as.numeric((x)))
merged_batting_table <- merge(batting_table,inflation_tables)
merged_batting_table$inflation_adjusted_salary <- 
merged_batting_table$inflator_2013*merged_batting_table$salary
merged_batting_table$season <- merged_batting_table$year 
tm <- unique(merged_batting_table$tm) 
team <- c('Athletics', 'Athletics','Orioles','Yankees','Angels','Indians','Mariners','White Sox','Royals','Rangers','Astros','Mets','Giants','Cardinals')
teams_codes <- data.frame(cbind(tm,team))
merged_batting_table <- merge(merged_batting_table,teams_codes)
write.csv(merged_batting_table,'BREF Advanced Batting Data, Inflation Adjusted Salaries.csv')


major_contracts <- final_contracts[final_contracts$contract_term > 3, ]
write.csv(major_contracts,'Major Contracts for SI Workflow.csv')


#####

merge(final_contracts,final_cleaned_salaries_table)
names(final_contracts)
names(final_cleaned_salaries_table)[1] <- 'season'
free_agent_merged_salaries <- merge(final_cleaned_salaries_table,final_contracts,by = c('player','season'))
all_merged_salaries <- merge(final_cleaned_salaries_table,final_contracts,by = c('player','season'),all.x=T,all.y=T)

write.csv(all_merged_salaries,'All Seasons Salaries Merged.csv')
write.csv(free_agent_merged_salaries,'Merged Salaries of Free Agency Years.csv')

merged_batting_table_free_agent_years <- merge(final_contracts,merged_batting_table,all.x=T)
all_merged_batting_data <- merge(final_contracts,merged_batting_table,all.x=T, all.y=T)
all_merged_batting_data[is.na(all_merged_batting_data$season),'season'] <- all_merged_batting_data[is.na(all_merged_batting_data$season),'year']
all_merged_batting_data$team <- NULL
all_merged_batting_data <- merge(all_merged_batting_data,teams_codes)
names(all_merged_batting_data)
all_merged_batting_data <- 
	str(all_merged_batting_data[,c(2,3,1,41,5:6,35,40,7:34,36:39)])
all_merged_batting_data <- all_merged_batting_data[order(all_merged_batting_data$year,decreasing=F),]
write.csv(merged_batting_table_free_agent_years,'Merged Batting Data Free Agency Years.csv')
write.csv(all_merged_batting_data,'All Merged Batting Data.csv')


