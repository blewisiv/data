#Prosports Transaction Scraper
library(XML)
library(RCurl)
library(reshape)
base<-"http://www.prosportstransactions.com/basketball/Search/"
url<-"http://www.prosportstransactions.com/basketball/Search/SearchResults.php?Player=&Team=&BeginDate=&EndDate=&PlayerMovementChkBx=yes&ILChkBx=yes&NBADLChkBx=yes&InjuriesChkBx=yes&PersonalChkBx=yes&DisciplinaryChkBx=yes&LegalChkBx=yes&submit=Search"
url<-htmlParse(getURL(url), asText=T)
url<-xpathSApply(url,"//*/a[contains(@href,'SearchResults.php')]", xmlAttrs)[-1]
urls<-paste0(base,url)
urls<-data.frame(urls)
names(urls)[1]<-"url"

u<-as.character(urls[,])
results<-data.frame()
for(i in u){
table<-readHTMLTable(i)
table<-table[1]
d<-data.frame(table)
d<-d[-1,]
results<-rbind.fill(results,d)
}