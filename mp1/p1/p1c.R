library(caret)

d_train_all <- read.csv("pima-indians-diabetes.csv")
n_col_total <- ncol(d_train_all)
n_row_total <- nrow(d_train_all)

accuracy <- matrix(ncol = 1, nrow = 10)

# for (t in 1:10) {
  
  train_idx <- createDataPartition(d_train_all$X1, p = 0.8, list = FALSE, times = 1)
  
  d_test <- d_train_all[ -train_idx,]
  d_train <- d_train_all[train_idx,]
  
  n_col <- ncol(d_train)
  n_row <- nrow(d_train)
  
  lbs <- d_train[, 9]
  
  svm <- svmlight(d_train[, 1:8], d_train[, 9], pathsvm = ".")
  pred <- predict(svm, d_test[, 1:8])
  
  correct_count <- 0
  for (i in 1:n_row_test) {
    if (pred[1] == d_test[i, 9])
      correct_count <- correct_count + 1
  }
  accuracy[t, 1] <- correct_count/n_row_test
# }

final_accuracy = mean(accuracy)
