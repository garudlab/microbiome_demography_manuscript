# Figure 1

[Figure 1](../Summary/figure_1.png) shows the nucleotide diversity within and between hosts in rural African and North American gut microbiomes.

To recreate this figure, you must:

## [`compute_nucleotide_diversity.py`](../Scripts/compute_nucleotide_diversity.py)
  Given a `*snps_ref_freq.txt.bz2` file output by MIDAS, outputs a `output_matrix.csv` with a specified outprefix. This output matrix has the nucleotide diversity computed for each individual host for a specified species. A relevant logfile named `compute_pi.log` is also output in the same directory. We performed this for analysis for two cohorts: one consisting of microbiome data from a rural African population and another consisting of microbiome data from the Human Microbiome Project.
## [`summarize_pi.py`](../Scripts/summarize_pi.py)
  Given an `output_matrix.csv` output by `compute_nucleotide_diversity.py`, this script summarizes the average pi values per sample across species to output a `*summarized_pi.csv` with a given outprefix.
## [`generate_figure_1.R`](../Scripts/generate_figure_1.R)
  This `.R` script generates Figure 1 and saves it to [`Summary/figure_1.png`](../Summary/figure_1.png).
