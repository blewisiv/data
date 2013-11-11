
countries <- countries[order(countries$country,decreasing=F),]
countries$url <- paste('live.dbpedia.org/page/',countries$country, sep= '')
countries$url[1]
images <- c('http://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_Armenia.svg/200px-Flag_of_Armenia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Azerbaijan.svg/200px-Flag_of_Azerbaijan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Flag_of_Belarus.svg/200px-Flag_of_Belarus.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Flag_of_Estonia.svg/200px-Flag_of_Estonia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/200px-Flag_of_Georgia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kazakhstan.svg/200px-Flag_of_Kazakhstan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Flag_of_Kyrgyzstan.svg/200px-Flag_of_Kyrgyzstan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Latvia.svg/200px-Flag_of_Latvia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Lithuania.svg/200px-Flag_of_Lithuania.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Moldova.svg/200px-Flag_of_Moldova.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/200px-Flag_of_Russia.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Tajikistan.svg/200px-Flag_of_Tajikistan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Turkmenistan.svg/200px-Flag_of_Turkmenistan.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Ukraine.svg/200px-Flag_of_Ukraine.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Flag_of_Russian_SFSR_%281918-1937%29.svg/200px-Flag_of_Russian_SFSR_%281918-1937%29.svg.png',
	'http://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Uzbekistan.svg/200px-Flag_of_Uzbekistan.svg.png'
)

countries$image_url <- images
countries[,'image_url'][2]
country_color <- c(
	'rgb(239, 154, 0)',
	'rgb(0, 133, 84)',
	'rgb(58, 154, 66)',
	'rgb(55, 122, 11)',
	'rgb(226,0,28)',
	'rgb(0,159,191)',
	'rgb(245,154,0)',
	'rgb(130,40,42)',
	'rgb(3,90,51)',
	'rgb(255,204,0)',
	'rgb(0,31,152)',
	'rgb(4,87,0)',
	'rgb(31,163,81)',
	'rgb(255,208,0)',
	'rgb(193,0,0)',
	'rgb(0,135,168)'
	)
countries$rgb_color <- country_color
images <- data.frame(country = countries)
names(countries)[3] <-'dbpedia_url'
write.csv(countries,'country_data.csv')
olympic_image_url <- c(
	'http://upload.wikimedia.org/wikipedia/commons/5/5c/1924WOlympicPoster.jpg',
	'http://upload.wikimedia.org/wikipedia/en/c/c5/1928_Winter_Olympics_poster.jpg',
	'http://upload.wikimedia.org/wikipedia/en/thumb/2/25/1936_Winter_Olympics_logo.png/300px-1936_Winter_Olympics_logo.png',
	'http://upload.wikimedia.org/wikipedia/en/8/8f/1956_Winter_Olympics_logo.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/6/62/1960_Winter_Olympics_logo.svg/300px-1960_Winter_Olympics_logo.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/d/d3/1964_Winter_Olympics_logo.png/300px-1964_Winter_Olympics_logo.png',
	'http://upload.wikimedia.org/wikipedia/en/0/0d/1968_Winter_Olympics_logo.png',
	'http://steveandamysly.tannerworld.com/databank/2010/image_logo_1972_sapporo1.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/3/3b/1976_Winter_Olympics_logo.png/300px-1976_Winter_Olympics_logo.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/9/99/1980_Winter_Olympics_logo.svg/300px-1980_Winter_Olympics_logo.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/e/e8/1984_Winter_Olympics_logo.svg/300px-1984_Winter_Olympics_logo.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/3/31/1988_Winter_Olympics_logo.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/d/d1/1992_Winter_Olympics_logo.svg/300px-1992_Winter_Olympics_logo.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/9/96/1994_Winter_Olympics_logo.svg/400px-1994_Winter_Olympics_logo.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/f/fc/1998_Winter_Olympics_logo.svg/420px-1998_Winter_Olympics_logo.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/4/47/2002_Winter_Olympics_logo.svg/400px-2002_Winter_Olympics_logo.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/c/ce/2006_Winter_Olympics_logo.svg/410px-2006_Winter_Olympics_logo.svg.png',
	'http://upload.wikimedia.org/wikipedia/en/thumb/a/a7/2010_Winter_Olympics_logo.svg/300px-2010_Winter_Olympics_logo.svg.png'	
	)
olympics_logos <- data.frame(year_code = yeears, olympic_url = olympic_image_url)

library(Kmisc)

medals_sports_athletes <- merge(medals_sports_athletes,countries[,c('country','image_url','dbpedia_url')],by='country')
medals_years_athletes <- merge(medals_years_athletes,countries[,c('country','image_url','dbpedia_url')],by='country')
medals_sports_athletes <- medals_sports_athletes[order(medals_sports_athletes$year_code,decreasing=F),]
medals_years_athletes <- medals_years_athletes[order(medals_years_athletes$year_code,decreasing=F),]
write.csv(medals_sports_athletes,'medals_sports_athletes.csv')
write.csv(medals_years_athletes,'medals_years_athletes.csv')
