setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

### Supplemental Table 3
one_epoch_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Prevotella_copri_61740_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_one_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_one_epoch_demography.txt'
)

two_epoch_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Prevotella_copri_61740_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_two_epoch_demography.txt'
)

three_epoch_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Prevotella_copri_61740_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_three_epoch_demography.txt'
)


phylogenetic_levels = c(
  'Bacteroidales bacterium',
  'Alistipes putredinis',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Odoribacter splanchnicus',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Prevotella copri',
  'Bacteroides fragilis',
  'Bacteroides cellulosilyticus',
  'Bacteroides stercoris',
  'Bacteroides uniformis',
  'Bacteroides thetaiotaomicron',
  # 'Bacteroides ovatus',
  'Bacteroides xylanisolvens',
  'Bacteroides caccae',
  # 'Bacteroides massiliensis',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Akkermansia muciniphila',
  'Dialister invisus',
  'Phascolarctobacterium species',
  'Eubacterium eligens',
  'Eubacterium rectale',
  # 'Coprococcus species',
  'Oscillibacter species',
  'Ruminococcus bromii',
  'Ruminococcus bicirculans',
  'Faecalibacterium prausnitzii'
)

phylogenetic_levels_MIDAS = c(
  'Bacteroidales_bacterium_58650',
  'Alistipes_putredinis_61533',
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_shahii_62199',
  'Odoribacter_splanchnicus_62174',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Prevotella_copri_61740',
  'Bacteroides_fragilis_54507',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_stercoris_56735',
  'Bacteroides_uniformis_57318',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_xylanisolvens_57185',
  'Bacteroides_caccae_53434',
  'Bacteroides_vulgatus_57955',
  'Barnesiella_intestinihominis_62208',
  'Akkermansia_muciniphila_55290',
  'Dialister_invisus_61905',
  'Phascolarctobacterium_sp_59817',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Oscillibacter_sp_60799',
  'Ruminococcus_bromii_62047',
  'Ruminococcus_bicirculans_59300',
  'Faecalibacterium_prausnitzii_57453'
)

likelihood_surface_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Prevotella_copri_61740_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_likelihood_surface.csv'
)

synonymous_sfs_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Prevotella_copri_61740_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_empirical_syn_downsampled_sfs.txt'
)

DFE_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Prevotella_copri_61740_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt'
)

DFE_core_file_list = c(
  '../Analysis/cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_uniformis_57318_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_likelihood_surface.csv'
)

DFE_core_file_list_constant_s = c(
  '../Analysis/cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_uniformis_57318_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_constant_s_likelihood_surface.csv'
)

DFE_acc_file_list = c(
  '../Analysis/accessory_cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_uniformis_57318_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Faecalibacterium_prausnitzii_57453_likelihood_surface.csv'
)

DFE_acc_file_list_constant_s = c(
  '../Analysis/accessory_cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_uniformis_57318_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Faecalibacterium_prausnitzii_57453_constant_s_likelihood_surface.csv'
)

core_acc_species_list = c(
  'Parabacteroides distasonis',
  'Bacteroides uniformis',
  'Bacteroides thetaiotaomicron',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Eubacterium rectale',
  'Faecalibacterium prausnitzii'
)

acc_core_dfe_comparison = numeric(7)
acc_core_dfe_comparison_constant_s = numeric(7)

for (i in 1:length(core_acc_species_list)) {
  acc_core_dfe_comparison[i] = cross_species_dfe_comparison(DFE_core_file_list[i], DFE_acc_file_list[i])
  acc_core_dfe_comparison_constant_s[i] = cross_species_dfe_comparison(DFE_core_file_list_constant_s[i], DFE_acc_file_list_constant_s[i])
}

nu_tau_distribution = data.frame(species=phylogenetic_levels, 
  nu_mle = numeric(27),
  time_mle = numeric(27),
  nu_low = numeric(27), 
  nu_high = numeric(27), 
  time_low = numeric(27), 
  time_high = numeric(27))

