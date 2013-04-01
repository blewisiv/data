#SI Photo Model Links
#Use apply rather than nested loops
si.swimsuit.urls <- unlist( apply( data , 1 , function(x) { i <- 1:x[2]; paste( x[1] , i , x[3] , sep ="/") } ) )
stems<-data.frame(si.swimsuit.urls)
stems$si.swimsuit.urls<-gsub(" ","",stems$si.swimsuit.urls)
write.csv(stems,"All Sports Illustrated Swimsuit URLS 1996-2012.csv")