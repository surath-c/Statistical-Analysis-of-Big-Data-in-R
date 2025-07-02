# Bagging on MTCars

library(rsample)
library(ipred)
library(caret)
library(ModelMetrics)

set.seed(123)

# Split data
mtcars_split <- initial_split(mtcars, prop = 0.7)
mtcars_train <- training(mtcars_split)
mtcars_test <- testing(mtcars_split)

# Bagging
bagged_model <- bagging(
  formula = mpg ~ disp + hp + drat + wt + qsec + vs + am + gear + carb,
  data = mtcars_train,
  coob = TRUE
)
print(bagged_model)

# 10-fold cross-validation
ctrl <- trainControl(method = "cv", number = 10)
bagged_cv <- train(
  mpg ~ disp + hp + drat + wt + qsec + vs + am + gear + carb,
  data = mtcars_train,
  method = "treebag",
  trControl = ctrl,
  importance = TRUE
)

print(bagged_cv)

# Variable importance plot
plot(varImp(bagged_cv), 20)

# Prediction and RMSE
pred <- predict(bagged_cv, mtcars_test)
print(rmse(pred, mtcars_test$mpg))
