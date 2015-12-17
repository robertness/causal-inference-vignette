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
## correlation figure at 20 reps
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
     xlab = "Highest observed correlation between unrelated protein pairs")
hist(set_20, col = rgb(0.8,0.8,0.8,0.5), add = TRUE)
legend("topright", legend=c("20 proteins", "500 proteins"), cex = c(.6),  lwd=c(8,8), col=c(rgb(0.8,0.8,0.8,0.5), rgb(0.1,0.1,0.1,0.5)))

## Generalization of the above sim
cor_sim <- function(n, p1, p2, m){
  set_1 <- rep(0, m)
  set_2 <- rep(0, m)
  for(i in 1:m){
    print(i)
    x <- matrix(rnorm(n * p1), ncol = p1)
    cor_x <- cor(x)
    diag(cor_x) <- 0
    set_1[i] <- max(cor_x)
    y <- matrix(rnorm(n * p2), ncol = p2)
    cor_y <- cor(y)
    diag(cor_y) <- 0
    set_2[i] <- max(cor_y)
  }
  list(set_1 = set_1, set_2 = set_2)
}
m <- 500
n <- 50
p1 <- 20
p2 <- 5000
r <- cor_sim(n, p1, p2, m)
hist(r$set_2, main = NULL, col = rgb(0.1,0.1,0.1,0.5), xlim = c(min(r$set_1) , max(r$set_2) + .1 ),
     freq = F,
     xlab = "Highest observed correlation between unrelated protein pairs")
hist(r$set_1, col = rgb(0.8,0.8,0.8,0.5), freq = F, add = TRUE)
legend("topleft", legend=c(paste(p1, " proteins"), paste(p2, " proteins")), 
       cex = c(.8),  lwd=c(8,8), col=c(rgb(0.8,0.8,0.8,0.5), rgb(0.1,0.1,0.1,0.5)))



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
legend("top", legend=c("20 proteins", "100 proteins"), cex = .9,  lwd=c(8,8), col=c(rgb(0.8,0.8,0.8,0.5), rgb(0.1,0.1,0.1,0.5)))

