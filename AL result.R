library(readxl)
Alehgls <- read_excel("C:/Users/bilskim/A-League 2017-2019.xlsx", sheet = "Match Stats")
homegls <- Alehgls[,c(4,7,8,9,10,11,28,29,32)]

cor(homegls,homegls$`home score`)
#remove columns 
library(caTools)
library(dbplyr)
library(dplyr)

htrain<- slice(homegls,1:467)
htest<- slice(homegls,470:475)

# Training Data
train = htrain

# Testing Data
test = htest

#Linear regression
model.home<- lm(train$`home score` ~ .,data=train)
print(summary(model.home))

re<- residuals(model.home)
re<- as.data.frame(re)

h.pred<- predict(model.home,test)
resultho<- as.data.frame(h.pred)

print(resultho)
