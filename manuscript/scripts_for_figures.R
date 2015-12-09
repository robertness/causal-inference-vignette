library(dplyr)
library(bnlearn)

# Calculate MI

get_mi <- function(x, y, p, base = p, ...){
  disc <- discretize(data.frame(x, y), 
                     method="quantile", 
                     breaks = p) 
  joint <- prop.table(table(disc) + .000001) 
  x_mar <- prop.table(table(disc$x))
  y_mar <- prop.table(table(disc$y))
  joint %>%
    apply(1, function(row) row / y_mar) %>%
    apply(1, function(row) row / x_mar) %>%
    log(base = p) %>%
    {joint * .} %>%
    sum
}

# Function for generating correlation panels
panel.cor <- function(x, y, digits=3, prefix="",  ...){
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y, method = "spearman"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  text(0.5, 0.5, txt, cex = 2)
}
set.seed(67)
# Generating the pairs table
mapk <- read.delim("Downloads/mapk3.txt") %>%
  sample_n(60) %>%
  select(Mek1.PP, Erk2.PP, Mos.P) %>%
  transmute(Raf = Mos.P, Mek = Mek1.PP, Erk = Erk2.PP) %>%
  lapply(function(item) {
    x <- jitter(item, 2500)
    ifelse(x > 0 , x , 0)
  }) %>%
  as.data.frame 
pairs(mapk, upper.panel = panel.cor)

library(ggplot2)
library(gridExtra)
# Zooming in on Erk and Raf
mapk2 <- mutate(mapk, 
                Mek = ifelse(Mek > quantile(Mek)[4], "high", "low"),
                Mek = factor(Mek, levels = c("derp", "low", "high")),
                shape = ifelse(Mek == "low", "circle", "square"))

p1 <- ggplot(mapk2, aes(x=Raf, y=Erk, group = Mek)) +
  geom_point(aes(shape=shape), size = 4) + 
  scale_shape_manual(name = "Mek", labels = c("low", "high"), values = c(1, 16)) +
  guides(shape=FALSE)
p2 <- ggplot(filter(mapk2, Mek == "high"), aes(x=Raf, y=Erk)) +
  geom_point(aes(shape="circle"), size = 4) + 
  guides(shape=FALSE)
grid.arrange(p1, p2, ncol=2)

# CI Test for Erk and Raf
.data <- discretize(mapk, 
           method="quantile", 
           breaks = 3)
ci.test("Erk", "Raf", "Mek", data = .data, test = "x2", debug = T)
ci.test("Raf", "Mek", "Erk", data = .data, test = "x2", debug = T)
ci.test("Erk", "Mek", "Raf", data = .data, test = "x2", debug = T)

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
m <- 1000
set_20 <- rep(0, m)
set_500 <- rep(0, m)
for(i in 1:m){
  x <- matrix(rnorm(20 * 20), ncol = 20)
  cor_x <- cor(x)
  diag(cor_x) <- 0
  set_20[i] <- max(cor_x)
  y <- matrix(rnorm(20 * 500), ncol = 500)
  cor_y <- cor(y)
  diag(cor_y) <- 0
  set_500[i] <- max(cor_y)
}
hist(set_500, main = NULL, col = rgb(0.1,0.1,0.1,0.5), xlim = c(min(set_20) , max(set_500) + .1 ),
     xlab = "Highest measured correlation between protein pairs")
hist(set_20, col = rgb(0.8,0.8,0.8,0.5), add = TRUE)
legend("topright", legend=c("20 proteins", "500 proteins"), cex = c(.5),  lwd=c(4,4), col=c(rgb(0.8,0.8,0.8,0.5), rgb(0.1,0.1,0.1,0.5)))

## conditional dependence figure
library(bnlearn)
do_sim <- function(learning_func){
  set_20 <- rep(0, 500)
  set_100 <- rep(0, 500)
  for(i in 1:length(set_20)){
    print(i)
    x <- as.data.frame(matrix(rnorm(100 * 20), ncol = 20))
    set_20[i] <- narcs(learning_func(x, undirected = TRUE))
    y <- as.data.frame(matrix(rnorm(100 * 100), ncol = 100))
    set_100[i] <- narcs(learning_func(y, undirected = TRUE))
  }
  return(list(set_20 = set_20, set_100 = set_100))
}
#results <- lapply(c(gs, fast.iamb, inter.iamb), do_sim)
#names(results) <- c("gs", "fast.iamb", "inter.iamb")
results1 <- list(gs = do_sim(gs))
hist(results1[["gs"]][["set_100"]], 
     col = rgb(0.1,0.1,0.1,0.5), 
     xlab = "Count of false positive detections of conditional dependence",  
     xlim = c(0, 140),
     ylim = c(0, 130),
     main = NULL, freq = T)
hist(results1[["gs"]][["set_20"]], 
     col = rgb(0.8,0.8,0.8,0.5), 
     add = TRUE,
     freq = T)
legend("top", legend=c("20 proteins", "100 proteins"), cex = 1,  lwd=c(8,8), col=c(rgb(0.8,0.8,0.8,0.5), rgb(0.1,0.1,0.1,0.5)))

