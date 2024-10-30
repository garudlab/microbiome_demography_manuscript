# Figure 2

[Figure 2](../Summary/figure_2_final.jpg) is comprised of several components.

Figures 2A-B are comprised of the synonymous and nonsynonymous SFSs of empirical and model data.

Figures 2C-D are comprised of the likelihood surfaces of demographic inference performed via `Dadi`.

Figures 2E-F are cartoon diagrams designed in Microsoft Powerpoint to represent the estimated population demographic histories shown in figures 2C and 2D respectively.

Figure 2G is a summarizing scatterplot of the estimates of `nu` and the estimated time in years since the most recent demographic event.

To recreate this figure, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## [`plot_likelihood.py`](../Scripts/plot_likelihood.py)
  As input, this script accepts a synonymous SFS file as specified in `Dadi` format, as well as the output `*demography.txt` from demographic inference. An example `.bash` script which computes likelihood surfaces for all of the species analyzed in this paper can be found at [`../Scripts/plot_likelihood.bash`](../Scripts/plot_likelihood.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## [`generate_figure_2.R`](../Scripts/generate_figure_2.R)
  This `.R` script generates Figure 2 and saves it to [`Summary/figure_2_output.svg`](../Summary/figure_2_output.svg).
