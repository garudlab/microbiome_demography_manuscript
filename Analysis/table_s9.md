# Table S9

[Supplemental Table 9](../Supplement/Supplemental_Table_9.csv)  details the outputs of the inference of the distribution of fitness effects from the filtered SFSs of 18 species analyzed in this study.

To recreate this table, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for the filtered SFS (HR).
## Fit the Distribution of Fitness Effects (DFE) using `FitDadi`
  An example `.bash` script which fits the DFE using `FitDadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_dfe.bash`](../Scripts/fit_dfe.bash). Uncomment appropriate lines to do so for the filtered SFS (HR).
## [`generate_tables.R`](../Scripts/generate_tables.R)
  This `.R` script generates all novel supplemental tables and saves them automatically in  [`Supplement`](../Supplement/).
