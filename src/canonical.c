#include "canonical.h"

void canonical
(
	PAR parameters,
	double MAX_TIME,
	double ENSEMBLES,
	double Dt,
	double dt
){
 

	/* Initialize random number generator*/ 
	gsl_rng * rng = gsl_rng_alloc (gsl_rng_default); 
	gsl_rng_set(rng, time(NULL));

    FILE *full, *data, *theory;	
    full = fopen("full.txt", "w");	
    data = fopen("data.txt", "w");	
    theory = fopen("theory.txt", "w");

    /* initialize ensemble variables */
    double runningAverage[100000]={0};
    double runningVar[100000]={0};

    /* define variable indices */
    double X;             // Trait values for all existing phenotypes
    double Y;             // Invader phenotype
    double prob;          // Probability of surviving extinction, \mathcal{D}

    /* Variables for timing the sampling and invasion events */
    double wait_time;           // time until next event
    double T1=0, T2=0;          // time of next mutation, time of next sample


    /* counters */
    int sample; 				// Indexes the Gillespie samples of the state
    int l;     					// Indexes the current ensemble


    for(l = 0; l < ENSEMBLES; l++){
        X = parameters.Xo;                   
        T1 = 0; T2 = 0;
        sample = 0;                         

        while(T2 < MAX_TIME){
		
            Y = X+gsl_ran_gaussian_ziggurat(rng, sqrt(parameters.SIGMA2_MU) );
			/* Compute wait time and probability */
			ratescalc(rng, X, Y, &parameters, &prob, &wait_time);
		 
			if (T1<T2)
			{ 
				T1 = T1+wait_time; 
				if(prob > gsl_rng_uniform(rng) )
					X = Y; 
            } 
			else 
			{ 
                T2 = T2+Dt; 
                runningAverage[sample] = X+runningAverage[sample]; 
                runningVar[sample] = X*X + runningVar[sample];
                ++sample; 
                fprintf(full, "%6.2lf, %6.4lf, %6d\n", T1, X, l); 
            }

            
        }//end evolution
    }//end ensembles


	/* Print Simulation averages */
    for(sample = 0; sample < MAX_TIME/Dt; sample++)
	{
	    fprintf(data, "%.6e %.6e %.6e\n",
			(float) Dt*sample, 
			(float) runningAverage[sample]/ENSEMBLES, 
			(float) runningVar[sample]/ENSEMBLES - 
				(float) runningAverage[sample]*runningAverage[sample]/(ENSEMBLES*ENSEMBLES) 
		);
	}

//	euler(&parameters, MAX_TIME, theory);
	gslode(&parameters, MAX_TIME, theory);

	fclose(full); 
	fclose(data);
	fclose(theory); 

}


