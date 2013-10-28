#Prosports Transaction Scraper
library(XML)
library(RCurl)
library(reshape)

base<-"http://www.prosportstransactions.com/baseball/Search/"
url<-"http://www.prosportstransactions.com/baseball/Search/SearchResults.php?Player=&Team=&BeginDate=1990-08-01&EndDate=&PlayerMovementChkBx=yes&submit=Search&start=0"

url_page<-htmlParse(getURL(url), asText=T)

urls <- xpathSApply(url_page,"//*/a[contains(@href,'SearchResults.php')]", xmlAttrs)[-1]

urls <- paste0(base,urls)
urls <- data.frame(urls)

names(urls)[1] <-"url"

results_1 <- data.frame()
table <- readHTMLTable(url,skip.rows=1,trim=T)
d <- data.frame(table[1])
d$url <- url
results_1 <- rbind(d,results_1)
u <- as.character(urls[,])

final_results <- data.frame()
u_15 <- u[1:15]
u_rest <-
	u[3437:3679]



results <- data.frame()
for(i in final_u) {
table <- readHTMLTable(i,skip.rows=1,trim=T)
d <- data.frame(table[1])
d$url <- i
results <- rbind(d,results)
rm(d)
rm(table)
}
final_results <- rbind(final_results,results)

names(final_results)[1:5] <- c('date','team','acquired','relinquished','notes')
write.csv(final_results,'transacations_since_1975.csv')

