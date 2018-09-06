library(caret)

d_train_all <- read.csv("pima-indians-diabetes.csv")
n_col_total <- ncol(d_train_all)
n_row_total <- nrow(d_train_all)

for (i in 1:n_row_total) {
  if (d_train_all[i, 3] == 0)
    d_train_all[i, 3] = NA
  if (d_train_all[i, 4] == 0)
    d_train_all[i, 4] = NA
  if (d_train_all[i, 6] == 0)
    d_train_all[i, 6] = NA
  if (d_train_all[i, 8] == 0)
    d_train_all[i, 8] = NA
}

accuracy <- matrix(ncol = 1, nrow = 50)

for (t in 1:nrow(accuracy)) {
  
  train_idx <- createDataPartition(d_train_all$X1, p = 0.8, list = FALSE, times = 1)
  
  d_test <- d_train_all[ -train_idx,]
  d_train <- d_train_all[train_idx,]
  
  n_col <- ncol(d_train)
  n_row <- nrow(d_train)
  
  lbs <- d_train[, 9]
  
  # From the dataset, first calculate p(x), p(y), and p(x|y)
  # 1. Find p(y) aka prior
  
  prior_0 <- 0
  count_0 <- 0
  for (i in 1:n_row) {
    if (lbs[i] == 0)
      count_0 <- count_0 + 1
  }
  prior_0 <- count_0/n_row
  prior_1 <- 1 - prior_0
  
  # 2. Find p(x|y) aka likelyhood
  normal_param_0 <- matrix(ncol = n_col - 1, nrow =  2)
  normal_param_1 <- matrix(ncol = n_col - 1, nrow =  2)
  
  for (i in 1:(n_col - 1) ) {
    feat_0 <- matrix(count_0, 1)
    feat_1 <- matrix(n_row - count_0, 1)
    n_0 <- 1
    n_1 <- 1
    for (j in 1:n_row) {
      entry = d_train[j, i]
      if (lbs[j] == 0) {
        feat_0[n_0] <- entry
        n_0 <- n_0 + 1
      } else {
        feat_1[n_1] <- entry
        n_1 <- n_1 + 1
      }
    }
    normal_param_0[1, i] <- mean(feat_0, na.rm=TRUE)
    normal_param_0[2, i] <- sqrt(var(feat_0, na.rm=TRUE))
    normal_param_1[1, i] <- mean(feat_1, na.rm=TRUE)
    normal_param_1[2, i] <- sqrt(var(feat_1, na.rm=TRUE))
  }
  
  # 3.Test
  n_row_test <- n_row_total - n_row
  predicts <- matrix(ncol = 1, nrow = n_row_test)
  for (i in 1:n_row_test) {
    prob_0 <- log(prior_0)
    prob_1 <- log(prior_1)
    for (j in 1:(n_col - 1)) {
      entry <- d_test[i, j]
      if (!is.na(entry)) {
        prob_0 <- prob_0 + dnorm(entry, mean = normal_param_0[1, j], sd = normal_param_0[2, j], log = TRUE)
        prob_1 <- prob_1 + dnorm(entry, mean = normal_param_1[1, j], sd = normal_param_1[2, j], log = TRUE)
        # print(prob_0)
      }
    }
    if (prob_1 > prob_0) {
      predicts[i, 1] <- 1
    } else {
      predicts[i, 1] <- 0
    }
  }
  
  correct_count <- 0
  for (l in 1:n_row_test) {
    if (predicts[l, 1] == d_test[l, 9])
      correct_count <- correct_count + 1
  }
  accuracy[t, 1] <- correct_count/n_row_test
}

final_accuracy = mean(accuracy)