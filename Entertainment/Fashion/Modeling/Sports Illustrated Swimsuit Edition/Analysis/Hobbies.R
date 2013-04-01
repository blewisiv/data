
library(sqldf)
hobbies<-sqldf("select ModelsHobbies as 'Hobby', COUNT(ModelsHobbies) as 'Count' from ModelsHobbies group by ModelsHobbies ORDER BY COUNT(ModelsHobbies) DESC")
hobbies<-hobbies[-1,]
write.csv(hobbies,"Hobbies.csv")