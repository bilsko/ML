library(ISLR)
purchase<- Caravan[,86]
standardized.Caravan <- scale(Caravan[,-86])

test.index<- 1:1000
test.data<- standardized.Caravan[test.index,]
test.purchase<- purchase[test.index]

train.data <- standardized.Caravan[-test.index,]
train.purchase<-purchase[-test.index]

#KNN model
library(class)
set.seed(101)
predicted.purchase<- knn(train.data,test.data,train.purchase,k=5)

print(head(predicted.purchase))
mean(test.purchase != predicted.purchase)
predicted.purchase = NULL
error.rate = NULL

for(i in 1:20){
  set.seed(101)
  predicted.purchase = knn(train.data,test.data,train.purchase,k=i)
  error.rate[i] = mean(test.purchase != predicted.purchase)
}
print(error.rate)

library(ggplot2)
k.values<- 1:20
error.df<- data.frame(error.rate,k.values)
error.df