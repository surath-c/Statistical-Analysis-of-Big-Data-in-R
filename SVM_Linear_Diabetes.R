# Support Vector Machine (Linear) on Diabetes Data

library(tidyverse)
library(caret)

s <- read.csv(file.choose()) # diabetes.csv
s$Outcome <- as.factor(s$Outcome)

# Split data
set.seed(123)
parts <- createDataPartition(s$Outcome, p = 0.8, list = FALSE)
train <- s[parts, ]
test <- s[-parts, ]

# Train SVM with linear kernel
train_control <- trainControl(method = "cv", number = 5)
model <- train(Outcome ~ ., data = train, method = "svmLinear", trControl = train_control)

# Prediction and accuracy
pred_y <- predict(model, test)
confusionMatrix(pred_y, test$Outcome)
