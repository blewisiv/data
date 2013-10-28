#PeyTom Data Frameer
library(rCharts)
library(dplyr)
library(data.table)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data")

list.files()
aaron <- 
	data.frame(read.csv(list.files()[1]),stringsAsFactors=F)
marino <- 
	data.frame(read.csv(list.files()[2]),stringsAsFactors=F)
brees <- 
	data.frame(read.csv(list.files()[3]),stringsAsFactors=F)
pey <- 
	data.frame(read.csv(list.files()[4]),stringsAsFactors=F)
tom <- 
	data.frame(read.csv(list.files()[5]),stringsAsFactors=F)

game_number <- 8 #ENTER GAME NUMBER

#peyton
pey_2013_progression <- subset(pey, season == 2013 , season_game <= game_number)
pey_2004_progression <- 
	subset(pey, season == 2004 & season_game <= game_number )


#Brady
tom_2011_progression <- 
	subset(tom, season == 2011 & season_game <= game_number)
tom_2007_progression <- 
	subset(tom, season == 2007 & season_game <= game_number)


#Rodgers
aaron_2011_progression <- 
	subset(aaron, season == 2011 & season_game <= game_number)

#Brees
brees_2011_progression <- 
	subset(brees, season == 2011 & season_game <= game_number)

#Marino
marino_1984_progression <- 
	subset(marino, season == 1984 & season_game <= game_number)


cols <- 
	c("player","season","season_game","pass_completions","pass_attempts","passing_touchdowns","passing_yards","interceptions_thrown","qb_rating","rushing_touchdowns","outcome","team_score","opponent_score",'opponent','game_location')

merged_df <- 
	data.table(merge(pey_2004_progression[,cols],pey_2013_progression[,cols],all.x=T,all.y=T))
merged_df <- 
	data.table(merge(tom_2011_progression[,cols],merged_df,all.x=T,all.y=T))
merged_df <- 
	data.table(merge(tom_2007_progression[,cols],merged_df,all.x=T,all.y=T))
merged_df <- 
	data.table(merge(brees_2011_progression[,cols],merged_df,all.x=T,all.y=T))
merged_df <- 
	data.table(merge(aaron_2011_progression[,cols],merged_df,all.x=T,all.y=T))
merged_df <- 
	data.table(merge(marino_1984_progression[,cols],merged_df,all.x=T,all.y=T))

names(merged_df)



ds <-
	data.frame( 
	merged_df[, list( completions = sum(pass_completions), attempts = sum(pass_attempts), passing_yards = sum(passing_yards), passing_touchdowns = sum(passing_touchdowns), interceptions = sum(interceptions_thrown), rushing_touchdowns = sum(rushing_touchdowns), qb_rating = mean(qb_rating), team_points = sum(team_score) , opponent_points = sum(opponent_score)
		), 
		by = list(player,season)]
	)
ds_week <- 
	data.frame( 
	merged_df[, list( completions = sum(pass_completions), attempts = sum(pass_attempts), passing_yards = sum(passing_yards), passing_touchdowns = sum(passing_touchdowns), interceptions = sum(interceptions_thrown), rushing_touchdowns = sum(rushing_touchdowns), qb_rating = mean(qb_rating), team_points = sum(team_score) , opponent_points = sum(opponent_score)
		), 
		by = list(player,season,season_game,opponent,game_location)]
	)
ds_week$game_location <-
	gsub("@",'away',ds_week$game_location)

ds_week[ds_week$game_location %in% '','game_location'] <- 'home'

outcomes <- 
	data.frame(
		merged_df[,list(wins = .N),by = list (player, season, outcome)]
		)
outcomes <- 
	outcomes[!(outcomes$outcome %in% "L"),c('player','wins','season')]

outcomes$win_percentage <- 
	100*(round(outcomes$wins/game_number,digits=4))
attach(ds)
ds$completion_percentage <- 100*round(completions/attempts, digits=4)
ds$point_contribution_ratio <- 100*round(((passing_touchdowns+rushing_touchdowns)*6)/team_points,digits=4)
ds$interceptions_per_attempt <- 100*round((interceptions/attempts),digits=4)
ds$yards_per_completion <- round(passing_yards/completions,digits=2)
ds$yards_per_attempt <- round(passing_yards/attempts,digits=2)
ds$touchdowns_per_interception <- round(passing_touchdowns/interceptions,digits=2)
ds$touchdowns_per_attempt <- 100*round(passing_touchdowns/attempts,digits=4)
ds$touchdowns_per_completion <-100*round(passing_touchdowns/completions,digits=4)
ds$player_point_to_opponent_point_ratio <- 100*round(((passing_touchdowns+rushing_touchdowns)*6)/opponent_points,digits=4)
ds$qb_rating <- round(ds$qb_rating,digits=2)

