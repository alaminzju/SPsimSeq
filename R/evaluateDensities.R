#' Evaluate the densities in the estimated SPsimSeq object
#' @param SPobj The SPsimSeq object, with details retained
#' @param newData A character vector of gene names
#' @return a list of estimated densities, breaks and midpoints, one for every
#' gene in newData
#' @export
#' @examples
#' data("zhang.data.sub")
#' # filter genes with sufficient expression (important step to avoid bugs)
#' zhang.counts <- zhang.data.sub$counts
#' MYCN.status  <- zhang.data.sub$MYCN.status
#' # simulate data
#' sim.data.bulk <- SPsimSeq(n.sim = 1, s.data = zhang.counts,
#'                           group = MYCN.status, n.genes = 100, batch.config = 1,
#'                           group.config = c(0.5, 0.5), tot.samples = 20,
#'                           pDE = 0.1, lfc.thrld = 0.5, result.format = "list",
#'                           return.details = TRUE)
#' outDens = evaluateDensities(sim.data.bulk)
#' select.genes <- sample(names(outDens), 4)
#' select.sample = sample(
#' seq_along(sim.data.bulk$detailed.results$exprmt.design$sub.groups), 1)
#' par(mfrow=c(2, 2))
#' for(i in select.genes){
#'      plot(outDens[[i]][[select.sample]]$mids, outDens[[i]][[select.sample]]$gy, type = "l",
#'      xlab = "Outcome", ylab = "Density", main = paste("Gene", i))
#'   }
evaluateDensities <- function(SPobj, newData = names(SPobj$detailed.results$densList)){
  if(!"detailed.results" %in% names(SPobj)){
    stop("Estimated densities needed, try running SPsimSeq with
         return.details = TRUE")
  }
  if(!is.character(newData)){
    stop("Provide a character vector of genes")
  }
  dets = SPobj$detailed.results #details
  names(newData) = newData
  #Construct the appropriate densities
  lapply(newData, function(gene){
    constructDens(returnDens = TRUE,
                  DE.ind.ii = gene %in% dets$cand.DE.genes$nonnull.genes,
                  exprmt.design = dets$exprmt.design,
                  densList.ii = dets$densList[[gene]])
  })
}