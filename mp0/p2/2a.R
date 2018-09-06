# First read CSVs

d_train_in <- read.csv("train.csv")
d_train <- d_train_in[, 2:ncol(d_train_in)]
d_val <- read.csv("val.csv")
d_test <- read.csv("test.csv")

