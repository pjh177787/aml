library(caret)
set.seed(1022)

thres <- 200

d_test <- read.csv("test.csv")
d_train_all <- read.csv("train.csv")
d_val <- read.csv("val.csv")

train_idx <- createDataPartition(d_train_all$X, p = 0.001, list = FALSE, times = 1)

d_train <- d_train_all[train_idx,]

n_col <- ncol(d_train)
n_row <- nrow(d_train)

lbs <- d_train[, 2]

d_train_fit <- data.frame(matrix(0L, nrow = n_row, ncol = 402))
dim(d_train_fit)
for (i in 1:n_row) {
    img_1d <- d_train[i, 3:n_col]
    img_2d <- matrix(0L, nrow = 28, ncol = 28)
    min_h <- 28
    max_h <- 0
    min_w <- 28
    max_w <- 0
    for (x in 1:28) {
        for(y in 1:28) {
            idx <- x + 28*(y - 1)
            pix <- img_1d[1, idx]
            img_2d[x, y] <- pix
            if (pix != 0) {
                if (x < min_w)
                    min_w <- x
                if (x > max_w)
                    max_w <- x
                if (y < min_h)
                    min_h <- y
                if (y > max_h)
                    max_h <- y
            }
        }
    }
    img_2d_shrink <- img_2d[min_w:max_w, min_h:max_h]
    img_2d_fitted <- resize(img_2d_shrink, w = 20, h = 20)
    d_train_fit[i, 1] <- d_train[i, 1]
    d_train_fit[i, 2] <- d_train[i, 2]
    for (x in 1:20) {
        for (y in 1:20) {
            idx <- x + 20*(y - 1)
            d_train_fit[i, idx + 2] <- img_2d_fitted[x, y]
        }
    }
}

n_col_fit <- ncol(d_train_fit)

# test_img <- matrix(0L, nrow = 20, ncol = 20)
# for (x in 1:20) {
#     for(y in 1:20) {
#         idx <- x + 20*(y - 1) + 1
#         pix <- d_train_fit[4, idx]
#         test_img[x, y] <- pix
#     }
# }
# display(test_img)

# 1. Find prior
priors <- matrix(0L, nrow = 10, ncol = 1)
counts <- matrix(0L, nrow = 10, ncol = 1)
for (i in 1:n_row) {
    lb <- lbs[i] + 1
    counts[lb] <- counts[lb] + 1
}
priors <- counts/n_row

# 2. Find likelyhood
means <- matrix(0L, nrow = 10, ncol = n_col)
stddv <- matrix(0L, nrow = 10, ncol = n_col)
bern1 <- matrix(0L, nrow = 10, ncol = n_col)

