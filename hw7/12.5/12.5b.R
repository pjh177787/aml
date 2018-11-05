library(ggplot2)
library(glmnet)
library(doParallel)
registerDoParallel(6)

crusio1 <- read.csv('Crusio1.csv')

# Part (b)
# Use columns 4 through 41.
crusio1_b <- crusio1[,c(1,seq(4,41))]
# Drop N/As.
crusio1_b <- na.omit(crusio1_b)
# Drop strains with fewer than 10 rows.
count <- table(unlist(crusio1_b[,1]))
crusio1_s <- subset(crusio1_b, count[crusio1_b[,1]] >= 10)
# Prepare data and labels.
strain <- factor(t(crusio1_s["strain"]))
obs <- crusio1_s[,-1]

# Fit model with multinomial logistic regression and lasso.
cv_model <- cv.glmnet(as.matrix(obs), t(strain), family="multinomial", type.measure="class", alpha=1, parallel = TRUE)
plot(cv_model)

# Find a good lambda and check accuracy over entire dataset.
opt_lambda <- cv_model["lambda.1se"][[1]]
pred <- predict(cv_model, as.matrix(obs), s=opt_lambda, type="class")
# Accuracy
mean(pred == strain)

# Baseline classification accuracy by predicting just random labels is 1/44 = 0.023.
