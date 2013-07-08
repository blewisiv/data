library(data.table)
DTIPEDS<-data.table(ipeds)
unique((ipeds$ID_School))
GTOWN<-[DTIPEDS==GTOWN]
