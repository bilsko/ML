library(ISLR)
library(e1071)
## classification mode
# default with factor response:
mod <- svm(allsvm$`home score` ~ ., data = allsvm,na.action(allsvm))

# alternatively the traditional interface:
x <- subset(allsvm, select = -allsvm$`home score`)
y <- allsvm$`home score`
mod <- svm(x, y) 

print(mod)
summary(mod)

# test with train data
pred <- predict(mod, x)
# (same as:)
pred <- fitted(mod)

# Check accuracy:
table(pred, y)

# compute decision values and probabilities:
pred <- predict(mod, x, decision.values = TRUE)
attr(pred, "decision.values")[440:444,]
