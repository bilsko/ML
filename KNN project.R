library(ISLR)
library(caTools)
library(class)
library(ggplot2)
head(iris)
str(iris)
stand.features<-scale(iris[1:4])
print(var(stand.features)[1])
# main data point
finald<- cbind(stand.features,iris[5])

# create sample for training
sample.iris<- sample.split(finald$Species,SplitRatio = 0.7)
#subset the data to get the right split

train.iris<- subset(finald,sample.iris==T)
test.iris<- subset(finald,sample.iris==F)

predicted.species<- knn(train.iris[1:4],test.iris[1:4],train.iris$Species, k=2)
print(mean(test.iris$Species != predicted.species))

#choose a K Value
predicted.species<- NULL
error.rate<- NULL

for (i in 1:10){
  set.seed(101)
  predicted.species<- knn(train.iris[1:4],test.iris[1:4],train.iris$Species, k=i)
  error.rate[i] <- mean((test.iris$Species != predicted.species))
}
k.values<- 1:10
error.df<- data.frame(error.rate,k.values)
# plot it now
pl<-ggplot(error.df,aes(x=k.values,y=error.rate)) + geom_point()
print(pl)

