\name{CommunityCorrelogram-package}
\alias{CommunityCorrelogram-package}
\alias{CommunityCorrelogram}
\docType{package}
\title{
  Ecological Community Correlogram
}
\description{
  The \code{CommunityCorrelogram} package is designed for the geostatistical analysis of ecological community datasets with either a spatial or temporal distance component.
}
\details{
\tabular{ll}{
Package: \tab CommunityCorrelogram\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2012-10-30\cr
License: \tab GPL-2\cr
Depends: \tab methods, vegan\cr
}
The package includes functions for constructing correlogram structure functions using either the Mantel or ANOSIM statistics, for assisting in selection of an appropriate lag size, and for modeling correlogram significance plots to determine correlation range.  

The \code{commcorrelogram()} package adds functionality over existing Mantel correlogram functions by allowing  directional (anisotropic) restrictions in both the xy (surface) plane and the z (depth) plane, and allowing usage of temporal and spatial information in the same correlogram.  It also contains an automatic modeling function that calculates the correlation distance of communities or other multidimensional datasets.
}

\author{
J. Malia Andrus, Timothy Kuehlhorn, Luis F. Rodriguez, Angela D. Kent, and Julie L. Zilles

Maintainer: J. Malia Andrus <jmaliaandrus@gmail.com>
}

\references{
  See function documentation.
}
\keyword{ package }
\keyword{ multivariate }
\keyword{ spatial }
\keyword{ chron }
