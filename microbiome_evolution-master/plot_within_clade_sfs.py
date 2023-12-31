# SFS plots, comparing syn and non syn
# (a) regular SFS (percentage of population)
# (b) Singletons, doubletons, and pi-weighted

# Summary across species?
# dN/dS vs dS plot?
# core vs variable genes?

# Within-snp gene changes

import matplotlib
matplotlib.use('Agg')
import config
import parse_midas_data
###
#
# For today while the new data processes
#
import os
#parse_midas_data.data_directory = os.path.expanduser("~/ben_nandita_hmp_data_062517/")
#########################################
import parse_HMP_data


import pylab
import sys
import numpy

import diversity_utils
import gene_diversity_utils
import calculate_substitution_rates
import clade_utils
import stats_utils
import matplotlib.colors as colors
import matplotlib.cm as cmx
from math import log10,ceil
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from numpy.random import randint

mpl.rcParams['font.size'] = 6
mpl.rcParams['lines.linewidth'] = 0.5
mpl.rcParams['legend.frameon']  = False
mpl.rcParams['legend.fontsize']  = 'small'

# species_name = "Bacteroides_vulgatus_57955"
# species_name = "Bacteroides_uniformis_57318"
# species_name = "Alistipes_putredinis_61533"
# species_name = "Bacteroides_ovatus_58035"
# species_name = "Eubacterium_rectale_56927"
# species_name = "Alistipes_shahii_62199"
# species_name = "Bacteroides_massiliensis_44749"
# species_name = "Odoribacter_splanchnicus_62174"
# species_name = "Prevotella_copri_61740"
# species_name = "Coprococcus_sp_62244"
# species_name = "Bacteroides_stercoris_56735"
# species_name = "Parabacteroides_merdae_56972"
# species_name = "Bacteroides_xylanisolvens_57185"
# species_name = "Ruminococcus_bromii_62047"
# species_name = "Bacteroides_thetaiotaomicron_56941"
# species_name = "Bacteroides_caccae_53434"
# species_name = "Alistipes_onderdonkii_55464"
# species_name = "Parabacteroides_distasonis_56985"
# species_name = "Barnesiella_intestinihominis_62208"
# species_name = "Oscillibacter_sp_60799"
# species_name = "Faecalibacterium_prausnitzii_57453"
# species_name = "Akkermansia_muciniphila_55290"
# species_name = "Bacteroides_cellulosilyticus_58046"
# species_name = "Ruminococcus_bicirculans_59300"
# species_name = "Dialister_invisus_61905"
# species_name = "Bacteroides_fragilis_54507"
# species_name = "Alistipes_finegoldii_56071"
# species_name = "Eubacterium_eligens_61678"
# species_name = "Faecalibacterium_cf_62236"
# species_name = "Roseburia_intestinalis_56239"
species_name = "Escherichia_coli_58110"
# species_name = "Phascolarctobacterium_sp_59817"
# species_name = "Blautia_wexlerae_56130"
# species_name = "Bacteroidales_bacterium_58650"
# species_name = "Roseburia_intestinalis_56239"
# species_name = "Faecalibacterium_cf_62236"
################################################################################
#
# Standard header to read in argument information
#
################################################################################
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--debug", help="Loads only a subset of SNPs for speed", action="store_true")
parser.add_argument("--chunk-size", type=int, help="max number of records to load", default=1000000000)
parser.add_argument('--other-species', type=str, help='Run the script for a different species')

args = parser.parse_args()

debug = args.debug
chunk_size = args.chunk_size
other_species = args.other_species

if other_species:
    species_name = other_species
    other_species_str = "_%s" % species_name
else:
    other_species_str = ""

################################################################################

min_coverage = config.min_median_coverage
alpha = 0.5 # Confidence interval range for rate estimates
low_divergence_threshold = 5e-04
min_change = 0.8
allowed_variant_types = set(['1D','2D','3D','4D'])
#max_clade_d = 1e-02

