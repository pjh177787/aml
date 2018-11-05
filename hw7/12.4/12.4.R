library(glmnet)
library(ggplot2)
library(data.table)

# Read the data and set the labels. Encode 1 as cancer and 0 as no cancer.
I2000 <- transpose(read.csv('I2000.csv', header=FALSE, sep=""))
cancer <- read.csv('tissues.csv', header=FALSE, sep="")
cancer[cancer <= 0] <- 0
cancer[cancer > 0] <- 1
cancer$V1 <- as.factor(cancer$V1)

# Use cross validation to find a good lambda.
cv_model <- cv.glmnet(as.matrix(I2000), t(cancer), family="binomial", type.measure="class", alpha=1.0)
plot(cv_model)

# Find a good lambda and check accuracy over entire dataset.
opt_lambda <- cv_model["lambda.1se"][[1]]
pred <- predict(cv_model, as.matrix(I2000), s=opt_lambda, type="class")
# Accuracy
mean(pred == cancer)

# Basline classification accuracy by predicting just 0 is 40/62 = 0.65
