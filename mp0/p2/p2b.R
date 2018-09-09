library(caret)
library(EBImage)

set.seed(1022)

thres <- 200

d_test <- read.csv("test.csv")
d_train_all <- read.csv("train.csv")
d_val <- read.csv("val.csv")

train_idx <- createDataPartition(d_train_all$X, p = 0.01, list = FALSE, times = 1)

d_train <- d_train_all[train_idx,]

n_col <- ncol(d_train)
n_row <- nrow(d_train)

lbs <- d_train[, 2]

d_train_fit <- data.frame(matrix(0L, nrow = n_row, ncol = 402))
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


