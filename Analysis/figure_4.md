# Figure 4

Figure 4 is comprised of a phylogenetically sorted panel of DFEs.

To recreate this figure, you must:

1. Download Data
  Consult [`download_data.md`](./download_data.md).
2. Run MIDAS
  Consult [`MIDAS.md`](./MIDAS.md).
3. Construct SFSs
  An example `.bash` script which constructs synonymous and nonsynonymous SFSs for all of the species analyzed in this paper can be found at [`../Scripts/compute_sfs.bash`](../Scripts/compute_sfs.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
4. Downsample SFSs
  An example `.bash` script which downsamples SFSs to 14 alleles, as was done for all of the species analyzed in this paper, can be found at [`../Scripts/downsample_sfs.bash`](../Scripts/downsample_sfs.bash).
5. Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
6. Fit the Distribution of Fitness Effects (DFE) using `FitDadi`
  An example `.bash` script which fits the DFE using `FitDadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_dfe.bash`](../Scripts/fit_dfe.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
7. `generate_figures.R`
  This `.R` script generates all figures and saves them automatically in either [`Summary`](../Summary) or [`Supplement`](../Supplement).
