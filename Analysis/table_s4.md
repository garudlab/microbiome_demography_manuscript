# Table S4

[Supplemental Table 4](../Supplement/Supplemental_Table_4.csv) details the outputs of inference of the distribution of fitness effects for the core genes of all species analyzed in this study.

To recreate this table, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Fit the Distribution of Fitness Effects (DFE) using `FitDadi`
  An example `.bash` script which fits the DFE using `FitDadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_dfe.bash`](../Scripts/fit_dfe.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## [`generate_tables.R`](../Scripts/generate_tables.R)
  This `.R` script generates all novel supplemental tables and saves them automatically in  [`Supplement`](../Supplement/README.md).
