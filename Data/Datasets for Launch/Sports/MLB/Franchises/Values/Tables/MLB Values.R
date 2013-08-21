#MLB
library(XML)


url13 <- 'http://www.forbes.com/mlb-valuations/list/'
table <- readHTMLTable(url13)
table
tables13 <- data.frame(table)
names(tables13) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables13$year <- 2013


url12 <- 'http://web.archive.org/web/20120429121442/http://www.forbes.com/mlb-valuations/list/'
table <- readHTMLTable(url12)
table[4]
tables12 <- data.frame(table[4])
names(tables12) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables12$year <- 2012

url11 <- 'http://www.forbes.com/lists/2011/33/baseball-valuations-11_rank.html'
table <- readHTMLTable(url11)
table
tables11 <- data.frame(table[1])
names(tables11) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables11$year <- 2011

url10<-'http://www.forbes.com/lists/2010/33/baseball-valuations-10_The-Business-Of-Baseball_Rank.html'
table <- readHTMLTable(url10)
tables10 <- data.frame(table[1])
names(tables10) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables10$year <- 2010
tables10 <- tables10[-1 ,]


url09<-'http://www.forbes.com/lists/2009/33/baseball-values-09_The-Business-Of-Baseball_Rank.html'
table <- readHTMLTable(url09)
tables09 <- data.frame(table[1])
names(tables09) <-c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables09<-tables09[-1 ,]
tables09$year <- 2009


url08 <-'http://www.forbes.com/lists/2008/33/biz_baseball08_The-Business-Of-Baseball_Rank.html'
table <- readHTMLTable(url08)
table[8]
tables08 <- data.frame(table[8])
names(tables08) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables08$year <- 2008
tables08 <- tables08[-1,]

url07 <- 'http://www.forbes.com/lists/2007/33/07mlb_The-Business-Of-Baseball_Rank.html'
table <- readHTMLTable(url07)
table[6]
tables07 <- data.frame(table[6])
names(tables07) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables07$year <- 2007
tables07 <- tables07[-1,]


mlb_07_13 <- rbind(tables07,tables08,tables09,tables10,tables11,tables12,tables13)

write.csv(mlb_07_13,'MLB Values 2007-13.csv')


library(gdata)
setwd(dir='/Users/alexbresler/Desktop/Github/Aragorn/data/Data/Categories/Entertainment/Sports/Current Ontology/Baseball/Professional/MLB/Rods Sports Business Data/MLBTeamValues/Forbes')
mlb_team_data = ldply(list.files(pattern = "xls"), function(fname) {
	dum = read.xls(fname,sheet=1)
	dum$fname = fname  # adds the filename it was read from as a column
	return(dum)
})

mlb_team_data
mlb_team_data <- mlb_team_data[ , c(1:8)]
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Franchise Values/Tables")
write.csv(mlb_team_data,'MLB Values 1991-2006.csv')
rm(mlb)
str(mlb_07_13)
str(mlb_team_data)
mlb_07_13 <- read.csv(list.files()[2])
mlb <- rbind(mlb_07_13,mlb_team_data)

mlb$revenue_multiple <- round(mlb$value / mlb$revenue, 2)
mlb$ebitda_multiple <- round((mlb$value / mlb$operating_income),2)
mlb$league <- 'MLB'
mlb$debt_percent <- as.numeric(mlb$debt_percent / 100)
mlb$debt_value <- mlb$debt_percent * mlb$value
mlb$expense <- mlb$revenue - mlb$operating_income
mlb$value_change <- as.numeric(mlb$value_change / 100)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/MLB/Franchise Values")

write.csv(mlb, 'MLB Values 1991-2013.csv')