## conditional dependence figure
library(bnlearn)
do_sim <- function(learning_func, n, sigma){
  m <- 100
  p1 <- 15
  p2 <- 75
  set_1 <- rep(0, m)
  set_2 <- rep(0, m)
  for(i in 1:length(set_1)){
    print(i)
    x <- as.data.frame(matrix(rnorm(n * p1, sd = sigma), ncol = p1))
    set_1[i] <- narcs(learning_func(x, undirected = TRUE))
    y <- as.data.frame(matrix(rnorm(n * p2, sd = sigma), ncol = p2))
    set_2[i] <- narcs(learning_func(y, undirected = TRUE))
  }
  # return(list(set_1 = set_1, set_2 = set_2))
  hist(set_1, 
       col = rgb(0.1,0.1,0.1,0.5),
       #xlab = NULL,
       #xlab = "Count of false positive detections of conditional dependence",  
       xlim = c(0, 150),
       ylim = c(0, .4),
       freq = FALSE,
       main = paste(n, sigma, sep="-")
       )
  hist(set_2, 
       freq = FALSE,
       col = rgb(0.8,0.8,0.8,0.5), 
       add = TRUE)
#   legend("topright", legend=c(paste(p1, "proteins"), paste(p2, "proteins")), 
#          cex = .5,  
#          lwd=c(4,4), 
#          col=c(rgb(0.8,0.8,0.8,0.5)))
}
# results <- lapply(c(gs, fast.iamb, inter.iamb), do_sim)
# names(results) <- c("gs", "fast.iamb", "inter.iamb")
arg_list <- list(sig1_n5000 = list(learning_func = iamb, sigma = 1, n = 5000),
                 sig1_n50000 = list(learning_func = iamb, sigma = 1, n = 50000),
                 sig5_n5000 = list(learning_func = iamb, sigma = 1000, n = 5000),
                 sig5_n50000 = list(learning_func = iamb, sigma = 1000, n = 50000))
lapply(arg_list, function(args){
  do.call("do_sim", args = args)
})

###### two sample t test
library(dplyr)
library(magrittr)
# Sim the a matrix for two treatment groups of size n * p
# conduct the t test and count the number of p values below alpha
# Return count
count_sig <- function(n, p, s, alpha = .1){
  matrix(rnorm(p * n * 2, sd = s), ncol = p) %>%
  data.frame %>%
  apply(2, function(v){
   t.test(v[1:n], v[(n+1):(2*n)])$p.value
  }) %>%
  is_less_than(alpha) %>%
  sum
}
# Repeat count_sig m times to get a distribution of counts
sig_dist <- function(n, p, s, m){  
  dist <- rep(NA, m)
  for(i in 1:m){
    print(i)
    dist[i] <- count_sig(n, p, s)
  }
  dist
}
# Plot the historgram of counts
plot_case <- function(n, p1, p2, s, m){
  small_p_case <- sig_dist(n, p1, s, m)
  big_p_case <- sig_dist(n, p2, s, m)
  hist(small_p_case, 
       col = rgb(0.1,0.1,0.1,0.5),
       #xlab = NULL,
       xlab = "Count of false positives @ < 10% significance (falsely conclude difference between groups) ",  
       xlim = c(0, 30),
       ylim = c(0, 1),
       freq = FALSE,
       main = paste("n = ", n, "s = ", s, sep=" "),
       sub = "n is number in each group, for 2n total subjects."
  )
  hist(big_p_case, 
       freq = FALSE,
       col = rgb(0.8,0.8,0.8,0.5), 
       add = TRUE)
  legend("topright", legend=c(paste(p1, "proteins"), paste(p2, " proteins")), 
                              cex = 1,  
                              lwd=c(4,4), col=c( rgb(0.1,0.1,0.1,0.5), rgb(0.8,0.8,0.8,0.5)))
}
# Apply to various combinations of arguments
arg_list <- list(small_n_small_sig = list(n = 10, p1 = 50, p2 = 100, s = 1, m = 500),
                 big_n_small_sig = list(n = 50, p1 = 50, p2 = 100, s = 1, m = 500),
                 small_n_big_sig = list(n = 10, p1 = 50, p2 = 100, s = 50, m = 500),
                 big_n_big_sig = list(n = 50, p1 = 50, p2 = 100, s = 50, m = 500))
lapply(arg_list, function(args){
  do.call("plot_case", args = args)
})
# Create a function that calculates the mean of a count distribution
mean_dist <- function(n, p, s){
  mean(sig_dist(n, p, s, m = 500))
} 
# Plot mean counts as a function of n and p
n_set <- c(seq(2,30, by = 1), 40)
p_set <- c(50, 150, 300)
l1 <- sapply(n_set, mean_dist, p = p_set[1])
l2 <-  sapply(n_set, mean_dist, p = p_set[2])
l3  <- sapply(n_set, mean_dist, p = p_set[3])
plot(n_set, l1[1:30], type = "l", xlab = "n", ylab = "mean # false positives in 500 sims", ylim = c(0, 35), col = "darkred")
lines(n_set, l2[1:30], col = "darkblue")
lines(n_set, l3[1:30], col = "darkgreen")
legend("topright", legend=c("p (features) = 50", "p = 150", "p = 300"), cex = .5,  
       lwd=c(4,4, 4), 
       col=c("darkblue", "darkblue", "darkgreen"))
