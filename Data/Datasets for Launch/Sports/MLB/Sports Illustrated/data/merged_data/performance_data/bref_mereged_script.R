#get fed data
fed_url <- 'http://www.minneapolisfed.org/community_education/teacher/calc/hist1800.cfm'
fed_tables <- readHTMLTable(fed_url)
inflation_tables <- data.frame(fed_tables[1])
inflation_tables <- 
	data.frame(inflation_tables[3:215,1:2])
names(inflation_tables) <- c('year','cpi_index')
inflation_tables$year <- gsub('\\*','',inflation_tables$year)
cols <- inflation_tables[,1:2]
inflation_tables[,1:2] = apply(inflation_tables[,1:2], 2, function(x) as.numeric((x)))
inflation_tables$inflator_2013 <- 701.5/inflation_tables$cpi_index
inflation_tables$cpi_index <- NULL




setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Sports Illustrated/data/merged_data/player_index")
player_contract_index <- read.csv(list.files()[2])
player_contract_index <- player_contract_index[,c(2,13,14,3:12,15)]
urls <- unique(a$player_bref_url)
players <- unique(a$player)
players <- players[1:148]
urls <- urls[1:150]
names(urls) <- players

players_positions <- data.frame()
for(player in players){
page <- htmlParse(getURL(urls[player]),error=function(...){})
position <- xpathSApply(page,"//*//p/span[@itemprop='role']",xmlValue)
table <- data.frame(position = position)
table$player <- player
players_positions <- rbind(players_positions,table)
rm(table)
rm(page)
rm(position)
}


attach(players_positions)
players_positions$position <- gsub(" and ",", ",players_positions$position)
merged_contracts <- 
	merge(a,players_positions)
write.csv(merged_contracts,'all_5_year_contracts_no_minors.csv')

match('Drew Henson',merged_contracts$player)
merged_contracts <- merged_contracts[-72,] #remove Drew Henson
pitchers <- 
	unique(merged_contracts[grepl("Pitcher",merged_contracts$position),c('player','player_bref_url')])
hitters <- 
	unique(merged_contracts[!grepl("Pitcher",merged_contracts$position),c('player','player_bref_url')])

salaries_table <- data.frame()
batting_table <- data.frame()
players <- hitters$player
urls <- hitters$player_bref_url
names(urls) <- players

for(player in players){
tables <- readHTMLTable(urls[player],header=F,trim=T)
batting_data <- data.frame(tables[match('batting_value',names(tables))])
batting_data$player <- player
batting_table <- rbind(batting_table,batting_data)
salary_data <- data.frame(tables['salaries'],stringsAsFactors=F)
salary_data$player <- player
salaries_table <- rbind(salary_data,salaries_table)
rm(salary_data)
rm(batting_data)
}
salaries_table$table_name <- 'salaries'
batting_table$table_name <- 'batting value'

names(salaries_table) <- 
	gsub("salaries.",'',names(salaries_table))
names(salaries_table)[1:6] <- 
	c('year','age','team','salary','sources','notes_other')
salaries_table <- 
	salaries_table[!salaries_table$year %in% 'Year',]
salaries_table <- 
	salaries_table[!salaries_table$year %in% '',]
salaries_table <- 
	salaries_table[!salaries_table$year %in% '2013 Status',]
salaries_table <- 
	salaries_table[!grepl('Career ',salaries_table$year),]

names(batting_table)[1:24] <- 
	c("year","age", "tm", "lg","g", "pa", "rbat","rbaser","rdp", "rfield", "rpos","raa", "waa", "rrep","rar", "war", "waawl." , "X162wl.", "owar","dwar","orar","salary","pos", "awards")
batting_table <- 
	batting_table[!batting_table$year %in% '',]
players_positions <- m_c[,c('player','position','player_bref_url')]



batting_table$disputed_salary <-
	grepl("\\*",batting_table$salary)
batting_table$salary <- 
	gsub("\\*","",batting_table$salary)
batting_table$salary <- 
	gsub("\\$","",batting_table$salary)
batting_table$salary <- 
	gsub("\\,","",batting_table$salary)
batting_table$salary <- 
	as.numeric(batting_table$salary)
batting_table <- 
	merge(batting_table,inflation_tables)
batting_table$salary_2013 <- 
	batting_table$salary * batting_table$inflator_2013
batting_table[,c('salary','salary_2013')] <- 
	round(
	batting_table[,c('salary','salary_2013')]/1000000,digits=3
	)
batting_table$inflator_2013 <- NULL
names(batting_table)
cols <- c(2,5:22,28)
batting_table[,cols] = 
	apply(batting_table[,cols], 2, function(x) as.numeric((x)))
names(batting_table)
batting_table <- 
	batting_table[,c(2,1,3:5,26,25,22,29,23,29,6:21,24,27)]

b <- 
	merge(batting_table,teams_ids,all.x=T)

players_positions <- merged_contracts[,c('player','position')]
players_urls <- merged_contracts[,c('player','player_bref_url')]
test <- merge(b,players_positions)
test <- unique(test)
test <- merge(test,players_urls,all.x=T)
test <- unique(test)
names(b)[2] <- 'season'
write.csv(b,'all_5_year_contract_non_pitchers.csv')

names(merged_contracts)[4] <- 'pst_team'

pitching_salaries_table <- data.frame()
pitching_table <- data.frame()
players <- pitchers$player
urls <- pitchers$player_bref_url
names(urls) <- players
for(player in players){
tables <- readHTMLTable(urls[player],header=F,trim=T)
pitching_salary_data <- data.frame(tables['salaries'],stringsAsFactors=F)
pitching_salary_data$player <- player
pitching_salaries_table <- rbind(pitching_salary_data,pitching_salaries_table)	
pitching_data <- data.frame(tables[match('pitching_value',names(tables))])
pitching_data$player <- player
pitching_table <- rbind(pitching_table,pitching_data)
rm(pitching_data)
}