nu_tau_distribution

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

nu_tau_distribution$species = factor(nu_tau_distribution$species, levels=phylogenetic_levels)

one_epoch_likelihood = numeric(27)
one_epoch_AIC = numeric(27)
one_epoch_theta = numeric(27)
one_epoch_nanc = numeric(27)
two_epoch_likelihood = numeric(27)
two_epoch_AIC = numeric(27)
two_epoch_nu = numeric(27)
two_epoch_tau = numeric(27)
two_epoch_time = numeric(27)
two_epoch_theta = numeric(27)
two_epoch_nanc = numeric(27)
two_epoch_ncurr = numeric(27)
three_epoch_likelihood = numeric(27)
three_epoch_AIC = numeric(27)
three_epoch_nu_bottleneck = numeric(27)
three_epoch_nu_contemporary = numeric(27)
three_epoch_tau_bottleneck = numeric(27)
three_epoch_tau_contemporary = numeric(27)
three_epoch_time_total = numeric(27)
three_epoch_theta = numeric(27)
three_epoch_nanc = numeric(27)
three_epoch_ncurr = numeric(27)

for (i in 1:length(one_epoch_file_list)) {
  one_epoch_likelihood[i] = return_demography_likelihood(one_epoch_file_list[i])
  one_epoch_AIC[i] = AIC_from_demography(one_epoch_file_list[i])
  one_epoch_theta[i] = theta_from_demography(one_epoch_file_list[i])
  one_epoch_nanc[i] = nanc_from_demography(one_epoch_file_list[i])
  two_epoch_likelihood[i] = return_demography_likelihood(two_epoch_file_list[i])
  two_epoch_AIC[i] = AIC_from_demography(two_epoch_file_list[i])
  two_epoch_nu[i] = return_demography_params(two_epoch_file_list[i])[1]
  two_epoch_tau[i] = return_demography_params(two_epoch_file_list[i])[2]
  two_epoch_time[i] = time_from_demography(two_epoch_file_list[i])
  two_epoch_theta[i] = theta_from_demography(two_epoch_file_list[i])
  two_epoch_nanc[i] = nanc_from_demography(two_epoch_file_list[i])
  two_epoch_ncurr[i] = two_epoch_nu[i] * two_epoch_nanc[i]
  three_epoch_likelihood[i] = return_demography_likelihood(three_epoch_file_list[i])
  three_epoch_AIC[i] = AIC_from_demography(three_epoch_file_list[i])
  three_epoch_nu_bottleneck[i] = return_demography_params(three_epoch_file_list[i])[1]
  three_epoch_nu_contemporary[i] = return_demography_params(three_epoch_file_list[i])[2]
  three_epoch_tau_bottleneck[i] = return_demography_params(three_epoch_file_list[i])[3]
  three_epoch_tau_contemporary[i] = return_demography_params(three_epoch_file_list[i])[4]
  three_epoch_time_total[i] = time_from_demography(three_epoch_file_list[i])
  three_epoch_theta[i] = theta_from_demography(three_epoch_file_list[i])
  three_epoch_nanc[i] = nanc_from_demography(three_epoch_file_list[i])
  three_epoch_ncurr[i] = three_epoch_nu_contemporary[i] * three_epoch_nanc[i]
}

table_s3 = data.frame(
  species=phylogenetic_levels_MIDAS,
  one_epoch_likelihood,
  one_epoch_AIC,
  one_epoch_theta,
  one_epoch_nanc,
  two_epoch_likelihood,
  two_epoch_AIC,
  two_epoch_nu,
  two_epoch_tau,
  two_epoch_time,
  two_epoch_theta,
  two_epoch_nanc,
  two_epoch_ncurr,
  three_epoch_likelihood,
  three_epoch_AIC,
  three_epoch_nu_bottleneck,
  three_epoch_nu_contemporary,
  three_epoch_tau_bottleneck,
  three_epoch_tau_contemporary,
  three_epoch_time_total,
  three_epoch_theta,
  three_epoch_nanc,
  three_epoch_ncurr
)

