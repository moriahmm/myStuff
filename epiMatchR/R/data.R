#' Raw dataset for toMatch
#'
#' Each Z score from each positive read for each of six samples.
#' Epitope id, individual, time point, sample id, hit, and hit all times
#' are included
#'
#' @docType data
#'
#' @usage data(toMatchRaw)
#'
#' @format A data frame with seven variables:
#'  \describe{
#'   \item{id}{id used to identify the epitope recognized}
#'   \item{MedianZ}{median Z score for measure used to quantify level of antibody specific to epitope}
#'   \item{hit}{describes whether z score high enough to consider antibody present}
#'   \item{hitAllTimes}{describes whether person had antibody at all time points}
#'   \item{time}{describes time point at which sample was obtained}
#'   \item{individual}{name of individual from which sample was obtained}
#'   \item{sampleID}{unique identifier for sample}}
"toMatchRaw"


#' Raw dataset for toSearch1
#'
#' Each Z score from each positive read for each of 8 samples.
#' Epitope id, individual, time point, sample id, hit, and hit all times
#' are included
#'
#' @docType data
#'
#' @usage data(toSearch1Raw)
#'
#' @format A data frame with seven variables:
#'  \describe{
#'   \item{id}{id used to identify the epitope recognized}
#'   \item{MedianZ}{median Z score for measure used to quantify level of antibody specific to epitope}
#'   \item{hit}{describes whether z score high enough to consider antibody present}
#'   \item{hitAllTimes}{describes whether person had antibody at all time points}
#'   \item{time}{describes time point at which sample was obtained}
#'   \item{individual}{name of individual from which sample was obtained}
#'   \item{sampleID}{unique identifier for sample}}
"toSearch1Raw"


#' Raw dataset for toSearch2
#'
#' Each Z score from each positive read for each of 8 samples.
#' Epitope id, individual, time point, sample id, hit, and hit all times
#' are included
#'
#' @docType data
#'
#' @usage data(toSearch2Raw)
#'
#' @format A data frame with seven variables:
#'  \describe{
#'   \item{id}{id used to identify the epitope recognized}
#'   \item{MedianZ}{median Z score for measure used to quantify level of antibody specific to epitope}
#'   \item{hit}{describes whether z score high enough to consider antibody present}
#'   \item{hitAllTimes}{describes whether person had antibody at all time points}
#'   \item{time}{describes time point at which sample was obtained}
#'   \item{individual}{name of individual from which sample was obtained}
#'   \item{sampleID}{unique identifier for sample}}
"toSearch2Raw"


#' List of Epitopes for toMatch
#'
#'List of Epitopes screend for toMatch
#'
#' @docType data
#'
#' @usage data(toMatchEpitopes)
#'
#' @format A data frame with 1 variable:
#'  \describe{
#'   \item{id}{id used to identify the epitope recognized}}
"toMatchEpitopes"

#' List of Epitopes for toSearch1
#'
#'List of Epitopes screend for toSearch1
#'
#' @docType data
#'
#' @usage data(toSearch1Epitopes)
#'
#' @format A data frame with 1 variable:
#'  \describe{
#'   \item{id}{id used to identify the epitope recognized}}
"toSearch1Epitopes"


#' List of Epitopes for toSearch2
#'
#'List of Epitopes screend for toSearch2
#'
#' @docType data
#'
#' @usage data(toSearch2Epitopes)
#'
#' @format A data frame with 1 variable:
#'  \describe{
#'   \item{id}{id used to identify the epitope recognized}}
"toSearch2Epitopes"

#' Metadata for epitope ID's
#'
#' Defines the species, family, and protein name for each epitope
#' id in the dataset
#'
#' @docType data
#'
#' @usage data(epitopeKey)
#'
#' @format A data frame with 4 variables:
#'  \describe{
#'   \item{id}{id used to identify the epitope recognized}
#'   \item{Species}{The species of the pathogen from which the epitope originates}
#'   \item{taxon_family}{family to which that species belongs}
#'   \item{Protein_name}{protein in which the epitope is found}}
"epitopeKey"
