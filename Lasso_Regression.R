# Lasso Regression Example

library(lars)

# Load data (meatspec)
# Columns: 100 predictors + fat outcome
meatspec <- read.csv(file.choose()) 

train <- meatspec[1:172, ]
test <- meatspec[173:215, ]

train_y <- train$fat
train_x <- as.matrix(train[, -101])

# Fit Lasso
lasso_model <- lars(train_x, train_y)

# Plot coefficient paths
plot(lasso_model)

# Cross-validation
cv_out <- cv.lars(train_x, train_y, K = 10, plot.it = TRUE)

# Best t
best_t <- cv_out$index[which.min(cv_out$cv)]
print(paste("Best t:", best_t))

# Predictions
pred <- predict(lasso_model, s = best_t, type = "coefficients", mode = "fraction")
nonzero_coef <- pred$coefficients[pred$coefficients != 0]
print(nonzero_coef)
