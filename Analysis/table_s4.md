# Table S4

Supplemental Table 4 details the 95% CI for `nu` and estimated time in years since the most recent demographic event when inferred under a two-epoch demographic model for the core genes of all species analyzed in this study.

To recreate this table, you must:

## Download Data
  Consult [`download_data.md`](./download_data.md).
## Run MIDAS
  Consult [`MIDAS.md`](./MIDAS.md).
## Construct SFSs
  An example `.bash` script which constructs synonymous and nonsynonymous SFSs for all of the species analyzed in this paper can be found at [`../Scripts/compute_sfs.bash`](../Scripts/compute_sfs.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Downsample SFSs
  An example `.bash` script which downsamples SFSs to 14 alleles, as was done for all of the species analyzed in this paper, can be found at [`../Scripts/downsample_sfs.bash`](../Scripts/downsample_sfs.bash).
## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## `plot_likelihood.py`
  As input, this script accepts a synonymous SFS file as specified in `Dadi` format, as well as the output `*demography.txt` from demographic inference. An example `.bash` script which computes likelihood surfaces for all of the species analyzed in this paper can be found at [`../Scripts/plot_likelihood.bash`](../Scripts/plot_likelihood.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## `generate_figures.R`
  This `.R` script generates all novel supplemental tables and saves them automatically in  [`Supplement`](../Supplement).