for (i in 3:n_col) {
    feat_0 <- matrix(0L, nrow = counts[1], ncol = 2)
    feat_1 <- matrix(0L, nrow = counts[2], ncol = 2)
    feat_2 <- matrix(0L, nrow = counts[3], ncol = 2)
    feat_3 <- matrix(0L, nrow = counts[4], ncol = 2)
    feat_4 <- matrix(0L, nrow = counts[5], ncol = 2)
    feat_5 <- matrix(0L, nrow = counts[6], ncol = 2)
    feat_6 <- matrix(0L, nrow = counts[7], ncol = 2)
    feat_7 <- matrix(0L, nrow = counts[8], ncol = 2)
    feat_8 <- matrix(0L, nrow = counts[9], ncol = 2)
    feat_9 <- matrix(0L, nrow = counts[10], ncol = 2)
    nums <- matrix(0L, nrow = 10, ncol = 1)
    for (j in 1:n_row) {
        entry = d_train[j, i]
        # if (entry > thres)
        #     entry = entry + 500
        if (lbs[j] == 0) {
            nums[1] <- nums[1] + 1
            n <- nums[1]
            if (entry > thres) {
                feat_0[n, 1] <- entry
                feat_0[n, 2] <- 1
            }
        } else if (lbs[j] == 1) {
            nums[2] <- nums[2] + 1
            n <- nums[2]
            if (entry > thres) {
                feat_1[n, 1] <- entry
                feat_1[n, 2] <- 1
            }
        } else if (lbs[j] == 2) {
            nums[3] <- nums[3] + 1
            n <- nums[3]
            if (entry > thres) {
                feat_2[n, 1] <- entry
                feat_2[n, 2] <- 1
            }
        } else if (lbs[j] == 3) {
            nums[4] <- nums[4] + 1
            n <- nums[4]
            if (entry > thres) {
                feat_3[n, 1] <- entry
                feat_3[n, 2] <- 1
            }
        } else if (lbs[j] == 4) {
            nums[5] <- nums[5] + 1
            n <- nums[5]
            if (entry > thres) {
                feat_4[n, 1] <- entry
                feat_4[n, 2] <- 1
            }
        } else if (lbs[j] == 5) {
            nums[6] <- nums[6] + 1
            n <- nums[6]
            if (entry > thres) {
                feat_5[n, 1] <- entry
                feat_5[n, 2] <- 1
            }
        } else if (lbs[j] == 6) {
            nums[7] <- nums[7] + 1
            n <- nums[7]
            if (entry > thres) {
                feat_6[n, 1] <- entry
                feat_6[n, 2] <- 1
            }
        } else if (lbs[j] == 7) {
            nums[8] <- nums[8] + 1
            n <- nums[8]
            if (entry > thres) {
                feat_7[n, 1] <- entry
                feat_7[n, 2] <- 1
            }
        } else if (lbs[j] == 8) {
            nums[9] <- nums[9] + 1
            n <- nums[9]
            if (entry > thres) {
                feat_8[n, 1] <- entry
                feat_8[n, 2] <- 1
            }
        } else if (lbs[j] == 9) {
            nums[10] <- nums[10] + 1
            n <- nums[10]
            if (entry > thres) {
                feat_9[n, 1] <- entry
                feat_9[n, 2] <- 1
            }
        }
    }
    means[1, i] <- mean(feat_0[, 1])
    means[2, i] <- mean(feat_1[, 1])
    means[3, i] <- mean(feat_2[, 1])
    means[4, i] <- mean(feat_3[, 1])
    means[5, i] <- mean(feat_4[, 1])
    means[6, i] <- mean(feat_5[, 1])
    means[7, i] <- mean(feat_6[, 1])
    means[8, i] <- mean(feat_7[, 1])
    means[9, i] <- mean(feat_8[, 1])
    means[10, i] <- mean(feat_9[, 1])
    stddv[1, i] <- sqrt(var(feat_0[, 1]))
    stddv[2, i] <- sqrt(var(feat_1[, 1]))
    stddv[3, i] <- sqrt(var(feat_2[, 1]))
    stddv[4, i] <- sqrt(var(feat_3[, 1]))
    stddv[5, i] <- sqrt(var(feat_4[, 1]))
    stddv[6, i] <- sqrt(var(feat_5[, 1]))
    stddv[7, i] <- sqrt(var(feat_6[, 1]))
    stddv[8, i] <- sqrt(var(feat_7[, 1]))
    stddv[9, i] <- sqrt(var(feat_8[, 1]))
    stddv[10, i] <- sqrt(var(feat_9[, 1]))
    bern1[1, i] <- (sum(feat_0[, 2]) + 1)/counts[1]
    bern1[2, i] <- (sum(feat_1[, 2]) + 1)/counts[2]
    bern1[3, i] <- (sum(feat_2[, 2]) + 1)/counts[3]
    bern1[4, i] <- (sum(feat_3[, 2]) + 1)/counts[4]
    bern1[5, i] <- (sum(feat_4[, 2]) + 1)/counts[5]
    bern1[6, i] <- (sum(feat_5[, 2]) + 1)/counts[6]
    bern1[7, i] <- (sum(feat_6[, 2]) + 1)/counts[7]
    bern1[8, i] <- (sum(feat_7[, 2]) + 1)/counts[8]
    bern1[9, i] <- (sum(feat_8[, 2]) + 1)/counts[9]
    bern1[10, i] <- (sum(feat_9[, 2]) + 1)/counts[10]
}

means_fit <- matrix(0L, nrow = 10, ncol = n_col_fit)
stddv_fit <- matrix(0L, nrow = 10, ncol = n_col_fit)
bern1_fit <- matrix(0L, nrow = 10, ncol = n_col_fit)