names(table_s3) = c(
  'Species',
  'One epoch, log likelihood',
  'One epoch, AIC',
  'One epoch, theta',
  'One epoch, Ancestral effective population size',
  'Two epoch, log likelihood',
  'Two epoch, AIC',
  'Two epoch, nu',
  'Two epoch, tau',
  'Two epoch, time in years',
  'Two epoch, theta',
  'Two epoch, Ancestral effective population size',
  'Two epoch, Current effective population size',
  'Three epoch, log likelihood',
  'Three epoch, AIC',
  'Three epoch, nu (bottleneck)',
  'Three epoch, nu (contemporary)',
  'Three epoch, tau (bottleneck)',
  'Three epoch, tau (contemporary)',
  'Three epoch, time in years',
  'Three epoch, theta',
  'Three epoch, Ancestral effective population size',
  'Three epoch, Current effective population size'
)

write.csv(table_s3, '../Supplement/Supplemental_Table_3.csv', row.names = F)

### Supplemental Table 4
names(nu_tau_distribution) = c(
  'Species',
  'Nu, MLE',
  'Time in years, MLE',
  'Low estimate of Nu',
  'High estimate of Nu',
  'Low estimate of time in years',
  'High estimate of time in years'
)

write.csv(nu_tau_distribution, '../Supplement/Supplemental_Table_4.csv', row.names = F)

### Supplemental Table 5

dfe_nanc = numeric(27)
gamma_likelihood = numeric(27)
gamma_AIC = numeric(27)
gamma_alpha = numeric(27)
gamma_beta = numeric(27)
neugamma_likelihood = numeric(27)
neugamma_AIC = numeric(27)
neugamma_pneu = numeric(27)
neugamma_alpha = numeric(27)
neugamma_beta = numeric(27)


for (i in 1:length(DFE_file_list)) {
  dfe_nanc[i] = nanc_from_demography(two_epoch_file_list[i])
  gamma_likelihood[i] = return_DFE_likelihood(DFE_file_list[i])[1]
  gamma_AIC[i] = 4 - 2 * gamma_likelihood[i]
  gamma_alpha[i] = return_DFE_params(DFE_file_list[i])[1]
  gamma_beta[i] = return_DFE_params(DFE_file_list[i])[2]
  neugamma_likelihood[i] = return_DFE_likelihood(DFE_file_list[i])[2]
  neugamma_AIC[i] = 6 - 2 * neugamma_likelihood[i]
  neugamma_pneu[i] = return_DFE_params(DFE_file_list[i])[3]
  neugamma_alpha[i] = return_DFE_params(DFE_file_list[i])[4]
  neugamma_beta[i] = return_DFE_params(DFE_file_list[i])[5]
}

table_s5 = data.frame(
  species=phylogenetic_levels_MIDAS,
  dfe_nanc,
  gamma_likelihood,
  gamma_AIC,
  gamma_alpha,
  gamma_beta,
  neugamma_likelihood,
  neugamma_AIC,
  neugamma_pneu,
  neugamma_alpha,
  neugamma_beta
)

names(table_s5) = c(
  'Species',
  'Ancestral effective population size',
  'Gamma DFE, Log likelihood',
  'Gamma DFE, AIC',
  'Gamma DFE, Shape',
  'Gamma DFE, Scale',
  'Neu-Gamma DFE, Log likelihood',
  'Neu-Gamma DFE, AIC',
  'Neu-Gamma DFE, Proportion of Neutral Mutations',
  'Neu-Gamma DFE, Shape',
  'Neu-Gamma DFE, Scale'
)

table_s5

write.csv(table_s5, '../Supplement/Supplemental_Table_5.csv', row.names = F)

