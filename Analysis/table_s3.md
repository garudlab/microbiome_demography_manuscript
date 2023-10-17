# Table S3

Supplemental Table 3 details the outputs of demographic inference for the core genes of all species analyzed in this study.

To recreate this table, you must:

## Download Data
  Consult [`download_data.md`](./download_data.md).
## Run MIDAS
  Consult [`MIDAS.md`](./MIDAS.md).
## Construct SFSs
  An example `.bash` script which constructs synonymous and nonsynonymous SFSs for all of the species analyzed in this paper can be found at [`../Scripts/compute_sfs.bash`](../Scripts/compute_sfs.bash). Uncomment appropriate lines to do so for core genes.
## Downsample SFSs
  An example `.bash` script which downsamples SFSs to 14 alleles, as was done for all of the species analyzed in this paper, can be found at [`../Scripts/downsample_sfs.bash`](../Scripts/downsample_sfs.bash).
## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes.
## `generate_figures.R`
  This `.R` script generates all novel supplemental tables and saves them automatically in  [`Supplement`](../Supplement).
