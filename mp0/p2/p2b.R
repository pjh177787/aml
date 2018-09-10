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

source("util.R")

train_idx <- createDataPartition(d_train_all$X, p = 1, list = FALSE, times = 1)
d_train <- d_train_all[train_idx,]
val_idx <- createDataPartition(d_val_all$X2, p = 1, list = FALSE, times = 1)
d_val <- d_val_all[val_idx,]

n_col <- ncol(d_train)
n_row <- nrow(d_train)

lbs <- d_train[, 2] # Labels

d_train_fit <- fit_img(d_train)
d_val_fit <- fit_img(d_val)

write.csv(d_train_fit, file = "d_train_fit.csv")
write.csv(d_val_fit, file = "d_val_fit.csv")

priors <- matrix(0L, nrow = 10, ncol = 1)
counts <- matrix(0L, nrow = 10, ncol = 1)
for (i in 1:n_row) {
    lb <- lbs[i] + 1
    counts[lb] <- counts[lb] + 1
}
priors <- counts/n_row

params <- train(d_train, counts, thres)
params_fit <- train(d_train_fit, counts, thres)

preds <- pred(d_val, priors, params, thres)
preds_fit <- pred(d_val_fit, priors, params_fit, thres)

preds_norm <- matrix(unlist(preds[1]), ncol = 1, byrow = TRUE)
preds_bern <- matrix(unlist(preds[2]), ncol = 1, byrow = TRUE)
preds_norm_fit <- matrix(unlist(preds_fit[1]), ncol = 1, byrow = TRUE)
preds_bern_fit <- matrix(unlist(preds_fit[2]), ncol = 1, byrow = TRUE)

res_norm <- report(d_val[, 2], preds_norm)
res_bern <- report(d_val[, 2], preds_bern)
res_norm_fit <- report(d_val[, 2], preds_norm_fit)
res_bern_fit <- report(d_val[, 2], preds_bern_fit)

confs_norm <- matrix(unlist(res_norm[1]), ncol = 10, byrow = TRUE)
confs_bern <- matrix(unlist(res_bern[1]), ncol = 10, byrow = TRUE)
confs_norm_fit <- matrix(unlist(res_norm_fit[1]), ncol = 10, byrow = TRUE)
confs_bern_fit <- matrix(unlist(res_bern_fit[1]), ncol = 10, byrow = TRUE)
accur_norm <- unlist(res_norm[2])
accur_bern <- unlist(res_bern[2])
accur_norm_fit <- unlist(res_norm_fit[2])
accur_bern_fit <- unlist(res_bern_fit[2])

