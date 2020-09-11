/* **************************************** *
 *		ODE integration functions			*
 *	Provides GSL ode integrator and			*
 *	a simple euler integrator				*
 * **************************************** */


#include "canonical.h"
#include <gsl/gsl_errno.h>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_odeiv.h>
#define DIM 2
#define NPTS 100.0 // number of points to print out, best as double notation




/* Many good algorithms don't need the Jacobian, so we'll just pass a null pointer */
double *jac = NULL;

void
gslode(void *params, double MAX_TIME, FILE *theory)
{
	PAR pars = *(PAR *)params;

	/* Create our ODE system */
	gsl_odeiv_system sys = {func, jac, DIM, params};

	/* Range of time to simulate*/
	double t = 0.0, t1 = MAX_TIME;
	/* Initial step size, will be modified as needed by adaptive alogorithm */
	double h = 1e-6;
	/* initial conditions */
	double y[DIM] = { pars.Xo, 0.0 };


	/* Define method as Embedded Runge-Kutta Prince-Dormand (8,9) method */
	const gsl_odeiv_step_type * T
	 = gsl_odeiv_step_rk4;
//	 = gsl_odeiv_step_rk8pd;
	/* allocate stepper for our method of correct dimension*/
	gsl_odeiv_step * s
	 = gsl_odeiv_step_alloc (T, DIM);
	/* control will maintain absolute and relative error */
	gsl_odeiv_control * c
	 = gsl_odeiv_control_y_new (1e-6, 0.0);
	/* allocate the evolver */
	gsl_odeiv_evolve * e
	 = gsl_odeiv_evolve_alloc (DIM);

	/*dummy to make easy to switch to regular printing */
	double ti = t1;
	int i;

	/* Uncomment the outer for loop to print *
	 * 100 sample pts at regular intervals   */
	for (i = 1; i <= NPTS; i++){   ti = i * t1 / NPTS;
		while (t < ti)
		{
			int status = gsl_odeiv_evolve_apply (e, c, s,
												&sys,
												&t, t1,
												&h, y);
			if (status != GSL_SUCCESS)
			   break;
//			fprintf(theory,"%.6e %.6e %.6e\n",t,y[0],y[1]); //adaptive mesh
		}
		fprintf(theory,"%.6e %.6e %.6e\n",t,y[0],y[1]);  }

	gsl_odeiv_evolve_free (e);
	gsl_odeiv_control_free (c);
	gsl_odeiv_step_free (s);
}


void euler(void *params, double MAX_TIME, FILE *theory){
	PAR pars = *(PAR *)params;

	double dt = .01;
	int sample;

	double y[DIM] = { pars.Xo, 0.0 };
	double f[DIM];
	double t=0.0;

	for(sample = 0; sample < MAX_TIME/dt; sample++){

		if( sample % (int) (1/dt) == 0)
		{
			fprintf
			(
				theory, "%.6e %.6e %.6e\n",
				dt*sample,
				y[0],
				y[1]
			);
		}
		int status = func(t, y, f, &pars);
		if(status != GSL_SUCCESS)
			break;
		y[0] = y[0] + dt*f[0];
		y[1] = y[1] + dt*f[1];
	}

}
