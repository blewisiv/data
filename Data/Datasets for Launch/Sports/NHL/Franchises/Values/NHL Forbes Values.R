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

url07 <- 'http://www.forbes.com/lists/2007/31/biz_07nhl_NHL-Team-Valuations_Rank.html'
table <- readHTMLTable(url07)
table[6]
tables07 <- data.frame(table[6])
names(tables07) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables07$year <- 2007
tables07 <- tables07[-1,]


url06 <- 'http://www.forbes.com/lists/2006/31/biz_06nhl_NHL-Team-Valuations_Rank.html'
table <- readHTMLTable(url06)
table[6]
tables06 <- data.frame(table[6])
names(tables06) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables06$year <- 2006
tables06 <- tables06[-1,]

tables06to12<-rbind(tables06,tables07,tables08,tables09,tables10,tables11,tables12)


setwd("~/Desktop/AragornTech Google Drive/Google Drive/Data/RodsSportsBusinessData/RodsSportsBusinessData/NHL/NHLTeamValues/Forbes")

library(gdata)
team_data = ldply(list.files(pattern = "xls"), function(fname) {
	dum = read.xls(fname,sheet=1)
	dum$fname = fname  # adds the filename it was read from as a column
	return(dum)
})

nhl$comments <- NULL
nhl$debt_value <- ((as.numeric(nhl$debt_percent)) / 100) * as.numeric(gsub(",","",nhl$value))
nhl$value_change <- as.numeric(nhl$value_change)/100
nhl$expense <- nhl$revenue-nhl$operating_income
nhl <- nhl[order(nhl$year,decreasing=T) , ]

write.csv(nhl,'NHL Values 1991 to 2012.csv')