# Load subject and sample metadata
sys.stderr.write("Loading sample metadata...\n")
subject_sample_map = parse_HMP_data.parse_subject_sample_map()
sample_country_map = parse_HMP_data.parse_sample_country_map()
sys.stderr.write("Done!\n")

# Only plot samples above a certain depth threshold that are "haploids"
snp_samples = diversity_utils.calculate_haploid_samples(species_name, debug=debug)
snp_samples = snp_samples[ diversity_utils.parse_midas_data.calculate_unique_samples(subject_sample_map, snp_samples)]
snp_samples = [s.decode("utf-8")  for s in snp_samples]


####################################################
#
# Set up Figure (2 panels, arranged horizontally)
#
####################################################
# This figure spreads them all out

pylab.figure(1,figsize=(5,1.7))
fig = pylab.gcf()
# make three panels panels
outer_grid  = gridspec.GridSpec(1,2, width_ratios=[2, 1], wspace=0.3)

##############################################################################
#
# Panel (a). Pooled SFS as function of minor allele freq
#
##############################################################################

sfs_axis = plt.Subplot(fig, outer_grid[0])
fig.add_subplot(sfs_axis)

sfs_axis.set_xlabel('Minor allele freq in largest clade, $f$')
sfs_axis.set_ylabel('Fraction of sites, $P(f)$')
# sfs_axis.set_ylabel('Scaled fraction of sites, $f(1-f) P(f)$')
sfs_axis.set_xlim([0,0.5])
sfs_axis.spines['top'].set_visible(False)
sfs_axis.spines['right'].set_visible(False)
sfs_axis.get_xaxis().tick_bottom()
sfs_axis.get_yaxis().tick_left()

##############################################################################
#
# Panel (b). Comparison of 1D and 4D for minor allele *count*
#
##############################################################################

count_axis = plt.Subplot(fig, outer_grid[1])
fig.add_subplot(count_axis)

count_axis.set_ylabel('pN/pS')
count_axis.set_xlabel('Minor allele count')
count_axis.set_xlim([-0.5,3.5])
count_axis.set_ylim([0,1])
count_axis.set_xticks([0,1,2,3])
count_axis.set_xticklabels(['1','2','3','4+'])
count_axis.spines['top'].set_visible(False)
count_axis.spines['right'].set_visible(False)
count_axis.get_xaxis().tick_bottom()
count_axis.get_yaxis().tick_left()

###############
#
# Do calculation!
#
###############

sys.stderr.write("Loading pre-computed substitution rates for %s...\n" % species_name)
substitution_rate_map = calculate_substitution_rates.load_substitution_rate_map(species_name)
sys.stderr.write("Calculating matrix...\n")
dummy_samples, snp_difference_matrix, snp_opportunity_matrix = calculate_substitution_rates.calculate_matrices_from_substitution_rate_map(substitution_rate_map, 'core', allowed_samples=snp_samples)
snp_samples = numpy.array(dummy_samples)
substitution_rate = snp_difference_matrix*1.0/(snp_opportunity_matrix+(snp_opportunity_matrix==0))
sys.stderr.write("Done!\n")

#################
#
# Cluster samples into clades based on distance matrix
#
#################
sys.stderr.write("Clustering samples with low divergence...\n")
coarse_grained_idxs, coarse_grained_cluster_list = clade_utils.cluster_samples(substitution_rate, min_d=low_divergence_threshold)

coarse_grained_samples = snp_samples[coarse_grained_idxs]
clade_sets = clade_utils.load_manual_clades(species_name)

clade_idxss = clade_utils.calculate_clade_idxs_from_clade_sets(coarse_grained_samples, clade_sets)

clade_sizes = numpy.array([clade_idxs.sum() for clade_idxs in clade_idxss])

largest_clade_samples = coarse_grained_samples[ clade_idxss[clade_sizes.argmax()] ]


sys.stderr.write("Top level: %d clades, %s\n" % (len(clade_sets), str(clade_sizes)))
sys.stderr.write("Max: %d\n" % len(largest_clade_samples))

if len(largest_clade_samples)<3:
    sys.stderr.write("Too few samples! Quitting...\n")
    sys.exit(1)

