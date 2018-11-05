library(ggplot2)
library(glmnet)

crusio1 <- read.csv('Crusio1.csv')

# Use columns 4 through 41.
crusio1_a <- crusio1[,c(2,seq(4,41))]
# Drop N/As.
crusio1_a <- na.omit(crusio1_a)
# Prepare data and labels.
gender <- crusio1_a[,1]
obs <- crusio1_a[,-1]

# Fit model with logistic regression and lasso.
cv_model <- cv.glmnet(as.matrix(obs), t(gender), family="binomial", type.measure="class", alpha=1)
plot(cv_model)

# Find a good lambda and check accuracy over entire dataset.
opt_lambda <- cv_model["lambda.1se"][[1]]
pred <- predict(cv_model, as.matrix(obs), s=opt_lambda, type="class")
# Accuracy
mean(pred == gender)

# Baseline classification accuracy by predicting just m is 461/906 = 0.51