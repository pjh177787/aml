library(caret)
library(EBImage)

set.seed(1022)
thres <- 200

d_test <- read.csv("test.csv")
d_train_all <- read.csv("train.csv")
d_val_all <- read.csv("val.csv")
d_val_temp <- data.frame(matrix(0L, nrow = nrow(d_val_all), ncol = ncol(d_val_all) + 1))
d_val_temp[, 2:ncol(d_val_temp)] <- d_val_all
d_val_all <- d_val_temp

source("util.r")

train_idx <- createDataPartition(d_train_all$X, p = 0.1, list = FALSE, times = 1)
d_train <- d_train_all[train_idx,]
val_idx <- createDataPartition(d_val_all$X2, p = 0.1, list = FALSE, times = 1)
d_val <- d_val_all[val_idx,]

d_train_fit <- fit_img(d_train)
d_val_fit <- fit_img(d_val)

res_10_4 <- rb_train(d_train, d_val, 10, 4)
confs_10_16 <- matrix(unlist(res_10_4[1]), ncol = 10, byrow = TRUE)
accur_10_16 <- unlist(res_10_4[2])

res_10_4_fit <- rb_train(d_train_fit, d_val_fit, 10, 4)
confs_10_16_fit <- matrix(unlist(res_10_4_fit[1]), ncol = 10, byrow = TRUE)
accur_10_16_fit <- unlist(res_10_4_fit[2])

res_10_16 <- rb_train(d_train, d_val, 10, 16)
confs_10_16 <- matrix(unlist(res_10_16[1]), ncol = 10, byrow = TRUE)
accur_10_16 <- unlist(res_10_16[2])

res_10_16_fit <- rb_train(d_train_fit, d_val_fit, 10, 16)
confs_10_16_fit <- matrix(unlist(res_10_16_fit[1]), ncol = 10, byrow = TRUE)
accur_10_16_fit <- unlist(res_10_16_fit[2])

res_30_4 <- rb_train(d_train, d_val, 30, 4)
confs_30_4 <- matrix(unlist(res_30_4[1]), ncol = 10, byrow = TRUE)
accur_30_4 <- unlist(res_30_4[2])

res_30_4_fit <- rb_train(d_train_fit, d_val_fit, 30, 4)
confs_30_4_fit <- matrix(unlist(res_30_4_fit[1]), ncol = 10, byrow = TRUE)
accur_30_4_fit <- unlist(res_30_4_fit[2])

res_30_16 <- rb_train(d_train, d_val, 30, 16)
confs_30_16 <- matrix(unlist(res_30_16[1]), ncol = 10, byrow = TRUE)
accur_30_16 <- unlist(res_30_16[2])

res_30_16_fit <- rb_train(d_train_fit, d_val_fit, 30, 16)
confs_30_16_fit <- matrix(unlist(res_30_16_fit[1]), ncol = 10, byrow = TRUE)
accur_30_16_fit <- unlist(res_30_16_fit[2])

