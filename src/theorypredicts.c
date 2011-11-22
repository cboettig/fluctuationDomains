#include "canonical.h"

/* Define the ode system */
int
func (double t, const double y[], double f[], void *params)
{
	PAR pars = *(PAR *)params;
	f[0] = alpha1(y[0], &pars);
	f[1] = 2*y[1]*alpha1_prime(y[0], &pars) 
		+ 2*sqrt(M_2_PI*pars.SIGMA2_MU)*GSL_SIGN(f[0])*alpha1(y[0], &pars);
	return GSL_SUCCESS;
}


