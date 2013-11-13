library(data.table)
setwd("~/Desktop/Github/Aragorn/data/Data/Datasets for Launch/Sports/NFL/SI/QBs/gamelog_data")

ds <- fread(list.files()[3])
names(ds)
ds$V1 <- NULL
ds$season <- as.numeric(ds$season)
ds$season_type_game_number <- as.numeric(ds$season_type_game_number)
keys <- c('player','date','season','table_name','player_sports_ref_gamelog_url')
setkeyv(ds, cols=keys)	
qbs_data <- data.frame(
	ds[
		!is.na(season)
		,list(career = paste(min(season),"-",max(season),sep = ''), rookie_season = min(season), final_season = max(season), 
		total_attempts = sum(passing_attempts, na.rm = T), total_completions = sum(completions,na.rm=T), total_passing_yards = sum(passing_yards, na.rm=T), total_touchdowns = sum(passing_touchdowns,na.rm=T),
		total_starts = length(started_game == T), total_games = length(game_number), total_seasons = (length(unique(season))),
		career_qb_rating = mean(qb_rating,na.rm=T),  total_interceptions = sum(interceptions_thrown,na.rm=T), total_kickoff_return_yards = sum(kickoff_return_yards, na.rm = T), 
		total_rushing_yards = sum(rushing_yards,na.rm=T) , total_rushing_touchdowns = sum(rushing_touchdowns,na.rm=T),
		total_receiving_yards = sum(receiving_yards,na.rm=T), total_team_points = sum(team_points,na.rm=T), total_opponent_points = sum(opponent_points,na.rm=T)
	), by = list(player
		)]
)
qbs_data$completion_percentage <- 
	round(100 * qbs_data$total_completions/qbs_data$total_attempts , 2)
qbs_data$career_qb_rating <- 
	round(qbs_data$career_qb_rating, 2)
qbs_data$yards_per_attempt <- 
	round(qbs_data$total_passing_yards/qbs_data$total_attempts , 2)
qbs_data$touchdowns_per_attempt <- 
	ifelse(is.na(round(100 * qbs_data$total_touchdowns/qbs_data$total_attempts , 2)
		),0,round(100 * qbs_data$total_touchdowns/qbs_data$total_attempts , 2)
	)
qbs_data$interceptions_per_attempt <- 
	ifelse(is.na(round(100 * qbs_data$total_interceptions/qbs_data$total_attempts , 2)),
		0,round(100 * qbs_data$total_interceptions/qbs_data$total_attempts , 2)
	)
qbs_data$touchdown_to_interception_ratio <- 
	ifelse(is.na(round(qbs_data$total_touchdowns/qbs_data$total_interceptions , 2)),
		0,
		round(qbs_data$total_touchdowns/qbs_data$total_interceptions , 2)
		)
qbs_data$player_total_plus_minus <-
	round(qbs_data$total_team_points - qbs_data$total_opponent_points , 2)
qbs_data$player_active <- 
	grepl(2013,qbs_data$final_season)

qbs_data[qbs_data$touchdown_to_interception_ratio == Inf, 'touchdown_to_interception_ratio'] <- 0
qbs_data[
	qbs_data$interceptions_per_attempt == Inf, 'interceptions_per_attempt'] <- 0

length(
	summary(subset(qbs_data, touchdown_to_interception_ratio > 3))
	)

gn <- 14
fs <- 
	data.table(subset(ds, season_type_game_number <= gn & table_name == 'RS' ))

qbs_through_game_number <-
	data.frame(fs[
		!is.na(season)
		,list(period = paste(min(season),"-",max(season),sep = ''), start_season = min(season), end_season = max(season),
		total_attempts = sum(passing_attempts, na.rm = T), total_completions = sum(completions,na.rm=T), total_passing_yards = sum(passing_yards, na.rm=T), total_touchdowns = sum(passing_touchdowns,na.rm=T),
		total_starts = length(started_game == T), total_games = length(game_number), total_seasons = (length(unique(season))),
		qb_rating = mean(qb_rating,na.rm=T),  total_interceptions = sum(interceptions_thrown,na.rm=T), total_kickoff_return_yards = sum(kickoff_return_yards, na.rm = T), 
		total_team_points = sum(team_points,na.rm=T), total_opponent_points = sum(opponent_points,na.rm=T)
	), by = list(player, team_pfbr_id
		)])