### Supplemental Table 6
accessory_phylogenetic_levels = c(
  'Parabacteroides_distasonis_56985',
  'Bacteroides_uniformis_57318',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_vulgatus_57955',
  'Barnesiella_intestinihominis_62208',
  'Eubacterium_rectale_56927',
  'Faecalibacterium_prausnitzii_57453'
)

accessory_one_epoch_file_list = c(
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_one_epoch_demography.txt'
)

accessory_two_epoch_file_list = c(
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_two_epoch_demography.txt'
)

accessory_three_epoch_file_list = c(
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_three_epoch_demography.txt'
)

accessory_one_epoch_likelihood = numeric(7)
accessory_one_epoch_AIC = numeric(7)
accessory_one_epoch_theta = numeric(7)
accessory_one_epoch_nanc = numeric(7)
accessory_two_epoch_likelihood = numeric(7)
accessory_two_epoch_AIC = numeric(7)
accessory_two_epoch_nu = numeric(7)
accessory_two_epoch_tau = numeric(7)
accessory_two_epoch_time = numeric(7)
accessory_two_epoch_theta = numeric(7)
accessory_two_epoch_nanc = numeric(7)
accessory_two_epoch_ncurr = numeric(7)
accessory_three_epoch_likelihood = numeric(7)
accessory_three_epoch_AIC = numeric(7)
accessory_three_epoch_nu_bottleneck = numeric(7)
accessory_three_epoch_nu_contemporary = numeric(7)
accessory_three_epoch_tau_bottleneck = numeric(7)
accessory_three_epoch_tau_contemporary = numeric(7)
accessory_three_epoch_time_total = numeric(7)
accessory_three_epoch_theta = numeric(7)
accessory_three_epoch_nanc = numeric(7)
accessory_three_epoch_ncurr = numeric(7)

for (i in 1:length(accessory_one_epoch_file_list)) {
  accessory_one_epoch_likelihood[i] = return_demography_likelihood(accessory_one_epoch_file_list[i])
  accessory_one_epoch_AIC[i] = AIC_from_demography(accessory_one_epoch_file_list[i])
  accessory_one_epoch_theta[i] = theta_from_demography(accessory_one_epoch_file_list[i])
  accessory_one_epoch_nanc[i] = nanc_from_demography(accessory_one_epoch_file_list[i])
  accessory_two_epoch_likelihood[i] = return_demography_likelihood(accessory_two_epoch_file_list[i])
  accessory_two_epoch_AIC[i] = AIC_from_demography(accessory_two_epoch_file_list[i])
  accessory_two_epoch_nu[i] = return_demography_params(accessory_two_epoch_file_list[i])[1]
  accessory_two_epoch_tau[i] = return_demography_params(accessory_two_epoch_file_list[i])[2]
  accessory_two_epoch_time[i] = time_from_demography(accessory_two_epoch_file_list[i])
  accessory_two_epoch_theta[i] = theta_from_demography(accessory_two_epoch_file_list[i])
  accessory_two_epoch_nanc[i] = nanc_from_demography(accessory_two_epoch_file_list[i])
  accessory_two_epoch_ncurr[i] = accessory_two_epoch_nu[i] * accessory_two_epoch_ncurr[i]
  accessory_three_epoch_likelihood[i] = return_demography_likelihood(accessory_three_epoch_file_list[i])
  accessory_three_epoch_AIC[i] = AIC_from_demography(accessory_three_epoch_file_list[i])
  accessory_three_epoch_nu_bottleneck[i] = return_demography_params(accessory_three_epoch_file_list[i])[1]
  accessory_three_epoch_nu_contemporary[i] = return_demography_params(accessory_three_epoch_file_list[i])[2]
  accessory_three_epoch_tau_bottleneck[i] = return_demography_params(accessory_three_epoch_file_list[i])[3]
  accessory_three_epoch_tau_contemporary[i] = return_demography_params(accessory_three_epoch_file_list[i])[4]
  accessory_three_epoch_time_total[i] = time_from_demography(accessory_three_epoch_file_list[i])
  accessory_three_epoch_theta[i] = theta_from_demography(accessory_three_epoch_file_list[i])
  accessory_three_epoch_nanc[i] = nanc_from_demography(accessory_three_epoch_file_list[i])
  accessory_three_epoch_ncurr[i] = accessory_three_epoch_nu_contemporary[i] * accessory_three_epoch_nanc[i]
}

