# Logistic Regression on Titanic Dataset

# Install and load required packages
install.packages(c("caTools", "ROCR"))
library(caTools)
library(ROCR)

# Load datasets
train <- read.csv(file.choose(), header = TRUE)
test <- read.csv(file.choose(), header = TRUE)
survivelist <- read.csv(file.choose(), header = TRUE)

# Fit logistic model
logistic_model <- glm(Survived ~ Pclass + Sex + Age + SibSp,
                      data = train, family = "binomial")

summary(logistic_model)

# Predict on test set
predict_reg <- predict(logistic_model, test, type = "response")
predict_reg <- ifelse(predict_reg > 0.5, 1, 0)

# Evaluate with confusion matrix
conf_matrix <- table(survivelist$Survived, predict_reg)
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
print(paste("Model Accuracy:", round(accuracy * 100, 2), "%"))
