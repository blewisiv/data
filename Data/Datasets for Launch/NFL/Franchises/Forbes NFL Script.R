library(data.table)
library(rCharts)

forbes<-read.csv(list.files()[1])
teams <- data.frame(franchise = unique(forbes$franchise))
wiki <- 'en.wikipedia.org/wiki/'
teams$wikiurl<-paste(wiki, gsub(" ",'_',teams$franchise),sep="")
fran<-read.cb()
names(forbes
names(fran) <- c('franchise','team','wikiurl','imageurl')
keep <- c('team', 'year', 'rank', 'value', 'revenue', 'operating_income', 'operating_income', 'revenue_multiple', 'wikiurl', 'imageurl')
sp<-forbes[,keep]
sp$wikiurl<-paste('http://',sp$wikiurl,sep="")
			names(nfl)
nfl<-data.table(
	x=sp$year,
	y=sp$value,
	name = sprintf("<table cellpadding='4' style='line-height:1.5'><tr><th colspan='3'>%1$s</th></tr><tr><td><img src='%2$s' height='120' width='120'></td><td align='left'>Year: %6$s<br>Team: %1$s<br>Value: $%3$s<br>Revenue: $%4$s<br>Value: $%3$s<br>Revenue Multiple: %5$s</td></tr></table>", 
								 sp$team,
								 sp$imageurl,
								 sp$value,
								 sp$revenue,
								 round(sp$revenue_multiple,3),
								 sp$year,
								 
	),
	url = sp$wikiurl,
	team = sp$team
)

nfl

teamSeries <- lapply(split(nfl, nfl$team), function(x) {
	res <- lapply(split(x, rownames(x)), as.list)
	names(res) <- NULL
	return(res)
})


b <- rCharts::Highcharts$new()
invisible(sapply(teamSeries, function(x) {
	b$series(data = x, type = ("scatter"), name = x[[1]]$team)
}
))


b$plotOptions(
	scatter = list(
		cursor = "pointer", 
		point = list(
			events = list(
				click = "#! function() { window.open(this.options.url); } !#")), 
		marker = list(
			symbol = "circle", 
			radius = 5
		)
	)
)

b$xAxis(title = list(text = "Year"), labels = list(format = "{value}"))
b$yAxis(title = list(text = "Valuation Millions"), labels = list(format = "${value}"))
b$tooltip(useHTML = T, formatter = "#! function() { return this.point.name+c; } !#")
b
	b$title(text = "Forbes NFL Franchise Valuation Explore 1991-2013")
b$subtitle(text = "Alex Bresler")
b$params$width <- 800
b$params$height <- 550
			b$colors(
				'rgba(183,016,040, 1)', #49ers
				'rgba(000,000,092, 1)', #Bears
				'rgba(215,070,016, 1)', #Bengals
				'rgba(096,088,088, 1)', #Bills
				'rgba(000,000,092, 1)', #Broncos
				'rgba(092,065,049, 1)', #Browns
				'rgba(159,008,008, 1)', #Bucs
				'rgba(142,040,032, 1)', #Cardinals
				'rgba(000,099,199, 1)', #Chargers
				'rgba(164,000,000, 1)', #Chiefs
				'rgba(019,007,092, 1)', #colts
				'rgba(111,111,143, 1)', #Cowboys
				'rgba(239,072,003, 1)', #Dolphins
				'rgba(022,092,076, 1)', #Eagles
				'rgba(000,000,000, 1)', #Falcons
				'rgba(016,016,097, 1)', #Giants
				'rgba(000,100,108, 1)', #Jaguars
				'rgba(040,156,048, 1)', #Jets
				'rgba(170,170,170, 1)', #Lions
				'rgba(000,000,092, 1)', #Oilers
				'rgba(000,092,000, 1)', #Packers
				'rgba(000,130,216, 1)', #Panthers
				'rgba(118,118,118, 1)', #Patriots
				'rgba(102,102,102, 1)', #Raiders
				'rgba(038,046,100, 1)', #Rams
				'rgba(054,016,086, 1)', #Ravens
				'rgba(102,008,003, 1)', #Redskins
				'rgba(148,121,064, 1)', #Saints
				'rgba(019,072,132, 1)', #Seahawks
				'rgba(255,188,000, 1)', #Steelers
				'rgba(158,024,024, 1)', #Texans
				'rgba(091,163,231, 1)', #Titans
				'rgba(051,000,107, 1)') #Vikings
			b$legend(
				align = 'right', 
				verticalAlign = 'middle', 
				layout = 'vertical', 
				title = list(text = "Team")
			)

			
b$publish('Forbes NFL Valuation History Explorer',host='gist')