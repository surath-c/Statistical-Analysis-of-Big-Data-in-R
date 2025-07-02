# Linear Discriminant Analysis (LDA) on Iris Dataset

library(caret)
library(tidyverse)
library(MASS)

# Load and split data
data("iris")
set.seed(123)
training.samples <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
train.data <- iris[training.samples, ]
test.data <- iris[-training.samples, ]

# Standardize features
preproc.param <- preProcess(train.data, method = c("center", "scale"))
train.transformed <- predict(preproc.param, train.data)
test.transformed <- predict(preproc.param, test.data)

# Fit LDA model
model <- lda(Species ~ ., data = train.transformed)
predictions <- predict(model, test.transformed)

# Accuracy
confusionMatrix(predictions$class, test.transformed$Species)

# Plot Linear Discriminants
lda.data <- cbind(train.transformed, predict(model)$x)
ggplot(lda.data, aes(LD1, LD2, color = Species)) + geom_point()
