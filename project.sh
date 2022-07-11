#!/usr/bin/bash

# download dataset
wget https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/Global_genome_structure_project/complete_1000_genomes_sample_list_.tsv
wget https://github.com/HackBio-Internship/public_datasets/blob/main/Asia_HLA_Distribution/binary_plink_file/asia.bed.gz?raw=true -O asia.bed.gz
wget https://github.com/HackBio-Internship/public_datasets/blob/main/Asia_HLA_Distribution/binary_plink_file/asia.bim?raw=true -O asia.bim
wget https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/Asia_HLA_Distribution/binary_plink_file/asia.fam

# unzip asia.bed
gunzip asia.bed.gz

# perform pca
plink --bfile asia --pca

# create a pruned set of markers that are not highly correlated
plink --bfile asia --indep-pairwise 1000 10 0.01 --out pruned

# calculate identity by descent score on the pruned marker list
plink --bfile asia  --extract pruned.prune.in --genome -out ibd

# Cluster individuals into homogeneous groups and perform a multidimensional scaling analysis
plink --bfile asia --read-genome ibd.genome --cluster --ppc 1e-3 --cc --mds-plot 2 --out strat