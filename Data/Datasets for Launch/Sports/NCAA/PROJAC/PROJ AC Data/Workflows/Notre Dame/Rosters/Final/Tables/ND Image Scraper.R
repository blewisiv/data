library(XML)
library(RCurl)

setwd("~/Desktop/Github/Aragorn/AragornData/Categories/Data/Datasets for Launch/NCAA/PROJAC/PROJ AC Data/Workflows/Notre Dame/Rosters")
nbp<-read.csv(list.files()[1])
as.character(nbp$Player_URL)
urls<-as.character(nbp$Player_URL)
url<-urls[19]
page<-htmlParse(getURL(url), asText=T)
pic<-xpathApply(page,"/*//img[@id='player-photo']/@src")


write.csv(allpics,"All SI Image URLS.csv")



pics<-list()
for(i in urls){
	player.page<-htmlParse(getURL(i), asText=T)
	pics[i]<-xpathSApply(player.page,"/*//img[@id='player-photo']/@src")
}
pics<-as.matrix(pics)
names(pics)[1]<-'Player_Image_URL'
write.csv(pics,"ND Football Player Pics.csv")

