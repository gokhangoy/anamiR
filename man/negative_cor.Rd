% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/negative_cor.R
\name{negative_cor}
\alias{negative_cor}
\title{Find the correlation coefficient between each gene and miRNA.}
\usage{
negative_cor(mrna_data, mirna_data, method = c("pearson", "kendall",
  "spearman"), cut.off = -0.5)
}
\arguments{
\item{mrna_data}{differential expressed data in matrix format, with
sample name in columns and gene symbol in rows, which is generated by
\link{differExp_discrete} or \link{differExp_continuous}.}

\item{mirna_data}{differential expressed data in matrix format, with
sample name in columns and miRNA in rows, which is generated by
\link{differExp_discrete} or \link{differExp_continuous}, miRNA should
be miRBase 21 version now.}

\item{method}{methods for calculating correlation coefficient, including
"pearson", "spearman", "kendall". Default is "pearson". From function
\code{\link[stats]{cor}}}

\item{cut.off}{an numeric value indicating a threshold of correlation
coefficient for every potential miRNA-genes interactions. Default is -0.5,
however, if no interaction pass the threshold, this function would add
0.2 value in threshold until at least one interaction passed the threshold.}
}
\value{
matrix format with each row indicating one potential miRNA-target
   gene interaction and seven columns are miRNA, gene, correlation
   coefficient and Fold change, P-adjust value for miRNA and gene.
}
\description{
This function will calculate the correlation coefficient between each gene
and miRNA from differential expressed data, which are produced by
\link{differExp_discrete} or \link{differExp_continuous}. After filtering
the positive and higher than cutoff value of correlation, this function
would return a matrix with seven columns, including miRNA, gene, correlation
coefficients and Fold change, P-adjust value for miRNA and gene. Each
row represents one potential miRNA-target gene interaction.
}
\examples{
## Use the internal dataset
data("mirna", package = "anamiR", envir = environment())
data("pheno.mirna", package = "anamiR", envir = environment())
data("mrna", package = "anamiR", envir = environment())
data("pheno.mrna", package = "anamiR", envir = environment())

## SummarizedExperiment class
require(SummarizedExperiment)
mirna_se <- SummarizedExperiment(
 assays = SimpleList(counts=mirna),
 colData = pheno.mirna)

## SummarizedExperiment class
require(SummarizedExperiment)
mrna_se <- SummarizedExperiment(
 assays = SimpleList(counts=mrna),
 colData = pheno.mrna)

## Finding differential miRNA from miRNA expression data with t.test
mirna_d <- differExp_discrete(
   se = mirna_se,
   class = "ER",
   method = "t.test"
)

## Finding differential mRNA from mRNA expression data with t.test
mrna_d <- differExp_discrete(
   se = mrna_se,
   class = "ER",
   method = "t.test"
)

## Correlation
cor <- negative_cor(mrna_data = mrna_d, mirna_data = mirna_d,
     method = "pearson"
)

}
\seealso{
\code{\link[stats]{cor}} for calculation of correlation.
}
