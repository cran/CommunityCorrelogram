\name{commcorrelogram}
\alias{commcorrelogram}

\title{
  Community Correlogram
}

\description{
The function \code{commcorrelogram} computes community correlograms using either the multivariate metric ANOSIM R (Clarke, 1993) or the Mantel statistic (Mantel, 1967), and includes functionality for both directional analyses and combinations of temporal or spatial analyses or both.  The Mantel correlogram was originally proposed by Sokal (1986) and Oden and Sokal (1986). The ANOSIM correlogram is suggested here.
}

\usage{
commcorrelogram(sampleData,sampleTime=NULL,sampleLocation=NULL,
LocationNames=NULL,option=1,metric='anosim',lagNumber,lagSize,lagTol,
numTests=999,anisotropic=FALSE,azimuth,azimuthTol,bandwidth,dipAngle,dipTol,
dipBandwidth,distmeth='bray',mantmeth='spearman',adj='holm',prog=TRUE,
alternative='one.sided')
}

\arguments{
  \item{sampleData}{
    A matrix or dataframe with samples as rows and species or populations as columns
  }
  \item{sampleTime}{
    A numeric, date, or POSIX format vector of sample collection times for the objects in \code{sampleData} (used for temporal analyses only)
  }
  \item{sampleLocation}{
    A matrix or dataframe of xyz, xy (surface) plane and the z (depth) plane, geographical coordinates for  objects in \code{sampleData} (used for spatial analyses only)
  }
  \item{LocationNames}{
    A character vector of location names for the objects in \code{sampleData} (used for temporal analyses grouped by location)
  }
  \item{option}{
    A switch specifying   type of correlogram to be determined (spatial, temporal, or a combintation of both). Options include: 1 = spatial analysis only (provide \code{sampleLocation}), 2 = temporal analysis only (provide \code{sampleTime}), 3 = spatial analysis grouped by sampling event (provide \code{sampleLocation} and \code{sampleTime}), 4 = temporal analysis grouped by sampling location (provide \code{sampleTime} and either \code{sampleLocation} or \code{LocationNames}).  Default = 1.
  }
  \item{metric}{
    A switch specifying statistical test for similarity to be applied. Options include: 'anosim' = ANOSIM Correlogram, 'mantel' = Mantel Correlogram. Default = 'anosim'.
  }
  \item{lagNumber}{
    Number of distance (lag) classes for correlogram
  }
  \item{lagSize}{
    Multiple for which the centers of distance (lag) classes are calculated
  }
  \item{lagTol}{
    Lag tolerance. Default is half the width of each distance (lag) class.
  }
  \item{numTests}{
    Number of permutation tests for significance testing. Default = 999.
  }
  \item{anisotropic}{
    A switch specifying whether sample pairs are restricted by geographic separation angles. Default = F. The user is advised to consider whether     anisotropic analsyses are appropriate for their dataset and specify a value for \code{anisotropic} accordingly.
  }
  \item{azimuth}{
    Direction of sample restriction in the xy plane (degrees)
  }
  \item{azimuthTol}{
    Tolerance of sample restriction angle in the xy plane (degrees)
  }
  \item{bandwidth}{
    Maximum perpendicular distance from vector of sample restriction angle in the z direction
  }
  \item{dipAngle}{
    Direction of sample restriction in the z (depth) direction (degrees)
  }
  \item{dipTol}{
    Tolerance of sample restriction angle in the z direction (degrees)
  }
  \item{dipBandwidth}{
    Maximum perpendicular distance from vector of sample restriction angle in the z direction
  }
  \item{distmeth}{
    A switch specifying  method to be applied  for calculation of  ecological distances between \code{sampleData}. A complete listing of available options are described in  \code{\link[vegan]{vegdist}}. Default = 'bray'.
  }
  \item{mantmeth}{
    A switch specifying method to be applied for calculation of  the Mantel statistic between ecological and geographical or temporal distance matrices.  Default = 'spearman' for Spearman rank correlation.  Other options are 'pearson' and 'kendall', as described in \code{\link{cor}}.
  }
  \item{adj}{
    A switch specifying  method for adjustment of significance values for multiple comparison tests to be applied. Default = 'holm'.  Other options are as in described in \code{\link{p.adjust}}.
  }
  \item{prog}{
    A switch specifying whether to adjust significance progressively as described in Legendre and Legendre (1998, p. 721). Significance for distance class k = correction for k multiple tests.  Default = T.
  }
  \item{alternative}{
    A switch specifying alternative hypothesis for statistical tests to be applied.  Options include: 'one.sided' = statistic <= 0, 'two.sided' = statistic = 0. Default = 'one.sided'.
  }
}

