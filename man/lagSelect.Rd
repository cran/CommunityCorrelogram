\name{lagSelect}
\alias{lagSelect}

\title{
Lag Selection
}

\description{
Function \code{lagSelect} provides multiple community correlograms of varying lag sizes to assist in optimizing lag size and number.
}

\usage{
lagSelect(sampleData,sampleLocation=NULL,sampleTime = NULL,LocationNames=NULL,
lagmin,lagmax,by,option=1,numTests=99,plot=T,anisotropic=F,...)
}

\arguments{
  \item{sampleData}{
    A matrix or dataframe with samples as rows and species or populations as columns
}
  \item{sampleLocation}{
    A matrix or dataframe of xyz, xy (surface) plane and the z (depth) plane, geographical coordinates for  objects in \code{sampleData} (used for spatial analyses only)
}
  \item{sampleTime}{
    A numeric, date, or POSIX format vector of sample collection times for the objects in \code{sampleData} (used for temporal analyses only)
}
  \item{LocationNames}{
    A character vector of location names for the objects in \code{sampleData} (used for temporal analyses grouped by location)
}
  \item{lagmin}{
Minimum lag size to compute in the units of distance (for options 1 and 3) or time (for options 2 and 4)
}
  \item{lagmax}{
Maximum lag size to compute in the units of distance (for options 1 and 3) or time (for options 2 and 4)
}
  \item{by}{
Number to increment tested lag sizes by
}
  \item{option}{
      A switch specifying   type of correlogram to be determined (spatial, temporal, or a combination of both). Options include: 1 = spatial analysis only (provide \code{sampleLocation}), 2 = temporal analysis only (provide \code{sampleTime}), 3 = spatial analysis grouped by sampling event (provide \code{sampleLocation} and \code{sampleTime}), 4 = temporal analysis grouped by sampling location (provide \code{sampleTime} and either \code{sampleLocation} or \code{LocationNames}).  Default = 1.
}
  \item{numTests}{
Number of permutations used to calculate significance. Default = 99.
}
  \item{plot}{
    A switch specifying whether to plot the \code{community.correlogram} calculated from each lag size. Default = T.
}
  \item{anisotropic}{
    A switch specifying whether  an anisotropic analysis should be performed. Default = F. The user is advised to consider whether an anisotropic analsysis is appropriate for their particular dataset and specify a value for \code{anisotropic} accordingly.
}
  \item{\dots}{
Other parameters passed to \code{\link{commcorrelogram}}
}
}
\details{
Optimization of lag size is critical for geostatistical analyses (Goovaerts, 1997). This function provides correlograms over a range of lag distances within user specified minimum and maximum distances, calculated using \code{commcorrelogram()}. 
Some general rules of thumb exist for selection of lag size and number (Journel and Huijbregts, 1978; Legendre and Fortin, 1989):

1. The lag distance must be larger than the smallest sampling distance.

2. A minimum of 30 sample pairs per lag distance is recommended.

3. The maximum distance class should be no more than 2/3 the total sampling site distance.

It is helpful when using this function to use a small value for numTests, to improve speed and reduce computational intensity.
}
\value{
  Returns a list of objects of class \code{community.correlogram}, each with different lag size used to compute them. 

  Plots of community correlogram metrics and significance values are created for each lag size tested when plot = T.
}
\references{
Goovaerts, P. 1997. Geostatistics for natural resources evaluation. Oxford, England: Oxford University Press.

Journel, A. G. and C. J. Huijbregts. 1978. Mining Geostatistics. San Diego, CA: Academic Press.

Legendre, P. and M. J. Fortin. 1989. Spatial Pattern and Ecological Analysis. Vegetatio 80(2): 107-138.
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
    #spatial lag selection
      data(mite)
      data(mite.xy)
      lagSelect(sampleData=mite,sampleLocation=cbind(mite.xy,z=0),lagmin=0.1
      ,lagmax=1,by=0.1,numTests=9)
      
      #temporal lag selection
      data(pyrifos)
      pyrifos.levels<-data.frame(ditch=gl(12,1,length=132),
      dose=factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6),11)),
          week= as.numeric(as.character(gl(11, 12,
          labels=c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24)))))
      lagSelect(sampleData=pyrifos,sampleTime=pyrifos.levels$week,
      option=2,lagmin=1,lagmax=6,by=1,numTests=9)
  }
}

\keyword{ multivariate }
\keyword{ spatial }
\keyword{ chron }
