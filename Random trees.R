# install.packages('rpart')
library(rpart)
tree <- rpart(Kyphosis ~ . , method='class', data= kyphosis)
tail(kyphosis)
printcp(tree)