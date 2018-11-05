At https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.
data, you will find the famous Boston Housing dataset. This consists of 506
data items. Each is 13 measurements, and a house price. The data was
collected by Harrison, D. and Rubinfeld, D.L in the 1970’s (a date which
explains the very low house prices). The dataset has been widely used in
regression exercises, but seems to be waning in popularity. At least one of
the independent variables measures the fraction of population nearby that is
“Black” (their word, not mine). This variable appears to have had a significant
effect on house prices then (and, sadly, may still now).

(a) Regress house price (variable 14) against all others, and use leverage,
Cook’s distance, and standardized residuals to find possible outliers. Produce
a diagnostic plot that allows you to identify possible outliers.

(b) Remove all the points you suspect as outliers, and compute a new regression.
Produce a diagnostic plot that allows you to identify possible
outliers.

(c) Apply a Box-Cox transformation to the dependent variable – what is the
best value of the parameter?

(d) Now transform the dependent variable, build a linear regression, and check
the standardized residuals. If they look acceptable, produce a plot of fitted
house price against true house price
