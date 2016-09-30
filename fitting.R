# used libraries
library(Metrics)
library(caret)
library(randomForest)

# function that calculates classification accuracy
accuracyRF=function(df, ntree, mtry){
  # to reproduce the results
  set.seed(888)
  dataset<-createDataPartition(df$Survived, p = 0.8, list = FALSE)
  training = df[dataset, ]
  testing = df[dataset, ]
  fit <- randomForest(as.factor(Survived) ~ ., data = training, mtry = mtry, importance = TRUE, ntree = ntree)
  pred <- predict(fit, testing[,-1])
  accuracy <- (1 - ce(testing$Survived, pred))*100
  print(ce(testing$Survived, pred))
  return(accuracy)
}

# function that plots variable importance plot
plotImp = function(df, ntree, mtry){
  # to reproduce the results
  set.seed(777)
  dataset <- createDataPartition(df$Survived, p = 0.8, list = FALSE)
  training = df[dataset, ]
  testing = df[dataset, ]
  fit <- randomForest(as.factor(Survived) ~ ., data=training, mtry=mtry, importance=TRUE, ntree=ntree)
  return(varImpPlot(fit, main = "Variable Importance")
  )
}