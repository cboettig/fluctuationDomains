logistic_curve <- function(x){-x*exp(-x*x/2)}

chemostat_curve <- function(x){
		d <- .1
		q <- .1
		(q*x-d/(1-x*d))* (d/x-2*d**2) 
}

SIGMA2_K <- 2
SIGMA2_C <- 1

branching_curve <- function(x){
		-exp( (x^2/2)*(4/SIGMA2_C -1/SIGMA2_K) ) *(SIGMA2_C+exp(2*x^2/SIGMA2_C)*SIGMA2_C-2*SIGMA2_K)*x/ ( (1+exp(2*x^2/SIGMA2_C)^2)*SIGMA2_C*SIGMA2_K)
}
