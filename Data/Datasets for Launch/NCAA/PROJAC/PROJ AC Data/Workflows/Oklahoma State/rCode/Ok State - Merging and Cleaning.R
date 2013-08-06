#Oklahoma State Roster Merging
setwd(dir='/Users/alexbresler/Desktop/Github/Aragorn/data/Data/Datasets for Launch/NCAA/PROJAC/PROJ AC Data/Workflows/Oklahoma State/Rosters')
library(plyr)
library(gdata)
roster_all_data = ldply(list.files(pattern = "csv"), function(fname) {
	dum = read.csv(fname)
	dum$fname = fname  # adds the filename it was read from as a column
	return(dum)
})
names(roster_all_data)
ok.state<-remove.vars(roster_all_data,c('X','fname','Position','URL','Height','Weight','First_Year','Height_Inches','Class','Number','Year','Prior_College'))

players<-players.urls[!is.na(players.urls$URL),]
p<-merge(players,ok.state,all.x=T)
p$High_School<-gsub(" HS","",p$High_School)
merge(unique(p$Player),p,all.x=T,all.y=F)
names(players)

