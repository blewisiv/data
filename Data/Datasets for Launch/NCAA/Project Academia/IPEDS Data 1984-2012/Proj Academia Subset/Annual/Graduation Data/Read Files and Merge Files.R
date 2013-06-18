#Read all files in a directory using plyr
library(gdata)
library(plyr)
projacademia_school_data = ldply(list.files(pattern = "csv"), function(fname) {
  dum = read.csv(fname)
  dum$fname = fname  # adds the filename it was read from as a column
  return(dum)
})
projacademia_school_data$Major<-NULL
write.csv(projacademia_school_data,"1984-2012 School Data.csv")
names(projacademia_sport_data)[5]<-"Variable"
write.csv(projacademia_sport_data,"Project Academia 1997-2006 Athlete Graduation Rates.csv"

#Sport Data
setwd('~/Desktop/Github/Aragorn/AragornData/Categories/Data/Datasets for Launch/NCAA/Project Academia/IPEDS Data 1984-2012/Annual/Sports Data/Graduation Rates')
projacademia_sport_data = ldply(list.files(pattern = "csv"), function(fname) {
	dum = read.csv(fname)
	dum$fname = fname  # adds the filename it was read from as a column
	return(dum)
})
projacademia_sport_data$idxtable_flags2005.idx_gr.vl.unitid.of.parent.institution.reporting.graduation.rates
write.csv(projacademia_sport_data,"1997-2006 School Sport Graduation Data.csv")
setwd("~/Desktop/Github/Aragorn/AragornData/Categories/Data/Datasets for Launch/NCAA/Project Academia/IPEDS Data 1984-2012/Annual/Sports Data/Team Sizes")
projacademia_team_size = ldply(list.files(pattern = "csv"), function(fname) {
	dum = read.csv(fname)
	dum$fname = fname  # adds the filename it was read from as a column
	return(dum)
})
projacademia_team_size$Cohort<-NULL
projacademia_team_size$Variable<-'Scholarship Awards'
write.csv(projacademia_team_size,'Project Academia Scholarship Awards 1997-2006.csv')