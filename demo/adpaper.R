# example calls
library(fluctuationDomains)
## Figure 1
logistic_curve = function(x){-x*exp(-x*x/2)}
chemostat_curve <- function(x, d = 0.1, q = 0.1){
  (q*x-d/(1-x*d))* (d/x-2*d**2)
}
branching_curve <- function(x, SIGMA2_K = 2, SIGMA2_C = 1){
  -exp( (x^2/2)*(4/SIGMA2_C -1/SIGMA2_K) ) *
    (SIGMA2_C+exp(2*x^2/SIGMA2_C)*SIGMA2_C-2*SIGMA2_K)*x /
    ( (1+exp(2*x^2/SIGMA2_C)^2)*SIGMA2_C*SIGMA2_K)
}

landscape(logistic_curve, -3, 3)
landscape(chemostat_curve, 1, 9)
landscape(branching_curve, -.8, .8)

## Figure 2

out = logistic(Xo = 1,  ENSEMBLES = 10^5)
out = logistic(Xo = 2,  ENSEMBLES = 10^5)
out = logistic(Xo = 3,  ENSEMBLES = 10^5, MAX_TIME = 10000)