sys.stderr.write("Continuing with %d samples...\n" % len(largest_clade_samples))

# Load SNP information for species_name
sys.stderr.write("Re-loading %s...\n" % species_name)

sys.stderr.write("Loading core genes...\n")
core_genes = parse_midas_data.load_core_genes(species_name)
sys.stderr.write("Done! Core genome consists of %d genes\n" % len(core_genes))


snp_difference_matrix = numpy.array([])
snp_opportunity_matrix = numpy.array([])

synonymous_difference_matrix = numpy.array([])
synonymous_opportunity_matrix = numpy.array([])

nonsynonymous_difference_matrix = numpy.array([])
nonsynonymous_opportunity_matrix = numpy.array([])

maf_bins = []
mafs = []

count_bins = []
count_locations = []

synonymous_sfs = []
nonsynonymous_sfs = []

synonymous_count_sfs = []
nonsynonymous_count_sfs = []

synonymous_pi_weighted_counts = 0
nonsynonymous_pi_weighted_counts = 0


final_line_number = 0
while final_line_number >= 0:

    sys.stderr.write("Loading chunk starting @ %d...\n" % final_line_number)
    snp_samples, allele_counts_map, passed_sites_map, final_line_number = parse_midas_data.parse_snps(species_name, debug=debug, allowed_variant_types=allowed_variant_types, allowed_samples=largest_clade_samples,allowed_genes=core_genes, chunk_size=chunk_size,initial_line_number=final_line_number)
    sys.stderr.write("Done! Loaded %d genes\n" % len(allele_counts_map.keys()))

    # Calculate fixation matrix
    sys.stderr.write("Calculating matrix of snp differences...\n")
    chunk_snp_difference_matrix, chunk_snp_opportunity_matrix = diversity_utils.calculate_fixation_matrix(allele_counts_map, passed_sites_map, allowed_genes=core_genes, min_change=min_change)
    sys.stderr.write("Done!\n")

    if snp_difference_matrix.shape[0]==0:
        snp_difference_matrix = numpy.zeros_like(chunk_snp_difference_matrix)*1.0
        snp_opportunity_matrix = numpy.zeros_like(snp_difference_matrix)*1.0
        synonymous_difference_matrix = numpy.zeros_like(snp_difference_matrix)
        synonymous_opportunity_matrix = numpy.zeros_like(snp_difference_matrix)
        nonsynonymous_difference_matrix = numpy.zeros_like(snp_difference_matrix)
        nonsynonymous_opportunity_matrix = numpy.zeros_like(snp_difference_matrix)

        n = len(snp_samples)

        maf_bins = numpy.arange(1,n+1)*1.0/n
        maf_bins -= (maf_bins[1]-maf_bins[0])/2
        maf_bins[0]=-0.1
        maf_bins[-1] = 1.1
        mafs = numpy.arange(1,n)*1.0/n

        count_bins = numpy.arange(1,n+1)-0.5
        count_locations = numpy.arange(1,n)

        synonymous_sfs = numpy.zeros_like(mafs)
        nonsynonymous_sfs = numpy.zeros_like(mafs)

        synonymous_count_sfs = numpy.zeros_like(count_locations)
        nonsynonymous_count_sfs = numpy.zeros_like(count_locations)


    snp_difference_matrix += chunk_snp_difference_matrix
    snp_opportunity_matrix += chunk_snp_opportunity_matrix

    # Calculate fixation matrix
    sys.stderr.write("Calculating matrix of 4D differences...\n")
    chunk_synonymous_difference_matrix, chunk_synonymous_opportunity_matrix =    diversity_utils.calculate_fixation_matrix(allele_counts_map, passed_sites_map, allowed_genes=core_genes, min_change=min_change,allowed_variant_types=set(['4D']))
    sys.stderr.write("Done!\n")

    synonymous_difference_matrix += chunk_synonymous_difference_matrix
    synonymous_opportunity_matrix += chunk_synonymous_opportunity_matrix

    # Calculate fixation matrix
    sys.stderr.write("Calculating matrix of 1D differences...\n")
    chunk_nonsynonymous_difference_matrix, chunk_nonsynonymous_opportunity_matrix =    diversity_utils.calculate_fixation_matrix(allele_counts_map, passed_sites_map, allowed_genes=core_genes, min_change=min_change,allowed_variant_types=set(['1D']))
    sys.stderr.write("Done!\n")

    nonsynonymous_difference_matrix += chunk_nonsynonymous_difference_matrix
    nonsynonymous_opportunity_matrix += chunk_nonsynonymous_opportunity_matrix

    sys.stderr.write("Calculating the SFS...\n")
    chunk_synonymous_freqs = diversity_utils.calculate_pooled_freqs(allele_counts_map, passed_sites_map, allowed_variant_types = set(['4D']), allowed_genes=core_genes)
    chunk_nonsynonymous_freqs = diversity_utils.calculate_pooled_freqs(allele_counts_map, passed_sites_map, allowed_variant_types = set(['1D']), allowed_genes=core_genes)

    chunk_synonymous_sfs, dummy = numpy.histogram(chunk_synonymous_freqs, bins=maf_bins)
    synonymous_sfs += chunk_synonymous_sfs

    chunk_nonsynonymous_sfs, dummy = numpy.histogram(chunk_nonsynonymous_freqs, bins=maf_bins)
    nonsynonymous_sfs += chunk_nonsynonymous_sfs

    sys.stderr.write("Calculating count SFS...\n")
    chunk_synonymous_counts, chunk_synonymous_weights = diversity_utils.calculate_pooled_counts(allele_counts_map, passed_sites_map, allowed_variant_types = set(['4D']), allowed_genes=core_genes,pi_min_k=4)
    chunk_nonsynonymous_counts, chunk_nonsynonymous_weights = diversity_utils.calculate_pooled_counts(allele_counts_map, passed_sites_map, allowed_variant_types = set(['1D']), allowed_genes=core_genes,pi_min_k=4)

    chunk_synonymous_count_sfs, dummy = numpy.histogram(chunk_synonymous_counts, bins=count_bins)
    synonymous_count_sfs += chunk_synonymous_count_sfs

    chunk_nonsynonymous_count_sfs, dummy = numpy.histogram(chunk_nonsynonymous_counts, bins=count_bins)
    nonsynonymous_count_sfs += chunk_nonsynonymous_count_sfs

    synonymous_pi_weighted_counts += chunk_synonymous_weights
    nonsynonymous_pi_weighted_counts += chunk_nonsynonymous_weights


