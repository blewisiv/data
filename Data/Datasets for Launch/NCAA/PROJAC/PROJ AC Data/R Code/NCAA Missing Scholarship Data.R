nd<-data.frame()
men<-"Am.Indian/AN 0 0 0 0 0
Asian/PI 0 0 0 0 4
Black 7 0 2 42 1
Hispanic 0 1 0 0 1
White 3 16 15 36 92
N-R Alien 0 1 5 1 12
Other 0 0 0 0 0"
men<-gsub("N-R Alien","NR",men)
men<-gsub("Two or More","Mixed",men)
men<-gsub("Am. Ind./AN","AI",men)
men<-gsub("Nat. Haw./PI","PI",men)
write.cb(men)

women<-"Am.Indian/AN 0 0 1
Asian/PI 0 0 3
Black 5 7 1
Hispanic 0 0 1
White 6 10 135
N-R Alien 0 3 13
Other 0 0 0"

women<-gsub("N-R Alien","NR",women)
women<-gsub("Two or More","Mixed",women)
women<-gsub("Am. Ind./AN","AI",women)
women<-gsub("Nat. Haw./PI","PI",women)
write.cb(women)

sports<-"Baseball
Freshman Rate
2005-06 4-Class GSR
Am. Ind./AN - - -
Asian - - -
Black - - -
Hispanic 100-a 100-a 100-a
Nat. Haw./PI - - -
N-R Alien - - -
Two or More - - -
Unknown - - 100-a
White 60-a 70-d 100-c
Total 67-b 73-e 100-d
Men's Basketball
Freshman Rate
2005-06 4-Class GSR
Am. Ind./AN - - -
Asian - - -
Black 100-a 67-b 100-a
Hispanic - - -
Nat. Haw./PI - - -
N-R Alien - - -
Two or More - - -
Unknown - - -
White 100-a 100-b 100-b
Total 100-a 83-c 100-b
Men's CC/Track
Freshman Rate
2005-06 4-Class GSR
Am. Ind./AN - - -
Asian - - -
Black - 100-a 100-a
Hispanic - - -
Nat. Haw./PI - - -
N-R Alien - 100-a 100-a
Two or More - - -
Unknown - - -
White 100-a 100-c 100-c
Total 100-a 100-d 100-d
Football
Freshman Rate
2005-06 4-Class GSR
Am. Ind./AN - - -
Asian - - -
Black 100-b 84-e 100-e
Hispanic - - -
Nat. Haw./PI - - -
N-R Alien - - -
Two or More - - -
Unknown - - -
White 88-b 82-e 93-e
Total 93-c 83-e 97-e
Men's Other
Freshman Rate
2005-06 4-Class GSR
Am. Ind./AN - - -
Asian - 100-a 100-a
Black 100-a 50-a 50-a
Hispanic - 100-a 100-a
Nat. Haw./PI - - -
N-R Alien 100-a 92-c 100-c
Two or More - - -
Unknown 100-a 100-a 100-a
White 100-d 95-e 99-e
Total 100-e 94-e 98-e
Women's Basketball
Freshman Rate
2005-06 4-Class GSR
Am. Ind./AN - - -
Asian - - -
Black 0-a 80-a 100-a
Hispanic - - -
Nat. Haw./PI - - -
N-R Alien - - -
Two or More - - -
Unknown - - -
White 100-a 80-a 100-a
Total 50-a 80-b 100-b
Women's CC/Track
Freshman Rate
2005-06 4-Class GSR
Am. Ind./AN - - -
Asian - - -
Black - 100-a 100-a
Hispanic - - -
Nat. Haw./PI - - -
N-R Alien - 100-a 100-a
Two or More - - -
Unknown - - -
White 75-a 92-c 100-c
Total 75-a 95-d 100-d
Women's Other
Freshman Rate
2005-06 4-Class GSR
Am. Ind./AN - 100-a 100-a
Asian 0-a 67-a 100-a
Black - 100-a 100-a
Hispanic - 100-a 100-a
Nat. Haw./PI - - -
N-R Alien 100-a 90-b 100-b
Two or More - - -
Unknown 0-a 0-a -
White 96-e 97-e 100-e
Total 89-e 95-e 100-e"
sports<-gsub("N-R Alien","NR",sports)
sports<-gsub("Two or More","Mixed",sports)
sports<-gsub("Am. Ind./AN","AI",sports)
sports<-gsub("Nat. Haw./PI","PI",sports)
write.cb(sports)