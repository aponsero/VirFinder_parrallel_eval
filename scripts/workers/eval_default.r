#!/usr/bin/env Rscript
args<-commandArgs(TRUE)

inFaFile <- args[1]
output <- args[2]

library(VirFinder)


predResultUser <- VF.pred(inFaFile)
write.table(predResultUser, output, row.names=T, col.names=T, sep="\t")


