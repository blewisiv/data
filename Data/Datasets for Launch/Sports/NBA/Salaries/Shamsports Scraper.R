## shamsports data
library(XML)
library(RCurl)
library(reshape2)
library(stringr)
library(dplyr)

# returns string w/o leading whitespace
trim.leading <- function (x)  sub("^\\s+", "", x)

# returns string w/o trailing whitespace
trim.trailing <- function (x) sub("\\s+$", "", x)

# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
tables <- readHTMLTable(urls[1],skip.rows=1,)

nba_franchises <- read.csv("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NBA/Franchises/nba_franchises.csv")
active <- nba_franchises[nba_franchises$active==T,]

sham <- active[,c(5,15)]
sham$shamsports_salary_url <- as.character(sham$shamsports_salary_url)
row.names(sham) <- sham$name
sham
urls <- sham$shamsports_salary_url
names(urls) <- as.character(sham$name)
urls
teams <- as.character(sham$name)
u <- as.character(urls[2])
t <- readHTMLTable(u)
t[11]

salaries <- data.frame() #create blank data table
#loop
for(team in teams){
  tables <- readHTMLTable(urls[team],skip.rows=1,trim=T)
  team.salaries <- tables[[9]] 
  team.salaries$Team <- team
  salaries <- rbind(salaries, team.salaries)
  rm(team.results, tables)
}

names(salaries)[1:9] <- c('player','2013_2014','2014_2015','2015_2016','2016_2017','2017_2018','2018_2019','total','team')
names(salaries)
salaries <- salaries[!grepl("Total ",x=as.character(salaries$player)),]
salaries$player <- gsub(" \r\n     ","",as.character(salaries$player))
salaries$player_off_roster <- grepl("\\*",salaries$player)
salaries$player <- str_trim(gsub("[\\*]","",salaries$player))
write.csv(salaries, file="All NBA Salaries 13-17 Table.csv")
salaries <- data.frame(read.csv(list.files()[1]),stringsAsFactors=F)
salaries$total<-NULL
salaries.melt <- melt(data=salaries,id.vars=c(names(salaries)[1:3]),na.rm=T,value.name=c('salary'))
names(salaries.melt)[4] <- c('season')
salaries.melt <- salaries.melt[order(salaries.melt$team,decreasing=T),]
write.csv(salaries.melt,'NBA Player Salaries List 2013-2019.csv')

capholds <- data.frame() #create blank data table
#loop
for(team in teams){
  tables <- readHTMLTable(urls[team],skip.rows=1,trim=T)
  team.capholds <- tables[[11]] 
  team.capholds$Team <- team
  capholds <- rbind(capholds, team.capholds)
  rm(team.capholds, tables)
}

names(capholds)[1:9] <- c('player','2013_2014','2014_2015','2015_2016','2016_2017','2017_2018','2018_2019','total','team')
names(salaries)
capholds <- capholds[!grepl("Total ",x=as.character(capholds$player)),]
capholds$player <- gsub(" \r\n     ","",as.character(capholds$player))

salaries$player_off_roster <- grepl("\\*",salaries$player)
salaries$player <- str_trim(gsub("[\\*]","",salaries$player))
write.csv(salaries, file="All NBA Salaries 13-17 Table.csv")
salaries <- data.frame(read.csv(list.files()[1]),stringsAsFactors=F)
salaries$total<-NULL
salaries.melt <- melt(data=salaries,id.vars=c(names(salaries)[1:3]),na.rm=T,value.name=c('salary'))
names(salaries.melt)[4] <- c('season')
salaries.melt <- salaries.melt[order(salaries.melt$team,decreasing=T),]
write.csv(salaries.melt,'NBA Player Salaries List 2013-2019.csv')
