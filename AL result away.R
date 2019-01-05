library(readxl)
Alehgls <- read_excel("C:/Users/bilskim/A-League 2017-2019.xlsx", sheet = "Match Stats")
awaygls <- Alehgls[,c(5,8,9,10,11,13,15,16,18,22,23,26)]

cor(awaygls,awaygls$`away Score`)
#remove columns 
library(caTools)
library(dbplyr)
library(dplyr)

atrain<- slice(awaygls,1:467)
atest<- slice(awaygls,470:475)

# Training Data
train = atrain

# Testing Data
test = atest

#Linear regression

model.away<- lm(train$`away Score`~ .,data=train)
print(summary(model.away))

res<- residuals(model.away)
res<- as.data.frame(res)

a.pred<- predict(model.away,test)
resultaw<- as.data.frame(a.pred)

print(resultaw)
