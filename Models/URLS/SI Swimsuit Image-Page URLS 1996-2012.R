library(XML)
library(RCurl)
urls<-as.character(urls[1:319,])
pics<-list()
for(i in urls){
	model.page<-htmlParse(getURL(i), asText=T)
	pics[i]<-xpathSApply(model.page,"//div/div/a/img/@src")
}
pics<-as.matrix(pics)
write.csv(pics,"Pics.csv")
search()
url<-"http://sportsillustrated.cnn.com/vault/swimsuit/modelfeatured/elsa_benitez/2006/allstar/1/13"
page<-htmlParse(getURL(url), asText=T)
pic<-xpathSApply(page,"//div/div/a/img/@src")
pic<-as.matrix(pic)
allpics<-rbind(pics1,pics2,pics3,pics4,pics5,pics6,pics7,pics8,pics9,pics10,pics11,pics12,pics13,pics14)
pics<-allpics[duplicated(allpics),]
write.csv(allpics,"All SI Image URLS.csv")