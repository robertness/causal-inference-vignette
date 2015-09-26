library(dplyr)
library(bnlearn)
panel.cor <- function(x, y, digits=3, prefix="",  ...){
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y, method = "spearman"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  text(0.5, 0.5, txt, cex = 2)
}
set.seed(17)
mapk <- read.delim("Downloads/mapk3.txt") %>%
  sample_n(100) %>%
  select(Mek1.PP, Erk2.PP, Mos.P) %>%
  transmute(Raf = Mos.P, Mek = Mek1.PP, Erk = Erk2.PP) %>%
  lapply(function(item) {
    x <- jitter(item, 2000)
    ifelse(x > 0 , x , 0)
  }) %>%
  as.data.frame 
pairs(mapk, upper.panel = panel.cor)

library(ggplot2)
library(gridExtra)

mapk2 <- mutate(mapk, Mek = ifelse(Mek > quantile(Mek)[3], "high", "low"))
p1 <- ggplot(mapk2, aes(x=Raf, y=Erk, group = Mek)) +
  geom_point(aes(shape=Mek), size = 4) + 
  guides(shape=FALSE)
p2 <- ggplot(filter(mapk2, Mek == "high"), aes(x=Raf, y=Erk)) +
  geom_point(aes(shape="circle"), size = 4) + 
  guides(shape=FALSE)
grid.arrange(p1, p2, ncol=2)

library(bnlearn)
d.data <- discretize(mapk, method = "hartemink", breaks = 8)
.data$dMek <- d.data$Mek    
cdplot(dMek ~ Raf, data = .data)

  gs(undirected = TRUE, debug = TRUE) %>%
  graphviz.plot
  lapply(function(item) {
    x <- jitter(item, 2000)
    ifelse(x > 0 , x , 0)
  }) %>%
  as.data.frame 


pairs(mapk, upper.panel = panel.cor) 
par(mfrow = c(1, 2))
plot(Erk ~ Raf, data = mapk, 
     col = factor(mapk$Mek > .41),
     main = "Raf vs Erk",
     sub = "Red = High Mek")
plot(Erk ~ Raf, data = filter(mapk, Mek > .41), col = "red")
mapk_inh <- read.delim("Downloads/mapk_inh.txt") %>%
  select(Mek1.PP, Erk2.PP, Mos.P) %>%
  transmute(Raf = jitter(Mos.P, 2000), 
            Mek = jitter(Mek1.PP, 2000),
            Erk = runif(length(Erk2.PP), 0, .2)) %>%
  sample_n(100) 
pairs(mapk_inh, main = "Inhibition on Mek",
      upper.panel = panel.cor)

gs(mapk) %>%
  graphviz.plot


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



