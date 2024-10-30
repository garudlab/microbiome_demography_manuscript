# Figure S8

[Supplemental Figure 8](../Supplement/Supplemental_Figure_8.jpg) shows all of the site-frequency spectra and likelihood surfaces for demographic inference over accessory genes for the 39 species included in this study.

To recreate this figure, you must:

## Perform demographic inference using `Dadi`
  An example `.bash` script which performs demographic inference using `Dadi` for all of the species analyzed in this paper can be found at [`../Scripts/fit_demographic_model.bash`](../Scripts/fit_demographic_model.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## [`plot_likelihood.py`](../Scripts/plot_likelihood.py)
  As input, this script accepts a synonymous SFS file as specified in `Dadi` format, as well as the output `*demography.txt` from demographic inference. An example `.bash` script which computes likelihood surfaces for all of the species analyzed in this paper can be found at [`../Scripts/plot_likelihood.bash`](../Scripts/plot_likelihood.bash). Uncomment appropriate lines to do so for core genes and for accessory genes.
## [`generate_supplemental_figures.R`](../Scripts/generate_supplemental_figures.R)
  This `.R` script generates all Supplemental Figures and saves them to [`../Supplement/`](../Supplement/).