largest_clade_matrix_idxs_i = []
largest_clade_matrix_idxs_j = []
for i in range(0, snp_difference_matrix.shape[0]):
    for j in range(i+1, snp_difference_matrix.shape[0]):

        largest_clade_matrix_idxs_i.append(i)
        largest_clade_matrix_idxs_j.append(j)

largest_clade_matrix_idxs = largest_clade_matrix_idxs_i, largest_clade_matrix_idxs_j


opportunity_ratio = nonsynonymous_opportunity_matrix[largest_clade_matrix_idxs].sum()*1.0 / synonymous_opportunity_matrix[largest_clade_matrix_idxs].sum()

pi_ratio = nonsynonymous_difference_matrix[largest_clade_matrix_idxs].sum()*1.0 / synonymous_difference_matrix[largest_clade_matrix_idxs].sum()

piNpiS = pi_ratio/opportunity_ratio

print "Opportunity ratio:", opportunity_ratio
print "piN/piS:", piNpiS

sys.stderr.write("%d singletons!\n" % (synonymous_count_sfs[0]+nonsynonymous_count_sfs[0]))
sys.stderr.write("%d doubletons!\n" % (synonymous_count_sfs[1]+nonsynonymous_count_sfs[1]))
sys.stderr.write("%d tripletons!\n" % (synonymous_count_sfs[2]+nonsynonymous_count_sfs[2]))
sys.stderr.write("%d rest-tons!\n" % (synonymous_count_sfs[3:]+nonsynonymous_count_sfs[3:]).sum())

