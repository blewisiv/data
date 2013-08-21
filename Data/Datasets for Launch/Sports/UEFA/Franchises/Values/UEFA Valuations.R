#EUFA
library(XML)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/UEFA/Franchise Values")
url13 <- 'http://www.forbes.com/soccer-valuations/list/'
table <- readHTMLTable(url13)
table
tables13 <- data.frame(table)
names(tables13) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables13$year <- 2013


url12 <- 'http://web.archive.org/web/20120421191947/http://www.forbes.com/soccer-valuations/list/'
table <- readHTMLTable(url12)
table[4]
tables12 <- data.frame(table[4])
names(tables12) <- c('rank','team','value','value_change','debt_percent','revenue','operating_income')
tables12$year <- 2012

url11 <- 'http://www.forbes.com/lists/2010/34/soccer-10_Soccer-Team-Valuations_Rank.html'
table <- readHTMLTable(url11)
table
tables11 <- data.frame(table[1])
names(tables11) <- c('rank','team','country','value','value_change','debt_percent','revenue','operating_income')
tables11$country<-NULL
tables11 <- tables11[-1 , ]
tables11$year <- 2011

url10<-'http://www.forbes.com/lists/2010/34/soccer-10_Soccer-Team-Valuations_Rank.html'
table <- readHTMLTable(url10)
tables10 <- data.frame(table[1])
names(tables10) <- c('rank','team','country','value','value_change','debt_percent','revenue','operating_income')
tables10$year <- 2010
tables10$country<-NULL
tables10<-tables10[-1 ,]


url09<-'http://www.forbes.com/lists/2009/34/soccer-values-09_Soccer-Team-Valuations_Rank.html'
table <- readHTMLTable(url09)
tables09 <- data.frame(table[1])
names(tables09) <-c('rank','team','country','value','value_change','debt_percent','revenue','operating_income')
tables09<-tables09[-1 ,]
tables09$year <- 2009
tables09$country<-NULL
tables09<-tables09[-1,]

url08 <-'http://www.forbes.com/lists/2008/34/biz_soccer08_Soccer-Team-Valuations_Rank.html'
table <- readHTMLTable(url08)
table[8]
tables08 <- data.frame(table[8])
names(tables08) <- c('rank','team','country','value','value_change','debt_percent','revenue','operating_income')
tables08$year <- 2008
tables08$country<-NULL
tables08 <- tables08[-1,]

url07 <- 'http://www.forbes.com/lists/2007/34/biz_07soccer_Soccer-Team-Valuations_Rank.html'
table <- readHTMLTable(url07)
table[6]
tables07 <- data.frame(table[6])
names(tables07) <- c('rank','team','country','value','value_change','debt_percent','revenue','operating_income')
tables07$year <- 2007
tables07$country<-NULL
tables07 <- tables07[-1,]


uefatables07to13<-rbind(tables07,tables08,tables09,tables10,tables11,tables12,tables13)
uefatables07to13 <- read.csv(list.files()[1])
write.csv(uefatables07to13,'UEFA Values 2007-13.csv')
write.csv(tables06to12,'uefa Values 2006 to 2012.csv')
library(gdata)
setwd("~/Desktop/AragornTech Google Drive/Google Drive/Data/RodsSportsBusinessData/RodsSportsBusinessData/EuropeanFootball/TeamValues")
uefa_team_data = ldply(list.files(pattern = "xls"), function(fname) {
	dum = read.xls(fname,sheet=1)
	dum$fname = fname  # adds the filename it was read from as a column
	return(dum)
})


names(uefa_team_data)
team.country<-uefa_team_data[, c('team', 'country')]
team.country <- unique(team.country[!is.na(team.country$country) , ])

uefa <- merge(uefa_team_data,uefatables07to13,all.x=T,all.y=T)
uefa <- uefa[ , c(1:8)]
uefa$value <- as.numeric(gsub(",","",uefa$value))
uefa$revenue_multiple <- round(uefa$value / uefa$revenue, 2)
uefa$ebitda_multiple <- round((uefa$value / uefa$operating_income),2)
uefa$league <- 'UEFA'
uefa$debt_percent <- as.numeric(uefa$debt_percent / 100)
uefa$debt_value <- uefa$debt_percent * uefa$value
uefa$expense <- uefa$revenue - uefa$operating_income

z <- setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/UEFA/Franchise Values")

write.csv(uefa, 'UEFA Values 2004-2013.csv')
