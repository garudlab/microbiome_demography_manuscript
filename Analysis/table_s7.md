# Table S7

[Supplemental Table 7](../Supplement/Supplemental_Table_7.csv) details the likelihood ratio test statistic comparing the DFE of core and accessory genes for the 18 species we performed this analysis over.

To recreate this table, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Fit the Distribution of Fitness Effects (DFE) using `FitDadi`
  An example `.bash` script which fits the DFE using `FitDadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_dfe.bash`](../Scripts/fit_dfe.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Compare the DFE between core and accessory genes
  This was performed using two different null expectations: one in which the selection coefficient `s` is assumed constant between two sets of genes, and one in which we assume that the population-scaled selection coefficient `2N_Anc*s` is assumed constant between two sets of genes. Uncomment appropriate lines to do so for core genes and for accessory genes.
  * To compare DFEs using a null expectation of `s`, an example `.bash` script which does so for all of the species analyzed in this paper can be found at [`../Scripts/constant_s_dfe.bash`](../Scripts/constant_s_dfe.bash).
  * To compare DFEs using a null expectation of `2N_Anc*s`, an example `.bash` script which does so for all of the species analyzed in this paper can be found at [`../Scripts/cross_species_dfe_inference.bash`](../Scripts/cross_species_dfe_inference.bash).
## [`generate_tables.R`](../Scripts/generate_tables.R)
  This `.R` script generates all novel supplemental tables and saves them automatically in  [`Supplement`](../Supplement/README.md).
