library(readxl)
Ale <- read_excel("C:/Users/bilskim/A-League 2017-2019.xlsx", sheet = "Match Stats")
awaygl <- Ale[,c(3,5,8,9,10,11,13,15,16,18,22,23,26)]
length(subset(awaygl,awaygl$Away == 'central coast'))
awayg<- subset(awaygl,awaygl$Away == 'central coast')

#remove columns 
library(caTools)
library(dbplyr)
library(dplyr)

awtrain<- slice(awayg[,-1],1:45)
awtest<- slice(awayg[,-1],46:47)

# Training Data
train = awtrain

# Testing Data
test = awtest

#Linear regression

model.aways<- kmeans(train$`away Score`~ .,data=train,nstart = 20)
print(summary(model.aways))

rest<- residuals(model.aways)
rest<- as.data.frame(rest)

aw.pred<- predict(model.aways,test)
resultawa<- as.data.frame(aw.pred)

print(resultawa)