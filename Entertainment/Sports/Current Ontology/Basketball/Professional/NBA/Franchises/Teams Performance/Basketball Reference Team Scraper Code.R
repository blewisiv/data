#Basketball ReferenceScraper for All Teams in 1 Data Frame

library(RCurl)
library(XML)

#Website #stem
stem <- "http://www.basketball-reference.com/teams/"
#Convert the site into parsed HTML as text
teams <- htmlParse(getURL(stem), asText=T)
#Look for attributes containing @href/teams and extract those as team
teams <- xpathSApply(teams,"//*/a[contains(@href,'/teams/')]", xmlAttrs)[-1]
#extract the /teams to get just names
teams <- gsub("/teams/(.*)/", "\\1", teams)
urls <- paste0(stem, teams)

names(teams) <- NULL   # get rid of the "href" labels
#change nameof url to teams
names(urls) <- teams

#Create a data frame with all the results

results <- data.frame() #create blank data table
#loop
for(team in teams){
  tables <- readHTMLTable(urls[team])
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  team.results <- tables[[which.max(n.rows)]] 
  write.csv(team.results, file=paste0(team, ".csv"))
  team.results$TeamCode <- team
  results <- rbind(results, team.results)
  rm(team.results, n.rows, tables)
}
rm(stem, team)

write.csv(results, file="AllTeams.csv")