qbs_through_game_number <- qbs_through_game_number[order(qbs_through_game_number$qb_rating,decreasing=T),]

qbs_through_game_number$completion_percentage <- 
	round(100 * qbs_through_game_number$total_completions/qbs_through_game_number$total_attempts , 2)
qbs_through_game_number$qb_rating <- 
	round(qbs_through_game_number$qb_rating, 2)
qbs_through_game_number$yards_per_attempt <- 
	round(qbs_through_game_number$total_passing_yards/qbs_through_game_number$total_attempts , 2)
qbs_through_game_number$touchdowns_per_attempt <- 
	ifelse(is.na(round(100 * qbs_through_game_number$total_touchdowns/qbs_through_game_number$total_attempts , 2)
		),0,round(100 * qbs_through_game_number$total_touchdowns/qbs_through_game_number$total_attempts , 2)
	)
qbs_through_game_number$interceptions_per_attempt <- 
	ifelse(is.na(round(100 * qbs_through_game_number$total_interceptions/qbs_through_game_number$total_attempts , 2)),
		0,round(100 * qbs_through_game_number$total_interceptions/qbs_through_game_number$total_attempts , 2)
	)
qbs_through_game_number$touchdown_to_interception_ratio <- 
	ifelse(is.na(round(qbs_through_game_number$total_touchdowns/qbs_through_game_number$total_interceptions , 2)),
		0,
		round(qbs_through_game_number$total_touchdowns/qbs_through_game_number$total_interceptions , 2)
		)
qbs_through_game_number$player_total_plus_minus <-
	round(qbs_through_game_number$total_team_points - qbs_through_game_number$total_opponent_points , 2)
qbs_through_game_number$player_active <- 
	grepl(2013,qbs_through_game_number$final_season)

qbs_through_game_number[qbs_through_game_number$touchdown_to_interception_ratio == Inf, 'touchdown_to_interception_ratio'] <- 0
qbs_through_game_number[
	qbs_through_game_number$interceptions_per_attempt == Inf, 'interceptions_per_attempt'] <- 0
q <- qbs_through_game_number[qbs_through_game_number$total_games == 14,,]

q <- data.table(q)
q <- q[total_attempts >= 25,,]
q$period <-
	ifelse(
	q$start_season == q$end_season,
	q$start_season,
	paste(q$start_season,"-",q$end_season,sep="")
		)
	

q$label <- ifelse(
	q$start_season == q$end_season,
	paste(q$player, q$start_season,sep=" "),
	paste(q$player," ", q$start_season,"-",q$end_season,sep=""))

iframe_base <- "http://nflcombineresults.com/testembed2.php#advanced/search-advanced-query="
q$iframe_url <- 
	paste(iframe_base,
		gsub(" ","+",q$player)
			,"+",q$start_season, sep = '')

d <- data.frame(q[1:30])

d$detail <- 
	sprintf("<table cellpadding='3' style='line-height:1.25'><tr><th colspan='2.5'>%1$s</th></tr><tr><td><iframe src='%2$s' height='125' width='100'></iframe></td><td align='left'>Period: %3$s<br>Career QB Rating: %5$s<br>Career Attempts: %7$s<br>Career Completions: %8$s<br>Career Passing Touchdowns: %4$s<br>Career Passing Yards: %6$s<br>Career Interceptions: %8$s</td></tr></table>",
	d$label,
	d$iframe_url,
	d$period,
	d$total_touchdowns,
	d$qb_rating,
	d$total_passing_yards,
	d$total_attempts,
	d$total_completions,
	d$total_interceptions
)
names(d)
d <- d[,c(1:3,6:9,13:14,18:23,16:17,24,26)]
d <- d[order(d$total_touchdowns,decreasing=T),]
