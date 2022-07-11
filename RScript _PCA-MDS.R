# get pwd and set correct directory
getwd()
setwd("C:/Users/Ismat Ghazal/Documents/From HB Server")

# launch ggplot2
library("ggplot2")

# set metadata with complete 1000 genome file
metadata <- read.table("complete_1000_genomes_sample_list_.tsv", sep = "\t", header = TRUE)

## Make Principal Component Analysis (PCA) Plot
# view head of both files, identify column with similar id content in each
head(metadata)
head(pca1)

# merge pca1 and metadata
merged <- merge(x = pca1, y = metadata, by.x = "V2", by.y = "Sample.name", all = F)

# create colorcoded plot, change axes labels and include title
ggplot(data = merged, aes(V3, V4, color = Population.code)) + geom_point() + xlab("Principal Component 1 (PC1)") + ylab("Principal Component 2 (PC2)") + ggtitle("PCA of selected Asian Populations")



## Multidimensional Scaling Analysis (MDS) Plot
# set strat.mds as newmdsdata
newmdsdata <- read.table("strat.mds", header = TRUE)

# merge metadata and newmdsdata
merged_mds2 <- merge(x = newmdsdata, y = metadata, by.x = "FID", by.y = "Sample.name", all = F)

# non-colorcoded plot of newmdsdata
ggplot(data=newmdsdata, aes(C1,C2)) + geom_point()

# colorcoded plot by population codes
ggplot(data=merged_mds2, aes(C1,C2, color = Population.code)) + geom_point() + ggtitle("Multidimensional Scaling Analysis")
