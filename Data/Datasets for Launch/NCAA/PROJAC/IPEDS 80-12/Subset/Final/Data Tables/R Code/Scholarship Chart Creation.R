library(rCharts)
library(plyr)
library(reshape2)
football$Sport<-NULL
levels(football$ID_School)
footballmelt<-melt(id.vars=c('Year','ID_School'),data=football)
mensbasketball<-remove.vars(basketball,c('White.Females','Other.Females','Hispanic.Females','White.Females','Black.Females'))
mensbasketball$Sport<-NULL
mensbasketballmelt<-melt(id.vars=c('Year','ID_School'),data=mensbasketball)

rutgers<-subset(footballmelt,footballmelt$ID_School=='RUT')
rutgers<-rutgers[order(rutgers$Year),]
rutgers<-hPlot(value~Year, data=rutgers,type = c('column'), group = 'variable', radius = 6)
rutgers$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
rutgers$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
rutgers$yAxis(title = list(text = "# of Players"))
rutgers$title(text ='Rutgers Football Racial Breakdown')
rutgers$subtitle(text ='Aragorn Alpha')
rutgers
rutgers$publish('Rutgers Football 97-05 Racial Breakdown',host='gist')

OKState<-subset(footballmelt,footballmelt$ID_School=='OKSTATE')
OKState<-OKState[order(OKState$Year),]
OKState<-hPlot(value~Year, data=OKState,type = c('column'), group = 'variable', radius = 6)
OKState$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
OKState$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
OKState$yAxis(title = list(text = "# of Players"))
OKState$title(text ='Oklahoma State Football Racial Breakdown')
OKState$subtitle(text ='Aragorn Alpha')
OKState
OKState$publish('Oklahoma State Football 97-05 Racial Breakdown',host='gist')

ND<-subset(footballmelt,footballmelt$ID_School=='ND')
ND<-ND[order(ND$Year),]
ND<-hPlot(value~Year, data=ND,type = c('column'), group = 'variable', radius = 6)
ND$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
ND$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
ND$yAxis(title = list(text = "# of Players"))
ND$title(text ='Notre Dame Football Racial Breakdown')
ND$subtitle(text ='Aragorn Alpha')
ND
ND$publish('Notre Dame Football 97-05 Racial Breakdown',host='gist')

LOUIS<-subset(footballmelt,footballmelt$ID_School=='LOUIS')
LOUIS<-LOUIS[order(LOUIS$Year),]
LOUIS<-hPlot(value~Year, data=LOUIS,type = c('column'), group = 'variable', radius = 6)
LOUIS$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
LOUIS$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
LOUIS$yAxis(title = list(text = "# of Players"))
LOUIS$title(text ='Louisville Football Racial Breakdown')
LOUIS$subtitle(text ='Aragorn Alpha')
LOUIS


LOUIS<-subset(footballmelt,footballmelt$ID_School=='LOUIS')
LOUIS<-LOUIS[order(LOUIS$Year),]
LOUIS<-hPlot(value~Year, data=LOUIS,type = c('column'), group = 'variable', radius = 6)
LOUIS$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
LOUIS$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
LOUIS$yAxis(title = list(text = "# of Players"))
LOUIS$title(text ='Louisville Football Racial Breakdown')
LOUIS$subtitle(text ='Aragorn Alpha')
LOUIS
LOUIS$publish('Lousville Football 97-05 Racial Breakdown',host='gist')

ORE<-subset(footballmelt,footballmelt$ID_School=='ORE')
ORE<-ORE[order(ORE$Year),]
ORE<-hPlot(value~Year, data=ORE,type = c('column'), group = 'variable', radius = 6)
ORE$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
ORE$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
ORE$yAxis(title = list(text = "# of Players"))
ORE$title(text ='Oregon Football Racial Breakdown')
ORE$subtitle(text ='Aragorn Alpha')
ORE
ORE$publish('University of Oregon Football 97-05 Racial Breakdown',host='gist')

LOUISBBALL<-(subset(mensbasketballmelt,mensbasketballmelt$ID_School=='LOUIS',))
LOUISBBALL<-LOUISBBALL[order(LOUISBBALL$Year),]
LOUISBBALL<-hPlot(value~Year, data=LOUISBBALL,type = c('column'), group = 'variable', radius = 6)
LOUISBBALL$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
LOUISBBALL$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
LOUISBBALL$yAxis(title = list(text = "# of Players"))
LOUISBBALL$title(text ='Louisville Basketball Racial Breakdown')
LOUISBBALL$subtitle(text ='Aragorn Alpha')
LOUISBBALL

LOUIS<-subset(footballmelt,footballmelt$ID_School=='LOUIS')
LOUIS<-LOUIS[order(LOUIS$Year),]
LOUIS<-hPlot(value~Year, data=LOUIS,type = c('column'), group = 'variable', radius = 6)
LOUIS$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
LOUIS$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
LOUIS$yAxis(title = list(text = "# of Players"))
LOUIS$title(text ='Louisville Football Racial Breakdown')
LOUIS$subtitle(text ='Aragorn Alpha')
LOUIS


LOUIS<-subset(footballmelt,footballmelt$ID_School=='LOUIS')
LOUIS<-LOUIS[order(LOUIS$Year),]
LOUIS<-hPlot(value~Year, data=LOUIS,type = c('column'), group = 'variable', radius = 6)
LOUIS$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
LOUIS$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
LOUIS$yAxis(title = list(text = "# of Players"))
LOUIS$title(text ='Louisville Football Racial Breakdown')
LOUIS$subtitle(text ='Aragorn Alpha')
LOUIS
LOUIS$publish('Lousville Football 97-05 Racial Breakdown',host='gist')

ORE<-subset(footballmelt,footballmelt$ID_School=='ORE')
ORE<-ORE[order(ORE$Year),]
ORE<-hPlot(value~Year, data=ORE,type = c('column'), group = 'variable', radius = 6)
ORE$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
ORE$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
ORE$yAxis(title = list(text = "# of Players"))
ORE$title(text ='Oregon Football Racial Breakdown')
ORE$subtitle(text ='Aragorn Alpha')
ORE
ORE$publish('University of Oregon Football 97-05 Racial Breakdown',host='gist')

levels(footballmelt$ID_School)
UGA<-subset(footballmelt,footballmelt$ID_School=='UGA')
UGA<-UGA[order(UGA$Year),]
UGA<-hPlot(value~Year, data=UGA,type = c('column'), group = 'variable', radius = 6)
UGA$plotOptions(column = list(dataLabels = list(enabled = T, rotation = -90, align = 'right', color = '#FFFFFF', x = 4, y = 10, style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
UGA$xAxis(labels = list(rotation = -45, align = 'right', style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif')), replace = F)
UGA$yAxis(title = list(text = "# of Players"))
UGA$title(text ='University of Georgia')
UGA$subtitle(text ='Aragorn Alpha')
UGA