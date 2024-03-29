% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Preparation.R
\name{splitToList}
\alias{splitToList}
\title{splits observations in a data frame into a list of data frames, grouped by factors}
\usage{
splitToList(x, by)
}
\arguments{
\item{x}{an object of type data frame}

\item{by}{a factor to split by}
}
\value{
a list of grouped data frames
}
\description{
Splits data into a list of data frames grouped by factors. Observations with the same values
for the specified factor(s) will be grouped together
}
