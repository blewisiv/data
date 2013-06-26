library(RCurl)
library(XML)
bama<-as.character(bcs12$Roster12_URL[1])
tables<-readHTMLTable(bama,skip.rows=1)
names(tables)
bamaroster<-data.frame(tables["sortable_roster"],stringsAsFactors=F)
names(bamaroster)<-gsub("sortable_roster.","",names(bamaroster))
i <- sapply(bamaroster, is.factor)
bamaroster[i] <- lapply(bamaroster[i], as.character)
bamaroster$Season<-"2012-2013"
bamaroster$Last.Name<-NULL
bamaroster$DBPediaCollege_Name<-"Alabama University"
write.csv(bamaroster,"2012-13 University of Alabama Football Roster.csv")