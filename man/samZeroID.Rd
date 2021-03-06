% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/samZeroID.R
\name{samZeroID}
\alias{samZeroID}
\title{Return ID for observations to be set to zero}
\usage{
samZeroID(fracZero.logit.list, logLL, gene)
}
\arguments{
\item{fracZero.logit.list}{The estimated zero model}

\item{logLL}{the logged library sizes}

\item{gene}{the gene name}
}
\value{
A boolean, should a zero be introduced or not?
}
\description{
Return ID for observations to be set to zero
}
