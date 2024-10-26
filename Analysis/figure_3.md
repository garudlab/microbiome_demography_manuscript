# Figure 3

[Figure 3](../Summary/figure_3.jpg) is comprised of a phylogenetically sorted panel of DFEs.

To recreate this figure, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## Fit the Distribution of Fitness Effects (DFE) using `FitDadi`
  An example `.bash` script which fits the DFE using `FitDadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_dfe.bash`](../Scripts/fit_dfe.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## [`generate_figure_3.R`](../Scripts/generate_figure_3.R)
  This `.R` script generates Figure 3 and saves it to [`Summary/figure_3_output.svg`](../Summary/figure_3_output.svg).
