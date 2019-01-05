# Import Library
library(caTools)
library(dbplyr)
library(dplyr)
#import data from spreadsheet
library(readxl)
A_League_2017_2019 <- read_excel("C:/Users/bilskim/A-League 2017-2019.xlsx",sheet = "Match Stats")

#create the dataframe 
a14<- A_League_2017_2019[,c(7,8,9,10,11,13,16,18,20,21,22,23,24,26,28,29,31)]

a14s<- slice(a14,100:467)
a15<- slice(a14,468:469)

# Training Data
train = a14s

# Testing Data
test = a15

#Linear regression
modelhome<- lm(train$`crns h` ~ .,data=train)
print(summary(modelhome))

modelaway<- lm(train$`crns a` ~ .,data=train)
print(summary(modelaway))



resh<- residuals(modelhome)
resa<- residuals(modelaway)

resh<- as.data.frame(resh)
resa<- as.data.frame(resa)

cnrh.pred<- predict(modelhome,test)
cnra.pred<- predict(modelaway,test)

resulth<- as.data.frame(cnrh.pred)
resulta<- as.data.frame(cnra.pred)

print(resulth)
print(resulta)



   