## conditional dependence figure
library(bnlearn)
do_sim <- function(learning_func, n, sigma){
  m <- 100
  p1 <- 20
  p2 <- 100
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

# Constrasting with discovery

## Sim relationships
library(bnlearn)
get_true_p <- function(p, prop){
  {function(x) x^2 - x - 2 * choose(p, 2) * prop} %>% # Calculated from the choose function
    uniroot(c(0, p)) %$%
    root %>%
    round
}
simMVNData <- function(num.vars, num.obs, corr){ 
  cov.mat <- matrix(rep(corr, num.vars^2), ncol = num.vars)
  diag(cov.mat) <- 1
  mvrnorm(num.obs, rep(0, num.vars), Sigma=cov.mat) %>%
    as.data.frame 
}
get_performance <- function(inferred_net, true_net){
  arcs(net) %>%
    apply(1, function(r){
      r <- as.character(r)
      r <- sort(r)
      paste(r, collapse = "-")
    }) %>%
  {as.data.frame(t(.))} %>%
    unique %>%
  {rownames(.) <- NULL;.} %>%
    apply(1, function(r){
      r <- as.character(r)
      if(grepl("T", r[1]) && grepl("T", r[2])) return(TRUE)
      return(FALSE)
    }) %>%
  {c(TP_count = sum(.), FP_count = length(.) - sum(.))}
}
# Calculate a set of related pairs that is 5% of all pairs
sim_instance <- function(p, n, true_p_count){
  simMVNData(true_p_count, n, .8) %>%
  setNames(paste0("T", 1:ncol(.))) %>%
  cbind(., simMVNData(p - ncol(.), n, 0)) %>%
  gs(undirected = TRUE) %>%
  get_results
}

repeat_sim <- function(m, args){
  tp = rep(NA, m)
  fp = rep(NA, m)
  print(args)
  for(i in 1:m){
    print(i)
    instance <- do.call("sim_instance", args)
    tp[i] <- instance[1]
    fp[i] <- instance[2]
  }
  list(tp = tp, fp = fp)
}

repeat_sim <- function(m, args){
  tp = rep(NA, m)
  fp = rep(NA, m)
  print(args)
  for(i in 1:m){
    print(i)
    instance <- do.call("sim_instance", args)
    tp[i] <- instance[1]
    fp[i] <- instance[2]
  }
  list(tp = tp, fp = fp)
}



# Stablize graph
## This will make it so I get a fixed amount of edges each time.
permute_graph <- function(g){
  in_degree <- igraph::degree(g, mode = "in")
  out_degree <- igraph::degree(g, mode = "out")
  igraph::degree.sequence.game(out_degree, in_degree, method = "simple.no.multiple")
}
as_bn <- function(g){
  g %>%
  igraph.to.graphNEL %>%
  as.bn
}
sim_covariance_with_constant_partials <- function(net, rho){
  net %>%
    amat %>%
    multiply_by(rho) %>%
    {. + diag(nrow(.)) * (abs(min(eigen(.)$values)) + nrow(.))} %>%
    solve  
}
get_edges <- function(net){
  arcs(net) %>%
    apply(1, function(edge) paste(sort(as.character(edge)), collapse = "--")) %>%
    unique
}
compare_nets <- function(inferred, truth){
  true_edges <- get_edges(truth)
  inferred_edges <- get_edges(inferred)
  fp_count <- length(setdiff(inferred_edges, true_edges))
  tp_count <- length(intersect(inferred_edges, true_edges))
  c(tp= tp_count, fp = fp_count)
}


#Sim according to KEGG
library(devtools)
library(ensurer)
library(bninfo)
library(clusterGeneration)
# Get KEGG
source_gist("de6639a871ef36ce1d1c")
small_p <- 20
big_p <- 100
small_n <- 100
big_n <- 200
rho <- .9


# Need to have a way of applying permute edges to the 
do_sim <- function(m, small_p, big_p, n, rho){
  starting_graph <- signalgraph::power_signal_graph(g, small_p)
  scaled_graph <- signalgraph::power_signal_graph(g, big_p, lucy::reverse_edges(starting_graph)
  net <- starting_graph %>%
    permute_graph %>%
    as_bn %>%
    moral 
  small_data <- sim_covariance_with_constant_partials(net, rho) %>%
    {mvrnorm(small_n, rep(0, small_p), Sigma=.)} %>%
    as.data.frame
  noisy_data <- cbind(small_data, matrix(rnorm(small_n * (big_p - small_p)), ncol = big_p - small_p))
  scaled_data <- scaled_graph %>%
    permute_graph %>%
    as_bn %>%
    moral
  
  gs(undirected = TRUE) %>%
    compare_nets(net)
}



small_n <- 100
big_n <- 200
small_p <- 20
big_p <- 100
tpc_small <- get_true_p(small_p, .4)
tpc_big <- get_true_p(big_p, .4)
combos <- list(  
  list(p = small_p, n = small_n, true_p_count = tpc_small),
  list(p = small_p, n = big_n, true_p_count =tpc_small),
  list(p = big_p, n = small_n, true_p_count = tpc_small),
  list(p = big_p, n = big_n, true_p_count = tpc_small),
  list(p = big_p, n = small_n,true_p_count =  tpc_big),
  list(p = big_p, n = big_n, true_p_count = tpc_big)
)
results <- lapply(combos, function(combo){
  do.call("repeat_sim", c(list(m = 50), list(combo)))
})
names(results) <- c("small_p_small_n", "small_p_big_n", "big_p_small_n", "big_p_big_n", "big_p_small_n_w_increase", "big_p_big_n_w_increase")
results$big_p_small_w_increase <- repeat_sim(50, list(big_p, small_n, tpc_big))

#A
hist(results$small_p_small_n$tp, main = NULL, freq = F, col = rgb(0.1,0.1,0.1,0.5), ylim = c(0, .3), xlim = c(10, 30))
hist(results$big_p_small_n$tp, col = rgb(0.8,0.8,0.8,0.5), freq = FALSE, add = TRUE)

#B
hist(results$small_p_big_n$tp, main = NULL, freq = FALSE, col = rgb(0.1,0.1,0.1,0.5), ylim = c(0, .3), xlim = c(10, 30))
hist(results$big_p_big_n$tp, col = rgb(0.8,0.8,0.8,0.5), freq = FALSE, add = TRUE)

#C
hist(results$small_p_small_n$tp, main = NULL, freq = F,  col = rgb(0.1,0.1,0.1,0.5), ylim = c(0, .3), xlim = c(10, 140))
hist(results$big_p_small_n_w_increase$tp, col = rgb(0.8,0.8,0.8,0.5), freq = F, add = TRUE)

#D
hist(results$small_p_big_n$tp, main = NULL, freq = F,  col = rgb(0.1,0.1,0.1,0.5), ylim = c(0, .3), xlim = c(10, 140))
hist(results$big_p_big_n_w_increase$tp, col = rgb(0.8,0.8,0.8,0.5), freq = F, add = TRUE)

#A
hist(results$small_p_small_n$fp, main = NULL, freq = FALSE, col = rgb(0.1,0.1,0.1,0.5), ylim = c(0, .4), xlim = c(0, 148))
hist(results$big_p_small_n$fp, col = rgb(0.8,0.8,0.8,0.5), freq = FALSE, add = TRUE)

#B
hist(results$small_p_big_n$fp, main = NULL, freq = FALSE, col = rgb(0.1,0.1,0.1,0.5), ylim = c(0, .4), xlim = c(0, 148))
hist(results$big_p_big_n$fp, col = rgb(0.8,0.8,0.8,0.5), freq = FALSE, add = TRUE)

#C
hist(results$small_p_small_n$fp, main = NULL, freq = FALSE, col = rgb(0.1,0.1,0.1,0.5), ylim = c(0, .4), xlim = c(0, 148))
hist(results$big_p_small_n_w_increase$fp, col = rgb(0.8,0.8,0.8,0.5), freq = FALSE, add = TRUE)

#D
hist(results$small_p_big_n$fp, main = NULL, freq = FALSE, col = rgb(0.1,0.1,0.1,0.5), ylim = c(0, .4), xlim = c(0, 148))
hist(results$big_p_big_n_w_increase$fp, col = rgb(0.8,0.8,0.8,0.5), freq = F, add = TRUE)

#legend("topright", legend=c("20 proteins", "100 proteins"), cex = c(.6),  lwd=c(8,8), col=c(rgb(0.8,0.8,0.8,0.5), rgb(0.1,0.1,0.1,0.5)))

