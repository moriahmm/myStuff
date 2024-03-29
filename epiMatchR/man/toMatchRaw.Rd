% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{toMatchRaw}
\alias{toMatchRaw}
\title{Raw dataset for toMatch}
\format{A data frame with seven variables:
 \describe{
  \item{id}{id used to identify the epitope recognized}
  \item{MedianZ}{median Z score for measure used to quantify level of antibody specific to epitope}
  \item{hit}{describes whether z score high enough to consider antibody present}
  \item{hitAllTimes}{describes whether person had antibody at all time points}
  \item{time}{describes time point at which sample was obtained}
  \item{individual}{name of individual from which sample was obtained}
  \item{sampleID}{unique identifier for sample}}}
\usage{
data(toMatchRaw)
}
\description{
Each Z score from each positive read for each of six samples.
Epitope id, individual, time point, sample id, hit, and hit all times
are included
}
\keyword{datasets}
