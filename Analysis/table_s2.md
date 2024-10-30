# Table S2

[Supplemental Table 2](../Supplement/Supplemental_Table_2.csv) details the outputs of demographic inference for the core genes of all species analyzed in this study.

To recreate this table, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes.
## [`generate_tables.R`](../Scripts/generate_tables.R)
  This `.R` script generates all novel supplemental tables and saves them automatically in  [`Supplement`](../Supplement/README.md).
