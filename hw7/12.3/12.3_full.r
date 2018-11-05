library(glmnet)
library(ggplot2)
library(doParallel)
library(zoom)
# Part (a)
# Load training data.
train <- read.csv(file = './BlogFeedback/blogData_train.csv', header = FALSE);
# Make all counts integers.
labels <- as.integer(unlist(train[281]))
# Predict dependent variable with Poisson and Lasso. Plot CV deviance of model vs regularization variable.
start_time <- as.numeric(Sys.time())
registerDoParallel(6)
cv_train <- cv.glmnet(as.matrix(train[1:280]), t(labels), family = 'poisson', alpha=1, parallel=TRUE)
end_time <- as.numeric(Sys.time())
paste('Training Time (full):', end_time - start_time)
plot(cv_train)

# Choose good lambda.
opt_lambda = cv_train["lambda.min"][[1]]

# Part (b)
# int label accuracy = 0.3932
# double label accuracy = 0.3935
pred <- predict(cv_train, newx=as.matrix(train[1:280]), s=opt_lambda, type="response")
pred <- floor(pred)
actual <- t(train[281])
accuracy <- mean(pred[,1] == actual)
par(pty="s")
plot(pred, actual,
     ylab='True value',
     xlab='Fitted value')
abline(0,1)
# zm() # You can zoom now

# Part (c)
# int label accuracy = 0.4276
# double label accuracy = 0.4291
test <- read.csv('./BlogFeedback/blogData_test.csv', header=FALSE)
pred <- predict(cv_train, newx=as.matrix(test[1:280]), s=opt_lambda, type="response")
pred <- floor(pred)
actual <- t(test[281])
accuracy <- mean(pred[,1] == actual)
par(pty="s")
plot(pred, actual,
     ylab='True value',
     xlab='Fitted value')
abline(0,1)
zm() # You can zoom now
 