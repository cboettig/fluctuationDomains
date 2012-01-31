#' simulate evolution under the logistic branching model
#' 
#' @param Xo starting trait
#' @param Ko carrying capacity
#' @param SIGMA2_K carrying capacity kernel width
#' @param SIGMA2_C competition kernel width (wider means no branching)
#' @param R growth rate
#' @param MU mutation rate
#' @param SIGMA2_MU mutation step size
#' @param MAX_TIME simulation time
#' @param ENSEMBLES number of replicates
#' @param Dt sampling time
#' @param dt step size
#' @return a data frame with evolved trajectories
#' @details an R function to call the c code for simulation
#' @examples
#' X11(w=7, h=3, xpos=-100)
#' out = logistic(Xo = 2)
#' print(out)
#' @export
#' @useDynLib fluctuationDomains 
logistic = function(
	Xo = 1, 
	Ko = 1, 
	SIGMA2_K = 1, 
	SIGMA2_C = 1.01, 
	R = 10,
	MU = 1,
	SIGMA2_MU = 0.0005,
	MAX_TIME =3000,
	ENSEMBLES = 100,
	Dt = 100,
	dt = .1
){
	.C(
		"Rlogistic",
		as.numeric(Xo), 
		as.numeric(Ko), 
		as.numeric(SIGMA2_K), 
		as.numeric(SIGMA2_C), 
		as.numeric(R),
		as.numeric(MU),
		as.numeric(SIGMA2_MU),
		as.numeric(MAX_TIME),
		as.numeric(ENSEMBLES),
		as.numeric(Dt),
		as.numeric(dt)
	)
	resultsplot()
	out = data.frame(Xo, Ko, SIGMA2_K, SIGMA2_C, R, MU, SIGMA2_MU, MAX_TIME, ENSEMBLES, Dt, dt)

}
