
# Import Library
library(caTools)
library(dbplyr)
library(dplyr)
#import data from spreadsheet
library(readxl)
A13s <- read_excel("C:/Users/bilskim/A-League 2017-2019.xlsx",sheet = "Match Stats")
A13<- A13s[,-c(1:6)]

#correlation to cards
a<- cor(A13,A13$`yellowc h`)
b<- cor(A13,A13$`redcard h`)

b
# Import Library
library(caTools)

cardstrain<- slice(A13,1:463)
cardstest<- slice(A13,464:469)

# Training Data
train.cards = cardstrain

# Testing Data
test.cards = cardstest

#Linear regression
model.hcards<- lm(train.cards$`yellowc h` ~ .,data=train.cards)
print(summary(model.hcards))

model.acards<- lm(train.cards$`yellowc a` ~ .,data=train.cards)
print(summary(model.acards))

#print out resluts and predictions

reshcards<- residuals(model.hcards)
resacards<- residuals(model.acards)

reshcards<- as.data.frame(reshcards)
resacards<- as.data.frame(resacards)

hcards.pred<- predict(model.hcards,test.cards)
acards.pred<- predict(model.acards,test.cards)

hcards.pred<- data.frame(hcards.pred)
acards.pred<-data.frame(acards.pred)

print(tail(hcards.pred))
print(tail(acards.pred))
