library(ggplot2)
library(MASS)

# Part (a)
# Fit initial model.
data <- read.csv(file = 'housing.data', header=TRUE, sep="")
model <- lm('MEDV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PTRATIO + B + LSTAT', data = data)
# Produce diagnostic plot.
plot(model, which=5,id.n = 10)
# Produce standardized residual vs fitted value plot.
plot(predict(model), rstandard(model),
     xlab='Fitted value',
     ylab='Standardized Residual')
abline(0,0)

# Part (b)
# Remove outliers.
# data2 <- data[-c(413,373,372,371,370,369,368,366,365),] same lambda
data2 <- data[-c(413,373,372,371,370,369),]
model2 <- lm('MEDV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PTRATIO + B + LSTAT', data = data2)
# Produce diagnostic plot after removing outliers.
plot(model2, which=5, id.n = 10)

# Part (c)
# Produce Box-Cox transformation curve.
lambda_plot <- boxcox(model2)
# Report optimal lambda value.
lambda <- with(lambda_plot, x[which.max(y)])

# Part (d)
# Fit model to transformed dependent variable.
model_transf <- lm('(((MEDV^lambda)-1)/lambda) ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PTRATIO + B + LSTAT', data=data2)
# Plot standardized residuals vs fitted values.
plot((predict(model_transf)*lambda+1)^(1/lambda), rstandard(model_transf),
     xlab='Fitted value',
     ylab='Standardized Residual')
abline(0,0)
# Plot fitted vs true house price.
plot((predict(model_transf)*lambda+1)^(1/lambda),data2$MEDV,
     xlab="Fitted House Price",ylab="True House Price")
abline(a=0,b=1)
