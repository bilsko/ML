library(stringr)
library(XML)
library(rvest)
library(tidyr)
library(dplyr)

#the first step is getting the html (data) in from the page ("https://en.wikipedia.org/wiki/2016_AFL_season")
afl_season<-read_html("https://en.wikipedia.org/wiki/2016_AFL_season", encoding = "UTF-8")
#once you have all the html, you want to find the tables
tables<-html_table(afl_season, fill = TRUE)


table.example<-tables[[2]] ##just looking at round 1
names(table.example) #see the variable names 
str(table.example) #see the data structure


df1<-table.example[-c(1,2,12),]

#we also want some sort of label for the round
df1$round<-"Round 1" ##add a label so I know what round it is
df2<-select(df1, X1, X2, X4,X5,round) #just getting the columns that I want

df3<-extract(df2, X1, into = c("Date", "Time"), "([^(]+)\\s+\\(([:graph:]+).") ### seperates the date and the time

df4<-extract(df3, X2, into = c("winning team", "winning Score"), "([^(]+)\\s+\\(([0-9]+).")
#what this does is take the numbers but only the numbers in the () #prettycoolay
df5<-extract(df4, X4, into = c("losing team", "Score"), "([^(]+)\\s+\\(([0-9]+).") ##getting the losing score


df6<-separate(df5,X5,into=c("Venue","Crowd"),sep='[(]crowd:',remove=TRUE,convert=FALSE)
df6$Crowd<-gsub("\\)","",df6$Crowd)

df7<-separate(df6, 'winning team',into=c("winning.team","winning.behinds"),sep="\\.") 
df8<-separate(df7,'losing team', into = c("losing.team","losing.behinds"),sep="\\.")
df9<-separate(df8, winning.team, c("winning.team", "winning.goals"), "(?<=[a-z]) ?(?=[0-9])")
df10<-separate(df9, losing.team, c("losing.team", "losing.goals"), "(?<=[a-z]) ?(?=[0-9])")
View(df10)
