library("EBImage")
source("util.R")
d_val <- read.csv("val.csv")
d_val_fit <- fit_img(d_val)
img <- d_val_fit[4, 3:ncol(d_val_fit)]
img <- matrix(img, nrow = 20, ncol = 20, byrow = FALSE)
display(img)