ds <- merge(ds,outcomes)
players <- 
	ds[,c('player','season')]
image_urls <- 
	c('http://3.bp.blogspot.com/-V_1dP__CU00/UjM6e5f6_XI/AAAAAAAAKTY/hth-u46579o/s1600/Brady_03.PNG',
		'http://vlsportysexycool.com/wp-content/uploads/2012/03/Peyton-Manning-Broncos.png',
		'http://www.coltsdigital.me/community/uploads/gallery/album_3/gallery_1_3_109440.png',
		'http://www.wallpaperati.com/wp-content/uploads/2011/01/aaron-rodgers-wallpaper-3.png',
		'http://thegothamgridiron.files.wordpress.com/2010/08/young-dan-marino.png',
		'http://maizeandgoblue.com/wp-content/uploads/2011/09/Tom-Brady.png',
		'http://vlsportysexycool.com/wp-content/uploads/2012/06/Drew-Brees.png')
labels <- c(
	"Brady '07",
	"Manning '13",
	"Manning '04",
	"Rodgers '11",
	"Marino '84",
	"Brady '11",
	"Brees '11")
color <- c(
	'#0D254C',
	'#FB4F14',
	'#003B7B',
	'#FFCC00',
	'#006666',
	'#C80815',
	'#D2B887')
players <- c(
	'Tom Brady',
	'Peyton Manning',
	'Peyton Manning',
	'Aaron Rodgers',
	'Dan Marino',
	'Tom Brady',
	'Drew Brees')
season <- c(
	2007,
	2013,
	2004,	
	2011,
	1984,
	2011,
	2011)
players_images <- data.frame(player = players, season = season, image_url = image_urls, label = labels, color = color)
ds <- merge(ds,players_images)

ds$week <- 
	game_number
ds$detail <- sprintf("<table cellpadding='3' style='line-height:1.25'><tr><th colspan='2.5'>%1$s</th></tr><tr><td><img src='%2$s' height='125' width='100'></td><td align='left'>Season: %3$s<br>Week: %7$s<br>QB Rating: %5$s<br>Passing Touchdowns: %4$s<br>Passing Yards: %6$s<br>Interceptions: %8$s</td></tr></table>",
	ds$label,
	ds$image_url,
	ds$season,
	ds$passing_touchdowns,
	ds$qb_rating,
	ds$passing_yards,
	ds$week,
	ds$interceptions)

ds
names(ds)

final_ds <- ds[,c(1:2,6,9,5:3,7,12,10:11,21:22,13:20,24,26,25,27)]
ds <- 
	ds[order(ds$passing_touchdowns,decreasing=T),]
ds
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data/weekly_viz_data")
write.csv(final_ds,paste('Week_',game_number,'_Peyton_Quest','.csv',sep=""))

attach(ds_week)
ds_week$completion_percentage <- 
	100*round(completions/attempts, digits=4)
ds_week$point_contribution_ratio <- 
	100*round(((passing_touchdowns+rushing_touchdowns)*6)/team_points,digits=4)
ds_week$interceptions_per_attempt <- 
	100*round((interceptions/attempts),digits=4)
ds_week$yards_per_completion <- 
	round(passing_yards/completions,digits=2)
ds_week$yards_per_attempt <- 
	round(passing_yards/attempts,digits=2)
ds_week$touchdowns_per_attempt <- 
	100*round(passing_touchdowns/attempts,digits=4)
ds_week$touchdowns_per_completion <-
	100*round(passing_touchdowns/completions,digits=4)
ds_week$player_point_to_opponent_point_ratio <- 
	100*round(((passing_touchdowns+rushing_touchdowns)*6)/opponent_points,digits=4)
ds_week$qb_rating <- 
	round(ds_week$qb_rating,digits=2)
ds_week <- 
	merge(ds_week,players_images,all.x=T)
ds_week$detail <- sprintf("<table cellpadding='3' style='line-height:1.25'><tr><th colspan='2.5'>%1$s</th></tr><tr><td><img src='%2$s' height='125' width='100'></td><td align='left'>Season: %3$s<br>Game Number: %7$s<br>QB Rating: %5$s<br>Passing Touchdowns: %4$s<br>Passing Yards: %6$s<br>Interceptions: %8$s</td></tr></table>",
	ds_week$label,
	ds_week$image_url,
	ds_week$season,
	ds_week$passing_touchdowns,
	ds_week$qb_rating,
	ds_week$passing_yards,
	ds_week$season_game,
	ds_week$interceptions)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/Workflows/pey_tom/data/series_data")
write.csv(ds_week,paste('Week_',game_number,'_Peyton_Quest_Game_by_Game_Data','.csv',sep=""))
