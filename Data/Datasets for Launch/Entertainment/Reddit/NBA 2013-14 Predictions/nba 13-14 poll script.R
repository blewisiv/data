## Reddit NBA Scraper
library(reshape2)
library(dplyr)
library(rCharts)
library(data.table)

poll_2013_14_responses <- read.csv("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Entertainment/Reddit/NBA 2013-14 Predictions/data/poll_2013_14_responses.csv")
names(poll_2013_14_responses)
head(poll_2013_14_responses)
poll.melt <- melt(poll_2013_14_responses,id.vars=c('Timestamp'),value.name=c('projected_outcome'))
names(poll.melt)[2] <- c('team')
poll.melt <- data.frame(poll.melt,stringsAsFactors=F)
teams <- colsplit(poll.melt$team,"\\_",names=c('team','record'))
teams$team <- gsub("\\."," ",teams$team)
teams$record <- gsub("\\.","",teams$record)
teams$record <- gsub("and","-",teams$record)
wins.losses <- colsplit(teams$record,"-",c('wins_12_13','losses_12_13'))
teams <- cbind(teams,wins.losses)
teams$win_percentage_12_13 <- round(x=teams$wins_12_13/(teams$wins_12_13+teams$losses_12_13),digits=3)
poll.melt <- (cbind(poll.melt,teams))
names(poll.melt)
poll.data <- poll.melt[,c(4,5,6,7,8,3)]
summary(as.factor(poll.data$projected_outcome))
outcomes <- poll.data$projected_outcome
pds <- poll.data[!(is.na(poll.data$projected_outcome) | poll.data$projected_outcome==""), ]

DT <- data.table(pds)
teams.votes <- data.frame(DT[, .N, by = team])
names(teams.votes)[2] <- 'vote'
poll.outcomes <- DT[, .N, by = list(team,projected_outcome)]
polls.outcomes <- merge(poll.outcomes, teams.votes, all.x=T,by="team")
polls.outcomes$percentage_votes <- round(polls.outcomes$N/polls.outcomes$votes,2)
names(polls.outcomes) [3:4] <- c('votes','total_votes')
final_ds <- merge(polls.outcomes,unique(poll.data[, c(1:5)]))

names(final_ds)

final_ds <- final_ds[order(final_ds$team_name,decreasing=F),]
	
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Entertainment/Reddit/NBA 2013-14 Predictions/data")
write.csv(final_ds,'Reddit NBA 2013-14 SummaryPredictions.csv')

nPlot(votes~projected_outcome,data=final_ds,group = 'team', type = 'multiBarChart')
nPlot(votes~projected_outcome,data=final_ds,group = 'team', type = 'multiBarChart')

p1 <- nPlot(votes~team_name,data=final_ds,group = 'projected_outcome', type = 'multiBarHorizontalChart')
p2 <- nPlot(percentage_votes~team_name,data=final_ds,group = 'projected_outcome', type = 'multiBarHorizontalChart')

p2$chart(color = c('red', 'grey','green'))


p2$params$height <- 600

p2$yAxis(staggerLabels = TRUE)
p2$params$controls
p2$yAxis( tickFormat="#!function(d) {return d3.format('.0%')(d)}!#" )
p2