\details{
Mantel correlograms, a form of geostatistical structure function, have often been used in ecological analyses to evaluate the spatial variation of ecological communities or other multidimensional datasets (Mantel, 1967; Oden and Sokal, 1986; Sokal, 1986; Legendre and Legendre, 2012).  The correlogram bins sample pairs by their spatial or temporal separation distance and then plots the average multidimensional similarity between pairs versus their (binned) separation distance; the approach tests whether pairs of samples that are separated by a particular distance are more similar than those that are separated by a different distance. By not including lesser distances in a distance class, recurring or oscillating patterns can be detected as well as gradients.

Basic Mantel correlograms are implemented in both the \code{\link{vegan}} (Oksanen et al., 2012) and \code{ecodist} (Goslee and Urban, 2007) packages; however, anisotropy, or directional differences in spatial structure, is frequently encountered in geostatistical analyses.  The \code{commcorrelogram()} function, unlike other implementations, includes the ability to impose directional restrictions on the distance classes, facilitating identification and characterization of spatial patterns(Andrus et al. 2013).  The current implementation further allows the integration of temporal and spatial data; strictly temporal or spatial correlograms can be performed, or alternatively temporal correlograms holding spatial locations constant or spatial correlograms holding sample times constant are possible.  This functionality allows multiple perspectives of analysis of data that has been collected in several locations over time.

The distance classes are specified by the parameters lag size (\eqn{h}, the interval between distance classes) and lag tolerance (width of the distance classes) and must be optimized for each dataset (see \code{\link{lagSelect}}). To include all samples in one distance class the lag tolerance is set to half the lag size. Directional parameters are standard geostatistical terms, for example as used in the \code{gamv} program of the FORTRAN geostatistics package GS-Lib (Deutsch and Journel, 1998). The azimuth is the direction of the analysis along a horizontal plane, while the allowed variation in this direction is the azimuth tolerance, and the allowed perpendicular distance from the azimuth is the bandwidth.  Similarly, parameters related to deflection from this surface in the depth direction (dip angle, dip tolerance, and dip bandwidth) can also be defined.

Additionally, the function also allows selection of either the ANOSIM R statistic (Clarke and Green, 1988; Clarke, 1993) or the Mantel statistic \eqn{R_M} (Mantel, 1967) as measures of similarity within the correlogram.  In univariate analyses, various statistics have been developed to quantify autocorrelation: e.g. Moran's I (Moran, 1950), Geary's C (1954). The ANOSIM statistic is commonly used in microbial ecology to test differences in community between factor groups, and therefore may be more accessible for microbial ecologists performing spatial or temporal community analyses.  It is a nonparametric statistic based on the ranks of similarities between sample pairs. The similarity metric used to calculate similarity is user-specified.

The implementation of ANOSIM in a correlogram is an adaptation of the
original statistic for pairs of samples separated by a particular
distance rather than for membership in a particular group.  The
statistic is calculated for a specific distance class \eqn{h}:

\deqn{R(h) = \frac{r_{b}(h)-r_{w}(h)}{\frac{1}{4}n(n-1)}}{%
  R(h) = (r_b(h) - r_w(h))/(1/4 * n(n-1))}

where \eqn{r_{b}(h)}{r_b(h)} is the mean rank of similarities for sample pairs between groups (with a separation distance not equal to \eqn{h}), \eqn{r_{w}(h)}{r_w(h)} is the mean rank of similarities for sample pairs within groups (separated by a distance of \eqn{h}), and \eqn{n} is the total number of samples.

Legendre and Legendre (2012) advise adjusting the p-values for each
distance class in a multidimensional correlogram for multiple
comparison.  This function allows the specification of a particular
multiple comparison adjustment via \code{p.adjust} and whether the comparison
should be adjusted progressively or uniformly.  Furthermore, the p-value
can be calculated based on whether a one- or two-tailed test is desired.
For a two-tailed test, the p-value reflects the probability that the
Mantel \eqn{R_M} or ANOSIM \eqn{R} statistic is zero, or in other words, there is no difference in similarity between sample pairs having a particular separation distance
and those that do not.
}

\value{
Returns an object of class \code{community.correlogram}, which is a \code{dataframe} consisting of:

\item{lag.distance}{The average lag distance separating pairs in the lag class}
\item{Num.Pairs}{The number of pairs in the lag class}
\item{statistic}{The value of the statistic (Mantel or ANOSIM) for the lag class}
\item{significance}{The p-value (adjusted if required) of the statistic}
}

