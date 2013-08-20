library(data.table)
allsp <- read.csv("~/Desktop/Github/Aragorn/AragornData/Categories/Data/Datasets for Launch/NCAA/PROJAC/PROJ AC Data/DOE Revenue-Expense/Summary/Summary Revenue-Expenses 2000-2012.csv")
dt<-data.table(allsp)
names<-names(dt)
keycols<-names[c(1:5)]
setkeyv(dt,cols=keycols)
summary(dt)