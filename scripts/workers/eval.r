#!/usr/bin/env Rscript
args<-commandArgs(TRUE)

modFile <- args[1]
inFaFile <- args[2]
output <- args[3]

library(VirFinder)
load(modFile)

predResultUser <- VF.pred.user(inFaFile, VF.trainModUser)
write.table(predResultUser, output, row.names=T, col.names=T, sep="\t")


