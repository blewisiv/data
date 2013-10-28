#SI Olympic Story
library(XML)
library(RCurl)
library(data.table)

countries <- c('Armenia', 'Azerbaijan','Belarus','Estonia','Georgia','Kazakhstan','Kyrgyzstan','Latvia','Lithuania','Moldova','Russia','Tajikistan','Turkmenistan','Ukraine','Uzbekistan')
readHTMLTable("http://www.sports-reference.com/olympics/countries/AZE/summer/2012/")
url <- "http://www.sports-reference.com/olympics/countries/"
	page <- htmlParse(getURL(url),error=function(...){})

names <- xpathSApply(page,"//td/a/text()",xmlValue) 
stems <- 
		xpathSApply(page,"//*/td/a", xmlAttrs)
page <- 'http://www.sports-reference.com'
urls <- paste(page,stems,sep='')

olympic_urls <- data.frame(country = names, country_url = urls)
tables <- readHTMLTable(url,header=T,trim=T,as.data.frame=T)
table <- data.frame(tables)
skip <- "Summer Games"
skip2 <- 'Rk'

table <- table[!table$countries.Country %in% skip,]
table <- table[!table$countries.Country %in% skip2,]
names(table) <- 
		tolower(gsub("countries.","",names(table)))
names(table) <- gsub(".1","_winter_games",names(table))
names(table)[3:10] <- paste(names(table)[3:10],'_summer_games',sep='')
merged_olympic_table <-
		merge(table,olympic_urls,by='country')
table$table_name <- 'country_summary'
former_ussr_bloc <- merged_olympic_table[merged_olympic_Table$country %in% countries,]
write.csv(merged_olympic_table,'all_olympic_summary_data_by_country.csv')
write.csv(former_ussr_bloc,'former_ussr_bloc_summary_data.csv')
