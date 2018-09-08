library(EBImage)

# x <- readImage("sample.png")
# 
# # width and height of the original image
# dim(x)[1:2]
# 
# # scale to a specific width and height
# y <- resize(x, w = 20, h = 20)
# 
# # show the scaled image
# display(y)
# 
# # extract the pixel array
# z <- imageData(y)

d_val <- read.csv("val.csv")
n_row_val <- nrow(d_val)
n_col_val <- ncol(d_val)

img_1d <- d_val[1, 2:n_col_val]
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
img_1d_fitted <- matrix(0L, nrow = 1, ncol = 400)
for (x in 1:20) {
    for (y in 1:20) {
        idx <- x + 20*(y - 1)
        img_1d_fitted[1, idx] <- img_2d_fitted[x, y]
    }
}
