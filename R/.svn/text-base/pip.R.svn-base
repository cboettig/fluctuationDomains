#pip.R
pip <- function(SIGMA2_K = 2, SIGMA2_C = 1 ){

K <- function(x){ exp(-x^2/(2*SIGMA2_K)) }
C <- function(x,y){ exp(-(x-y)^2/(2*SIGMA2_C) ) }
S_sing <- function(y,x)
{
	1 - (K(x)*C(x,y) )/K(y) 

}


X <-( seq(-1, 1, length = 200) )
Y <- X

Sy <- function(y){ mapply(S_sing, x=X, y=y) }
S <- sapply(Y, Sy)


filled.contour(X, Y, S, levels=c(-1, 0, 1), col=c("white", "gray"))
}
