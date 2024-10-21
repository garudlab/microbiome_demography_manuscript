setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

FD_phylogenetic_levels = c(
  'Alistipes sp.',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Alistipes putredinis',
  'Bacteroidales bacterium',
  'Odoribacter splanchnicus',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Prevotella copri',
  'Bacteroides fragilis',
  'Bacteroides cellulosilyticus',
  'Bacteroides eggerthii',
  # 'Bacteroides stercoris',
  'Bacteroides uniformis',
  'Bacteroides thetaiotaomicron',
  'Bacteroides xylanisolvens',
  'Bacteroides caccae',
  'Bacteroides massiliensis',
  'Bacteroides vulgatus',
  # 'Bacteroides plebeius',
  'Bacteroides coprocola',
  'Barnesiella intestinihominis',
  'Akkermansia muciniphila',
  'Dialister invisus',
  'Phascolarctobacterium sp.',
  'Eubacterium eligens',
  'Eubacterium rectale',
  'Roseburia inulinivorans',
  # 'Roseburia intestinalis',
  'Lachnospiraceae bacterium',
  'Coprococcus sp.',
  'Oscillibacter sp.',
  'Ruminococcus bromii',
  'Ruminococcus bicirculans',
  'Eubacterium siraeum',
  'Faecalibacterium prausnitzii (57453)',
  'Faecalibacterium prausnitzii (62201)',
  'Faecalibacterium prausnitzii (61481)'
)

FD_phylogenetic_levels_MIDAS = c(
  'Alistipes_sp_60764',
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_shahii_62199',
  'Alistipes_putredinis_61533',
  'Bacteroidales_bacterium_58650',
  'Odoribacter_splanchnicus_62174',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Prevotella_copri_61740',
  'Bacteroides_fragilis_54507',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_eggerthii_54457',
  # 'Bacteroides_stercoris_56735',
  'Bacteroides_uniformis_57318',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_xylanisolvens_57185',
  'Bacteroides_caccae_53434',
  'Bacteroides_massiliensis_44749',
  'Bacteroides_vulgatus_57955',
  # 'Bacteroides_plebeius_61623',
  'Bacteroides_coprocola_61586',
  'Barnesiella_intestinihominis_62208',
  'Akkermansia_muciniphila_55290',
  'Dialister_invisus_61905',
  'Phascolarctobacterium_sp_59817',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Roseburia_inulinivorans_61943',
  # 'Roseburia_intestinalis_56239',
  'Lachnospiraceae_bacterium_51870',
  'Coprococcus_sp_62244',
  'Oscillibacter_sp_60799',
  'Ruminococcus_bromii_62047',
  'Ruminococcus_bicirculans_59300',
  'Eubacterium_siraeum_57634',
  'Faecalibacterium_prausnitzii_57453',
  'Faecalibacterium_prasunitzii_62201',
  'Faecaelibacterium_prausnitzii_61481'
)

supplementary_species_list = c(
  'Akkermansia muciniphila',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes putredinis',
  'Alistipes shahii',
  'Alistipes sp.',
  'Bacteroidales bacterium',
  'Bacteroides caccae',
  'Bacteroides cellulosilyticus',
  'Bacteroides coprocola',
  'Bacteroides eggerthii',
  'Bacteroides fragilis',
  'Bacteroides massiliensis',
  # 'Bacteroides plebeius',
  # 'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides uniformis',
  'Bacteroides vulgatus',
  'Bacteroides xylanisolvens',
  'Barnesiella intestinihominis',
  'Coprococcus sp.',
  'Dialister invisus',
  'Eubacterium eligens',
  'Eubacterium rectale',
  'Eubacterium siraeum',
  'Faecalibacterium prausnitzii (57453)',
  'Faecalibacterium prausnitzii (61481)',
  'Faecalibacterium prausnitzii (62201)',
  'Lachnospiraceae bacterium',
  'Odoribacter splanchnicus',
  'Oscillibacter sp.',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Phascolarctobacterium sp.',
  'Prevotella copri',
  # 'Roseburia intestinalis',
  'Roseburia inulinivorans',
  'Ruminococcus bicirculans',
  'Ruminococcus bromii'
)

one_epoch_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/one_epoch_demography.txt',
  # '../SupplementaryAnalysis/Bacteroides_plebeius_61623/one_epoch_demography.txt',
  # '../SupplementaryAnalysis/Bacteroides_stercoris_56735/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/one_epoch_demography.txt',
  # '../SupplementaryAnalysis/Roseburia_intestinalis_56239/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/one_epoch_demography.txt'
)

two_epoch_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt',
  # '../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt',
  # '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt',
  # '../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt'
)

likelihood_surface_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_sp_60764/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/likelihood_surface.csv',
  # '../SupplementaryAnalysis/Bacteroides_plebeius_61623/likelihood_surface.csv',
  # '../SupplementaryAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/likelihood_surface.csv',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/likelihood_surface.csv',
  '../SupplementaryAnalysis/Dialister_invisus_61905/likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/likelihood_surface.csv',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/likelihood_surface.csv',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/likelihood_surface.csv',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/likelihood_surface.csv',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/likelihood_surface.csv',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/likelihood_surface.csv',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/likelihood_surface.csv',
  '../SupplementaryAnalysis/Prevotella_copri_61740/likelihood_surface.csv',
  # '../SupplementaryAnalysis/Roseburia_intestinalis_56239/likelihood_surface.csv',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv'
)

synonymous_sfs_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_empirical_syn_downsampled_sfs.txt',
  # '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_empirical_syn_downsampled_sfs.txt',
  # '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_empirical_syn_downsampled_sfs.txt',
  # '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_syn_downsampled_sfs.txt'
)

