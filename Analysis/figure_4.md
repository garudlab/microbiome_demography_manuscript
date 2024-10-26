# Figure 4

[Figure 4](../Summary/figure_4.jpg) is comprised of 6 scatterplots comparing various evolutionary summary statistics between a full SFS and a filtered SFS (see Methods).

To recreate this figure, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for the full SFS (internally referred to as "FD" or full data), and for the filtered SFS (internally referred to as "HR" or high recombination).
## Fit the Distribution of Fitness Effects (DFE) using `FitDadi`
  An example `.bash` script which fits the DFE using `FitDadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_dfe.bash`](../Scripts/fit_dfe.bash). Uncomment appropriate lines to do so for the full and filtered SFS.
## [`generate_figure_4.R`](../Scripts/generate_figure_4.R)
  This `.R` script generates Figure 4 and saves it to [`Summary/figure_4_output.svg`](../Summary/figure_4_output.svg).
