# Decision Trees on MTCars

library(rpart)
library(rpart.plot)

# Simple tree
tree_simple <- rpart(mpg ~ disp,
                     data = mtcars,
                     control = rpart.control(maxdepth = 3, minbucket = 1, cp = 0))
prp(tree_simple)

# Tree with more predictors
tree_complex <- rpart(mpg ~ disp + wt + hp,
                      data = mtcars,
                      control = rpart.control(maxdepth = 3, minbucket = 1, cp = 0))
prp(tree_complex)

# Summary
summary(tree_complex)
