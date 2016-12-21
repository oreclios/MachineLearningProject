##Project assignmnet:
library(lattice)
library(ggplot2)
library(caret)
library(randomForest)
set.seed(32335)

#Load training and test data sets:
training_set <- read.csv("~/data/pml-training.csv", stringsAsFactors = FALSE)
testing_set <- read.csv("~/data/pml-testing.csv", stringsAsFactors = FALSE)

#Keep only key columns:
testing_set <- testing_set[, colSums(is.na(testing_set)) != nrow(testing_set)]
training_set <- training_set[, colSums(is.na(training_set)) != nrow(training_set)]
training_set_skp <- training_set[, names(training_set) %in% names(testing_set)]
training_set_skp$classe <- training_set$classe

#Make a partition:
inTrain <- createDataPartition(y=training_set_skp$classe, p=0.7, list=FALSE)
training <- training_set_skp[inTrain, ]
testing <- training_set_skp[-inTrain, ]

training <- training[, 8:60]
testing <- testing[, 8:60]

#Make models to predict variable "classe":
modFit_rf <- train(classe ~ ., data=training, method="rf")

#Predict the test set:
pred_rf <- predict(modFit_rf, testing)

#Predict the unknown testing set:
pred_rf_unknown <- predict(modFit_rf, testing_set)



