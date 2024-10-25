setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

HR_phylogenetic_levels = c(
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Bacteroides fragilis',
  'Bacteroides cellulosilyticus',
  'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides caccae',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Akkermansia muciniphila',
  'Dialister invisus',
  'Eubacterium rectale',
  'Oscillibacter sp.',
  'Ruminococcus bromii',
  'Ruminococcus bicirculans'
)

HR_phylogenetic_levels_MIDAS = c(
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_shahii_62199',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Bacteroides_fragilis_54507',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_caccae_53434',
  'Bacteroides_vulgatus_57955',
  'Barnesiella_intestinihominis_62208',
  'Akkermansia_muciniphila_55290',
  'Dialister_invisus_61905',
  'Eubacterium_rectale_56927',
  'Oscillibacter_sp_60799',
  'Ruminococcus_bromii_62047',
  'Ruminococcus_bicirculans_59300'
)

shared_species_list = c(
  'Akkermansia muciniphila',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Bacteroides caccae',
  'Bacteroides cellulosilyticus',
  'Bacteroides fragilis',
  'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Dialister invisus',
  'Eubacterium rectale',
  'Oscillibacter sp.',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Ruminococcus bicirculans',
  'Ruminococcus bromii'
)

hr_demography_file_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_two_epoch_demography.txt'
)

hr_sfs_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_empirical_syn_sfs.txt'
)

hr_downsampled_sfs_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_empirical_syn_14_downsampled_sfs.txt'
)

hr_likelihood_surface_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv'
)

hr_dfe_file_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt'
)

fd_shared_demography_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt'
)

fd_shared_sfs_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_syn_downsampled_sfs.txt'
)

fd_shared_likelihood_surface_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv',
  '../SupplementaryAnalysis/Dialister_invisus_61905/likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv'
)

fd_shared_dfe_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt'
)

shared_species_df = data.frame(species=shared_species_list,
  HR_nu_mle = numeric(18),
  FD_nu_mle = numeric(18),
  HR_time_mle = numeric(18),
  FD_time_mle = numeric(18),
  HR_tau_mle = numeric(18),
  FD_tau_mle = numeric(18),
  HR_nanc = numeric(18),
  FD_nanc = numeric(18),
  HR_shape = numeric(18),
  FD_shape = numeric(18),
  HR_scale = numeric(18),
  FD_scale = numeric(18),
  HR_mean_s = numeric(18),
  FD_mean_s = numeric(18),
  HR_allele_sum = numeric(18),
  FD_allele_sum = numeric(18)
)



for (i in 1:length(shared_species_list)) {
  # nu_mle
  ## HR
  shared_species_df[i, 2] = return_nu_mle(hr_likelihood_surface_list[i])
  ## FD
  shared_species_df[i, 3] = return_nu_mle(fd_shared_likelihood_surface_list[i])
  # tau_mle
  ## HR
  shared_species_df[i, 4] = return_time_mle(hr_likelihood_surface_list[i],
    hr_downsampled_sfs_list[i],
    hr_demography_file_list[i])
  ## FD
  shared_species_df[i, 5] = return_time_mle(fd_shared_likelihood_surface_list[i],
    fd_shared_sfs_list[i],
    fd_shared_demography_file_list[i])
  # Tau
  shared_species_df[i, 6] = return_tau_mle(hr_likelihood_surface_list[i])
  shared_species_df[i, 7] = return_tau_mle(fd_shared_likelihood_surface_list[i])
  # Nanc
  ## HR
  shared_species_df[i, 8] = nanc_from_demography(hr_demography_file_list[i])
  ## FD
  shared_species_df[i, 9] = nanc_from_demography(fd_shared_demography_file_list[i])
  # shape
  ## HR
  shared_species_df[i, 10] = return_shape_from_dfe(hr_dfe_file_list[i])
  ## FD
  shared_species_df[i, 11] = return_shape_from_dfe(fd_shared_dfe_file_list[i])
  # scale
  ## HR
  shared_species_df[i, 12] = return_scale_from_dfe(hr_dfe_file_list[i])
  ## FD
  shared_species_df[i, 13] = return_scale_from_dfe(fd_shared_dfe_file_list[i])
  # Mean s
  ## HR
  shared_species_df[i, 14] = mean(read_dfe_params(hr_dfe_file_list[i])$gamma_dfe_dist_high)
  ## FD
  shared_species_df[i, 15] = mean(read_dfe_params(fd_shared_dfe_file_list[i])$gamma_dfe_dist_high)
  # Allele sum
  ## HR
  shared_species_df[i, 16] = return_allele_sum(hr_downsampled_sfs_list[i])
  ## FD
  shared_species_df[i, 17] = return_allele_sum(fd_shared_sfs_list[i])
}

shared_species_df

shared_species_df$species = factor(shared_species_df$species, levels=HR_phylogenetic_levels)

shared_species_df <- shared_species_df[order(shared_species_df$species), ]

