# Ridge Regression Example

# Load MASS for ridge regression
library(MASS)

# Load data
EEO <- read.table("P236.txt", header = TRUE)

# Fit Ridge regression with multiple lambdas
ridge_model <- lm.ridge(ACHV ~ FAM + PEER + SCHOOL,
                        data = EEO,
                        lambda = c(1, 5, 10))

print(ridge_model)

# Automatically select best lambda via GCV
ridge_model_all <- lm.ridge(ACHV ~ FAM + PEER + SCHOOL,
                            data = EEO,
                            lambda = seq(0, 20, 0.1))

select(ridge_model_all)

# Refit with optimal lambda
best_lambda <- 19.95
final_model <- lm.ridge(ACHV ~ FAM + PEER + SCHOOL,
                        data = EEO,
                        lambda = best_lambda)

print(final_model$coef)
