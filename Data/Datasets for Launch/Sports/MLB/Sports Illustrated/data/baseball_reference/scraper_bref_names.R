library(XML)
library(RCurl)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/data/baseball_reference")
players <- unique(all_5_year_contracts$player)
players
dictonary <- paste('http://www.baseball-reference.com/players/',letters,'/',sep='')
u <- dictonary[-24]
final_results <- data.frame()
for(i in 1:length(u)){
page <- htmlParse(getURL(u[i]),error=function(...){})
names <- 
		xpathSApply(page,"//*//a[contains(@href,'/players/')]",xmlValue)
stems <- 
		xpathSApply(page,"//*//a[contains(@href,'/players/')]",xmlAttrs)
page_url <- 'http://www.baseball-reference.com'
urls <- paste(page_url,stems,sep='')
results <- data.frame(player = names, player_bref_url = urls)
results$bref_directory_url <- u[i]
final_results <- rbind(results,final_results)
rm(names)
rm(stems)
rm(urls)
rm(page)
}

rm(all_data)
final_results <-
	final_results[!final_results$player_bref_url == 'http://www.baseball-reference.com/players/',]

write.csv(final_results,'baseball_reference_player_directory.csv')
