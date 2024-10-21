import os.path 
from math import log10

# ==========================================================================
# Set up default source and output directories
# ==========================================================================

main_dir = '/u/home/j/jonmah/project-ngarud/'
# data_directory = '/u/project/ngarud/Garud_lab/metagenomic_fastq_files/HMP1-2/data'
# data_directory = os.path.expanduser("/u/project/ngarud/Garud_lab/metagenomic_fastq_files/HMP1-2/data")

data_directory = os.path.expanduser("/u/project/ngarud/Garud_lab/metagenomic_fastq_files/HMP1_2_Kuleshov_Qin_Twins_Korpela/")
#data_directory = os.path.expanduser("~/ben_nandita_hmp_data_071518/")
#data_directory = os.path.expanduser("~/ben_nandita_hmp_data/")
analysis_directory = os.path.expanduser("~/project-ngarud/demo_for_ccgb/Analysis/")
scripts_directory = os.path.expanduser("~/project-ngarud/demo_for_ccgb/microbiome_evolution-master/")
patric_directory = os.path.expanduser("~/patric_db/")
midas_directory = os.path.expanduser("/u/project/ngarud/Garud_lab/midas_db_v1.2")


# data_directory = os.path.expanduser("%s/dbd/data/" % main_dir)
# data_rarefied_directory = os.path.expanduser("%s/dbd/data_rarefied/" % main_dir)
# int_data_directory = os.path.expanduser("%s/glab/metagenomic_fastq_files/HMP1-2/midas_output_rarefied_v2" % main_dir)
metadata_directory = os.path.expanduser("%s/demo_for_ccgb/Scripts/metadata/" % main_dir)
# analysis_directory = os.path.expanduser("%s/dbd/analysis/" % main_dir)
# scripts_directory = os.path.expanduser("%s/dbd/scripts/" % main_dir)
# patric_directory = os.path.expanduser("%s/patric_db/" % main_dir)
# midas_directory = os.path.expanduser("%s/midas_db/" % main_dir)

# We use this one to debug because it was the first one we looked at
debug_species_name = 'Bacteroides_uniformis_57318'

good_species_min_coverage = 10
good_species_min_prevalence = 10

min_median_coverage = 20

consensus_lower_threshold = 0.2
consensus_upper_threshold = 0.8
temporal_lower_threshold = 0.35
temporal_upper_threshold = 0.65

fixation_min_change = 0.3 # Originally consensus_upper_threshold - consensus_lower_threshold
fixation_log10_depth_ratio_threshold = log10(3)

threshold_within_between_fraction = 0.1
threshold_pi = 1e-03

min_opportunities = 100000

modification_difference_threshold = 20
replacement_difference_threshold = 500

twin_modification_difference_threshold = 1000
twin_replacement_difference_threshold = 1000

gainloss_max_absent_copynum = 0.05
gainloss_min_normal_copynum = 0.6
gainloss_max_normal_copynum = 1.2

core_genome_min_copynum = 0.3
core_genome_max_copynum = 3 # BG: should we use a maximum for "core genome"? I'm going to go w/ yes for now
core_genome_min_prevalence = 0.9
shared_genome_min_copynum = 3

# Default parameters for pipe snps
# (Initial filtering for snps, done during postprocessing)
pipe_snps_min_samples=4
pipe_snps_min_nonzero_median_coverage=5
pipe_snps_lower_depth_factor=0.3
pipe_snps_upper_depth_factor=3

parse_snps_min_freq = 0.05

between_host_min_sample_size = 33
between_host_ld_min_sample_size = 10
within_host_min_sample_size = 3
within_host_min_haploid_sample_size = 10

between_low_divergence_threshold = 2e-04