\references{
  Andrus, J. M., Matthew D. Porter, Luis F. Rodriguez, Timothy Kuehlhorn, R. A. C. Cooke, Yuanhui Zhang, Angela D. Kent, and Julie L. Zilles. 2013. "Spatial Variation in the Bacterial and Denitrifying Bacterial Community in a Biofilter Treating Subsurface Agricultural Drainage." Microbial Ecology. DOI 10.1007/s00248-013-0286-0.

  Clarke KR, Green RH (1988) Statistical design and analysis for a biological effects study. Mar Ecol-Prog Ser 46 (1-3):213-226.

  Clarke KR (1993) Nonparametric multivariate analyses of changes in community structure. Aust J Ecol 18 (1):117-143.

  Deutsch, C. V. and A. G. Journel. 1998. GSLIB geostatistical software library and user's guide. Oxford: Oxford University Press.

  Geary, R.C. (1954). "The Contiguity Ratio and Statistical Mapping". The Incorporated Statistician 5 (3): 115-145.

  Goslee, S.C. and Urban, D.L. 2007. The ecodist package for dissimilarity-based analysis of ecological data. Journal of Statistical Software 22(7): 1-19.
  
  Legendre, P., and L. Legendre.  1998. Numerical Ecology. 2nd English Edition. Elsevier Science: Amsterdam.

  Legendre, P., and L. Legendre. 2012.  Numerical Ecology. 3rd English Edition. Elsevier Science: Amsterdam.

  Mantel, N. 1967. The detection of disease clustering and a generalized regression approach. Cancer Res. 27: 209-220.

  Moran, P.A.P.(1950). Notes on Continuous Stochastic Phenomena. Biometrika 37 (1): 17-23.

  Oden, N. L. and R. R. Sokal. 1986. Directional autocorrelation: an extension of spatial correlograms to two dimensions. Syst. Zool. 35: 608-617.

  Oksanen, J., F. G. Blanchet, R. Kindt, P. Legendre, P. R. Minchin, R. B. O'Hara, G. L. Simpson, P. Solymos, M. Henry, H. Stevens and H. Wagner (2012). vegan: Community Ecology Package. R package version 2.0-4. http://CRAN.R-project.org/package=vegan

  Sokal, R. R. 1986. Spatial data analysis and historical processes. 29-43 in: E. Diday et al. [eds.] Data analysis and informatics, IV. North-Holland, Amsterdam.
}

\author{
J. Malia Andrus, Timothy Kuehlhorn, Luis F. Rodriguez, Angela D. Kent, and Julie L. Zilles

Maintainer: J. Malia Andrus <jmaliaandrus@gmail.com>
}

\seealso{
  \code{\link{mod.commcorrelogram}}

  \code{\link{lagSelect}}
}

\examples{
#spatial community ANOSIM correlogram
data(mite)
data(mite.xy)
commcorrelogram(sampleData=mite,sampleLocation=cbind(mite.xy,z=0)
,lagSize=0.3,lagNumber=17,lagTol=0.15,option=1,numTests=5)

\dontrun{
  #spatial community Mantel correlogram
  data(mite)
  data(mite.xy)
  commcorrelogram(sampleData=mite,sampleLocation=cbind(mite.xy,z=0)
  ,lagSize=0.3,lagNumber=17,lagTol=0.15,option=1,metric="mantel"
  ,mantmeth="spearman",numTests=9)
  
  #anisotropic community correlograms
  commcorrelogram(sampleData=mite,sampleLocation=cbind(mite.xy,z=0)
  ,lagSize=0.3,lagNumber=8,lagTol=0.15,option=1,anisotropic=TRUE
  ,azimuth=0,azimuthTol=15,bandwidth=2,numTests=9,dipAngle=0
  ,dipTol=90,dipBandwidth=1)
  
  commcorrelogram(sampleData=mite,sampleLocation=cbind(mite.xy,z=0)
  ,lagSize=0.5,lagNumber=10,lagTol=0.25,option=1,anisotropic=TRUE
  ,azimuth=90,azimuthTol=15,bandwidth=2,numTests=9,dipAngle=0
  ,dipTol=90,dipBandwidth=1)
  
  commcorrelogram(sampleData=mite,sampleLocation=cbind(mite.xy,z=0)
  ,lagSize=0.5,lagNumber=10,lagTol=0.25,option=1,anisotropic=TRUE
  ,azimuth=45,azimuthTol=15,bandwidth=2,numTests=9,dipAngle=0
  ,dipTol=90,dipBandwidth=1)
  
  #temporal community correlogram
  data(pyrifos)
  pyrifos.levels<-data.frame(ditch=gl(12,1,length=132),
  dose=factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6),11)),
      week=as.numeric(as.character(gl(11, 12,
      labels=c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24)))))
  commcorrelogram(sampleData=pyrifos,sampleTime=pyrifos.levels$week,
  option=2,lagSize=3,lagTol=1.5,numTests=9,lagNumber=10)
  
  #temporal community correlogram holding location constant
  commcorrelogram(sampleData=pyrifos,sampleTime=pyrifos.levels$week,
  LocationNames=pyrifos.levels$ditch,option=4,lagSize=3,lagTol=1.5,
  numTests=9,lagNumber=10)
}
}
\keyword{ multivariate }
\keyword{ spatial }
\keyword{ chron }
