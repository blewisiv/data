library(XML)
library(RCurl)
library(stringr)
library(reshape2)
options(stringsAsFactors=F)

ussr <- read.csv(list.files()[2])
urls <- ussr[,c('country_url')]
countries <- ussr[,c('country')]
names(urls) <- countries

former_ussr_performance_by_games <- data.frame()
for(country in countries){
tables <- readHTMLTable(urls[country],header=T)	
table <- data.frame(tables)
table$country_url <- urls[country]
table$country <- names(urls[country])
table$table_name <-'country_medals'
names(table) <- tolower(gsub('medals.','',names(table)))
page <- htmlParse(getURL(urls[country]),error=function(...){})
names <- xpathSApply(page,"//*/td/a[contains(@href,'/olympics/countries/')]",xmlValue)
links <- xpathSApply(page,"//*/td/a[contains(@href,'/olympics/countries/')]",xmlAttrs)
u <- paste("http://www.sports-reference.com",links,sep='')
olympic_years_urls <- data.frame(games = names, country_games_url = u)
merged_table <- merge(table,olympic_years_urls)
former_ussr_performance_by_games <- rbind(former_ussr_performance_by_games,merged_table)
rm(table,page,names,links,u,olympic_years_urls,merged_table)
}
former_ussr_performance_by_games <- cbind(former_ussr_performance_by_games,colsplit(former_ussr_performance_by_games$games,"\\ ",c('year','olympic_games')))
write.csv(former_ussr_performance_by_games,'former_ussr_bloc_medals_by_games.csv')


