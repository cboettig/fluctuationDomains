#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <time.h> 
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <gsl/gsl_math.h>


typedef struct parameters{
	double Xo; 
	double Ko; 
	double SIGMA2_K; 
	double SIGMA2_C; 
	double R;
	double MU;
	double SIGMA2_MU;
}PAR;

/****** Function Prototypes ******/
/* Model */

double Nhat(double x, double Ko, double SIGMA2_K);
double C(double x, double y, double SIGMA2_C);

/* Jump moment equations */
double alpha1(double phi, void *params);
double alpha1_prime(double phi, void *params);

/* Useful functions */
double round( double x);               // rounding 


/*Main function */
void canonical
( 
	PAR parameters,
	double MAX_TIME,
	double ENSEMBLES,
	double Dt,
	double dt
);

void ratescalc
(
	gsl_rng *rng,
	double X, double Y,
	void *params,  
	double *prob, double *wait_time
);

int func (double t, const double y[], double f[], void *params);
void gslode(void *params, double MAX_TIME, FILE *theory);
void euler(void *params, double MAX_TIME, FILE *theory);


