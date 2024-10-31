# microbiome_demography_manuscript

## Overview

This is the GitHub repository for Mah, Lohmueller, and Garud 2023, BioRxiv. The entirety of the project and the work that went into it is available via the commit history; however, for ease of viewing, we have organized the directory with helpful `.md` documents describing how to recreate the figures and tables in our study.

This directory includes the following subdirectories:

* [Analysis](./Analysis/): Several `.md` documents describing how to reproduce each figure and table in the main text and supplement.
* [Data](./Data/): Intermediate files used by [Scripts](./Scripts/)
* [HighRecombinationAnalysis](./HighRecombinationAnalysis/): Model and empirical site-frequency-spectra derived from [HighRecombinationData](./HighRecombinationData/)
* [HighRecombinationData](./HighRecombinationData/): Intermediate files used by [Scripts](./Scripts/) to produce the files in [HighRecombinationAnalysis](./HighRecombinationAnalysis/).
* [Scripts](./Scripts/): Scripts used for analysis and plotting.
* [Summary](./Summary/): Figures and Tables for inclusion in the main text, as well as some intermediate outputs
* [Supplement](./Supplement/): All supplemental tables and figures
* [SupplementaryAnalysis](./SupplementaryAnalysis/): Over the course of revisions, we substantially augmented our data set. This directory contains model and empirical site-frequency-spectra used for the revised version of our manuscript.
* [microbiome_evolution_master](./microbiome_evolution_master/): Inherited code from Garud and Good et al. 2019, PLoS Biology

## Necessary steps for all Figures

### Download Data
  Consult [`download_data.md`](./Analysis/download_data.md).
### Run MIDAS
  Consult ['MIDAS.md'](./Analysis/MIDAS.md).
### Construct SFSs
  An example `.bash` script which constructs synonymous and nonsynonymous SFSs for all of the species analyzed in this paper can be found at [`./Scripts/compute_sfs.bash`](./Scripts/compute_sfs.bash). Uncomment appropriate lines to do so for core genes and for accessory genes. To construct SFS's while removing regions of low recombination and selective sweeps, instead you may consult [`./Scripts/high_recombination.bash`](./Scripts/high_recombination.bash).
### Downsample SFSs
  An example `.bash` script which downsamples SFSs to 14 alleles, as was done for all of the species analyzed in this paper, can be found at [`./Scripts/downsample_sfs.bash`](./Scripts/downsample_sfs.bash).