sys.stderr.write("%g pi-weighted!\n" % (nonsynonymous_pi_weighted_counts+synonymous_pi_weighted_counts))

output_syn_sfs = '../Data/' + species_name + '_syn.sfs'
output_nonsyn_sfs = '../Data/' + species_name + '_nonsyn.sfs'
output_figure = '../Data/' + species_name + '_sfs.pdf'

num_bins = len(count_locations)
with open(output_syn_sfs, 'w+') as f:
    f.write(str(num_bins + 1 + num_bins % 2) +
            ' folded "' + str(species_name) + '"\n')
    f.write('0')
    for freq in synonymous_count_sfs:
        f.write(' ' + str(freq))
    if num_bins % 2 == 1:
        f.write(' 0')
    f.write('\n')
    f.write('1')
    for i in range(num_bins / 2 + num_bins % 2):
        f.write(' 0')
    for i in range(num_bins / 2 + num_bins % 2):
        f.write(' 1')

with open(output_nonsyn_sfs, 'w+') as f:
    f.write(str(num_bins + 1 + num_bins % 2) +
            ' folded "' + str(species_name) + '"\n')
    f.write('0')
    for freq in nonsynonymous_count_sfs:
        f.write(' ' + str(freq))
    if num_bins % 2 == 1:
        f.write(' 0')
    f.write('\n')
    f.write('1')
    for i in range(num_bins / 2 + num_bins % 2):
        f.write(' 0')
    for i in range(num_bins / 2 + num_bins % 2):
        f.write(' 1')

print count_locations
print synonymous_count_sfs
print nonsynonymous_count_sfs

###############
#
# Plot figures!
#
###############

# sfs_axis.plot(mafs, synonymous_sfs*mafs*(1-mafs)/(synonymous_sfs*mafs*(1-mafs)).sum(), 'b.-',label='4D')
# sfs_axis.plot(mafs, nonsynonymous_sfs*mafs*(1-mafs)/(nonsynonymous_sfs*mafs*(1-mafs)).sum(),'r.-',label='1D')
sfs_axis.plot(mafs, synonymous_sfs/synonymous_sfs.sum(), 'b.-',label='4D')
sfs_axis.plot(mafs, nonsynonymous_sfs/nonsynonymous_sfs.sum(),'r.-',label='1D')
# sfs_axis.set_xscale('log',basex=10)
# sfs_axis.set_yscale('log',basey=10)

singleton_fraction = nonsynonymous_count_sfs[0]*1.0/(synonymous_count_sfs[0])/opportunity_ratio
doubleton_fraction =  nonsynonymous_count_sfs[1]*1.0/(synonymous_count_sfs[1])/opportunity_ratio
tripleton_fraction =  nonsynonymous_count_sfs[2]*1.0/(synonymous_count_sfs[2])/opportunity_ratio
restton_fraction =   nonsynonymous_count_sfs[3:].sum()*1.0/((synonymous_count_sfs[3:]).sum())/opportunity_ratio

sfs_axis.legend(loc='upper right',frameon=False,numpoints=1)

pi_weighted_fraction = nonsynonymous_pi_weighted_counts*1.0/(synonymous_pi_weighted_counts)/opportunity_ratio

count_axis.bar([-0.3],[singleton_fraction],width=0.6,color='r',linewidth=0)
count_axis.bar([1-0.3],[doubleton_fraction],width=0.6,color='r',linewidth=0)
count_axis.bar([2-0.3],[tripleton_fraction],width=0.6,color='r',linewidth=0)
#count_axis.bar([3-0.3],[restton_fraction],width=0.6,color='r',linewidth=0)
count_axis.bar([3-0.3],[pi_weighted_fraction],width=0.6,color='r',linewidth=0)


sys.stderr.write("Saving figure...\t")
# fig.savefig('%s/figure_5%s.pdf' % (parse_midas_data.analysis_directory, other_species_str),bbox_inches='tight')
fig.savefig(output_figure, bbox_inches='tight')
sys.stderr.write("Done!\n")
