\name{landscape}
\alias{landscape}
\title{landscape}
\usage{
  landscape(func, llim = 0, rlim = 1)
}
\arguments{
  \item{func}{the adaptive landscape to plot}

  \item{llim}{lower limit}

  \item{rlim}{upper limit}
}
\value{
  the landscape plot
}
\description{
  plot the adaptive landscapes produced by
  fluctuationDomains
}
\examples{
logistic_curve = function(x){-x*exp(-x*x/2)}
X11(w=5, h=6.5)
landscape(logistic_curve, -3, 3)
}

