library(glmnet)
library(ggplot2)
library(doParallel)
library(zoom)


# Part (a)
# Load training data and subsample every 100th point.
train <- read.csv(file = './BlogFeedback/blogData_train.csv', header = FALSE);
train_subsampled <- train[seq(1, nrow(train), 100),]
labels <- as.integer(unlist(train_subsampled[281]))
# Predict dependent variable with Poisson and Lasso. Plot CV deviance of model vs regularization variable.
start_time <- as.numeric(Sys.time())
registerDoParallel(6)
cv_train <- cv.glmnet(as.matrix(train_subsampled[1:280]), t(train_subsampled[281]), family = 'poisson', alpha=1)
end_time <- as.numeric(Sys.time())
paste('Training Time (subsampled):', end_time - start_time)
plot(cv_train)

# Part (b)
pred <- predict(cv_train, newx=as.matrix(train_subsampled[1:280]), s="lambda.min", type="response")
pred <- floor(pred)
actual <- t(train_subsampled[281])
count = 0
for (i in 1:length(pred)) if (pred[i] == actual[i]) count = count + 1
accuracy = count/length(pred)
plot(pred, actual,
     ylab='True value',
     xlab='Fitted value')
abline(0,1)
# zm() # You can zoom now

# Part (c)
test <- read.csv('./BlogFeedback/blogData_test.csv', header=FALSE)
test_subsampled <- test[seq(1, nrow(test), 100),]
pred <- predict(cv_train, newx=as.matrix(test_subsampled[1:280]), s="lambda.min", type="response")
pred <- floor(pred)
actual <- t(test_subsampled[281])
count = 0
for (i in 1:length(pred)) if (pred[i] == actual[i]) count = count + 1
accuracy = count/length(pred)
plot(pred, actual,
     ylab='True value',
     xlab='Fitted value')
abline(0,1)
