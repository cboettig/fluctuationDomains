#include "canonical.h"

/* Theoretical Jump Moments */
double alpha1(double phi, void *params)
{
	PAR pars = *(PAR *)params;
	return (double) -0.5*pars.Ko*pars.R*pars.MU*pars.SIGMA2_MU*phi*exp(-phi*phi/2.)/pars.SIGMA2_K; 
}

double alpha1_prime(double phi, void *params)
{ 
	PAR pars = *(PAR *)params;
	return (double) -0.5*pars.Ko*pars.R*pars.MU*pars.SIGMA2_MU*(1-phi*phi)*exp(-phi*phi/2.)/pars.SIGMA2_K; 
}


/* */
void ratescalc(
	gsl_rng *rng,
	double X, double Y,
	void *params,  
	double *prob, double *wait_time
	)
{
	PAR pars = *(PAR *)params;

	double N = Nhat(X, pars.Ko, pars.SIGMA2_K);
	*prob = GSL_MAX(
				1 - ( N*C(X,Y, pars.SIGMA2_C)
					/ Nhat(Y, pars.Ko, pars.SIGMA2_K) ),
				0
			);
	*wait_time = gsl_ran_exponential(rng, 1/(pars.R*N*pars.MU) );
}


/* equilibrium population size */
double Nhat(double x, double Ko, double SIGMA2_K)
{
	return Ko*exp(-x*x/(2*SIGMA2_K)); 
}
/* Competition Kernel */
double C(double x, double y, double SIGMA2_C)
{
	return exp(-(x-y)*(x-y)/(2*SIGMA2_C));
}


