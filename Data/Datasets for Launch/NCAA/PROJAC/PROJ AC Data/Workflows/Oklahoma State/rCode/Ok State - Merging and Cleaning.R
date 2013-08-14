#Oklahoma State Roster Merging
setwd(dir='/Users/alexbresler/Desktop/Github/Aragorn/data/Data/Datasets for Launch/NCAA/PROJAC/PROJ AC Data/Workflows/Oklahoma State/Rosters')
library(ggmap)
library(Kmisc)
library(data.table)
library(plyr)
library(gdata)
roster_all_data = ldply(list.files(pattern = "csv"), function(fname) {
	dum = read.csv(fname)
	dum$fname = fname  # adds the filename it was read from as a column
	return(dum)
})


names(roster_all_data)
ok.state<-remove.vars(roster_all_data,c('X','fname','Position','First_Year','Prior_College','Hometown','City','State','URL',"High_School","Last_Name","First_Name",'Sport','School_ID'))

d<-merge(ok.state,players,all.x=T,by='Player')

t<-unique(d[,c('Player','Height_Inches')])
test<-unique(subset(test, Weight==ave(Weight, Player, FUN=max)))
q<-unique(subset(t, Height_Inches==ave(Height_Inches, Player, FUN=max)))
p<-merge(q,test)
z<-merge(p,players,all.x=T)
z$Height_Numeric<-round(z$Height_Inches*0.0833333,3)
names(cip)
codes<-cip[,c(2:5,8)]
names(codes)[3]<-c('CIP_Code')
z<-merge(z,codes,all.x=T)
all<-merge(z,codes,all.x=T)

write.csv(q,'Unique Players Since 2005.csv')
q<-merge(p,dt,all.x=T)
q<-q[!is.na(q$URL),]
names(q)

races<-count(q,c('ID_Race'))
races<-races[order(races$freq,decreasing=T),]
races
write.csv(races,'Players by Race.csv')

races.position<-count(q,c('ID_Race','Position'))
races.position<-races.position[order(races.position$freq,decreasing=T),]
races.position
write.csv(races.position,'Players by Race and Position.csv')

names(q)
majors<-count(q,c('ID_Race','Position'))
races.position<-races.position[order(races.position$freq,decreasing=T),]
races.position
write.csv(races.position,'Players by Race and Position.csv')


race.state<-count(q,c('State','ID_Race'))
race.state<-race.state[order(race.state$freq,decreasing=T),]
head(race.state)
write.csv(race.state,'Players by Race and State.csv')

race.state.city<-count(q,c('State','City','ID_Race'))
race.state.city<-race.state.city[order(race.state.city$freq,decreasing=T),]
head(race.state.city)
write.csv(race.state.city,'Players by Race, City and State.csv')


race.state.city.position<-count(q,c('State','City','Position','ID_Race'))
race.state.city.position<-race.state.city.position[order(race.state.city.position$freq,decreasing=T),]
head(race.state.city.position)
write.csv(race.state.city.position,'Players by Race, City, State, and Position.csv')

race.state.position<-count(q,c('State','Position','ID_Race'))
race.state.position<-race.state.position[order(race.state.position$freq,decreasing=T),]
head(race.state.position)
write.csv(race.state.position,'Players by Race, State, Position.csv')

library(dplyr)
library(plyr)
names(p.data)
p.data<-q[!is.na(q$CIP_ID),]

majors<-count(p.data,c('Stated_Major','CIP_ID'))
majors<-majors[order(majors$freq,decreasing=T),]
write.csv(majors,'Stated Majors.csv')

majors.year<-count(p.data,c('Stated_Major','CIP_ID','Graduation_Year'))
majors.year<-majors.year[order(majors.year$freq,decreasing=T),]
head(majors.year,n=15)
write.csv(majors.year,'Stated Majors by Year.csv')

majors.position<-count(p.data,c('Stated_Major','CIP_ID','Position'))
majors.position<-majors.position[order(majors.position$freq,decreasing=T),]
head(majors.position,n=15)
write.csv(majors.position,'Stated Majors by Position.csv')

majors.race<-count(p.data,c('Stated_Major','CIP_ID','ID_Race'))
majors.race<-majors.race[order(majors.race$freq,decreasing=T),]
majors.race
write.csv(majors.race,'Stated Majors by Race.csv')

majors.position.race<-count(p.data,c('Stated_Major','CIP_ID','Position','ID_Race'))
majors.position.race<-majors.position.race[order(majors.position.race$freq,decreasing=T),]
head(majors.position.race,n=15)
write.csv(majors.position,'Stated Majors by Race and Position.csv')


majors.position.race.year<-count(p.data,c('Stated_Major','CIP_ID','Position','ID_Race','Graduation_Year'))
majors.position.race.year<-majors.position.race.year[order(majors.position.race.year$freq,decreasing=T),]
head(majors.position.race.year,n=15)
write.csv(majors.position,'Stated Majors by Race, Position and Year.csv')