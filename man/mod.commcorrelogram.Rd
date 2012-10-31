\name{mod.commcorrelogram}
\alias{mod.commcorrelogram}
\alias{mod}
\title{
Community Correlogram Model
}
\description{
Function \code{mod.commcorrelogram} automatically fits a Gaussian curve to the significance plot of a commcorrelogram object and calculates the correlation range of the data.
}

\usage{
mod.commcorrelogram(object,Ch=1,Cc=5,Cw=0.01,plot=T,alpha=0.05,
alternative='one.tailed',pw=5,lgpos='topleft',...)
}

\arguments{
  \item{object}{
A \code{community.correlogram} object
}
  \item{Ch}{
An initial guess for the asymptotic maximum significance. Default = 1. The user is advised to consider values for \code{Ch} appropriate for their particular dataset and specify values accordingly.
}
  \item{Cc}{
An initial guess for the center of the Gaussian curve. Default = 5.  The user is advised to consider values for \code{Cc} appropriate for their particular dataset and specify values accordingly.
}
  \item{Cw}{
An initial guess for the Gaussian curve incline. Default = 0.01.  The user is advised to consider values for \code{Cw} appropriate for their particular dataset and specify values accordingly.
}
  \item{plot}{
A switch specifying whether to plot results. Default = T.
}
  \item{alpha}{
The level of Type I error to be applied to the analysis. Default = 0.05.
}
  \item{alternative}{
        A switch specifying alternative hypothesis for statistical tests to be applied.  Options include: 'one.tailed' = statistic <= 0, 'two.tailed' = statistic = 0. Default = 'one.sided'. Note: This selection must match the alternative hypothesis used in the calculation of \code{link{commcorrelogram}}.
}
  \item{pw}{
Weight given to significance points in proximity of \code{alpha}.  The user is advised to consider values for \code{pw} appropriate for their particular dataset and specify values accordingly.
}
  \item{lgpos}{
    A switch specify position of the legend, and  passed to \code{\link{legend}}. Default = 'topleft'.
}
  \item{\dots}{
Other parameters passed to \code{\link{commcorrelogram}}
}
}
\details{
One of the main purposes of constructing a correlogram is to determine the maximum distance at which the samples are statistically similar, or range of correlation.  Typically, the range of correlation of a multivariate correlogram is determined by finding on the primary plot the class for which the statistic is no longer significant.  However, depending on the lag size and tolerance of the correlogram, this may not be a very precise figure.  Depending on the spatial (or temporal) structure reflected in the plot, or the number of pairs in the deciding lag class, the figure may not be very accurate, either.  

The approach developed here is to instead plot the significance values
of the correlogram in a separate plot and model this plot to determine
the point at which the curve is equal to a chosen Type I error rate
(\code{alpha}, typically 0.05).  In univariate geostatistics, the range of
correlation is typically found by modeling the semivariogram structure
function (Goovaerts, 1997).  To model the correlogram significance plot, we
developed a Gaussian model similar to that used to model univariate
semivariograms:

\deqn{y^s(h) = C_h(1-e^{C_w(h-C_C)^2})}

where \eqn{C_h} is the curve height, \eqn{C_w} the curve width/steepness, \eqn{C_c} the curve center, and h the lag separation.

The \code{mod.commcorrelogram()} function automatically fits this Gaussian curve to \code{\link{commcorrelogram}} objects using the \code{\link{nlminb}} optimization function and calculates the correlation distance (where the resulting curve equals \code{alpha}) using the \code{\link{uniroot}} function.  The function allows the user to provide initial guesses for each parameter and also allows the user to adjust the weight of points that are closest to the \code{alpha} level in the optimization routine.  This enhances the fit of the curve around the \code{alpha} line.   In the case where a two-tailed correlogram has been calculated, the ranges at which the modeled curve crosses the \code{alpha}/2 line (where samples are no longer statistical similar) and where it crosses the 1-\code{alpha}/2 line (where samples become statistically different), called here the "outer range" are reported.
}

\value{
  Returns a list of objects of class community.correlogram, each with
  different lag size used to compute them.
  \item{model.coefficients}{A vector of fitted values for \eqn{C_h}, \eqn{C_c}, and \eqn{C_w}}
  \item{empirical}{The original empirical community correlogram used for modeling}
  \item{predicted}{A dataframe of predicted values against lag separation distance for use in external plotting or other functions}
  \item{range}{The correlation range (one.tailed analyses use model = \code{alpha}, two.tailed analyses use model=\code{alpha}/2)}
  \item{outer.range}{The outer correlation range for two.tailed analyses (model=1-\code{alpha}/2)}

Plots of community correlogram metrics, significance values, modeled significance curve and the correlation range are created when plot=TRUE.
}
\references{
Goovaerts, P. 1997. Geostatistics for natural resources evaluation. Oxford, England: Oxford University Press.
}

\author{
J. Malia Andrus, Timothy Kuehlhorn, Luis F. Rodriguez, Angela D. Kent, and Julie L. Zilles

Maintainer: J. Malia Andrus <jmaliaandrus@gmail.com>
}

\seealso{
  \code{\link{commcorrelogram}}
}

\examples{
  \dontrun{
    data(mite)
      data(mite.xy)
      mite.commcorr <-commcorrelogram(sampleData=mite,
          sampleLocation=cbind(mite.xy,z=0),lagSize=1,lagNumber=7,
          lagTol=0.5,option=1,numTests=9) 
      mod (mite.commcorr,Ch=1,Cc=2.5,Cw=0.8,pw=3)
  }
}

\keyword{ models }
\keyword{ multivariate }
\keyword{ spatial }
\keyword{ chron }
