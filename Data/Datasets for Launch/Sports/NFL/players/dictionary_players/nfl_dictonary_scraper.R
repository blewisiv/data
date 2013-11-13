library(XML)
library(RCurl)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/players/dictionary_players")
football_dictonary <- 
	paste('http://www.pro-football-reference.com/players/',toupper(letters),'/',sep='')
u <- 
	football_dictonary[2:26]
final_results <- data.frame()
for(i in 1:length(u)){
page <- htmlParse(getURL(u[i]),error=function(...){})
names <- 
		xpathSApply(page,"//*//a[contains(@href,'/players/')]",xmlValue)
stems <- 
		xpathSApply(page,"//*//a[contains(@href,'/players/')]",xmlAttrs)
page_url <- 'http://www.pro-football-reference.com'
urls <- 
		paste(page_url,stems,sep='')
results <- 
		data.frame(player = names, player_bref_url = urls)
results$bref_directory_url <- u[i]
final_results <- rbind(results,final_results)
rm(names)
rm(stems)
rm(urls)
rm(page)
rm(results)
}

rm(all_data)
f <-
	final_results[!final_results$player_bref_url == 'http://www.pro-football-reference.com/players/',]

ignore <- 
	p[1:2,2]
for(i in ignore){
	p <- p[!grepl(i,p$player_bref_url),]
}
write.csv(p,'nfl_player_dictonary.csv')
p <- read.csv(list.files()[1])
