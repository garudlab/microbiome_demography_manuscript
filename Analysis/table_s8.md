# Table S8

[Supplemental Table 8](../Supplement/Supplemental_Table_8.csv) details the outputs of demographic inference from the filtered SFSs of 18 species analyzed in this study.


To recreate this table, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for the filtered SFS (HR).
## [`generate_tables.R`](../Scripts/generate_tables.R)
  This `.R` script generates all novel supplemental tables and saves them automatically in  [`Supplement`](../Supplement/README.md).
