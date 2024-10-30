# Figure S11

[Supplemental Figure 11](../Supplement/Supplemental_Figure_11.jpg) shows the comparison of core and accessory gene gamma-distributed selection coefficients for 18 species. Species names are highlighted in red when we can reject the null hypothesis of equivalent DFEs between core and accessory genes.

To recreate this figure, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Fit the Distribution of Fitness Effects (DFE) using `FitDadi`
  An example `.bash` script which fits the DFE using `FitDadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_dfe.bash`](../Scripts/fit_dfe.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Compute the likelihood ratio test for comparing DFEs using `FitDadi`
  An example `.bash` script which compares the DFEs between two sets of genes can be found at [`../Scripts/constant_s_dfe.bash`](../Scripts/constant_s_dfe.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## [`generate_supplemental_figures.R`](../Scripts/generate_supplemental_figures.R)
  This `.R` script generates all Supplemental Figures and saves them to [`../Supplement/`](../Supplement/README.md).