pitching_salaries_table$table_name <- 'salaries'
pitching_table$table_name <- 'pitching value'
names(pitching_salaries_table) <- gsub("salaries.",'',names(pitching_salaries_table))
names(pitching_salaries_table)[1:6] <- c('year','age','team','salary','sources','notes_other')
pitching_salaries_table <- 
	pitching_salaries_table[!pitching_salaries_table$year %in% '',]
pitching_salaries_table <- pitching_salaries_table[!pitching_salaries_table$year %in% 'Year',]
pitching_salaries_table <- pitching_salaries_table[!pitching_salaries_table$year %in% '',]
pitching_salaries_table <- pitching_salaries_table[!pitching_salaries_table$year %in% '2013 Status',]
pitching_salaries_table <- pitching_salaries_table[!grepl('Career ',pitching_salaries_table$year),]

pitching_table <- 
	pitching_table[!pitching_table$pitching_value.V1 %in% '',]

names(pitching_table)[1:24] <- 
	c("year","age", "tm", "lg",'ip',"g", "gs", "r","ra9","ra9opp", "ra9def", "ra9role","ppfp", "ra9avg", "raa","waa", "gmli", "waaadj" , "war", "rar","waawl","wl162",'salary',"awards")
pitching_table <- 
	merge(pitching_table,
		merged_contracts[,c('player','position','player_bref_url')])

pitching_table$disputed_salary <-
	grepl("\\*",pitching_table$salary)
pitching_table$salary <- 
	gsub("\\*","",pitching_table$salary)
pitching_table$salary <- 
	gsub("\\$","",pitching_table$salary)
pitching_table$salary <- 
	gsub("\\,","",pitching_table$salary)
pitching_table$salary <- 
	as.numeric(pitching_table$salary)
pitching_table <- 
	merge(pitching_table,inflation_tables)
pitching_table$salary_2013 <- 
	pitching_table$salary * pitching_table$inflator_2013
pitching_table[,c('salary','salary_2013')] <- 
	round(
	pitching_table[,c('salary','salary_2013')]/1000000,digits=3
	)
pitching_table$inflator_2013 <- NULL
names(pitching_table)
cols <- c(2,5:23,28)
pitching_table[,cols] = 
	apply(pitching_table[,cols], 2, function(x) as.numeric((x)))

pitching_table <- 
	pitching_table[,c(2,1,4:5,27,24,30,25,6:23,28,26)]
pitching_table <- 
	merge(pitching_table,teams_ids,all.x=T)
pitching_table$X <- NULL
players <- read.csv(list.files()[4])
p <- merge(pitching_table,players_urls,all.x = T)
p <- unique(p)
p <- merge(pitching_table,players_positions,all.x = T)
p <- unique(p)
names(p)[3] <- 'season'
cols <- c(4,6:24,28)
names(p)
p[,cols] = 
	apply(p[,cols], 2, function(x) as.numeric((x)))
write.csv(p,'all_5_year_contract_pitchers.csv')

all_salary_data <- 
	rbind(pitching_salaries_table,salaries_table)

names(all_salary_data)
all_salary_data <- 
	all_salary_data[,c(7,1:6,8)]
all_salary_data <- 
		merge(all_salary_data,merged_contracts[,c('player','position','player_bref_url')])
all_salary_data$disputed_salary <-
	grepl("\\*",all_salary_data$salary)
all_salary_data$salary <- 
	gsub("\\*","",all_salary_data$salary)
all_salary_data$salary <- 
	gsub("\\$","",all_salary_data$salary)
all_salary_data$salary <- 
	gsub("\\,","",all_salary_data$salary)
all_salary_data$salary <- as.numeric(all_salary_data$salary)
all_salary_data <- merge(all_salary_data,inflation_tables)
all_salary_data$salary_2013 <- 
	all_salary_data$salary * all_salary_data$inflator_2013
all_salary_data[,c('salary','salary_2013')] <- round(
	all_salary_data[,c('salary','salary_2013')]/1000000,digits=3
	)
names(all_salary_data)
all_salary_data <- 
	all_salary_data[,c(1:2,9,3:5,13,6:8,10:11)]
names(all_salary_data)[6:7] <- 
	paste(names(all_salary_data)[6:7],"_millions",sep='')

names(all_salary_data)[1] <- 'season'

names <- merge(ab,ac)
names <- names[order(names$team, decreasing = T),]
a <- 
	names(all_salary_data)
	a <- merge(all_salary_data,years,all.x=T,by = c('team','year'))
teams <- all_salary_data$team
teams <- unique(teams[order(teams,decreasing=F)])
ids <- teams_ids$tm
ids <- ids[-31]

ids <- teams_ids$tm
ids <- ids[-31]

length(ids)
team_id <- 
	data.frame( team = teams, tm = ids)
a <- merge(all_salary_data,team_id)


all_salary_data <- read.csv(list.files()[3])
t <- merge(all_salary_data,teams_ids, all.x=T)

names <- t[, c('pst_team','season','tm','team')]
names <- unique(names)
m <- merge(merged_contracts,names,all.x=T)
m <- unique(m)
write.csv(m,'test.csv')
missing <- m[is.na(m$tm),]

missing$tm <- NULL
missing$team <- NULL
tms <- unique(t[,c('pst_team','season','tm')])
tms <- tms[order(tms$tm,decreasing=F),]
miss <- merge(missing,tms[,c('pst_team','tm')],all.x=T)
miss <- unique(miss)
