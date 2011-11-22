# R function to call the c code simulation
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
