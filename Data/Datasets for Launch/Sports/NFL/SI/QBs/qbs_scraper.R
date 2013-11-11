library(XML)
library(RCurl)
library(reshape2)
library(gdata)
library(stringr)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs")
qbs <-  'http://www.pro-football-reference.com/players/qbindex.htm'
u <- dictonary[-24]
final_results <- data.frame()
for(i in 1:length(u)){
page <- htmlParse(getURL(qbs),error=function(...){})
names <- 
		xpathSApply(page,"//*//a[contains(@href,'/players/')]",xmlValue)
stems <- 
		xpathSApply(page,"//*//a[contains(@href,'/players/')]",xmlAttrs)
page_url <- 'http://www.pro-football-reference.com/'
urls <- paste(page_url,stems,sep='')
results <- data.frame(player = names, player_bref_url = urls)
results$bref_directory_url <- qbs
final_results <- rbind(results,final_results)
rm(names)
rm(stems)
rm(urls)
rm(page)
}

rm(all_data)
final_results <-
	final_results[!final_results$player_bref_url == 'http://www.baseball-reference.com/players/',]

qbs$player_sports_ref_gamelog_url <- 
	paste(gsub('.htm','',qbs$player_sports_ref_url,),'/gamelog',sep='')
qbs$player_sports_ref_url <- gsub("http:/","http://",qbs$player_sports_ref_url)
qbs$player_sports_ref_gamelog_url <- gsub("http:/","http://",qbs$player_sports_ref_gamelog_url)
write.csv(qbs,'all_nfl_qb_urls.csv')


#Scrape Meta
urls <- qbs$player_sports_ref_url
players <- qbs$player
names(urls) <- players
length(urls)
all_players_metadata <- data.frame()
u <- 
	urls[620:907]
p <- 
	players[620:907]


for(player in p){
	page <- 
		htmlParse(getURL(u[player]),error=function(...){})
	birthdate_location <- 
		ifelse(
			length(xpathSApply(page,"//*//p/span[@id='necro-birth']",xmlValue)) > 0,
			xpathSApply(page,"//*//p/span[@id='necro-birth']",xmlValue),
			' '
		)
	college <- 
	ifelse(
		length(xpathSApply(page,"//p/a[contains(@href,'/colleges/')]",xmlValue)) > 0,
		xpathSApply(page,"//p/a[contains(@href,'/colleges/')]",xmlValue),
		' ')
	actual_name <-	
	str_trim(xpathSApply(page,"//div[1]/div[2]/p/strong",xmlValue)[1])
	height <-	
	ifelse(
		str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[3])
		== 'QB',
			str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[4]),
		str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[3]))
	weight <-	
	ifelse(
		str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[3])
		== 'QB',
	str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[5]),
	str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[4])
	)
	throwing_hand <-	
	ifelse(
		str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[3])
		== 'QB', 
		str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[6]),
		str_trim(xpathSApply(page,"//div[1]/div[2]/p/text()",xmlValue)[5])
	)
	l <- 
		length(str_trim(xpathSApply(page,"//div[1]/div[2]/p[3]/text()",xmlValue)))
	dp <-	
	unlist(str_trim(xpathSApply(page,"//div[1]/div[2]/p[3]/text()",xmlValue))[(l-2):l])
	draft_position <- do.call(paste, c(as.list(dp), sep=" "))
	draft_team <- ifelse(length(
		xpathSApply(page,"//*/p/a[contains(@href,'/teams/')]",xmlValue)) > 0,
		xpathSApply(page,"//*/p/a[contains(@href,'/teams/')]",xmlValue),' '
		)
	draft_year <-
	ifelse(
		length(xpathSApply(page,"//*/p/a[contains(@href,'/years/')]",xmlValue)) > 0,
		xpathSApply(page,"//*/p/a[contains(@href,'/years/')]",xmlValue)[1],
		' '
	)
	table <- 
		data.frame(
			actual_name = actual_name, birthdate_location = birthdate_location, college = college, 
			height = height, weight = weight, throwing_hand = throwing_hand, draft_team = draft_team,
			draft_position = draft_position, draft_year = draft_year)
	table$player <- player
	table$player_sportsref_url <- u[player]
	all_players_metadata <- 
		rbind(all_players_metadata,table)
	rm(table)
	rm(page)
}

all_players_metadata$weight <- 
	as.numeric(str_trim(gsub(' lbs.' ,'',all_players_metadata$weight)))
attach(all_players_metadata)
players_births <- all_players_metadata[
	!grepl("in",all_players_metadata$birthdate_location),c('actual_name','birthdate_location','player_sportsref_url')
	]
players_births$birthdate <- players_births$birthdate_location

players_births_locations <- all_players_metadata[
	grepl("in",all_players_metadata$birthdate_location),c('actual_name','birthdate_location','player_sportsref_url')
	]
players_births_locations <- 
	cbind(players_births_locations,colsplit(players_births_locations$birthdate_location,split=" in ",c('birthdate','location')))

players_births_locations <- 
	cbind(players_births_locations,colsplit(players_births_locations$location, ",",c('birth_city','birth_state'))
		)


players_births_locations$birth_city <- str_trim(players_births_locations$birth_city)
	players_births_locations$birth_state <- 
		str_trim(players_births_locations$birth_state)
pbl <- 
	merge(players_births,players_births_locations,
	all.x = T, all.y = T)

apm <- merge(all_players_metadata,pbl,all.x= T , all.y = T)

words <- c('Supplemental','NFL','AFL','Draft','AAFC')
for(word in words){
	apm$draft_year <- str_trim(gsub(word,'',apm$draft_year))
}

words <- c('in the','by the ','of the .')
for(word in words){
	apm$draft_position <- str_trim(gsub(word,'',apm$draft_position))
}
apm$height <- paste(
	gsub("-","'",apm$height),
	"''",sep='')