shared_species_df

shared_species_df$HR_2ns = shared_species_df$HR_nanc * 2 * shared_species_df$HR_mean_s
shared_species_df$FD_2ns = shared_species_df$FD_nanc * 2 * shared_species_df$FD_mean_s

nu_comparison = c('FD_nu_mle', 'HR_nu_mle')

t.test(shared_species_df$FD_nu_mle, shared_species_df$HR_nu_mle, paired=TRUE)

HR_FD_nu_mle_scatter = ggscatter(shared_species_df, x="FD_nu_mle", y="HR_nu_mle", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-2, 1E4)) +
  scale_y_log10(limits=c(1E-2, 1E4)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Maximum likelihood estimate of Nu') +
  theme(plot.title=element_text(size=22))

HR_FD_nu_mle_scatter

HR_FD_time_mle_scatter = ggscatter(shared_species_df, x="FD_time_mle", y="HR_time_mle", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E2, 1E6)) +
  scale_y_log10(limits=c(1E2, 1E6)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Maximum likelihood estimate of Time (years)') +
  theme(plot.title=element_text(size=22))

HR_FD_time_mle_scatter

HR_FD_tau_mle_scatter = ggscatter(shared_species_df, x="FD_tau_mle", y="HR_tau_mle", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-1, 1E4)) +
  scale_y_log10(limits=c(1E-1, 1E4)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Maximum likelihood estimate of tau') +
  theme(plot.title=element_text(size=22))

HR_FD_tau_mle_scatter

HR_FD_nanc_scatter = ggscatter(shared_species_df, x="FD_nanc", y="HR_nanc", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(3E6, 3E8)) +
  scale_y_log10(limits=c(3E6, 3E8)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Effective ancestral population size') +
  theme(plot.title=element_text(size=22))

HR_FD_nanc_scatter

HR_FD_shape_scatter = ggscatter(shared_species_df, x="FD_shape", y="HR_shape", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(0.003, 2.00)) +
  scale_y_log10(limits=c(0.003, 2.00)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Gamma-distributed DFE shape parameter') +
  theme(plot.title=element_text(size=22))

HR_FD_shape_scatter

HR_FD_scale_scatter = ggscatter(shared_species_df, x="FD_scale", y="HR_scale", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-14, 1E3)) +
  scale_y_log10(limits=c(1E-14, 1E3)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Gamma-distributed DFE scale parameter') +
  theme(plot.title=element_text(size=22))

HR_FD_scale_scatter

HR_FD_mean_s_scatter = ggscatter(shared_species_df, x="FD_mean_s", y="HR_mean_s", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-14, 1E3)) +
  scale_y_log10(limits=c(1E-14, 1E3)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Gamma-distributed DFE mean selection coefficient') +
  theme(plot.title=element_text(size=22))

HR_FD_mean_s_scatter

HR_FD_2ns_scatter = ggscatter(shared_species_df, x="FD_2ns", y="HR_2ns", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-8, 1E10)) +
  scale_y_log10(limits=c(1E-8, 1E10)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Estimated 2ns of gamma-distributed DFE') +
  theme(plot.title=element_text(size=22))

HR_FD_2ns_scatter

HR_FD_allele_count_scatter = ggscatter(shared_species_df, x="FD_allele_sum", y="HR_allele_sum", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(9E4, 5E5)) +
  scale_y_log10(limits=c(9E4, 5E5)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Number of sites included in SFS') +
  theme(plot.title=element_text(size=22))

HR_FD_allele_count_scatter

# nu
summary(lm(shared_species_df$FD_nu_mle ~ shared_species_df$HR_nu_mle))$r.squared
cor(shared_species_df$FD_nu_mle, shared_species_df$HR_nu_mle)


# tau
summary(lm(shared_species_df$FD_tau_mle ~ shared_species_df$HR_tau_mle))$r.squared

# mean s
summary(lm(shared_species_df$FD_mean_s ~ shared_species_df$HR_mean_s))$r.squared

# shape
summary(lm(shared_species_df$FD_shape ~ shared_species_df$HR_shape))$r.squared

# scale
summary(lm(shared_species_df$FD_scale ~ shared_species_df$HR_scale))$r.squared

# nanc
summary(lm(shared_species_df$FD_nanc ~ shared_species_df$HR_nanc))$r.squared

figure_4 = HR_FD_nu_mle_scatter + theme(axis.title=element_blank()) +
  HR_FD_time_mle_scatter + theme(axis.title=element_blank()) +
  HR_FD_nanc_scatter + theme(axis.title=element_blank()) +
  HR_FD_mean_s_scatter + theme(axis.title=element_blank()) +
  HR_FD_shape_scatter + theme(axis.title=element_blank()) +
  HR_FD_scale_scatter + theme(axis.title=element_blank()) +
  plot_layout(ncol=3)

ggsave('../Summary/Figure_4_output.svg', figure_4, width=24, height=16, units='in', dpi=600)


