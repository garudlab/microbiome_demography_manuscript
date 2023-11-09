# Figure S13

Supplemental Figure 13 shows a 2-dimensional scatterplot of ancestral effective population size for core and accessory genes.

To recreate this figure, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## [`generate_supplemental_figures.R`](../Scripts/generate_supplemental_figures.R)
  This `.R` script generates all Supplemental Figures and saves them to [`../Supplement/`](../Supplement/).
