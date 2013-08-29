library(dplyr)
library(data.table)
library(reshape2)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NCAA/PROJAC/PROJ AC Data/IPEDS-NCAA 80-12/Subset/Final/Data Tables/Final/Schoolwide IPEDS Data")
ipeds <- read.csv(list.files()[1])
DT <- source_dt(ipeds)
names(DT)
names(DT) <- tolower(names(DT))
ipedskeys <- c('id_school', 'year', 'cip_id')
setkeyv(DT,cols=ipedskeys)
okstate <- data.table(subset(x=DT, id_school == 'OKSTATE'))
okstate.majors <- okstate[ ,list(total, males = m, females = w, males_white = c.m, females_white = c.w, males_black = aa.m, females_black = aa.w) , by = list(year, cip_family, cipfamilytitle)]
okstate.majors$males_other <- okstate.majors$males - okstate.majors$males_white - okstate.majors$males_black
okstate.majors$females_other <- okstate.majors$females - okstate.majors$females_white - okstate.majors$females_black


okstate.races <- okstate[ ,list( total = sum(total), males =  sum(m) , females = sum(w), males_white = sum(c.m) ,females_white = sum(c.w) , males_black = sum(aa.m) , females_black = sum(aa.w)) , by = list(year)]
okstate.races$females_other <- okstate.races$females - okstate.races$females_white - okstate.races$females_black
okstate.races$males_other <- okstate.races$males - okstate.races$males_white - okstate.races$males_black
years <- as.character(okstate.races$year)
years <- cbind(years , colsplit(years, pattern="-", names=c('start_year', 'end_year')))
names(years)[1] <- c('year')
years
okstate.majors$year <- as.character(okstate.majors$year)
okstate.major <- merge(okstate.majors, years , all.x=T, by = c('year'))
names(okstate.major)[c(1,14)] <- c('year_academic' , 'year')
names(okstate.major)
okstate.race <- merge(okstate.races, years , all.x=T, by = c('year'))
names(okstate.race) [c(1,12)] <- c('year_academic' , 'year')

setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NCAA/PROJAC/PROJ AC Data/Workflows/Oklahoma State/Output/Data/School/IPEDS")


okstate.race <- data.frame(okstate.race)
okstate.major <- data.frame(okstate.major)
names(okstate.race)
okstate.races.genders <- okstate.race[ , c(12,2:10)]
names(okstate.major)
okstate.major <- data.frame(okstate.major)
okstate.major.race.gender.cip <- okstate.major[ ,c(14, 2:10) ]
names(okstate.major.race.gender.cip)[1] <- c('year')
write.csv(okstate.races.genders.majors,'Oklahoma State Schoolwide Degrees Conferred by Year and Major.csv')
write.csv(okstate.major.race.gender.cip,'Oklahoma State Schoolwide Degrees Conferred by CIP, Year and Major.csv')
write.csv(okstate.races.genders,'Oklahoma State Schoolwide Degrees Conferred by Year.csv')