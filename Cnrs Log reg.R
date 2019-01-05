library(dplyr)
#import data from spreadsheet
library(readxl)
A_League_2017_2019 <- read_excel("C:/Users/bilskim/A-League 2017-2019.xlsx",sheet = "Match Stats")

#create the dataframe 
a14<- A_League_2017_2019[,c(7,8,9,10,11,13,16,18,20,21,22,23,24,26,28,29,31)]

a14s<- slice(a14,1:449)
a15<- slice(a14,450:460)

# Training Data
train = a14s

# Testing Data
test = a15


#logistic regression model
lgmodelhome <- glm(train$`crns h` ~ .,data=train)
f.lgmodelhome <- glm(train$`crns h` ~ .,data=test)

lgmodelaway <- glm(train$`crns a` ~ .,data=train)
f.lgmodelaway <- glm(train$`crns a` ~ .,data=test)

reslgh<- residuals(lgmodelhome)
reslga<- residuals(lgmodelaway)

reslgh<- as.data.frame(reslgh)
reslga<- as.data.frame(reslga)

cnrlgh.pred<- predict(lgmodelhome,test)
cnrlga.pred<- predict(lgmodelaway,test)

resultlgh<- cbind(cnrlgh.pred,test$'cnrs h')
resultlga<- cbind(cnrlga.pred,test$'cnrs a')

colnames(resultlgh) <- c('pred.h','actualh')
colnames(resultlga) <- c('pred.a','actuala')

resultlgh<- as.data.frame(resultlgh)
resultlga<- as.data.frame(resultlga)

print(resultlgh)
print(resultlga)
