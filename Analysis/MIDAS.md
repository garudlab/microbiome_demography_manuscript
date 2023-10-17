# MIDAS

MIDAS consists of four primary steps: the `species` step, the `genes` step, the `snps` step, and then merging the output of each of these processes over all relevant hosts.

Below, we provide example `.bash` scripts which accomplish each of these steps; however, individual clusters or machines might require slightly different setups.

## Species step
An example `.bash` script which runs this step is located at [`../Scripts/MIDAS_species.bash`](../Scripts/MIDAS_species.bash).

### Species Union
Supposing that your data consists of multiple time points, you may wish to consider a list of species per host taking into account all of the time points.

['../Scripts/construct_species_union.py'](../Scripts/construct_species_union.py) is a python script accepts an `indir` containing all `*species_profile.txt` files output by the `species` step to output a `species_union.txt` at a specified outprefix.

## Genes step
An example `.bash` script which runs this step is located at [`../Scripts/MIDAS_genes.bash`](../Scripts/MIDAS_genes.bash).

## SNPs step
An example `.bash` script which runs this step is located at [`../Scripts/MIDAS_snps.bash`](../Scripts/MIDAS_snps.bash).

## Merge
The `merge` step is performed over each of the outputs from the previous steps. Example bash scripts can be found at:
* [`../Scripts/MIDAS_merge_species.bash`](../Scripts/MIDAS_merge_species.bash)
* [`../Scripts/MIDAS_merge_genes.bash`](../Scripts/MIDAS_merge_genes.bash)
* [`../Scripts/MIDAS_merge_snps.bash`](../Scripts/MIDAS_merge_snps.bash)
