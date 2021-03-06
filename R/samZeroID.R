#' Return ID for observations to be set to zero
#'
#' @param fracZero.logit.list The estimated zero model
#' @param logLL the logged library sizes
#' @param gene the gene name
#'
#' @return A boolean, should a zero be introduced or not?
#' @importFrom stats rbinom
samZeroID = function(fracZero.logit.list, logLL, gene){
  if(gene %in% names(fracZero.logit.list$meansLarge)){
    meansLarge = rep(fracZero.logit.list$meansLarge[gene], length(logLL))
    desMat = model.matrix(~meansLarge*logLL)
    zeroProb = expit(desMat %*% fracZero.logit.list$zeroModel)
    as.logical(rbinom(1, 1, zeroProb))
  } else FALSE
}
#' Evaluate the expit function
#' @param x the argument
#' @return the expit of the argument
expit = function(x){
  exp(x)/(1+exp(x))
}