core_ancestral = table_s3[c(7, 13, 14, 17, 18, 23, 27), ]

table_s6 = data.frame(
  species=accessory_phylogenetic_levels,
  accessory_one_epoch_likelihood,
  accessory_one_epoch_AIC,
  accessory_one_epoch_theta,
  accessory_one_epoch_nanc,
  accessory_two_epoch_likelihood,
  accessory_two_epoch_AIC,
  accessory_two_epoch_nu,
  accessory_two_epoch_tau,
  accessory_two_epoch_time,
  accessory_two_epoch_theta,
  accessory_two_epoch_nanc,
  accessory_two_epoch_ncurr,
  accessory_three_epoch_likelihood,
  accessory_three_epoch_AIC,
  accessory_three_epoch_nu_bottleneck,
  accessory_three_epoch_nu_contemporary,
  accessory_three_epoch_tau_bottleneck,
  accessory_three_epoch_tau_contemporary,
  accessory_three_epoch_time_total,
  accessory_three_epoch_theta,
  accessory_three_epoch_nanc,
  accessory_three_epoch_ncurr,
  core_ancestral$`One epoch, Ancestral effective population size`,
  core_ancestral$`Two epoch, Ancestral effective population size`,
  core_ancestral$`Three epoch, Ancestral effective population size`
)

names(table_s6) = c(
  'Species',
  'One epoch, log likelihood (Accessory)',
  'One epoch, AIC (Accessory)',
  'One epoch, theta (Accessory)',
  'One epoch, Ancestral effective population size (Accessory)',
  'Two epoch, log likelihood (Accessory)',
  'Two epoch, AIC (Accessory)',
  'Two epoch, nu (Accessory)',
  'Two epoch, tau (Accessory)',
  'Two epoch, time in years (Accessory)',
  'Two epoch, theta (Accessory)',
  'Two epoch, Ancestral effective population size (Accessory)',
  'Two epoch, Current effective population size (Accessory)',
  'Three epoch, log likelihood (Accessory)',
  'Three epoch, AIC (Accessory)',
  'Three epoch, nu at end of epoch one (Accessory)',
  'Three epoch, nu at end of epoch two (Accessory)',
  'Three epoch, tau at end of epoch one (Accessory)',
  'Three epoch, tau at end of epoch two (Accessory)',
  'Three epoch, time in years (Accessory)',
  'Three epoch, theta (Accessory)',
  'Three epoch, Ancestral effective population size (Accessory)',
  'Three epoch, Current effective population size (Accessory)',
  'One epoch, Ancestral effective population size (Core)',
  'Two epoch, Ancestral effective population size (Core)',
  'Three epoch, Ancestral effective population size (Core)'
)

table_s6
write.csv(table_s6, '../Supplement/Supplemental_Table_6.csv', row.names = F)


### Supplemental Table 7
accessory_DFE_file_list = c(
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_inferred_DFE.txt'
)

accessory_dfe_nanc = numeric(7)
accessory_gamma_likelihood = numeric(7)
accessory_gamma_AIC = numeric(7)
accessory_gamma_alpha = numeric(7)
accessory_gamma_beta = numeric(7)
accessory_neugamma_likelihood = numeric(7)
accessory_neugamma_AIC = numeric(7)
accessory_neugamma_pneu = numeric(7)
accessory_neugamma_alpha = numeric(7)
accessory_neugamma_beta = numeric(7)

