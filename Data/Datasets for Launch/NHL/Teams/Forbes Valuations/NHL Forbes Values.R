library(XML)
url12 <- 'http://www.forbes.com/nhl-valuations/list/'
table <- readHTMLTable(url12)
table
tables12 <- data.frame(table)
names(tables12) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables12$year <- 2012

url11 <- 'http://web.archive.org/web/20111202142604/http://www.forbes.com/nhl-valuations/list'
table <- readHTMLTable(url11)
table
tables11 <- data.frame(table[4])
names(tables11) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables11$year <- 2011

url10<-'http://www.forbes.com/lists/2010/31/hockey-valuations-10_land.html'
table <- readHTMLTable(url10)
tables10 <- data.frame(table)
names(tables10) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables10$year <- 2010

url09<-'http://www.forbes.com/lists/2009/31/hockey-values-09_NHL-Team-Valuations_Rank.html'
table <- readHTMLTable(url09)
tables09 <- data.frame(table[1])
names(tables09) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables09$year <- 2009
tables09<-tables09[-1,]

url08 <-'http://www.forbes.com/lists/2008/31/nhl08_NHL-Team-Valuations_Rank.html'
table <- readHTMLTable(url08)
table[8]
tables08 <- data.frame(table[8])
names(tables08) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables08$year <- 2008
tables08 <- tables08[-1,]