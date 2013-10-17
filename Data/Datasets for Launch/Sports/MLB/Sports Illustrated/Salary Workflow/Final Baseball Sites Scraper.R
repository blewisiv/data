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
write.csv(pro_data_contract,'Subsetted Pro Sports Transaction Subsetted Contract Data.csv')


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

batting_table$disputed_salary <- grepl("\\*",batting_table$salary)
batting_table$salary <- gsub("\\*","",batting_table$salary)
batting_table$salary <- gsub("\\$","",batting_table$salary)
batting_value_table$salary <- gsub("\\,","",batting_value_table$salary)

#
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/Salary Workflow/bref_data")
write.csv(cleaned_salaries_table,#ENTER)
write.csv(batting_table)