for (i in 1:length(accessory_DFE_file_list)) {
  accessory_dfe_nanc[i] = nanc_from_demography(accessory_two_epoch_file_list[i])
  accessory_gamma_likelihood[i] = return_DFE_likelihood(accessory_DFE_file_list[i])[1]
  accessory_gamma_AIC[i] = 4 - 2 * accessory_gamma_likelihood[i]
  accessory_gamma_alpha[i] = return_DFE_params(accessory_DFE_file_list[i])[1]
  accessory_gamma_beta[i] = return_DFE_params(accessory_DFE_file_list[i])[2]
  accessory_neugamma_likelihood[i] = return_DFE_likelihood(accessory_DFE_file_list[i])[2]
  accessory_neugamma_AIC[i] = 6 - 2 * accessory_neugamma_likelihood[i]
  accessory_neugamma_pneu[i] = return_DFE_params(accessory_DFE_file_list[i])[3]
  accessory_neugamma_alpha[i] = return_DFE_params(accessory_DFE_file_list[i])[4]
  accessory_neugamma_beta[i] = return_DFE_params(accessory_DFE_file_list[i])[5]
}

table_s7 = data.frame(
  species=accessory_phylogenetic_levels,
  accessory_dfe_nanc,
  accessory_gamma_likelihood,
  accessory_gamma_AIC,
  accessory_gamma_alpha,
  accessory_gamma_beta,
  accessory_neugamma_likelihood,
  accessory_neugamma_AIC,
  accessory_neugamma_pneu,
  accessory_neugamma_alpha,
  accessory_neugamma_beta
)

names(table_s7) = c(
  'Species',
  'Ancestral effective population size',
  'Gamma DFE, Log likelihood',
  'Gamma DFE, AIC',
  'Gamma DFE, Shape',
  'Gamma DFE, Scale',
  'Neu-Gamma DFE, Log likelihood',
  'Neu-Gamma DFE, AIC',
  'Neu-Gamma DFE, Proportion of Neutral Mutations',
  'Neu-Gamma DFE, Shape',
  'Neu-Gamma DFE, Scale'
)

table_s7

write.csv(table_s7, '../Supplement/Supplemental_Table_7.csv', row.names = F)

### Supplemental Table 8
DFE_core_file_list = c(
  '../Analysis/cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_uniformis_57318_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_likelihood_surface.csv'
)

DFE_core_file_list_constant_s = c(
  '../Analysis/cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_uniformis_57318_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_constant_s_likelihood_surface.csv'
)

DFE_acc_file_list = c(
  '../Analysis/accessory_cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_uniformis_57318_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Faecalibacterium_prausnitzii_57453_likelihood_surface.csv'
)

DFE_acc_file_list_constant_s = c(
  '../Analysis/accessory_cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_uniformis_57318_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Faecalibacterium_prausnitzii_57453_constant_s_likelihood_surface.csv'
)

core_acc_species_list = c(
  'Parabacteroides distasonis',
  'Bacteroides uniformis',
  'Bacteroides thetaiotaomicron',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Eubacterium rectale',
  'Faecalibacterium prausnitzii'
)

acc_core_dfe_comparison = numeric(7)
acc_core_dfe_comparison_constant_s = numeric(7)

for (i in 1:length(core_acc_species_list)) {
  acc_core_dfe_comparison[i] = cross_species_dfe_comparison(DFE_core_file_list[i], DFE_acc_file_list[i])
  acc_core_dfe_comparison_constant_s[i] = cross_species_dfe_comparison(DFE_core_file_list_constant_s[i], DFE_acc_file_list_constant_s[i])
}

### 

acc_core_dfe_LRT_table = data.frame(species=core_acc_species_list, constant_2NAs=acc_core_dfe_comparison, constant_s=acc_core_dfe_comparison_constant_s)

acc_core_dfe_LRT_table

write.csv(acc_core_dfe_LRT_table, '../Summary/core_acc_dfe_LRT.csv', row.names =FALSE)
