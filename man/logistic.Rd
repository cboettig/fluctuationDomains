\name{logistic}
\alias{logistic}
\title{simulate evolution under the logistic branching model}
\usage{
  logistic(Xo = 1, Ko = 1, SIGMA2_K = 1, SIGMA2_C = 1.01,
    R = 10, MU = 1, SIGMA2_MU = 5e-04, MAX_TIME = 3000,
    ENSEMBLES = 100, Dt = 100, dt = 0.1)
}
\arguments{
  \item{Xo}{starting trait}

  \item{Ko}{carrying capacity}

  \item{SIGMA2_K}{carrying capacity kernel width}

  \item{SIGMA2_C}{competition kernel width (wider means no
  branching)}

  \item{R}{growth rate}

  \item{MU}{mutation rate}

  \item{SIGMA2_MU}{mutation step size}

  \item{MAX_TIME}{simulation time}

  \item{ENSEMBLES}{number of replicates}

  \item{Dt}{sampling time}

  \item{dt}{step size}
}
\value{
  a data frame with evolved trajectories
}
\description{
  simulate evolution under the logistic branching model
}
\details{
  an R function to call the c code for simulation
}
\examples{
X11(w=7, h=3, xpos=-100)
out = logistic(Xo = 2)
print(out)
}

