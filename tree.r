require(ape)
require(phangorn)
require(dendextend)
require(tidyverse)
source("~/ggplot_theme.txt")

EF1a_aln = read.phyDat("~/GARNAS_neonectria_EF1a_RPB2_seqs/EF-1a_alnd_refs_w_queries.trimRelalign.labels.aln", type = "DNA", format = "fasta")
RPB2_aln = read.phyDat("~/GARNAS_neonectria_EF1a_RPB2_seqs/RPB2_alnd_refs_w_queries.trimRelalign.labels.aln", type = "DNA", format = "fasta")

#distances
EF1a_dist = dist.ml(EF1a_aln)
RPB2_dist = dist.ml(RPB2_aln)

#neighbor-joining
EF1a_nj = NJ(EF1a_dist)
RPB2_nj = NJ(RPB2_dist)

#root
EF1a_nj = root(EF1a_nj, outgroup = "HM054088.1.Neonectria.discophora", resolve.root = T)
RPB2_nj = root(RPB2_nj, outgroup = "DQ789764.1.Neonectria.coccinea", resolve.root = T)

#plot
plot.phylo(EF1a_nj)
plot.phylo(RPB2_nj)

pdf("~/GARNAS_neonectria_EF1a_RPB2_seqs/EF-1a_NJ.pdf", width = 10, height = 10)
plot.phylo(EF1a_nj)
dev.off()

pdf("~/GARNAS_neonectria_EF1a_RPB2_seqs/RPB2_NJ.pdf", width = 10, height = 10)
plot.phylo(RPB2_nj)
dev.off()


#Or plot dendextend way
EF1a_nj.dend = force.ultrametric(EF1a_nj) %>% as.dendrogram
RPB2_nj.dend = force.ultrametric(RPB2_nj) %>% as.dendrogram

pdf("~/GARNAS_neonectria_EF1a_RPB2_seqs/EF-1a_NJ_col_leaves.pdf", width = 24, height = 10)
ggplot(EF1a_nj.dend  %>% hang.dendrogram(0.05) %>% set("labels_col", k = 8, value = cbPalette), horiz = T)
dev.off()

#cut does not seem to be working properly on ggdend object (i.e. not correctly choosing groups correcty)
pdf("~/GARNAS_neonectria_EF1a_RPB2_seqs/RPB2_NJ_col_leaves.pdf", width = 24, height = 10)
ggplot(RPB2_nj.dend  %>% hang.dendrogram(0.05) %>% set("labels_col", k = 4, value = cbPalette), horiz = T)
dev.off()

#
force.ultrametric<-function(tree,method=c("nnls","extend")){
	method<-method[1]
	if(method=="nnls") tree<-nnls.tree(cophenetic(tree),tree,
	rooted=TRUE,trace=0)
	else if(method=="extend"){
		h<-diag(vcv(tree))
		d<-max(h)-h
		ii<-sapply(1:Ntip(tree),function(x,y) which(y==x),
		y=tree$edge[,2])
		tree$edge.length[ii]<-tree$edge.length[ii]+d
	} else
	cat("method not recognized: returning input tree\n\n")
	tree
}

