#include "canonical.h"
/*
 * wrapper function:
 * must pass everything as pointers, so this extra function is easiest way to do so
 * Passing by reference is crucial!!
 *
 * use: R CMD SHLIB Rcanonical.c canonical.c theoryfunctions.c to compile
 * from R, use the canonical.R function to call. Check out its code to see how this uses
 * dyn.load and .C to call the C function.  
 * 
 */

void Rlogistic
(
	double *Xo, 
	double *Ko, 
	double *SIGMA2_K, 
	double *SIGMA2_C, 
	double *R,
	double *MU,
	double *SIGMA2_MU,
	double *MAX_TIME,
	double *ENSEMBLES,
	double *Dt,
	double *dt
){
	PAR parameters;
	parameters.Xo = *Xo;
	parameters.Ko = *Ko;
	parameters.SIGMA2_K = *SIGMA2_K;
	parameters.SIGMA2_C = *SIGMA2_C;
	parameters.R = *R;
	parameters.MU = *MU;
	parameters.SIGMA2_MU = *SIGMA2_MU;

	canonical(
		parameters,
		*MAX_TIME,
		*ENSEMBLES,
		*Dt,
		*dt
	);
}
