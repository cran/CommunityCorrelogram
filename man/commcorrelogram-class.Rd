\name{commcorrelogram-class}
\Rdversion{1.1}
\docType{class}
\alias{commcorrelogram-class}
\alias{mod,commcorrelogram-method}
\alias{plot,commcorrelogram,missing-method}

\title{Class \code{"community.correlogram"}}

\description{
The \code{community.correlogram} class is designed for the geostatistical analysis of ecological community datasets with either a spatial or temporal distance component.
}

\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("commcorrelogram", ...)}, which will be useful for subsequent calls to \code{\link{mod.commcorrelogram}} or \code{plot.commcorrelogram}.
}

\section{Slots}{
  \describe{
    \item{\code{community.correlogram}:}{Object of class \code{"\link{data.frame}"} consisting of:} 
    \describe{
      \item{lag.distance}{The average lag distance separating pairs in the lag class}
      \item{Num.Pairs}{The number of pairs in the lag class}
      \item{statistic}{The value of the statistic (Mantel or ANOSIM) for the lag class}
      \item{significance}{The p-value (adjusted if required) of the statistic}
    }
  }
}

\section{Methods}{
  \describe{
    \item{mod}{\code{signature(object = "commcorrelogram")}: ... } calls \code{mod.commcorrelogram} and automatically fits a Gaussian curve to the significance plot of a commcorrelogram object and calculates the correlation range of the data.

    \item{plot}{\code{signature(x = "commcorrelogram", y = "missing")}: ... } calls \code{plot.commcorrelogram} for custom visual displays of correlograms allowing visualization of spatial correlation within \code{community.correlogram} objects.
	 }
}

\author{
J. Malia Andrus, Timothy Kuehlhorn, Luis F. Rodriguez, Angela D. Kent, and Julie L. Zilles

Maintainer: J. Malia Andrus <jmaliaandrus@gmail.com>
}

\examples{
showClass("commcorrelogram")
}

\keyword{ multivariate }
\keyword{ spatial }
\keyword{ chron }
