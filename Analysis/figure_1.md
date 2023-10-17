# Figure 1

Figure 1 shows the nucleotide diversity within and between hosts in rural African and North American gut microbiomes.

To recreate this figure, you must:

1. Download Data
  Consult [`download_data.md`](./download_data.md).
2. Run MIDAS
  Consult ['MIDAS.md'](./MIDAS.md).
2. `compute_nucleotide_diversity.py`
  Given a `*snps_ref_freq.txt.bz2` file output by MIDAS, outputs a `output_matrix.csv` with a specified outprefix.

  This output matrix has the nucleotide diversity computed for each individual host for a specified species.

  A relevant logfile named `compute_pi.log` is also output in the same directory.

  We performed this for analysis for two cohorts: one consisting of microbiome data from a rural African population and another consisting of microbiome data from the Human Microbiome Project.
3. `summarize_pi.py`
  Given an `output_matrix.csv` output by `compute_nucleotide_diversity.py`, this script summarizes the average pi values per sample across species to output a `*summarized_pi.csv` with a given outprefix.
4. `generate_figures.R`
  This `.R` script generates all figures and saves them automatically in either [`Summary`](../Summary) or [`Supplement`](../Supplement).