for (i in 3:n_col_fit) {
    feat_0 <- matrix(0L, nrow = counts[1], ncol = 2)
    feat_1 <- matrix(0L, nrow = counts[2], ncol = 2)
    feat_2 <- matrix(0L, nrow = counts[3], ncol = 2)
    feat_3 <- matrix(0L, nrow = counts[4], ncol = 2)
    feat_4 <- matrix(0L, nrow = counts[5], ncol = 2)
    feat_5 <- matrix(0L, nrow = counts[6], ncol = 2)
    feat_6 <- matrix(0L, nrow = counts[7], ncol = 2)
    feat_7 <- matrix(0L, nrow = counts[8], ncol = 2)
    feat_8 <- matrix(0L, nrow = counts[9], ncol = 2)
    feat_9 <- matrix(0L, nrow = counts[10], ncol = 2)
    nums <- matrix(0L, nrow = 10, ncol = 1)
    for (j in 1:n_row) {
        entry = d_train_fit[j, i]
        # if (entry > thres)
        #     entry = entry + 500
        if (lbs[j] == 0) {
            nums[1] <- nums[1] + 1
            n <- nums[1]
            if (entry > thres) {
                feat_0[n, 1] <- entry
                feat_0[n, 2] <- 1
            }
        } else if (lbs[j] == 1) {
            nums[2] <- nums[2] + 1
            n <- nums[2]
            if (entry > thres) {
                feat_1[n, 1] <- entry
                feat_1[n, 2] <- 1
            }
        } else if (lbs[j] == 2) {
            nums[3] <- nums[3] + 1
            n <- nums[3]
            if (entry > thres) {
                feat_2[n, 1] <- entry
                feat_2[n, 2] <- 1
            }
        } else if (lbs[j] == 3) {
            nums[4] <- nums[4] + 1
            n <- nums[4]
            if (entry > thres) {
                feat_3[n, 1] <- entry
                feat_3[n, 2] <- 1
            }
        } else if (lbs[j] == 4) {
            nums[5] <- nums[5] + 1
            n <- nums[5]
            if (entry > thres) {
                feat_4[n, 1] <- entry
                feat_4[n, 2] <- 1
            }
        } else if (lbs[j] == 5) {
            nums[6] <- nums[6] + 1
            n <- nums[6]
            if (entry > thres) {
                feat_5[n, 1] <- entry
                feat_5[n, 2] <- 1
            }
        } else if (lbs[j] == 6) {
            nums[7] <- nums[7] + 1
            n <- nums[7]
            if (entry > thres) {
                feat_6[n, 1] <- entry
                feat_6[n, 2] <- 1
            }
        } else if (lbs[j] == 7) {
            nums[8] <- nums[8] + 1
            n <- nums[8]
            if (entry > thres) {
                feat_7[n, 1] <- entry
                feat_7[n, 2] <- 1
            }
        } else if (lbs[j] == 8) {
            nums[9] <- nums[9] + 1
            n <- nums[9]
            if (entry > thres) {
                feat_8[n, 1] <- entry
                feat_8[n, 2] <- 1
            }
        } else if (lbs[j] == 9) {
            nums[10] <- nums[10] + 1
            n <- nums[10]
            if (entry > thres) {
                feat_9[n, 1] <- entry
                feat_9[n, 2] <- 1
            }
        }
    }
    means_fit[1, i] <- mean(feat_0[, 1])
    means_fit[2, i] <- mean(feat_1[, 1])
    means_fit[3, i] <- mean(feat_2[, 1])
    means_fit[4, i] <- mean(feat_3[, 1])
    means_fit[5, i] <- mean(feat_4[, 1])
    means_fit[6, i] <- mean(feat_5[, 1])
    means_fit[7, i] <- mean(feat_6[, 1])
    means_fit[8, i] <- mean(feat_7[, 1])
    means_fit[9, i] <- mean(feat_8[, 1])
    means_fit[10, i] <- mean(feat_9[, 1])
    stddv_fit[1, i] <- sqrt(var(feat_0[, 1]))
    stddv_fit[2, i] <- sqrt(var(feat_1[, 1]))
    stddv_fit[3, i] <- sqrt(var(feat_2[, 1]))
    stddv_fit[4, i] <- sqrt(var(feat_3[, 1]))
    stddv_fit[5, i] <- sqrt(var(feat_4[, 1]))
    stddv_fit[6, i] <- sqrt(var(feat_5[, 1]))
    stddv_fit[7, i] <- sqrt(var(feat_6[, 1]))
    stddv_fit[8, i] <- sqrt(var(feat_7[, 1]))
    stddv_fit[9, i] <- sqrt(var(feat_8[, 1]))
    stddv_fit[10, i] <- sqrt(var(feat_9[, 1]))
    bern1_fit[1, i] <- (sum(feat_0[, 2]) + 1)/counts[1]
    bern1_fit[2, i] <- (sum(feat_1[, 2]) + 1)/counts[2]
    bern1_fit[3, i] <- (sum(feat_2[, 2]) + 1)/counts[3]
    bern1_fit[4, i] <- (sum(feat_3[, 2]) + 1)/counts[4]
    bern1_fit[5, i] <- (sum(feat_4[, 2]) + 1)/counts[5]
    bern1_fit[6, i] <- (sum(feat_5[, 2]) + 1)/counts[6]
    bern1_fit[7, i] <- (sum(feat_6[, 2]) + 1)/counts[7]
    bern1_fit[8, i] <- (sum(feat_7[, 2]) + 1)/counts[8]
    bern1_fit[9, i] <- (sum(feat_8[, 2]) + 1)/counts[9]
    bern1_fit[10, i] <- (sum(feat_9[, 2]) + 1)/counts[10]
}