b_xylanisolvens_hmp_qp_syn = fold_sfs(read_input_sfs_original('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_empirical_syn_downsampled_sfs.txt'))
b_xylanisolvens_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt') 
b_xylanisolvens_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_empirical_nonsyn_downsampled_sfs.txt'))
b_xylanisolvens_core_gamma_dfe = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt') 

r_bromii_hmp_qp_syn = fold_sfs(read_input_sfs_original('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_syn_downsampled_sfs.txt'))
r_bromii_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt') 
r_bromii_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_nonsyn_downsampled_sfs.txt'))
r_bromii_core_gamma_dfe = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt') 

one_epoch_14 = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/one_epoch_demography.txt')
x_axis = 1:length(one_epoch_14)

b_xylanisolvens_best_fit = cbind(
  proportional_sfs(b_xylanisolvens_hmp_qp_syn[-1]),
  proportional_sfs(b_xylanisolvens_core_two_epoch),
  proportional_sfs(b_xylanisolvens_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_xylanisolvens_core_gamma_dfe),
  rep('B. xylanisolvens', length(b_xylanisolvens_hmp_qp_syn[-1])),
  x_axis
)

r_bromii_best_fit = cbind(
  proportional_sfs(r_bromii_hmp_qp_syn[-1]),
  proportional_sfs(r_bromii_core_two_epoch),
  proportional_sfs(r_bromii_hmp_qp_nonsyn[-1]),
  proportional_sfs(r_bromii_core_gamma_dfe),
  rep('R. bromii', length(r_bromii_hmp_qp_syn[-1])),
  x_axis
)

nu_tau_distribution = data.frame(species=supplementary_species_list, 
  nu_mle = numeric(36),
  time_mle = numeric(36),
  nu_low = numeric(36), 
  nu_high = numeric(36), 
  time_low = numeric(36), 
  time_high = numeric(36))

for (i in 1:length(likelihood_surface_file_list)) {
  # nu_mle
  nu_tau_distribution[i, 2] = return_nu_mle(likelihood_surface_file_list[i])
  # nu_low
  nu_tau_distribution[i, 4] = return_nu_low(likelihood_surface_file_list[i])
  # nu_high
  nu_tau_distribution[i, 5] =  return_nu_high(likelihood_surface_file_list[i])
  # tau_mle
  nu_tau_distribution[i, 3] = return_time_mle(likelihood_surface_file_list[i], 
    synonymous_sfs_file_list[i], 
    two_epoch_file_list[i])
  # tau_low
  nu_tau_distribution[i, 6] = return_time_low(likelihood_surface_file_list[i], 
    synonymous_sfs_file_list[i], 
    two_epoch_file_list[i])
  # tau_high
  nu_tau_distribution[i, 7] =  return_time_high(likelihood_surface_file_list[i], 
    synonymous_sfs_file_list[i], 
    two_epoch_file_list[i])
}

nu_tau_distribution$species = factor(nu_tau_distribution$species, levels=FD_phylogenetic_levels)

nu_tau_distribution <- nu_tau_distribution[order(nu_tau_distribution$species), ]

nu_tau_distribution

# 2000 x 900

demography_df = nu_tau_distribution[1:3]

names(demography_df) = c(
  'species',
  'nu_mle',
  'time_mle'
)

# demography_df$species = factor(demography_df$species, levels=phylogenetic_levels)

species_highlight = c('Bacteroides xylanisolvens', 'Ruminococcus bromii')

# species_highlight = c('Ruminococcus bromii')

typeface = ifelse(demography_df$species %in% species_highlight, 8, 6)

demography_df_highlight = demography_df[demography_df$species %in% species_highlight, ]
options(ggrepel.max.overlaps = Inf)
x_label_text = expression(nu == frac(N[current], N[ancestral]))

demography_scatter = ggscatter(demography_df, x="nu_mle", y="time_mle", color="species", shape=18, size=4) +
  ylab('Estimated time in years since most recent demographic event') +
  xlab(x_label_text) +
  geom_vline(xintercept=1.0, color='red', linewidth=1, linetype='dashed') +
  scale_shape_manual(name = "Best-Fit Demographic Model",
                     labels = c("Three Epoch", "Two Epoch"),
                     values = c(17, 19)) +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=typeface) +
  guides(color=guide_legend(title="Species")) +
  scale_x_log10(limits=c(1e-2, 2e4)) +
  #scale_y_log10(limits=c(3e2, 5e6)) +
  scale_y_log10() +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=16),
    axis.title=element_text(size=20))

demography_scatter

design = c(
  area(1, 1, 1, 1),
  area(1, 2, 1, 2),
  area(2, 1, 2, 1),
  area(2, 2, 2, 2),
  area(1, 3, 2, 5)
)

p9 = plot_best_fit_sfs_3A(b_xylanisolvens_best_fit) + ggtitle('Bacteroides xylanisolvens')
p9_l = plot_likelihood_surface_contour_3C('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/likelihood_surface.csv')

p30 = plot_best_fit_sfs_3B(r_bromii_best_fit) + ggtitle('Ruminococcus bromii')
p30_l = plot_likelihood_surface_contour_3D('../SupplementaryAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv')

### Figure 3
# 2000 x 900 dimensions for saved image

# png("../Summary/figure_3_output.png", width = 2000, height = 900)
figure_3 = p9 + p9_l + # B. xylanisolvens
  p30 + p30_l + #R. bicirculans
  demography_scatter +
  plot_layout(design=design)

# dev.off()
ggsave('../Summary/figure_3_output.svg', figure_3, width=25, height=10, units='in', dpi=600)
