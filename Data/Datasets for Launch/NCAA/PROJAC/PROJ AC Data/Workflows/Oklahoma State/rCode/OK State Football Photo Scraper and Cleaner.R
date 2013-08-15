#OKState Image Scraper

library(XML)
library(RCurl)

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/NCAA/PROJAC/PROJ AC Data/Workflows/Oklahoma State/Output/Data/Players")
ok.state <- read.csv(list.files()[4])
ok.state <- ok.state[!is.na(ok.state$URL),]
ok.urls <- ok.state[!is.na(ok.state$URL),c('Player','URL')]
as.character(ok.urls$URL)[10]
urls <- as.character(ok.urls$URL)
url <- urls[19]
page <- htmlParse(getURL(url), asText=T)
pic <- xpathApply(page,"/*//img[@id='player-photo']/@src")


write.csv(allpics,"All SI Image URLS.csv")



pics<-list()
for(i in urls){
	player.page<-htmlParse(getURL(i), asText=T)
	pics[i]<-xpathSApply(player.page,"/*//img[@id='player-photo']/@src")
}
pics<-as.matrix(pics)
names(pics)[1] <- 'player_imageurl'
write.csv(pics,"OK State Football Player Pics.csv")

pics<-read.csv(list.files()[3])
okstate<-read.csv(list.files()[5])
ok.state<-merge(okstate,pics,all.x=T)
ok.state.final<-ok.state[,c(2:5,1,34,6:33)]
write.csv(ok.state.final,'Unique Players Since 2005.csv')