# 3. Test
n_row_val <- nrow(d_val)
predicts_norm <- matrix(0L, nrow = n_row_val, ncol = 1)
predicts_bern <- matrix(0L, nrow = n_row_val, ncol = 1)
for (i in 1:n_row_val) {
    probs_norm <- matrix(0L, nrow = 10, ncol = 1)
    probs_bern <- matrix(0L, nrow = 10, ncol = 1)
    for (j in 1:10) {
        probs_norm[j] <- log(priors[j])
        probs_bern[j] <- log(priors[j])
    }
    for (j in 3:n_col) {
        entry <- d_val[i, j-1]
        for (k in 1:10) {
            if (means[k, j] != 0)
                probs_norm[k] <- probs_norm[k] + dnorm(entry, mean = means[k, j], sd = stddv[k, j], log = TRUE)
            if (entry > thres)
                probs_bern[k] <- probs_bern[k] + log(bern1[k, j])
        }
    }
    idx_norm <- arrayInd(which.max(probs_norm), dim(probs_norm))
    idx_bern <- arrayInd(which.max(probs_bern), dim(probs_bern))
    predicts_norm[i] <- idx_norm[, 1] - 1
    predicts_bern[i] <- idx_bern[, 1] - 1
}

predicts_norm_fit <- matrix(0L, nrow = n_row_val, ncol = 1)
predicts_bern_fit <- matrix(0L, nrow = n_row_val, ncol = 1)
for (i in 1:n_row_val) {
    probs_norm <- matrix(0L, nrow = 10, ncol = 1)
    probs_bern <- matrix(0L, nrow = 10, ncol = 1)
    for (j in 1:10) {
        probs_norm[j] <- log(priors[j])
        probs_bern[j] <- log(priors[j])
    }
    for (j in 3:n_col_) {
        entry <- d_val[i, j-1]
        for (k in 1:10) {
            if (means[k, j] != 0)
                probs_norm[k] <- probs_norm[k] + dnorm(entry, mean = means_fit[k, j], sd = stddv_fit[k, j], log = TRUE)
            if (entry > thres)
                probs_bern[k] <- probs_bern[k] + log(bern1_fit[k, j])
        }
    }
    idx_norm <- arrayInd(which.max(probs_norm), dim(probs_norm))
    idx_bern <- arrayInd(which.max(probs_bern), dim(probs_bern))
    predicts_norm_fit[i] <- idx_norm[, 1] - 1
    predicts_bern_fit[i] <- idx_bern[, 1] - 1
}

correct_count_norm <- 0
correct_count_bern <- 0
correct_count_norm_fit <- 0
correct_count_bern_fit <- 0
confusion_mat_norm <- matrix(0L, nrow = 10, ncol = 10)
confusion_mat_bern <- matrix(0L, nrow = 10, ncol = 10)
confusion_mat_norm_fit <- matrix(0L, nrow = 10, ncol = 10)
confusion_mat_bern_fit <- matrix(0L, nrow = 10, ncol = 10)
for (i in 1:n_row_val) {
    real_lb <- d_val[i, 1] + 1
    pred_norm <- predicts_norm[i] + 1
    pred_bern <- predicts_bern[i] + 1
    pred_norm_fit <- predicts_norm_fit[i] + 1
    pred_bern_fit <- predicts_bern_fit[i] + 1
    
    confusion_mat_norm[real_lb, pred_norm] <- confusion_mat_norm[real_lb, pred_norm] + 1
    confusion_mat_bern[real_lb, pred_bern] <- confusion_mat_bern[real_lb, pred_bern] + 1
    confusion_mat_norm_fit[real_lb, pred_norm_fit] <- confusion_mat_norm_fit[real_lb, pred_norm_fit] + 1
    confusion_mat_bern_fit[real_lb, pred_bern_fit] <- confusion_mat_bern_fit[real_lb, pred_bern_fit] + 1
    
    if (pred_norm == real_lb) {
        correct_count_norm <- correct_count_norm + 1
    }
    if (pred_bern == real_lb) {
        correct_count_bern <- correct_count_bern + 1
    }
    if (pred_norm_fit == real_lb) {
        correct_count_norm_fit <- correct_count_norm_fit + 1
    }
    if (pred_bern_fit == real_lb) {
        correct_count_bern_fit <- correct_count_bern_fit + 1
    }
}

accuracy_norm  <- correct_count_norm/n_row_val
accuracy_bern  <- correct_count_bern/n_row_val
accuracy_norm_fit  <- correct_count_norm_fit/n_row_val
accuracy_bern_fit  <- correct_count_bern_fit/n_row_val

