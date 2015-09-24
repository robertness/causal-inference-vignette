# R scripts for generating spurious correlation and conditional dependence histograms.
## correlation figure
set_20 <- rep(0, 500)
set_500 <- rep(0, 500)
for(i in 1:500){
  x <- matrix(rnorm(100 * 20), ncol = 20)
  cor_x <- cor(x)
  diag(cor_x) <- 0
  set_20[i] <- max(cor_x)
  y <- matrix(rnorm(100 * 500), ncol = 500)
  cor_y <- cor(y)
  diag(cor_y) <- 0
  set_500[i] <- max(cor_y)
}
hist(set_500, main = NULL, col = rgb(0.1,0.1,0.1,0.5), xlim = c(min(set_20) , max(set_500) + .1 ),
     xlab = "Highest measured correlation between protein pairs")
hist(set_20, col = rgb(0.8,0.8,0.8,0.5), add = TRUE)
legend("topr", legend=c("20 proteins", "500 proteins"), cex = c(.5),  lwd=c(4,4), col=c(rgb(0.8,0.8,0.8,0.5), rgb(0.1,0.1,0.1,0.5)))

## conditional dependence figure
library(bnlearn)
set_20 <- rep(0, 500)
set_100 <- rep(0, 500)
for(i in 1:length(set_20)){
  print(i)
  x <- as.data.frame(matrix(rnorm(100 * 20), ncol = 20))
  set_20[i] <- narcs(gs(x, undirected = TRUE))
  y <- as.data.frame(matrix(rnorm(100 * 100), ncol = 100))
  set_100[i] <- narcs(gs(y, undirected = TRUE))
}
hist(set_100, col = rgb(0.1,0.1,0.1,0.5), xlab = "Count of false positive detections of conditional dependence",  xlim = c(min(set_20), max(set_100)), 
     main = NULL)
hist(set_20, col = rgb(0.8,0.8,0.8,0.5), add = TRUE)
legend("top", legend=c("20 proteins", "100 proteins"), cex = c(.5),  lwd=c(4,4), col=c(rgb(0.8,0.8,0.8,0.5), rgb(0.1,0.1,0.1,0.5)))
