# Figure S6

[Supplemental Figure 6](../Supplement/Supplemental_Figure_6.jpg) shows the distribution of various summary statistics for within-genera and between-genera DFE comparisons: the LRT statistics, E[_s_], and E[_2Na*s_].

To recreate this figure, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Fit the Distribution of Fitness Effects (DFE) using `FitDadi`
  An example `.bash` script which fits the DFE using `FitDadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_dfe.bash`](../Scripts/fit_dfe.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Compare the DFE for all species
  This was performed using two different null expectations: one in which the selection coefficient `s` is assumed constant between two sets of genes, and one in which we assume that the population-scaled selection coefficient `2N_Anc*s` is assumed constant between two sets of genes. Uncomment appropriate lines to do so for core genes and for accessory genes.
  * To compare DFEs using a null expectation of `s`, an example `.bash` script which does so for all of the species analyzed in this paper can be found at [`../Scripts/constant_s_dfe.bash`](../Scripts/constant_s_dfe.bash).
  * To compare DFEs using a null expectation of `2N_Anc*s`, an example `.bash` script which does so for all of the species analyzed in this paper can be found at [`../Scripts/cross_species_dfe_inference.bash`](../Scripts/cross_species_dfe_inference.bash).
## [`generate_supplemental_figures.R`](../Scripts/generate_supplemental_figures.R)
  This `.R` script generates all Supplemental Figures and saves them to [`../Supplement/`](../Supplement/README.md).
