library(ggplot2)
library(ggrepel)
library(ggsignif)
#install.packages("ggpubr")
library(ggpubr)
library(dplyr)
library(fitdistrplus)
library(scales)
library(reshape2)
library(stringr)
library(ggridges)
library(forcats)
library("ggrepel")
library(patchwork)
library(ape)
library(ggtree)
library(treeio)
# install.packages('plotly')
library(plotly)
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
library(latex2exp)
library(ggvis)
library(pheatmap)
library(ComplexHeatmap)
library(phytools)
# BiocManager::install("ComplexHeatmap")
library(mdthemes)

# BiocManager::install("treeio")
# BiocManager::install("ggtree")

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
options(digits = 15)

data = read.table('../Summary/HighRecombination_species_prevalence.txt', sep=',')
data

names(data) = c('Species', 'Prevalence')

data = data[order(-data$Prevalence, data$Species), ]

data = top_n(data, 50)

plt <- ggplot(data) +
  geom_col(aes(y=fct_reorder(Species, Prevalence), x = Prevalence), fill = 'blue', width = 0.6) +
  theme_bw() +
  xlab('Prevalence in Large Dataset') +
  ylab('Species') +
  ggtitle('Species Prevalence in Korpela') +
  xlim(0, 900)
plt
