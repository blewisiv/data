names(medals_games)
countries_years_games <- unique(medals_games[,c('year','games','country','country_games_url')])
countries_years_games$name <- paste(countries_years_games$country,countries_years_games$year,countries_years_games$games,sep="_")
countries_years <- countries_years_games$name
urls <- countries_years_games$country_games_url
names(urls) <- countries_years

athletes <- data.frame()
for(country in countries_years){
tables <- readHTMLTable(urls[country])
table <- data.frame(tables['athletes'])
table$country_year_url <- urls[country]
table$country_year <- names(urls[country])
table$table_name <-'country_athlete_games'
names(table) <- tolower(gsub('athletes.','',names(table)))
page <- htmlParse(getURL(urls[country]),error=function(...){})
names <- xpathSApply(page,"//*/td/a[contains(@href,'/olympics/athletes/')]",xmlValue)
links <- xpathSApply(page,"//*/td/a[contains(@href,'/olympics/athletes/')]",xmlAttrs)
u <- paste("http://www.sports-reference.com",links,sep='')
athlete_years_urls <- data.frame(athlete = names, athlete_url = u)
merged_table <- merge(table,athlete_years_urls)
athletes <- rbind(athletes,merged_table)
rm(table,page,names,links,u,athlete_years_urls,merged_table)
}
athletes$games <- athletes$country_year_url
gsub("http://www.sports-reference.com/olympics/countries/","",athletes$games)
athletes$games <- gsub("http://www.sports-reference.com/olympics/countries/","",athletes$games)
colsplit(games,"/",c('country_code','game_code','year_code'))
colsplit(athletes$games,"[/]",c('country_code','game_code','year_code'))
cbind(athletes,colsplit(athletes$games,"[/]",c('country_code','game_code','year_code')))
athletes <- cbind(athletes,colsplit(athletes$games,"[/]",c('country_code','game_code','year_code')))
athletes$games <- NULL
athletes$olympic_games <- NULL
gsub("[/]","",athletes$year_code)
as.numeric(gsub("[/]","",athletes$year_code))
athletes$year_code <- as.numeric(gsub("[/]","",athletes$year_code))
athletes$athlete <- athletes$athlete_url
gsub('http://www.sports-reference.com/olympics/athletes/',"",athletes$athlete)
athletes$athlete <- gsub('http://www.sports-reference.com/olympics/athletes/',"",athletes$athlete)
cbind(athletes,colsplit(athletes$athlete,"[/]",c('name_code','name_link')))
athletes <- cbind(athletes,colsplit(athletes$athlete,"[/]",c('name_code','name_link')))
cbind(athletes,colsplit(athletes$name_link,"[-]",c('first_name','last_name','html')))
athletes <- cbind(athletes,colsplit(athletes$name_link,"[-]",c('first_name','last_name','html')))
athletes$html <- NULL
athletes$name_code <-NULL
athletes$name_link <- NULL
athletes$games <- athletes$country_year_url
gsub("http://www.sports-reference.com/olympics/countries/","",athletes$games)
athletes$games <- gsub("http://www.sports-reference.com/olympics/countries/","",athletes$games)
colsplit(athletes$games,"/",c('country_code','game_code','year_code'))
colsplit(athletes$games,"[/]",c('country_code','game_code','year_code'))
cbind(athletes,colsplit(athletes$games,"[/]",c('country_code','game_code','year_code')))
athletes <- cbind(athletes,colsplit(athletes$games,"[/]",c('country_code','game_code','year_code')))
athletes$games <- NULL
athletes$olympic_games <- NULL
gsub("[/]","",athletes$year_code)
as.numeric(gsub("[/]","",athletes$year_code))
athletes$year_code <- as.numeric(gsub("[/]","",athletes$year_code))
write.csv(athletes,'all_ussr_bloc_athletes_games.csv')
