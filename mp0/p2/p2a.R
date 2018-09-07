library(caret)
set.seed(1022)

d_test <- read.csv("test.csv")
d_train_all <- read.csv("train.csv")
d_val <- read.csv("val.csv")

train_idx <- createDataPartition(d_train_all$X, p = 0.05, list = FALSE, times = 1)

d_test <- d_train_all[ -train_idx,]
d_train <- d_train_all[train_idx,]

n_col <- ncol(d_train)
n_row <- nrow(d_train)

lbs <- d_train[, 2]

# 1. Find prior

priors <- matrix(0L, ncol = 1, nrow = 10)
counts <- matrix(0L, ncol = 1, nrow = 10)
for (i in 1:n_row) {
    lb <- lbs[i] - 1
    counts[lb] <- counts[lb] + 1
}
priors <- counts/n_row

means <- matrix(0L, ncol = n_col - 2, nrow = 10)
stddv <- matrix(0L, ncol = n_col - 2, nrow = 10)
berp0 <- matrix(0L, ncol = n_col - 2, nrow = 10)
berp1 <- matrix(0L, ncol = n_col - 2, nrow = 10)

feats <- matrix(0L, ncol = n_col - 2, nrow = 10)
for (i in 1:n_row) {
    for (j in 3:n_col) {
        lb <- lbs[i] - 1
        r <- j - 2
        temp <- feats[lb, r]
        feats[lb, r] <- temp + d_train[i, j]
    }
}
# for (i in 1:nrow(feats)) {
#     for (j in 1:ncol(feats)) {
#         means[i, j] <- feats[i, j]/counts[j]
#     }
# }