setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# Supplemental Tables

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
  'Bacteroides stercoris',
  'Bacteroides uniformis',
  'Bacteroides thetaiotaomicron',
  'Bacteroides xylanisolvens',
  'Bacteroides caccae',
  'Bacteroides massiliensis',
  'Bacteroides vulgatus',
  'Bacteroides plebeius',
  'Bacteroides coprocola',
  'Barnesiella intestinihominis',
  'Akkermansia muciniphila',
  'Dialister invisus',
  'Phascolarctobacterium sp.',
  'Eubacterium eligens',
  'Eubacterium rectale',
  'Roseburia inulinivorans',
  'Roseburia intestinalis',
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
  'Bacteroides_stercoris_56735',
  'Bacteroides_uniformis_57318',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_xylanisolvens_57185',
  'Bacteroides_caccae_53434',
  'Bacteroides_massiliensis_44749',
  'Bacteroides_vulgatus_57955',
  'Bacteroides_plebeius_61623',
  'Bacteroides_coprocola_61586',
  'Barnesiella_intestinihominis_62208',
  'Akkermansia_muciniphila_55290',
  'Dialister_invisus_61905',
  'Phascolarctobacterium_sp_59817',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Roseburia_inulinivorans_61943',
  'Roseburia_intestinalis_56239',
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

core_one_epoch_file_list = c(
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
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/one_epoch_demography.txt',
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
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/one_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/one_epoch_demography.txt'
)

core_two_epoch_file_list = c(
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
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
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
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt'
)

core_three_epoch_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/three_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/three_epoch_demography.txt'
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
  'Bacteroides plebeius',
  'Bacteroides stercoris',
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
  'Roseburia intestinalis',
  'Roseburia inulinivorans',
  'Ruminococcus bicirculans',
  'Ruminococcus bromii'
)

core_likelihood_surface_file_list = c(
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
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv',
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
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/likelihood_surface.csv',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv'
)

core_synonymous_sfs_file_list = c(
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
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_empirical_syn_downsampled_sfs.txt',
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
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_syn_downsampled_sfs.txt'
)

core_DFE_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt'
)

a_muciniphila_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_empirical_syn_downsampled_sfs.txt')
a_finegoldii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_empirical_syn_downsampled_sfs.txt')
a_onderdonkii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_empirical_syn_downsampled_sfs.txt')
a_putredinis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_empirical_syn_downsampled_sfs.txt')
a_shahii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_shahii_62199/core_empirical_syn_downsampled_sfs.txt')
alistipes_sp_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_sp_60764/core_empirical_syn_downsampled_sfs.txt')
b_bacterium_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_empirical_syn_downsampled_sfs.txt')
b_caccae_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_empirical_syn_downsampled_sfs.txt')
b_cellulosilyticus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_empirical_syn_downsampled_sfs.txt')
b_coprocola_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_empirical_syn_downsampled_sfs.txt')
b_eggerthii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_empirical_syn_downsampled_sfs.txt')
b_fragilis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_empirical_syn_downsampled_sfs.txt')
b_massiliensis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_empirical_syn_downsampled_sfs.txt')
b_ovatus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_empirical_syn_downsampled_sfs.txt')
b_plebeius_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_empirical_syn_downsampled_sfs.txt')
b_stercoris_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_empirical_syn_downsampled_sfs.txt')
b_thetaiotaomicron_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_empirical_syn_downsampled_sfs.txt')
b_uniformis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_empirical_syn_downsampled_sfs.txt')
b_vulgatus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_empirical_syn_downsampled_sfs.txt')
b_xylanisolvens_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_empirical_syn_downsampled_sfs.txt')
b_intestinihominis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_empirical_syn_downsampled_sfs.txt')
coprococcus_sp_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Coprococcus_sp_62244/core_empirical_syn_downsampled_sfs.txt')
d_invisus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Dialister_invisus_61905/core_empirical_syn_downsampled_sfs.txt')
e_eligens_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_empirical_syn_downsampled_sfs.txt')
e_rectale_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_empirical_syn_downsampled_sfs.txt')
e_siraeum_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_57453_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_61481_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_62201_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_empirical_syn_downsampled_sfs.txt')
l_bacterium_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_empirical_syn_downsampled_sfs.txt')
o_splanchnicus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_empirical_syn_downsampled_sfs.txt')
oscillibacter_sp_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_empirical_syn_downsampled_sfs.txt')
p_distasonis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_empirical_syn_downsampled_sfs.txt')
p_merdae_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_empirical_syn_downsampled_sfs.txt')
phascolarctobacterium_sp_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_empirical_syn_downsampled_sfs.txt')
p_copri_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Prevotella_copri_61740/core_empirical_syn_downsampled_sfs.txt')
r_intestinalis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_empirical_syn_downsampled_sfs.txt')
r_inulinivorans_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_empirical_syn_downsampled_sfs.txt')
r_bicirculans_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_empirical_syn_downsampled_sfs.txt')
r_bromii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_syn_downsampled_sfs.txt')

## Read in demographic model fit for high recombination

### One-epoch (core)
a_muciniphila_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/one_epoch_demography.txt')
a_finegoldii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/one_epoch_demography.txt')
a_onderdonkii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/one_epoch_demography.txt')
a_putredinis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/one_epoch_demography.txt')
a_shahii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/one_epoch_demography.txt')
alistipes_sp_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/one_epoch_demography.txt')
b_bacterium_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/one_epoch_demography.txt')
b_caccae_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/one_epoch_demography.txt')
b_cellulosilyticus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/one_epoch_demography.txt')
b_coprocola_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/one_epoch_demography.txt')
b_eggerthii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/one_epoch_demography.txt')
b_fragilis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/one_epoch_demography.txt')
b_massiliensis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/one_epoch_demography.txt')
b_ovatus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/one_epoch_demography.txt')
b_plebeius_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/one_epoch_demography.txt')
b_stercoris_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/one_epoch_demography.txt')
b_thetaiotaomicron_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/one_epoch_demography.txt')
b_uniformis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/one_epoch_demography.txt')
b_vulgatus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/one_epoch_demography.txt')
b_xylanisolvens_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/one_epoch_demography.txt')
b_intestinihominis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/one_epoch_demography.txt')
coprococcus_sp_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/one_epoch_demography.txt')
d_invisus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/one_epoch_demography.txt')
e_eligens_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/one_epoch_demography.txt')
e_rectale_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/one_epoch_demography.txt')
e_siraeum_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/one_epoch_demography.txt')
f_prausnitzii_57453_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/one_epoch_demography.txt')
f_prausnitzii_61481_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/one_epoch_demography.txt')
f_prausnitzii_62201_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/one_epoch_demography.txt')
l_bacterium_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/one_epoch_demography.txt')
o_splanchnicus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/one_epoch_demography.txt')
oscillibacter_sp_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/one_epoch_demography.txt')
p_distasonis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/one_epoch_demography.txt')
p_merdae_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/one_epoch_demography.txt')
phascolarctobacterium_sp_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/one_epoch_demography.txt')
p_copri_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/one_epoch_demography.txt')
r_intestinalis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/one_epoch_demography.txt')
r_inulinivorans_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/one_epoch_demography.txt')
r_bicirculans_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/one_epoch_demography.txt')
r_bromii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/one_epoch_demography.txt')

### Two-epoch (core)
a_muciniphila_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt')
a_finegoldii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt')
a_onderdonkii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt')
a_putredinis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt')
a_shahii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt')
alistipes_sp_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt')
b_bacterium_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt')
b_caccae_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt')
b_cellulosilyticus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt')
b_coprocola_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt')
b_eggerthii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt')
b_fragilis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt')
b_massiliensis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt')
b_ovatus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/two_epoch_demography.txt')
b_plebeius_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt')
b_stercoris_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt')
b_thetaiotaomicron_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt')
b_uniformis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt')
b_vulgatus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt')
b_xylanisolvens_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt')
b_intestinihominis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt')
coprococcus_sp_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt')
d_invisus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt')
e_eligens_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt')
e_rectale_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt')
e_siraeum_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt')
f_prausnitzii_57453_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt')
f_prausnitzii_61481_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt')
f_prausnitzii_62201_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt')
l_bacterium_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt')
o_splanchnicus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt')
oscillibacter_sp_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt')
p_distasonis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt')
p_merdae_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt')
phascolarctobacterium_sp_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt')
p_copri_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt')
r_intestinalis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt')
r_inulinivorans_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt')
r_bicirculans_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt')
r_bromii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt')

### Three-epoch (core)
a_muciniphila_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/three_epoch_demography.txt')
a_finegoldii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/three_epoch_demography.txt')
a_onderdonkii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/three_epoch_demography.txt')
a_putredinis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/three_epoch_demography.txt')
a_shahii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/three_epoch_demography.txt')
alistipes_sp_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/three_epoch_demography.txt')
b_bacterium_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/three_epoch_demography.txt')
b_caccae_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/three_epoch_demography.txt')
b_cellulosilyticus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/three_epoch_demography.txt')
b_coprocola_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/three_epoch_demography.txt')
b_eggerthii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/three_epoch_demography.txt')
b_fragilis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/three_epoch_demography.txt')
b_massiliensis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/three_epoch_demography.txt')
b_ovatus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/three_epoch_demography.txt')
b_plebeius_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/three_epoch_demography.txt')
b_stercoris_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/three_epoch_demography.txt')
b_thetaiotaomicron_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/three_epoch_demography.txt')
b_uniformis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/three_epoch_demography.txt')
b_vulgatus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/three_epoch_demography.txt')
b_xylanisolvens_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/three_epoch_demography.txt')
b_intestinihominis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/three_epoch_demography.txt')
coprococcus_sp_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/three_epoch_demography.txt')
d_invisus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/three_epoch_demography.txt')
e_eligens_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/three_epoch_demography.txt')
e_rectale_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/three_epoch_demography.txt')
e_siraeum_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/three_epoch_demography.txt')
f_prausnitzii_57453_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/three_epoch_demography.txt')
f_prausnitzii_61481_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/three_epoch_demography.txt')
f_prausnitzii_62201_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/three_epoch_demography.txt')
l_bacterium_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/three_epoch_demography.txt')
o_splanchnicus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/three_epoch_demography.txt')
oscillibacter_sp_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/three_epoch_demography.txt')
p_distasonis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/three_epoch_demography.txt')
p_merdae_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/three_epoch_demography.txt')
phascolarctobacterium_sp_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/three_epoch_demography.txt')
p_copri_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/three_epoch_demography.txt')
r_intestinalis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/three_epoch_demography.txt')
r_inulinivorans_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/three_epoch_demography.txt')
r_bicirculans_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/three_epoch_demography.txt')
r_bromii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/three_epoch_demography.txt')

# Nonsyn empirical (core)

a_muciniphila_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt')
a_finegoldii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt')
a_onderdonkii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt')
a_putredinis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt')
a_shahii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt')
alistipes_sp_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt')
b_bacterium_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt')
b_caccae_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt')
b_cellulosilyticus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt')
b_coprocola_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt')
b_eggerthii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt')
b_fragilis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt')
b_massiliensis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt')
b_ovatus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_DFE.txt')
b_plebeius_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt')
b_stercoris_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt')
b_thetaiotaomicron_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt')
b_uniformis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt')
b_vulgatus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt')
b_xylanisolvens_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt')
b_intestinihominis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt')
coprococcus_sp_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt')
d_invisus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt')
e_eligens_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt')
e_rectale_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt')
e_siraeum_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt')
f_prausnitzii_57453_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt')
f_prausnitzii_61481_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt')
f_prausnitzii_62201_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt')
l_bacterium_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt')
o_splanchnicus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt')
oscillibacter_sp_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt')
p_distasonis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt')
p_merdae_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt')
phascolarctobacterium_sp_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt')
p_copri_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt')
r_intestinalis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt')
r_inulinivorans_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt')
r_bicirculans_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt')
r_bromii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt')

# Gamma (core)

a_muciniphila_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt')
a_finegoldii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt')
a_onderdonkii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt')
a_putredinis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt')
a_shahii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt')
alistipes_sp_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt')
b_bacterium_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt')
b_caccae_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt')
b_cellulosilyticus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt')
b_coprocola_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt')
b_eggerthii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt')
b_fragilis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt')
b_massiliensis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt')
b_ovatus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_DFE.txt')
b_plebeius_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt')
b_stercoris_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt')
b_thetaiotaomicron_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt')
b_uniformis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt')
b_vulgatus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt')
b_xylanisolvens_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt')
b_intestinihominis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt')
coprococcus_sp_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt')
d_invisus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt')
e_eligens_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt')
e_rectale_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt')
e_siraeum_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt')
f_prausnitzii_57453_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt')
f_prausnitzii_61481_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt')
f_prausnitzii_62201_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt')
l_bacterium_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt')
o_splanchnicus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt')
oscillibacter_sp_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt')
p_distasonis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt')
p_merdae_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt')
phascolarctobacterium_sp_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt')
p_copri_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt')
r_intestinalis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt')
r_inulinivorans_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt')
r_bicirculans_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt')
r_bromii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt')

# Neugamma

a_muciniphila_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt')
a_finegoldii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt')
a_onderdonkii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt')
a_putredinis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt')
a_shahii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt')
alistipes_sp_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt')
b_bacterium_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt')
b_caccae_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt')
b_cellulosilyticus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt')
b_coprocola_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt')
b_eggerthii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt')
b_fragilis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt')
b_massiliensis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt')
b_ovatus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_DFE.txt')
b_plebeius_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt')
b_stercoris_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt')
b_thetaiotaomicron_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt')
b_uniformis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt')
b_vulgatus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt')
b_xylanisolvens_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt')
b_intestinihominis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt')
coprococcus_sp_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt')
d_invisus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt')
e_eligens_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt')
e_rectale_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt')
e_siraeum_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt')
f_prausnitzii_57453_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt')
f_prausnitzii_61481_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt')
f_prausnitzii_62201_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt')
l_bacterium_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt')
o_splanchnicus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt')
oscillibacter_sp_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt')
p_distasonis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt')
p_merdae_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt')
phascolarctobacterium_sp_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt')
p_copri_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt')
r_intestinalis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt')
r_inulinivorans_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt')
r_bicirculans_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt')
r_bromii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt')

a_muciniphila_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_empirical_syn_downsampled_sfs.txt')
a_finegoldii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_empirical_syn_downsampled_sfs.txt')
a_onderdonkii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_empirical_syn_downsampled_sfs.txt')
a_putredinis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_empirical_syn_downsampled_sfs.txt')
a_shahii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_empirical_syn_downsampled_sfs.txt')
alistipes_sp_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_empirical_syn_downsampled_sfs.txt')
b_bacterium_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_empirical_syn_downsampled_sfs.txt')
b_caccae_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_empirical_syn_downsampled_sfs.txt')
b_cellulosilyticus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_empirical_syn_downsampled_sfs.txt')
b_coprocola_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_empirical_syn_downsampled_sfs.txt')
b_eggerthii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_empirical_syn_downsampled_sfs.txt')
b_fragilis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_empirical_syn_downsampled_sfs.txt')
b_massiliensis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_empirical_syn_downsampled_sfs.txt')
b_ovatus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_empirical_syn_downsampled_sfs.txt')
b_plebeius_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_empirical_syn_downsampled_sfs.txt')
b_stercoris_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_empirical_syn_downsampled_sfs.txt')
b_thetaiotaomicron_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_empirical_syn_downsampled_sfs.txt')
b_uniformis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_empirical_syn_downsampled_sfs.txt')
b_vulgatus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_empirical_syn_downsampled_sfs.txt')
b_xylanisolvens_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_empirical_syn_downsampled_sfs.txt')
b_intestinihominis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_empirical_syn_downsampled_sfs.txt')
coprococcus_sp_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_empirical_syn_downsampled_sfs.txt')
d_invisus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_empirical_syn_downsampled_sfs.txt')
e_eligens_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_empirical_syn_downsampled_sfs.txt')
e_rectale_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_empirical_syn_downsampled_sfs.txt')
e_siraeum_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_57453_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_61481_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_62201_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_empirical_syn_downsampled_sfs.txt')
l_bacterium_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_empirical_syn_downsampled_sfs.txt')
o_splanchnicus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_empirical_syn_downsampled_sfs.txt')
oscillibacter_sp_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_empirical_syn_downsampled_sfs.txt')
p_distasonis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_empirical_syn_downsampled_sfs.txt')
p_merdae_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_empirical_syn_downsampled_sfs.txt')
phascolarctobacterium_sp_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_empirical_syn_downsampled_sfs.txt')
p_copri_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_empirical_syn_downsampled_sfs.txt')
r_intestinalis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_empirical_syn_downsampled_sfs.txt')
r_inulinivorans_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_empirical_syn_downsampled_sfs.txt')
r_bicirculans_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_empirical_syn_downsampled_sfs.txt')
r_bromii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_empirical_syn_downsampled_sfs.txt')

## Read in demographic model fit for high recombination

### One-epoch (accessory)
a_muciniphila_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_one_epoch_demography.txt')
a_finegoldii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_one_epoch_demography.txt')
a_onderdonkii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_one_epoch_demography.txt')
a_putredinis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_one_epoch_demography.txt')
a_shahii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_one_epoch_demography.txt')
alistipes_sp_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_one_epoch_demography.txt')
b_bacterium_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_one_epoch_demography.txt')
b_caccae_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_one_epoch_demography.txt')
b_cellulosilyticus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_one_epoch_demography.txt')
b_coprocola_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_one_epoch_demography.txt')
b_eggerthii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_one_epoch_demography.txt')
b_fragilis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_one_epoch_demography.txt')
b_massiliensis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_one_epoch_demography.txt')
b_ovatus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_one_epoch_demography.txt')
b_plebeius_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_one_epoch_demography.txt')
b_stercoris_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_one_epoch_demography.txt')
b_thetaiotaomicron_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_one_epoch_demography.txt')
b_uniformis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_one_epoch_demography.txt')
b_vulgatus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_one_epoch_demography.txt')
b_xylanisolvens_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_one_epoch_demography.txt')
b_intestinihominis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_one_epoch_demography.txt')
coprococcus_sp_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_one_epoch_demography.txt')
d_invisus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_one_epoch_demography.txt')
e_eligens_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_one_epoch_demography.txt')
e_rectale_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_one_epoch_demography.txt')
e_siraeum_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_one_epoch_demography.txt')
f_prausnitzii_57453_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_one_epoch_demography.txt')
f_prausnitzii_61481_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_one_epoch_demography.txt')
f_prausnitzii_62201_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_one_epoch_demography.txt')
l_bacterium_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_one_epoch_demography.txt')
o_splanchnicus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_one_epoch_demography.txt')
oscillibacter_sp_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_one_epoch_demography.txt')
p_distasonis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_one_epoch_demography.txt')
p_merdae_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_one_epoch_demography.txt')
phascolarctobacterium_sp_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_one_epoch_demography.txt')
p_copri_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_one_epoch_demography.txt')
r_intestinalis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_one_epoch_demography.txt')
r_inulinivorans_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_one_epoch_demography.txt')
r_bicirculans_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_one_epoch_demography.txt')
r_bromii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_one_epoch_demography.txt')

### Two-epoch (accessory)
a_muciniphila_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_two_epoch_demography.txt')
a_finegoldii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_two_epoch_demography.txt')
a_onderdonkii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_two_epoch_demography.txt')
a_putredinis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_two_epoch_demography.txt')
a_shahii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_two_epoch_demography.txt')
alistipes_sp_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_two_epoch_demography.txt')
b_bacterium_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt')
b_caccae_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt')
b_cellulosilyticus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt')
b_coprocola_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_two_epoch_demography.txt')
b_eggerthii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_two_epoch_demography.txt')
b_fragilis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_two_epoch_demography.txt')
b_massiliensis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_two_epoch_demography.txt')
b_ovatus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_two_epoch_demography.txt')
b_plebeius_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_two_epoch_demography.txt')
b_stercoris_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt')
b_thetaiotaomicron_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt')
b_uniformis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_two_epoch_demography.txt')
b_vulgatus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt')
b_xylanisolvens_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_two_epoch_demography.txt')
b_intestinihominis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_two_epoch_demography.txt')
coprococcus_sp_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_two_epoch_demography.txt')
d_invisus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt')
e_eligens_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_two_epoch_demography.txt')
e_rectale_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_two_epoch_demography.txt')
e_siraeum_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_two_epoch_demography.txt')
f_prausnitzii_57453_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_two_epoch_demography.txt')
f_prausnitzii_61481_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_two_epoch_demography.txt')
f_prausnitzii_62201_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_two_epoch_demography.txt')
l_bacterium_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_two_epoch_demography.txt')
o_splanchnicus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_two_epoch_demography.txt')
oscillibacter_sp_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_two_epoch_demography.txt')
p_distasonis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt')
p_merdae_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt')
phascolarctobacterium_sp_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_two_epoch_demography.txt')
p_copri_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_two_epoch_demography.txt')
r_intestinalis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_two_epoch_demography.txt')
r_inulinivorans_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_two_epoch_demography.txt')
r_bicirculans_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_two_epoch_demography.txt')
r_bromii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt')

### Three-epoch (accessory)
a_muciniphila_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_three_epoch_demography.txt')
a_finegoldii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_three_epoch_demography.txt')
a_onderdonkii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_three_epoch_demography.txt')
a_putredinis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_three_epoch_demography.txt')
a_shahii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_three_epoch_demography.txt')
alistipes_sp_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_three_epoch_demography.txt')
b_bacterium_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_three_epoch_demography.txt')
b_caccae_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_three_epoch_demography.txt')
b_cellulosilyticus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_three_epoch_demography.txt')
b_coprocola_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_three_epoch_demography.txt')
b_eggerthii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_three_epoch_demography.txt')
b_fragilis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_three_epoch_demography.txt')
b_massiliensis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_three_epoch_demography.txt')
b_ovatus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_three_epoch_demography.txt')
b_plebeius_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_three_epoch_demography.txt')
b_stercoris_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_three_epoch_demography.txt')
b_thetaiotaomicron_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_three_epoch_demography.txt')
b_uniformis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_three_epoch_demography.txt')
b_vulgatus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_three_epoch_demography.txt')
b_xylanisolvens_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_three_epoch_demography.txt')
b_intestinihominis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_three_epoch_demography.txt')
coprococcus_sp_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_three_epoch_demography.txt')
d_invisus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_three_epoch_demography.txt')
e_eligens_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_three_epoch_demography.txt')
e_rectale_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_three_epoch_demography.txt')
e_siraeum_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_three_epoch_demography.txt')
f_prausnitzii_57453_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_three_epoch_demography.txt')
f_prausnitzii_61481_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_three_epoch_demography.txt')
f_prausnitzii_62201_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_three_epoch_demography.txt')
l_bacterium_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_three_epoch_demography.txt')
o_splanchnicus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_three_epoch_demography.txt')
oscillibacter_sp_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_three_epoch_demography.txt')
p_distasonis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_three_epoch_demography.txt')
p_merdae_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_three_epoch_demography.txt')
phascolarctobacterium_sp_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_three_epoch_demography.txt')
p_copri_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_three_epoch_demography.txt')
r_intestinalis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_three_epoch_demography.txt')
r_inulinivorans_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_three_epoch_demography.txt')
r_bicirculans_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_three_epoch_demography.txt')
r_bromii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_three_epoch_demography.txt')

# Nonsyn empirical (accessory)

a_muciniphila_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt')
a_finegoldii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt')
a_onderdonkii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt')
a_putredinis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt')
a_shahii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt')
alistipes_sp_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt')
b_bacterium_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt')
b_caccae_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt')
b_cellulosilyticus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt')
b_coprocola_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt')
b_eggerthii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt')
b_fragilis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt')
b_massiliensis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt')
b_ovatus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_inferred_DFE.txt')
b_plebeius_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt')
b_stercoris_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt')
b_thetaiotaomicron_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt')
b_uniformis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt')
b_vulgatus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt')
b_xylanisolvens_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt')
b_intestinihominis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt')
coprococcus_sp_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt')
d_invisus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt')
e_eligens_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt')
e_rectale_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt')
e_siraeum_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt')
f_prausnitzii_57453_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt')
f_prausnitzii_61481_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt')
f_prausnitzii_62201_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt')
l_bacterium_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt')
o_splanchnicus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt')
oscillibacter_sp_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt')
p_distasonis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt')
p_merdae_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt')
phascolarctobacterium_sp_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt')
p_copri_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt')
r_intestinalis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt')
r_inulinivorans_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt')
r_bicirculans_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt')
r_bromii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt')

# Gamma (accessory)

a_muciniphila_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt')
a_finegoldii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt')
a_onderdonkii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt')
a_putredinis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt')
a_shahii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt')
alistipes_sp_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt')
b_bacterium_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt')
b_caccae_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt')
b_cellulosilyticus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt')
b_coprocola_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt')
b_eggerthii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt')
b_fragilis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt')
b_massiliensis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt')
b_ovatus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_inferred_DFE.txt')
b_plebeius_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt')
b_stercoris_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt')
b_thetaiotaomicron_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt')
b_uniformis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt')
b_vulgatus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt')
b_xylanisolvens_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt')
b_intestinihominis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt')
coprococcus_sp_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt')
d_invisus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt')
e_eligens_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt')
e_rectale_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt')
e_siraeum_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt')
f_prausnitzii_57453_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt')
f_prausnitzii_61481_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt')
f_prausnitzii_62201_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt')
l_bacterium_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt')
o_splanchnicus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt')
oscillibacter_sp_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt')
p_distasonis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt')
p_merdae_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt')
phascolarctobacterium_sp_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt')
p_copri_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt')
r_intestinalis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt')
r_inulinivorans_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt')
r_bicirculans_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt')
r_bromii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt')

# Neugamma

a_muciniphila_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt')
a_finegoldii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt')
a_onderdonkii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt')
a_putredinis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt')
a_shahii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt')
alistipes_sp_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt')
b_bacterium_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt')
b_caccae_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt')
b_cellulosilyticus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt')
b_coprocola_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt')
b_eggerthii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt')
b_fragilis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt')
b_massiliensis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt')
b_ovatus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_inferred_DFE.txt')
b_plebeius_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt')
b_stercoris_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt')
b_thetaiotaomicron_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt')
b_uniformis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt')
b_vulgatus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt')
b_xylanisolvens_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt')
b_intestinihominis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt')
coprococcus_sp_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt')
d_invisus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt')
e_eligens_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt')
e_rectale_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt')
e_siraeum_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt')
f_prausnitzii_57453_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt')
f_prausnitzii_61481_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt')
f_prausnitzii_62201_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt')
l_bacterium_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt')
o_splanchnicus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt')
oscillibacter_sp_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt')
p_distasonis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt')
p_merdae_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt')
phascolarctobacterium_sp_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt')
p_copri_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt')
r_intestinalis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt')
r_inulinivorans_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt')
r_bicirculans_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt')
r_bromii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt')

### Supplemental Table 3

one_epoch_likelihood = numeric(39)
one_epoch_AIC = numeric(39)
one_epoch_theta = numeric(39)
one_epoch_nanc = numeric(39)
two_epoch_likelihood = numeric(39)
two_epoch_AIC = numeric(39)
two_epoch_nu = numeric(39)
two_epoch_tau = numeric(39)
two_epoch_time = numeric(39)
two_epoch_theta = numeric(39)
two_epoch_nanc = numeric(39)
two_epoch_ncurr = numeric(39)
three_epoch_likelihood = numeric(39)
three_epoch_AIC = numeric(39)
three_epoch_nu_bottleneck = numeric(39)
three_epoch_nu_contemporary = numeric(39)
three_epoch_tau_bottleneck = numeric(39)
three_epoch_tau_contemporary = numeric(39)
three_epoch_time_total = numeric(39)
three_epoch_theta = numeric(39)
three_epoch_nanc = numeric(39)
three_epoch_ncurr = numeric(39)

for (i in 1:length(core_one_epoch_file_list)) {
  one_epoch_likelihood[i] = return_demography_likelihood(core_one_epoch_file_list[i])
  one_epoch_AIC[i] = AIC_from_demography(core_one_epoch_file_list[i])
  one_epoch_theta[i] = theta_from_demography(core_one_epoch_file_list[i])
  one_epoch_nanc[i] = nanc_from_demography(core_one_epoch_file_list[i])
  two_epoch_likelihood[i] = return_demography_likelihood(core_two_epoch_file_list[i])
  two_epoch_AIC[i] = AIC_from_demography(core_two_epoch_file_list[i])
  two_epoch_nu[i] = return_demography_params(core_two_epoch_file_list[i])[1]
  two_epoch_tau[i] = return_demography_params(core_two_epoch_file_list[i])[2]
  two_epoch_time[i] = time_from_demography(core_two_epoch_file_list[i])
  two_epoch_theta[i] = theta_from_demography(core_two_epoch_file_list[i])
  two_epoch_nanc[i] = nanc_from_demography(core_two_epoch_file_list[i])
  two_epoch_ncurr[i] = two_epoch_nu[i] * two_epoch_nanc[i]
  three_epoch_likelihood[i] = return_demography_likelihood(core_three_epoch_file_list[i])
  three_epoch_AIC[i] = AIC_from_demography(core_three_epoch_file_list[i])
  three_epoch_nu_bottleneck[i] = return_demography_params(core_three_epoch_file_list[i])[1]
  three_epoch_nu_contemporary[i] = return_demography_params(core_three_epoch_file_list[i])[2]
  three_epoch_tau_bottleneck[i] = return_demography_params(core_three_epoch_file_list[i])[3]
  three_epoch_tau_contemporary[i] = return_demography_params(core_three_epoch_file_list[i])[4]
  three_epoch_time_total[i] = time_from_demography(core_three_epoch_file_list[i])
  three_epoch_theta[i] = theta_from_demography(core_three_epoch_file_list[i])
  three_epoch_nanc[i] = nanc_from_demography(core_three_epoch_file_list[i])
  three_epoch_ncurr[i] = three_epoch_nu_contemporary[i] * three_epoch_nanc[i]
}

table_s3 = data.frame(
  species=supplementary_species_list,
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

table_s3$Species = factor(table_s3$Species, levels=FD_phylogenetic_levels)

table_s3 <- table_s3[order(table_s3$Species), ]

table_s3

# write.csv(table_s3, '../Supplement/Supplemental_Table_3.csv', row.names = F)

### Supplemental Table 4
nu_tau_distribution = data.frame(species=supplementary_species_list, 
  nu_mle = numeric(39),
  time_mle = numeric(39),
  nu_low = numeric(39), 
  nu_high = numeric(39), 
  time_low = numeric(39), 
  time_high = numeric(39))

for (i in 1:length(core_likelihood_surface_file_list)) {
  # nu_mle
  nu_tau_distribution[i, 2] = return_nu_mle(core_likelihood_surface_file_list[i])
  # nu_low
  nu_tau_distribution[i, 4] = return_nu_low(core_likelihood_surface_file_list[i])
  # nu_high
  nu_tau_distribution[i, 5] =  return_nu_high(core_likelihood_surface_file_list[i])
  # tau_mle
  nu_tau_distribution[i, 3] = return_time_mle(core_likelihood_surface_file_list[i], 
    core_synonymous_sfs_file_list[i], 
    core_two_epoch_file_list[i])
  # tau_low
  nu_tau_distribution[i, 6] = return_time_low(core_likelihood_surface_file_list[i], 
    core_synonymous_sfs_file_list[i], 
    core_two_epoch_file_list[i])
  # tau_high
  nu_tau_distribution[i, 7] =  return_time_high(core_likelihood_surface_file_list[i], 
    core_synonymous_sfs_file_list[i], 
    core_two_epoch_file_list[i])
}

nu_tau_distribution$species = factor(nu_tau_distribution$species, levels=FD_phylogenetic_levels)

nu_tau_distribution <- nu_tau_distribution[order(nu_tau_distribution$species), ]

nu_tau_distribution

names(nu_tau_distribution) = c(
  'Species',
  'Nu, MLE',
  'Time in years, MLE',
  'Low estimate of Nu',
  'High estimate of Nu',
  'Low estimate of time in years',
  'High estimate of time in years'
)

# write.csv(nu_tau_distribution, '../Supplement/Supplemental_Table_4.csv', row.names = F)

### Supplemental Table 5

dfe_nanc = numeric(39)
gamma_likelihood = numeric(39)
gamma_AIC = numeric(39)
gamma_alpha = numeric(39)
gamma_beta = numeric(39)
neugamma_likelihood = numeric(39)
neugamma_AIC = numeric(39)
neugamma_pneu = numeric(39)
neugamma_alpha = numeric(39)
neugamma_beta = numeric(39)

for (i in 1:length(core_DFE_file_list)) {
  dfe_nanc[i] = nanc_from_demography(core_two_epoch_file_list[i])
  gamma_likelihood[i] = return_DFE_likelihood(core_DFE_file_list[i])[1]
  gamma_AIC[i] = 4 - 2 * gamma_likelihood[i]
  gamma_alpha[i] = return_DFE_params(core_DFE_file_list[i])[1]
  gamma_beta[i] = return_DFE_params(core_DFE_file_list[i])[2]
  neugamma_likelihood[i] = return_DFE_likelihood(core_DFE_file_list[i])[2]
  neugamma_AIC[i] = 6 - 2 * neugamma_likelihood[i]
  neugamma_pneu[i] = return_DFE_params(core_DFE_file_list[i])[3]
  neugamma_alpha[i] = return_DFE_params(core_DFE_file_list[i])[4]
  neugamma_beta[i] = return_DFE_params(core_DFE_file_list[i])[5]
}

table_s5 = data.frame(
  species=supplementary_species_list,
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

table_s5$Species = factor(table_s5$Species, levels=FD_phylogenetic_levels)

table_s5 <- table_s5[order(table_s5$Species), ]

table_s5

# write.csv(table_s5, '../Supplement/Supplemental_Table_5.csv', row.names = F)

### Supplemental Table 6

FD_accessory_phylogenetic_levels = c(
  'Alistipes putredinis',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Bacteroidales bacterium',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Bacteroides cellulosilyticus',
  'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides caccae',
  'Bacteroides massiliensis',
  'Bacteroides vulgatus',
  'Dialister invisus',
  'Eubacterium eligens',
  'Eubacterium rectale',
  'Eubacterium siraeum',
  'Ruminococcus bromii'
)

FD_accessory_phylogenetic_levels_MIDAS = c(
  'Alistipes_putredinis_61533',
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_shahii_62199',
  'Bacteroidales_bacterium_58650',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_caccae_53434',
  'Bacteroides_massiliensis_44749',
  'Bacteroides_vulgatus_57955',
  'Dialister_invisus_61905',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Eubacterium_siraeum_57634',
  'Ruminococcus_bromii_62047'
)

accessory_core_one_epoch_file_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_one_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_one_epoch_demography.txt'
)

accessory_core_two_epoch_file_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt'
)

accessory_core_three_epoch_file_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_three_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_three_epoch_demography.txt'
)

accessory_core_DFE_file_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt'
)

accessory_one_epoch_likelihood = numeric(18)
accessory_one_epoch_AIC = numeric(18)
accessory_one_epoch_theta = numeric(18)
accessory_one_epoch_nanc = numeric(18)
accessory_two_epoch_likelihood = numeric(18)
accessory_two_epoch_AIC = numeric(18)
accessory_two_epoch_nu = numeric(18)
accessory_two_epoch_tau = numeric(18)
accessory_two_epoch_time = numeric(18)
accessory_two_epoch_theta = numeric(18)
accessory_two_epoch_nanc = numeric(18)
accessory_two_epoch_ncurr = numeric(18)
accessory_three_epoch_likelihood = numeric(18)
accessory_three_epoch_AIC = numeric(18)
accessory_three_epoch_nu_bottleneck = numeric(18)
accessory_three_epoch_nu_contemporary = numeric(18)
accessory_three_epoch_tau_bottleneck = numeric(18)
accessory_three_epoch_tau_contemporary = numeric(18)
accessory_three_epoch_time_total = numeric(18)
accessory_three_epoch_theta = numeric(18)
accessory_three_epoch_nanc = numeric(18)
accessory_three_epoch_ncurr = numeric(18)

for (i in 1:length(accessory_core_one_epoch_file_list)) {
  accessory_one_epoch_likelihood[i] = return_demography_likelihood(accessory_core_one_epoch_file_list[i])
  accessory_one_epoch_AIC[i] = AIC_from_demography(accessory_core_one_epoch_file_list[i])
  accessory_one_epoch_theta[i] = theta_from_demography(accessory_core_one_epoch_file_list[i])
  accessory_one_epoch_nanc[i] = nanc_from_demography(accessory_core_one_epoch_file_list[i])
  accessory_two_epoch_likelihood[i] = return_demography_likelihood(accessory_core_two_epoch_file_list[i])
  accessory_two_epoch_AIC[i] = AIC_from_demography(accessory_core_two_epoch_file_list[i])
  accessory_two_epoch_nu[i] = return_demography_params(accessory_core_two_epoch_file_list[i])[1]
  accessory_two_epoch_tau[i] = return_demography_params(accessory_core_two_epoch_file_list[i])[2]
  accessory_two_epoch_time[i] = time_from_demography(accessory_core_two_epoch_file_list[i])
  accessory_two_epoch_theta[i] = theta_from_demography(accessory_core_two_epoch_file_list[i])
  accessory_two_epoch_nanc[i] = nanc_from_demography(accessory_core_two_epoch_file_list[i])
  accessory_two_epoch_ncurr[i] = accessory_two_epoch_nu[i] * accessory_two_epoch_nanc[i]
  accessory_three_epoch_likelihood[i] = return_demography_likelihood(accessory_core_three_epoch_file_list[i])
  accessory_three_epoch_AIC[i] = AIC_from_demography(accessory_core_three_epoch_file_list[i])
  accessory_three_epoch_nu_bottleneck[i] = return_demography_params(accessory_core_three_epoch_file_list[i])[1]
  accessory_three_epoch_nu_contemporary[i] = return_demography_params(accessory_core_three_epoch_file_list[i])[2]
  accessory_three_epoch_tau_bottleneck[i] = return_demography_params(accessory_core_three_epoch_file_list[i])[3]
  accessory_three_epoch_tau_contemporary[i] = return_demography_params(accessory_core_three_epoch_file_list[i])[4]
  accessory_three_epoch_time_total[i] = time_from_demography(accessory_core_three_epoch_file_list[i])
  accessory_three_epoch_theta[i] = theta_from_demography(accessory_core_three_epoch_file_list[i])
  accessory_three_epoch_nanc[i] = nanc_from_demography(accessory_core_three_epoch_file_list[i])
  accessory_three_epoch_ncurr[i] = accessory_three_epoch_nu_contemporary[i] * accessory_three_epoch_nanc[i]
}

# core_ancestral = table_s3[c(7, 13, 14, 17, 18, 23, 27), ]
core_ancestral = table_s3[c(5, 2, 3, 4, 6, 8, 9, 12, 14, 16, 18, 19, 20, 25, 27, 28, 36, 34), ]
# table_s3$Species
FD_accessory_phylogenetic_levels


table_s6 = data.frame(
  species=FD_accessory_phylogenetic_levels,
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

accessory_dfe_nanc = numeric(18)
accessory_gamma_likelihood = numeric(18)
accessory_gamma_AIC = numeric(18)
accessory_gamma_alpha = numeric(18)
accessory_gamma_beta = numeric(18)
accessory_neugamma_likelihood = numeric(18)
accessory_neugamma_AIC = numeric(18)
accessory_neugamma_pneu = numeric(18)
accessory_neugamma_alpha = numeric(18)
accessory_neugamma_beta = numeric(18)

for (i in 1:length(accessory_core_DFE_file_list)) {
  accessory_dfe_nanc[i] = nanc_from_demography(accessory_core_two_epoch_file_list[i])
  accessory_gamma_likelihood[i] = return_DFE_likelihood(accessory_core_DFE_file_list[i])[1]
  accessory_gamma_AIC[i] = 4 - 2 * accessory_gamma_likelihood[i]
  accessory_gamma_alpha[i] = return_DFE_params(accessory_core_DFE_file_list[i])[1]
  accessory_gamma_beta[i] = return_DFE_params(accessory_core_DFE_file_list[i])[2]
  accessory_neugamma_likelihood[i] = return_DFE_likelihood(accessory_core_DFE_file_list[i])[2]
  accessory_neugamma_AIC[i] = 6 - 2 * accessory_neugamma_likelihood[i]
  accessory_neugamma_pneu[i] = return_DFE_params(accessory_core_DFE_file_list[i])[3]
  accessory_neugamma_alpha[i] = return_DFE_params(accessory_core_DFE_file_list[i])[4]
  accessory_neugamma_beta[i] = return_DFE_params(accessory_core_DFE_file_list[i])[5]
}

table_s7 = data.frame(
  species=FD_accessory_phylogenetic_levels,
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

#write.csv(table_s7, '../Supplement/Supplemental_Table_7.csv', row.names = F)

### Supplemental Table 8
DFE_core_file_list = c(
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_putredinis_61533_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_finegoldii_56071_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_onderdonkii_55464_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_shahii_62199_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroidales_bacterium_58650_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_merdae_56972_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_stercoris_56735_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_caccae_53434_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_massiliensis_44749_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Dialister_invisus_61905_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_eligens_61678_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_siraeum_57634_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Ruminococcus_bromii_62047_likelihood_surface.csv'
)

demography_core_file_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt'
)

demography_acc_file_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt'
)

DFE_core_file_list_constant_s = c(
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_putredinis_61533_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_finegoldii_56071_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_onderdonkii_55464_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_shahii_62199_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroidales_bacterium_58650_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_merdae_56972_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_stercoris_56735_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_caccae_53434_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_massiliensis_44749_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Dialister_invisus_61905_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_eligens_61678_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_siraeum_57634_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Ruminococcus_bromii_62047_constant_s_likelihood_surface.csv'
)

DFE_acc_file_list = c(
  '../SupplementaryAnalysis/accessory_cross/Alistipes_putredinis_61533_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Alistipes_finegoldii_56071_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Alistipes_onderdonkii_55464_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Alistipes_shahii_62199_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroidales_bacterium_58650_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Parabacteroides_merdae_56972_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_cellulosilyticus_58046_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_stercoris_56735_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_caccae_53434_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_massiliensis_44749_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Dialister_invisus_61905_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Eubacterium_eligens_61678_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Eubacterium_siraeum_57634_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Ruminococcus_bromii_62047_likelihood_surface.csv'
)

DFE_acc_file_list_constant_s = c(
  '../SupplementaryAnalysis/accessory_constant_s/Alistipes_putredinis_61533_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Alistipes_finegoldii_56071_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Alistipes_onderdonkii_55464_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Alistipes_shahii_62199_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroidales_bacterium_58650_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Parabacteroides_merdae_56972_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_cellulosilyticus_58046_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_stercoris_56735_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_caccae_53434_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_massiliensis_44749_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Dialister_invisus_61905_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Eubacterium_eligens_61678_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Eubacterium_siraeum_57634_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Ruminococcus_bromii_62047_constant_s_likelihood_surface.csv'
)

DFE_core_files = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt'
)

DFE_acc_files = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt'
)

core_acc_species_list = c(
  'Alistipes putredinis',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Bacteroidales bacterium',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Bacteroides cellulosilyticus',
  'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides caccae',
  'Bacteroides massiliensis',
  'Bacteroides vulgatus',
  'Dialister invisus',
  'Eubacterium eligens',
  'Eubacterium rectale',
  'Eubacterium siraeum',
  'Ruminococcus bromii'
)

acc_core_dfe_comparison = numeric(18)
acc_core_dfe_comparison_constant_s = numeric(18)
core_mean_s = numeric(18)
core_mean_2ns = numeric(18)
acc_mean_s = numeric(18)
acc_mean_2ns = numeric(18)

for (i in 1:length(core_acc_species_list)) {
  acc_core_dfe_comparison[i] = cross_species_dfe_comparison(DFE_core_file_list[i], DFE_acc_file_list[i])
  acc_core_dfe_comparison_constant_s[i] = cross_species_dfe_comparison(DFE_core_file_list_constant_s[i], DFE_acc_file_list_constant_s[i])
}

acc_core_dfe_LRT_table = data.frame(species=core_acc_species_list, constant_2NAs_LRT=acc_core_dfe_comparison, constant_s_LRT=acc_core_dfe_comparison_constant_s)

acc_core_dfe_LRT_table

write.csv(acc_core_dfe_LRT_table, '../Supplement/Supplemental_Table_8.csv', row.names=FALSE)

### Supplemental Table 9



### Supplemental Table 10





# 
# FD_phylogenetic_levels = c(
#   'Alistipes sp.',
#   'Alistipes finegoldii',
#   'Alistipes onderdonkii',
#   'Alistipes shahii',
#   'Alistipes putredinis',
#   'Bacteroidales bacterium',
#   'Odoribacter splanchnicus',
#   'Parabacteroides distasonis',
#   'Parabacteroides merdae',
#   'Prevotella copri',
#   'Bacteroides fragilis',
#   'Bacteroides cellulosilyticus',
#   'Bacteroides eggerthii',
#   'Bacteroides stercoris',
#   'Bacteroides uniformis',
#   'Bacteroides thetaiotaomicron',
#   'Bacteroides xylanisolvens',
#   'Bacteroides caccae',
#   'Bacteroides massiliensis',
#   'Bacteroides vulgatus',
#   'Bacteroides plebeius',
#   'Bacteroides coprocola',
#   'Barnesiella intestinihominis',
#   'Akkermansia muciniphila',
#   'Dialister invisus',
#   'Phascolarctobacterium sp.',
#   'Eubacterium eligens',
#   'Eubacterium rectale',
#   'Roseburia inulinivorans',
#   'Roseburia intestinalis',
#   'Lachnospiraceae bacterium',
#   'Coprococcus sp.',
#   'Oscillibacter sp.',
#   'Ruminococcus bromii',
#   'Ruminococcus bicirculans',
#   'Eubacterium siraeum',
#   'Faecalibacterium prausnitzii (57453)',
#   'Faecalibacterium prausnitzii (62201)',
#   'Faecalibacterium prausnitzii (61481)'
# )
# 
# FD_phylogenetic_levels_MIDAS = c(
#   'Alistipes_sp_60764',
#   'Alistipes_finegoldii_56071',
#   'Alistipes_onderdonkii_55464',
#   'Alistipes_shahii_62199',
#   'Alistipes_putredinis_61533',
#   'Bacteroidales_bacterium_58650',
#   'Odoribacter_splanchnicus_62174',
#   'Parabacteroides_distasonis_56985',
#   'Parabacteroides_merdae_56972',
#   'Prevotella_copri_61740',
#   'Bacteroides_fragilis_54507',
#   'Bacteroides_cellulosilyticus_58046',
#   'Bacteroides_eggerthii_54457',
#   'Bacteroides_stercoris_56735',
#   'Bacteroides_uniformis_57318',
#   'Bacteroides_thetaiotaomicron_56941',
#   'Bacteroides_xylanisolvens_57185',
#   'Bacteroides_caccae_53434',
#   'Bacteroides_massiliensis_44749',
#   'Bacteroides_vulgatus_57955',
#   'Bacteroides_plebeius_61623',
#   'Bacteroides_coprocola_61586',
#   'Barnesiella_intestinihominis_62208',
#   'Akkermansia_muciniphila_55290',
#   'Dialister_invisus_61905',
#   'Phascolarctobacterium_sp_59817',
#   'Eubacterium_eligens_61678',
#   'Eubacterium_rectale_56927',
#   'Roseburia_inulinivorans_61943',
#   'Roseburia_intestinalis_56239',
#   'Lachnospiraceae_bacterium_51870',
#   'Coprococcus_sp_62244',
#   'Oscillibacter_sp_60799',
#   'Ruminococcus_bromii_62047',
#   'Ruminococcus_bicirculans_59300',
#   'Eubacterium_siraeum_57634',
#   'Faecalibacterium_prausnitzii_57453',
#   'Faecalibacterium_prasunitzii_62201',
#   'Faecaelibacterium_prausnitzii_61481'
# )

# Supplemental Figure 1

table_s3 = read.csv('../Supplement/Supplemental_Table_3.csv')

table_s3$Species = factor(table_s3$Species, levels=FD_phylogenetic_levels)
table_s3 = table_s3[order(table_s3$Species), ]
table_s3

plot_AIC_table = data.frame(table_s3$Species, table_s3$`Three.epoch..AIC`, table_s3$`Two.epoch..AIC`, table_s3$`One.epoch..AIC`)
names(plot_AIC_table) = c('Species', 'Three-epoch', 'Two-epoch', 'One-epoch')
plot_AIC_table = melt(plot_AIC_table)
names(plot_AIC_table) = c('Species', 'Model', 'AIC')

plot_AIC = ggplot(data=plot_AIC_table) +
  geom_jitter(mapping=aes(x=Species, y=AIC, colour=Model, fill=Model), size=3, shape=21, width = 0.15) +
  scale_y_log10() +
  # coord_flip() +
  theme_bw() +
  xlab('') +
  ylab('Aikake information criteria') +
  theme(axis.text.x = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(axis.text=element_text(size=20)) +
  theme(axis.title=element_text(size=24,face="bold")) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(legend.text=element_text(size=20)) +
  theme(legend.title=element_text(size=28))



png("../Supplement/Supplemental_Figure_1.jpg", width = 1600, height = 1200)
# 1600 x 900 dimensions for saved image
plot_AIC
dev.off()

# Supplemental Figure 2

# B. vulgatus, no clade control

b_vulgatus_all_clades_syn = fold_sfs(read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_no_clade_control/empirical_syn_sfs.txt'))
b_vulgatus_all_clades_nonsyn = fold_sfs(read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_no_clade_control/empirical_nonsyn_sfs.txt'))

fig_s2_a = plot_empirical_sfs(b_vulgatus_all_clades_syn) + 
  ggtitle('*Bacteroides vulgatus*, synonymous') + 
  md_theme_minimal() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    panel.background = element_blank(), axis.line = element_line(colour = "black"))

fig_s2_b = plot_empirical_sfs(b_vulgatus_all_clades_nonsyn) + 
  ggtitle('*Bacteroides vulgatus*, nonsynonymous') + 
  md_theme_minimal() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    panel.background = element_blank(), axis.line = element_line(colour = "black"))

# B. vulgatus, clade control

b_vulgatus_clade_control_syn = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955/core_empirical_syn_sfs.txt')
b_vulgatus_clade_control_nonsyn = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955/core_empirical_nonsyn_sfs.txt')

fig_s2_c = plot_empirical_sfs(b_vulgatus_clade_control_syn)
fig_s2_d = plot_empirical_sfs(b_vulgatus_clade_control_nonsyn)

# B. vulgatus, clade control + downsampling

b_vulgatus_clade_control_downsampled_syn = read_input_sfs('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_empirical_syn_downsampled_sfs.txt')
b_vulgatus_clade_control_downsampled_nonsyn = read_input_sfs('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_empirical_nonsyn_downsampled_sfs.txt')

fig_s2_e = plot_empirical_sfs(b_vulgatus_clade_control_downsampled_syn)
fig_s2_f = plot_empirical_sfs(b_vulgatus_clade_control_downsampled_nonsyn)

design = "
AB
CD
EF
"

fig_s2 = plot_figure_s9(b_vulgatus_all_clades_syn,
  b_vulgatus_clade_control_syn,
  b_vulgatus_clade_control_downsampled_syn)

ggsave('../Supplement/Supplemental_Figure_2.jpg', fig_s2, width=15, height=8, units='in', dpi=600)

# png("../Supplement/Supplemental_Figure_2.jpg", width = 2400, height = 800)
# # 2400 x 800 dimensions for saved image
# fig_s2
# dev.off()

# Supplemental Figure 3
# SFS comparison

## Read in empirical downsampled SFS (folded)

a_muciniphila_original_folded = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_finegoldii_original_folded = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_onderdonkii_original_folded = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_shahii_original_folded = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_caccae_original_folded = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_cellulosilyticus_original_folded = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
# read_input_sfs('../Analysis/Bacteroides_coprocola_61586_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
# read_input_sfs('../Analysis/Bacteroides_eggerthii_54457_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_fragilis_original_folded = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_ovatus_original_folded = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_stercoris_original_folded = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_thetaiotaomicron_original_folded = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_vulgatus_original_folded = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
d_invisus_original_folded = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_intestinihominis_original_folded = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
e_rectale_original_folded = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
# read_input_sfs('../Analysis/Eubacterium_siraeum_57634_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
oscillibacter_sp_original_folded = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
p_distasonis_original_folded = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
p_merdae_original_folded = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
r_bicirculans_original_folded = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
r_bromii_original_folded = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_syn_downsampled_sfs.txt')

## Read in high recombination SFS (folded)

a_muciniphila_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_empirical_syn_14_downsampled_sfs.txt')
a_finegoldii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_empirical_syn_14_downsampled_sfs.txt')
a_onderdonkii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_empirical_syn_14_downsampled_sfs.txt')
a_shahii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_caccae_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_cellulosilyticus_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_coprocola_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_eggerthii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_fragilis_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_ovatus_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_stercoris_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_thetaiotaomicron_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_vulgatus_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_empirical_syn_14_downsampled_sfs.txt')
d_invisus_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_intestinihominis_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_empirical_syn_14_downsampled_sfs.txt')
e_rectale_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_empirical_syn_14_downsampled_sfs.txt')
e_siraeum_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_empirical_syn_14_downsampled_sfs.txt')
oscillibacter_sp_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_empirical_syn_14_downsampled_sfs.txt')
p_distasonis_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_empirical_syn_14_downsampled_sfs.txt')
p_merdae_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_empirical_syn_14_downsampled_sfs.txt')
r_bicirculans_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_empirical_syn_14_downsampled_sfs.txt')
r_bromii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_empirical_syn_14_downsampled_sfs.txt')

## Read in demographic model fit for high recombination

### One-epoch
a_muciniphila_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_one_epoch_demography.txt')
a_finegoldii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_one_epoch_demography.txt')
a_onderdonkii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_one_epoch_demography.txt')
a_shahii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_one_epoch_demography.txt')
b_caccae_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_one_epoch_demography.txt')
b_cellulosilyticus_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_one_epoch_demography.txt')
b_coprocola_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_one_epoch_demography.txt')
b_eggerthii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_one_epoch_demography.txt')
b_fragilis_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_one_epoch_demography.txt')
b_ovatus_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_one_epoch_demography.txt')
b_stercoris_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_one_epoch_demography.txt')
b_thetaiotaomicron_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_one_epoch_demography.txt')
b_vulgatus_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_one_epoch_demography.txt')
d_invisus_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_one_epoch_demography.txt')
b_intestinihominis_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_one_epoch_demography.txt')
e_rectale_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_one_epoch_demography.txt')
e_siraeum_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_one_epoch_demography.txt')
oscillibacter_sp_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_one_epoch_demography.txt')
p_distasonis_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_one_epoch_demography.txt')
p_merdae_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_one_epoch_demography.txt')
r_bicirculans_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_one_epoch_demography.txt')
r_bromii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_one_epoch_demography.txt')

### Two-epoch
a_muciniphila_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_two_epoch_demography.txt')
a_finegoldii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_two_epoch_demography.txt')
a_onderdonkii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_two_epoch_demography.txt')
a_shahii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_two_epoch_demography.txt')
b_caccae_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_two_epoch_demography.txt')
b_cellulosilyticus_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_two_epoch_demography.txt')
b_coprocola_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_two_epoch_demography.txt')
b_eggerthii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_two_epoch_demography.txt')
b_fragilis_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_two_epoch_demography.txt')
b_ovatus_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_two_epoch_demography.txt')
b_stercoris_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_two_epoch_demography.txt')
b_thetaiotaomicron_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_two_epoch_demography.txt')
b_vulgatus_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_two_epoch_demography.txt')
d_invisus_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_two_epoch_demography.txt')
b_intestinihominis_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_two_epoch_demography.txt')
e_rectale_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_two_epoch_demography.txt')
e_siraeum_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_two_epoch_demography.txt')
oscillibacter_sp_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_two_epoch_demography.txt')
p_distasonis_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_two_epoch_demography.txt')
p_merdae_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_two_epoch_demography.txt')
r_bicirculans_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_two_epoch_demography.txt')
r_bromii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_two_epoch_demography.txt')

### Three-epoch
a_muciniphila_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_three_epoch_demography.txt')
a_finegoldii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_three_epoch_demography.txt')
a_onderdonkii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_three_epoch_demography.txt')
a_shahii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_three_epoch_demography.txt')
b_caccae_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_three_epoch_demography.txt')
b_cellulosilyticus_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_three_epoch_demography.txt')
b_coprocola_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_three_epoch_demography.txt')
b_eggerthii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_three_epoch_demography.txt')
b_fragilis_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_three_epoch_demography.txt')
b_ovatus_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_three_epoch_demography.txt')
b_stercoris_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_three_epoch_demography.txt')
b_thetaiotaomicron_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_three_epoch_demography.txt')
b_vulgatus_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_three_epoch_demography.txt')
d_invisus_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_three_epoch_demography.txt')
b_intestinihominis_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_three_epoch_demography.txt')
e_rectale_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_three_epoch_demography.txt')
e_siraeum_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_three_epoch_demography.txt')
oscillibacter_sp_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_three_epoch_demography.txt')
p_distasonis_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_three_epoch_demography.txt')
p_merdae_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_three_epoch_demography.txt')
r_bicirculans_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_three_epoch_demography.txt')
r_bromii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_three_epoch_demography.txt')

## HR nonsynonoymous
a_muciniphila_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt')
a_finegoldii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt')
a_onderdonkii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt')
a_shahii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt')
b_caccae_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt')
b_cellulosilyticus_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt')
b_coprocola_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_inferred_DFE.txt')
b_eggerthii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_inferred_DFE.txt')
b_fragilis_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt')
b_ovatus_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_inferred_DFE.txt')
b_stercoris_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt')
b_thetaiotaomicron_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt')
b_vulgatus_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt')
d_invisus_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt')
b_intestinihominis_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt')
e_rectale_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt')
e_siraeum_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_inferred_DFE.txt')
oscillibacter_sp_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt')
p_distasonis_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt')
p_merdae_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt')
r_bicirculans_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt')
r_bromii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt')

# HR gamma
a_muciniphila_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt')
a_finegoldii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt')
a_onderdonkii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt')
a_shahii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt')
b_caccae_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt')
b_cellulosilyticus_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt')
b_coprocola_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_inferred_DFE.txt')
b_eggerthii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_inferred_DFE.txt')
b_fragilis_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt')
b_ovatus_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_inferred_DFE.txt')
b_stercoris_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt')
b_thetaiotaomicron_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt')
b_vulgatus_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt')
d_invisus_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt')
b_intestinihominis_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt')
e_rectale_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt')
e_siraeum_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_inferred_DFE.txt')
oscillibacter_sp_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt')
p_distasonis_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt')
p_merdae_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt')
r_bicirculans_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt')
r_bromii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt')

# HR neugamma
a_muciniphila_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt')
a_finegoldii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt')
a_onderdonkii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt')
a_shahii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt')
b_caccae_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt')
b_cellulosilyticus_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt')
b_coprocola_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_inferred_DFE.txt')
b_eggerthii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_inferred_DFE.txt')
b_fragilis_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt')
b_ovatus_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_inferred_DFE.txt')
b_stercoris_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt')
b_thetaiotaomicron_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt')
b_vulgatus_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt')
d_invisus_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt')
b_intestinihominis_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt')
e_rectale_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt')
e_siraeum_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_inferred_DFE.txt')
oscillibacter_sp_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt')
p_distasonis_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt')
p_merdae_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt')
r_bicirculans_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt')
r_bromii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt')

## High recombination model fit
a_muciniphila_HR_demography_sfs = compare_sfs(proportional_sfs(a_muciniphila_HR_folded), 
  proportional_sfs(a_muciniphila_HR_one_epoch), 
  proportional_sfs(a_muciniphila_HR_two_epoch), 
  proportional_sfs(a_muciniphila_HR_three_epoch)) +
  ggtitle('Akkermansia muciniphila (HR) model fit')

a_finegoldii_HR_demography_sfs = compare_sfs(proportional_sfs(a_finegoldii_HR_folded), 
  proportional_sfs(a_finegoldii_HR_one_epoch), 
  proportional_sfs(a_finegoldii_HR_two_epoch), 
  proportional_sfs(a_finegoldii_HR_three_epoch)) +
  ggtitle('Alistipes finegoldii (HR) model fit')

a_onderdonkii_HR_demography_sfs = compare_sfs(proportional_sfs(a_onderdonkii_HR_folded), 
  proportional_sfs(a_onderdonkii_HR_one_epoch), 
  proportional_sfs(a_onderdonkii_HR_two_epoch), 
  proportional_sfs(a_onderdonkii_HR_three_epoch)) +
  ggtitle('Alistipes onderdonkii (HR) model fit')

a_shahii_HR_demography_sfs = compare_sfs(proportional_sfs(a_shahii_HR_folded), 
  proportional_sfs(a_shahii_HR_one_epoch), 
  proportional_sfs(a_shahii_HR_two_epoch), 
  proportional_sfs(a_shahii_HR_three_epoch)) +
  ggtitle('Alistipes shahii (HR) model fit')

b_caccae_HR_demography_sfs = compare_sfs(proportional_sfs(b_caccae_HR_folded), 
  proportional_sfs(b_caccae_HR_one_epoch), 
  proportional_sfs(b_caccae_HR_two_epoch), 
  proportional_sfs(b_caccae_HR_three_epoch)) +
  ggtitle('Bacteroides caccae (HR) model fit')

b_cellulosilyticus_HR_demography_sfs = compare_sfs(proportional_sfs(b_cellulosilyticus_HR_folded), 
  proportional_sfs(b_cellulosilyticus_HR_one_epoch), 
  proportional_sfs(b_cellulosilyticus_HR_two_epoch), 
  proportional_sfs(b_cellulosilyticus_HR_three_epoch)) +
  ggtitle('Bacteroides cellulosilyticus (HR) model fit')

b_coprocola_HR_demography_sfs = compare_sfs(proportional_sfs(b_coprocola_HR_folded), 
  proportional_sfs(b_coprocola_HR_one_epoch), 
  proportional_sfs(b_coprocola_HR_two_epoch), 
  proportional_sfs(b_coprocola_HR_three_epoch)) +
  ggtitle('Bacteroides copracola (HR) model fit')

b_eggerthii_HR_demography_sfs = compare_sfs(proportional_sfs(b_eggerthii_HR_folded), 
  proportional_sfs(b_eggerthii_HR_one_epoch), 
  proportional_sfs(b_eggerthii_HR_two_epoch), 
  proportional_sfs(b_eggerthii_HR_three_epoch)) +
  ggtitle('Bacteroides eggerthii (HR) model fit')

b_fragilis_HR_demography_sfs = compare_sfs(proportional_sfs(b_fragilis_HR_folded), 
  proportional_sfs(b_fragilis_HR_one_epoch), 
  proportional_sfs(b_fragilis_HR_two_epoch), 
  proportional_sfs(b_fragilis_HR_three_epoch)) +
  ggtitle('Bacteroides fragilis (HR) model fit')

b_ovatus_HR_demography_sfs = compare_sfs(proportional_sfs(b_ovatus_HR_folded), 
  proportional_sfs(b_ovatus_HR_one_epoch), 
  proportional_sfs(b_ovatus_HR_two_epoch), 
  proportional_sfs(b_ovatus_HR_three_epoch)) +
  ggtitle('Bacteroides ovatus (HR) model fit')

b_stercoris_HR_demography_sfs = compare_sfs(proportional_sfs(b_stercoris_HR_folded), 
  proportional_sfs(b_stercoris_HR_one_epoch), 
  proportional_sfs(b_stercoris_HR_two_epoch), 
  proportional_sfs(b_stercoris_HR_three_epoch)) +
  ggtitle('Bacteroides stercoris (HR) model fit')

b_thetaiotaomicron_HR_demography_sfs = compare_sfs(proportional_sfs(b_thetaiotaomicron_HR_folded), 
  proportional_sfs(b_thetaiotaomicron_HR_one_epoch), 
  proportional_sfs(b_thetaiotaomicron_HR_two_epoch), 
  proportional_sfs(b_thetaiotaomicron_HR_three_epoch)) +
  ggtitle('Bacteroides thetaiotaomicron (HR) model fit')

b_vulgatus_HR_demography_sfs = compare_sfs(proportional_sfs(b_vulgatus_HR_folded), 
  proportional_sfs(b_vulgatus_HR_one_epoch), 
  proportional_sfs(b_vulgatus_HR_two_epoch), 
  proportional_sfs(b_vulgatus_HR_three_epoch)) +
  ggtitle('Bacteroides vulgatus (HR) model fit')

d_invisus_HR_demography_sfs = compare_sfs(proportional_sfs(d_invisus_HR_folded), 
  proportional_sfs(d_invisus_HR_one_epoch), 
  proportional_sfs(d_invisus_HR_two_epoch), 
  proportional_sfs(d_invisus_HR_three_epoch)) +
  ggtitle('Dialister invisus (HR) model fit')

b_intestinihominis_HR_demography_sfs = compare_sfs(proportional_sfs(b_intestinihominis_HR_folded), 
  proportional_sfs(b_intestinihominis_HR_one_epoch), 
  proportional_sfs(b_intestinihominis_HR_two_epoch), 
  proportional_sfs(b_intestinihominis_HR_three_epoch)) +
  ggtitle('Barnesiella intestinihominis (HR) model fit')

e_rectale_HR_demography_sfs = compare_sfs(proportional_sfs(e_rectale_HR_folded), 
  proportional_sfs(e_rectale_HR_one_epoch), 
  proportional_sfs(e_rectale_HR_two_epoch), 
  proportional_sfs(e_rectale_HR_three_epoch)) +
  ggtitle('Eubacterium rectale (HR) model fit')

e_siraeum_HR_demography_sfs = compare_sfs(proportional_sfs(e_siraeum_HR_folded), 
  proportional_sfs(e_siraeum_HR_one_epoch), 
  proportional_sfs(e_siraeum_HR_two_epoch), 
  proportional_sfs(e_siraeum_HR_three_epoch)) +
  ggtitle('Eubacterium siraeum (HR) model fit')

oscillibacter_sp_HR_demography_sfs = compare_sfs(proportional_sfs(oscillibacter_sp_HR_folded), 
  proportional_sfs(oscillibacter_sp_HR_one_epoch), 
  proportional_sfs(oscillibacter_sp_HR_two_epoch), 
  proportional_sfs(oscillibacter_sp_HR_three_epoch)) +
  ggtitle('Oscillibacter sp. (HR) model fit')

p_distasonis_HR_demography_sfs = compare_sfs(proportional_sfs(p_distasonis_HR_folded), 
  proportional_sfs(p_distasonis_HR_one_epoch), 
  proportional_sfs(p_distasonis_HR_two_epoch), 
  proportional_sfs(p_distasonis_HR_three_epoch)) +
  ggtitle('Parabacteroides distasonis (HR) model fit')

p_merdae_HR_demography_sfs = compare_sfs(proportional_sfs(p_merdae_HR_folded), 
  proportional_sfs(p_merdae_HR_one_epoch), 
  proportional_sfs(p_merdae_HR_two_epoch), 
  proportional_sfs(p_merdae_HR_three_epoch)) +
  ggtitle('Parabacteroides merdae (HR) model fit')

r_bicirculans_HR_demography_sfs = compare_sfs(proportional_sfs(r_bicirculans_HR_folded), 
  proportional_sfs(r_bicirculans_HR_one_epoch), 
  proportional_sfs(r_bicirculans_HR_two_epoch), 
  proportional_sfs(r_bicirculans_HR_three_epoch)) +
  ggtitle('Ruminococcus bicirculans (HR) model fit')

r_bromii_HR_demography_sfs = compare_sfs(proportional_sfs(r_bromii_HR_folded), 
  proportional_sfs(r_bromii_HR_one_epoch), 
  proportional_sfs(r_bromii_HR_two_epoch), 
  proportional_sfs(r_bromii_HR_three_epoch)) +
  ggtitle('Ruminococcus bromii (HR) model fit')

a_muciniphila_HR_demography_sfs +
  a_finegoldii_HR_demography_sfs +
  a_onderdonkii_HR_demography_sfs +
  a_shahii_HR_demography_sfs +
  plot_layout(ncol=1)


## Likelihood surfaces
a_muciniphila_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv') + 
  ggtitle('A. muciniphila (High recombination)')

a_finegoldii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv') + 
  ggtitle('A. finegoldii (High recombination)')

a_onderdonkii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv') + 
  ggtitle('A. onderdonkii (High recombination)')

a_shahii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Alistipes_shahii_62199/likelihood_surface.csv') + 
  ggtitle('A. shahii (High recombination)')

b_caccae_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv') + 
  ggtitle('B. caccae (High recombination)')

b_cellulosilyticus_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv') + 
  ggtitle('B. cellulosilyticus (High recombination)')

b_coprocola_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/likelihood_surface.csv') + 
  ggtitle('B. coprocola (High recombination)')

b_eggerthii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/likelihood_surface.csv') + 
  ggtitle('B. eggerthii (High recombination)')

b_fragilis_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv') + 
  ggtitle('B. fragilis (High recombination)')

b_ovatus_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/likelihood_surface.csv') + 
  ggtitle('B. ovatus (High recombination)')

b_stercoris_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv') + 
  ggtitle('B. stercoris (High recombination)')

b_thetaiotaomicron_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv') + 
  ggtitle('B. thetaiotaomicron (High recombination)')

b_vulgatus_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv') + 
  ggtitle('B. vulgatus (High recombination)')

b_intestinihominis_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv') + 
  ggtitle('B. intestinihominis (High recombination)')

d_invisus_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Dialister_invisus_61905/likelihood_surface.csv') + 
  ggtitle('D. invisus (High recombination)')

e_rectale_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv') + 
  ggtitle('E. rectale (High recombination)')

e_siraeum_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/likelihood_surface.csv') + 
  ggtitle('E. siraeum (High recombination)')

oscillibacter_sp_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv') + 
  ggtitle('Oscillibacter sp. (High recombination)')

p_distasonis_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv') + 
  ggtitle('P. distasonis (High recombination)')

p_merdae_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv') + 
  ggtitle('P. merdae (High recombination)')

r_bicirculans_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv') + 
  ggtitle('R. bicirculans (High recombination)')

r_bromii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv') + 
  ggtitle('R. bromii (High recombination)')

## HR demography_fit

HR_demography_fit = a_finegoldii_HR_demography_sfs + a_finegoldii_HR_likelihood_surface +
  a_onderdonkii_HR_demography_sfs + a_onderdonkii_HR_likelihood_surface +
  a_shahii_HR_demography_sfs + a_shahii_HR_likelihood_surface +
  p_distasonis_HR_demography_sfs + p_distasonis_HR_likelihood_surface +
  p_merdae_HR_demography_sfs + p_merdae_HR_likelihood_surface +
  b_fragilis_HR_demography_sfs + b_fragilis_HR_likelihood_surface +
  b_cellulosilyticus_HR_demography_sfs + b_cellulosilyticus_HR_likelihood_surface +
  b_stercoris_HR_demography_sfs + b_stercoris_HR_likelihood_surface +
  b_thetaiotaomicron_HR_demography_sfs + b_thetaiotaomicron_HR_likelihood_surface +
  b_caccae_HR_demography_sfs + b_caccae_HR_likelihood_surface +
  b_vulgatus_HR_demography_sfs + b_vulgatus_HR_likelihood_surface +
  b_intestinihominis_HR_demography_sfs + b_intestinihominis_HR_likelihood_surface +
  a_muciniphila_HR_demography_sfs + a_muciniphila_HR_likelihood_surface +
  d_invisus_HR_demography_sfs + d_invisus_HR_likelihood_surface +
  e_rectale_HR_demography_sfs + e_rectale_HR_likelihood_surface +
  oscillibacter_sp_HR_demography_sfs + oscillibacter_sp_HR_likelihood_surface +
  r_bromii_HR_demography_sfs + r_bromii_HR_likelihood_surface +
  r_bicirculans_HR_demography_sfs + r_bicirculans_HR_likelihood_surface +
  plot_layout(ncol=2)
  
# ggsave(filename='../Supplement/HR_demography_fit.jpg', plot=HR_demography_fit, width=20, height=150, units='in', limitsize=FALSE)

a_muciniphila_FD_core_demography = compare_sfs(proportional_sfs(a_muciniphila_FD_core_folded), 
  proportional_sfs(a_muciniphila_FD_core_one_epoch), 
  proportional_sfs(a_muciniphila_FD_core_two_epoch), 
  proportional_sfs(a_muciniphila_FD_core_three_epoch)) +
  ggtitle('Akkermansia muciniphila (FD, core) model fit')

a_finegoldii_FD_core_demography = compare_sfs(proportional_sfs(a_finegoldii_FD_core_folded), 
  proportional_sfs(a_finegoldii_FD_core_one_epoch), 
  proportional_sfs(a_finegoldii_FD_core_two_epoch), 
  proportional_sfs(a_finegoldii_FD_core_three_epoch)) +
  ggtitle('Alistipes finegoldii (FD, core) model fit')

a_onderdonkii_FD_core_demography = compare_sfs(proportional_sfs(a_onderdonkii_FD_core_folded), 
  proportional_sfs(a_onderdonkii_FD_core_one_epoch), 
  proportional_sfs(a_onderdonkii_FD_core_two_epoch), 
  proportional_sfs(a_onderdonkii_FD_core_three_epoch)) +
  ggtitle('Alistipes onderdonkii (FD, core) model fit')

a_putredinis_FD_core_demography = compare_sfs(proportional_sfs(a_putredinis_FD_core_folded), 
  proportional_sfs(a_putredinis_FD_core_one_epoch), 
  proportional_sfs(a_putredinis_FD_core_two_epoch), 
  proportional_sfs(a_putredinis_FD_core_three_epoch)) +
  ggtitle('Alistipes putredinis (FD, core) model fit')

a_shahii_FD_core_demography = compare_sfs(proportional_sfs(a_shahii_FD_core_folded), 
  proportional_sfs(a_shahii_FD_core_one_epoch), 
  proportional_sfs(a_shahii_FD_core_two_epoch), 
  proportional_sfs(a_shahii_FD_core_three_epoch)) +
  ggtitle('Alistipes shahii (FD, core) model fit')

alistipes_sp_FD_core_demography = compare_sfs(proportional_sfs(alistipes_sp_FD_core_folded), 
  proportional_sfs(alistipes_sp_FD_core_one_epoch), 
  proportional_sfs(alistipes_sp_FD_core_two_epoch), 
  proportional_sfs(alistipes_sp_FD_core_three_epoch)) +
  ggtitle('Alistipes sp. (FD, core) model fit')

b_bacterium_FD_core_demography = compare_sfs(proportional_sfs(b_bacterium_FD_core_folded), 
  proportional_sfs(b_bacterium_FD_core_one_epoch), 
  proportional_sfs(b_bacterium_FD_core_two_epoch), 
  proportional_sfs(b_bacterium_FD_core_three_epoch)) +
  ggtitle('Bacteroidales bacterium (FD, core) model fit')

b_caccae_FD_core_demography = compare_sfs(proportional_sfs(b_caccae_FD_core_folded), 
  proportional_sfs(b_caccae_FD_core_one_epoch), 
  proportional_sfs(b_caccae_FD_core_two_epoch), 
  proportional_sfs(b_caccae_FD_core_three_epoch)) +
  ggtitle('Bacteroides caccae (FD, core) model fit')

b_cellulosilyticus_FD_core_demography = compare_sfs(proportional_sfs(b_cellulosilyticus_FD_core_folded), 
  proportional_sfs(b_cellulosilyticus_FD_core_one_epoch), 
  proportional_sfs(b_cellulosilyticus_FD_core_two_epoch), 
  proportional_sfs(b_cellulosilyticus_FD_core_three_epoch)) +
  ggtitle('Bacteroides cellulosilyticus (FD, core) model fit')

b_coprocola_FD_core_demography = compare_sfs(proportional_sfs(b_coprocola_FD_core_folded), 
  proportional_sfs(b_coprocola_FD_core_one_epoch), 
  proportional_sfs(b_coprocola_FD_core_two_epoch), 
  proportional_sfs(b_coprocola_FD_core_three_epoch)) +
  ggtitle('Bacteroides coprocola (FD, core) model fit')

b_eggerthii_FD_core_demography = compare_sfs(proportional_sfs(b_eggerthii_FD_core_folded), 
  proportional_sfs(b_eggerthii_FD_core_one_epoch), 
  proportional_sfs(b_eggerthii_FD_core_two_epoch), 
  proportional_sfs(b_eggerthii_FD_core_three_epoch)) +
  ggtitle('Bacteroides eggerthii (FD, core) model fit')

b_fragilis_FD_core_demography = compare_sfs(proportional_sfs(b_fragilis_FD_core_folded), 
  proportional_sfs(b_fragilis_FD_core_one_epoch), 
  proportional_sfs(b_fragilis_FD_core_two_epoch), 
  proportional_sfs(b_fragilis_FD_core_three_epoch)) +
  ggtitle('Bacteroides fragilis (FD, core) model fit')

b_massiliensis_FD_core_demography = compare_sfs(proportional_sfs(b_massiliensis_FD_core_folded), 
  proportional_sfs(b_massiliensis_FD_core_one_epoch), 
  proportional_sfs(b_massiliensis_FD_core_two_epoch), 
  proportional_sfs(b_massiliensis_FD_core_three_epoch)) +
  ggtitle('Bacteroides massiliensis (FD, core) model fit')

b_ovatus_FD_core_demography = compare_sfs(proportional_sfs(b_ovatus_FD_core_folded), 
  proportional_sfs(b_ovatus_FD_core_one_epoch), 
  proportional_sfs(b_ovatus_FD_core_two_epoch), 
  proportional_sfs(b_ovatus_FD_core_three_epoch)) +
  ggtitle('Bacteroides ovatus (FD, core) model fit')

b_plebeius_FD_core_demography = compare_sfs(proportional_sfs(b_plebeius_FD_core_folded), 
  proportional_sfs(b_plebeius_FD_core_one_epoch), 
  proportional_sfs(b_plebeius_FD_core_two_epoch), 
  proportional_sfs(b_plebeius_FD_core_three_epoch)) +
  ggtitle('Bacteroides plebeius (FD, core) model fit')

b_stercoris_FD_core_demography = compare_sfs(proportional_sfs(b_stercoris_FD_core_folded), 
  proportional_sfs(b_stercoris_FD_core_one_epoch), 
  proportional_sfs(b_stercoris_FD_core_two_epoch), 
  proportional_sfs(b_stercoris_FD_core_three_epoch)) +
  ggtitle('Bacteroides stercoris (FD, core) model fit')

b_thetaiotaomicron_FD_core_demography = compare_sfs(proportional_sfs(b_thetaiotaomicron_FD_core_folded), 
  proportional_sfs(b_thetaiotaomicron_FD_core_one_epoch), 
  proportional_sfs(b_thetaiotaomicron_FD_core_two_epoch), 
  proportional_sfs(b_thetaiotaomicron_FD_core_three_epoch)) +
  ggtitle('Bacteroides thetaiotaomicron (FD, core) model fit')

b_uniformis_FD_core_demography = compare_sfs(proportional_sfs(b_uniformis_FD_core_folded), 
  proportional_sfs(b_uniformis_FD_core_one_epoch), 
  proportional_sfs(b_uniformis_FD_core_two_epoch), 
  proportional_sfs(b_uniformis_FD_core_three_epoch)) +
  ggtitle('Bacteroides uniformis (FD, core) model fit')

b_vulgatus_FD_core_demography = compare_sfs(proportional_sfs(b_vulgatus_FD_core_folded), 
  proportional_sfs(b_vulgatus_FD_core_one_epoch), 
  proportional_sfs(b_vulgatus_FD_core_two_epoch), 
  proportional_sfs(b_vulgatus_FD_core_three_epoch)) +
  ggtitle('Bacteroides vulgatus (FD, core) model fit')

b_xylanisolvens_FD_core_demography = compare_sfs(proportional_sfs(b_xylanisolvens_FD_core_folded), 
  proportional_sfs(b_xylanisolvens_FD_core_one_epoch), 
  proportional_sfs(b_xylanisolvens_FD_core_two_epoch), 
  proportional_sfs(b_xylanisolvens_FD_core_three_epoch)) +
  ggtitle('Bacteroides xylanisolvens (FD, core) model fit')

b_intestinihominis_FD_core_demography = compare_sfs(proportional_sfs(b_intestinihominis_FD_core_folded), 
  proportional_sfs(b_intestinihominis_FD_core_one_epoch), 
  proportional_sfs(b_intestinihominis_FD_core_two_epoch), 
  proportional_sfs(b_intestinihominis_FD_core_three_epoch)) +
  ggtitle('Barnesiella intestinihominis (FD, core) model fit')

coprococcus_sp_FD_core_demography = compare_sfs(proportional_sfs(coprococcus_sp_FD_core_folded), 
  proportional_sfs(coprococcus_sp_FD_core_one_epoch), 
  proportional_sfs(coprococcus_sp_FD_core_two_epoch), 
  proportional_sfs(coprococcus_sp_FD_core_three_epoch)) +
  ggtitle('Coprococcus sp. (FD, core) model fit')

d_invisus_FD_core_demography = compare_sfs(proportional_sfs(d_invisus_FD_core_folded), 
  proportional_sfs(d_invisus_FD_core_one_epoch), 
  proportional_sfs(d_invisus_FD_core_two_epoch), 
  proportional_sfs(d_invisus_FD_core_three_epoch)) +
  ggtitle('Dialister invisus (FD, core) model fit')

e_eligens_FD_core_demography = compare_sfs(proportional_sfs(e_eligens_FD_core_folded), 
  proportional_sfs(e_eligens_FD_core_one_epoch), 
  proportional_sfs(e_eligens_FD_core_two_epoch), 
  proportional_sfs(e_eligens_FD_core_three_epoch)) +
  ggtitle('Eubacterium eligens (FD, core) model fit')

e_rectale_FD_core_demography = compare_sfs(proportional_sfs(e_rectale_FD_core_folded), 
  proportional_sfs(e_rectale_FD_core_one_epoch), 
  proportional_sfs(e_rectale_FD_core_two_epoch), 
  proportional_sfs(e_rectale_FD_core_three_epoch)) +
  ggtitle('Eubacterium rectale (FD, core) model fit')

e_siraeum_FD_core_demography = compare_sfs(proportional_sfs(e_siraeum_FD_core_folded), 
  proportional_sfs(e_siraeum_FD_core_one_epoch), 
  proportional_sfs(e_siraeum_FD_core_two_epoch), 
  proportional_sfs(e_siraeum_FD_core_three_epoch)) +
  ggtitle('Eubacterium siraeum (FD, core) model fit')

f_prausnitzii_57453_FD_core_demography = compare_sfs(proportional_sfs(f_prausnitzii_57453_FD_core_folded), 
  proportional_sfs(f_prausnitzii_57453_FD_core_one_epoch), 
  proportional_sfs(f_prausnitzii_57453_FD_core_two_epoch), 
  proportional_sfs(f_prausnitzii_57453_FD_core_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 57453 (FD, core) model fit')

f_prausnitzii_61481_FD_core_demography = compare_sfs(proportional_sfs(f_prausnitzii_61481_FD_core_folded), 
  proportional_sfs(f_prausnitzii_61481_FD_core_one_epoch), 
  proportional_sfs(f_prausnitzii_61481_FD_core_two_epoch), 
  proportional_sfs(f_prausnitzii_61481_FD_core_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 61481 (FD, core) model fit')

f_prausnitzii_62201_FD_core_demography = compare_sfs(proportional_sfs(f_prausnitzii_62201_FD_core_folded), 
  proportional_sfs(f_prausnitzii_62201_FD_core_one_epoch), 
  proportional_sfs(f_prausnitzii_62201_FD_core_two_epoch), 
  proportional_sfs(f_prausnitzii_62201_FD_core_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 62201 (FD, core) model fit')

l_bacterium_FD_core_demography = compare_sfs(proportional_sfs(l_bacterium_FD_core_folded), 
  proportional_sfs(l_bacterium_FD_core_one_epoch), 
  proportional_sfs(l_bacterium_FD_core_two_epoch), 
  proportional_sfs(l_bacterium_FD_core_three_epoch)) +
  ggtitle('Lachnospiraceae bacterium (FD, core) model fit')

o_splanchnicus_FD_core_demography = compare_sfs(proportional_sfs(o_splanchnicus_FD_core_folded), 
  proportional_sfs(o_splanchnicus_FD_core_one_epoch), 
  proportional_sfs(o_splanchnicus_FD_core_two_epoch), 
  proportional_sfs(o_splanchnicus_FD_core_three_epoch)) +
  ggtitle('Odoribacter splanchnicus (FD, core) model fit')

oscillibacter_sp_FD_core_demography = compare_sfs(proportional_sfs(oscillibacter_sp_FD_core_folded), 
  proportional_sfs(oscillibacter_sp_FD_core_one_epoch), 
  proportional_sfs(oscillibacter_sp_FD_core_two_epoch), 
  proportional_sfs(oscillibacter_sp_FD_core_three_epoch)) +
  ggtitle('Oscillibacter sp. (FD, core) model fit')

p_distasonis_FD_core_demography = compare_sfs(proportional_sfs(p_distasonis_FD_core_folded), 
  proportional_sfs(p_distasonis_FD_core_one_epoch), 
  proportional_sfs(p_distasonis_FD_core_two_epoch), 
  proportional_sfs(p_distasonis_FD_core_three_epoch)) +
  ggtitle('Parabacteroides distasonis (FD, core) model fit')

p_merdae_FD_core_demography = compare_sfs(proportional_sfs(p_merdae_FD_core_folded), 
  proportional_sfs(p_merdae_FD_core_one_epoch), 
  proportional_sfs(p_merdae_FD_core_two_epoch), 
  proportional_sfs(p_merdae_FD_core_three_epoch)) +
  ggtitle('Parabacteroides merdae (FD, core) model fit')

phascolarctobacterium_sp_FD_core_demography = compare_sfs(proportional_sfs(phascolarctobacterium_sp_FD_core_folded), 
  proportional_sfs(phascolarctobacterium_sp_FD_core_one_epoch), 
  proportional_sfs(phascolarctobacterium_sp_FD_core_two_epoch), 
  proportional_sfs(phascolarctobacterium_sp_FD_core_three_epoch)) +
  ggtitle('Phascolarctobacterium sp. (FD, core) model fit')

p_copri_FD_core_demography = compare_sfs(proportional_sfs(p_copri_FD_core_folded), 
  proportional_sfs(p_copri_FD_core_one_epoch), 
  proportional_sfs(p_copri_FD_core_two_epoch), 
  proportional_sfs(p_copri_FD_core_three_epoch)) +
  ggtitle('Prevotella copri (FD, core) model fit')

r_intestinalis_FD_core_demography = compare_sfs(proportional_sfs(r_intestinalis_FD_core_folded), 
  proportional_sfs(r_intestinalis_FD_core_one_epoch), 
  proportional_sfs(r_intestinalis_FD_core_two_epoch), 
  proportional_sfs(r_intestinalis_FD_core_three_epoch)) +
  ggtitle('Roseburia intestinalis (FD, core) model fit')

r_inulinivorans_FD_core_demography = compare_sfs(proportional_sfs(r_inulinivorans_FD_core_folded), 
  proportional_sfs(r_inulinivorans_FD_core_one_epoch), 
  proportional_sfs(r_inulinivorans_FD_core_two_epoch), 
  proportional_sfs(r_inulinivorans_FD_core_three_epoch)) +
  ggtitle('Roseburia inulinivorans (FD, core) model fit')

r_bicirculans_FD_core_demography = compare_sfs(proportional_sfs(r_bicirculans_FD_core_folded), 
  proportional_sfs(r_bicirculans_FD_core_one_epoch), 
  proportional_sfs(r_bicirculans_FD_core_two_epoch), 
  proportional_sfs(r_bicirculans_FD_core_three_epoch)) +
  ggtitle('Ruminococcus bicirculans (FD, core) model fit')

r_bromii_FD_core_demography = compare_sfs(proportional_sfs(r_bromii_FD_core_folded), 
  proportional_sfs(r_bromii_FD_core_one_epoch), 
  proportional_sfs(r_bromii_FD_core_two_epoch), 
  proportional_sfs(r_bromii_FD_core_three_epoch)) +
  ggtitle('Ruminococcus bromii (FD, core) model fit')

a_muciniphila_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv')
# a_muciniphila_FD_core_likelihood_surface + ggtitle('Akkermansia muciniphila (FD) likelihood surface')

a_finegoldii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv')
# a_finegoldii_FD_core_likelihood_surface + ggtitle('Alistipes finegoldi (FD) likelihood surface')

a_onderdonkii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv')
# a_onderdonkii_FD_core_likelihood_surface + ggtitle('Alistipes onderdonkii (FD) likelihood surface')

a_putredinis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_putredinis_61533/likelihood_surface.csv')
# a_putredinis_FD_core_likelihood_surface + ggtitle('Alistipes putredinis (FD) likelihood surface')

a_shahii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_shahii_62199/likelihood_surface.csv')
# a_shahii_FD_core_likelihood_surface + ggtitle('Alistipes shahii (FD) likelihood surface')

alistipes_sp_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_sp_60764/likelihood_surface.csv')
# alistipes_sp_FD_core_likelihood_surface + ggtitle('Alistipes sp. (FD) likelihood surface')

b_bacterium_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/likelihood_surface.csv')
# b_bacterium_FD_core_likelihood_surface + ggtitle('Bacteroides bacterium (FD) likelihood surface')

b_caccae_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv')
# b_caccae_FD_core_likelihood_surface + ggtitle('Bacteroides caccae (FD) likelihood surface')

b_cellulosilyticus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv')
# b_cellulosilyticus_FD_core_likelihood_surface + ggtitle('Bacteroides cellulosilyticus (FD) likelihood surface')

b_coprocola_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_coprocola_61586/likelihood_surface.csv')
# b_coprocola_FD_core_likelihood_surface + ggtitle('Bacteroides coprocola (FD) likelihood surface')

b_eggerthii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/likelihood_surface.csv')
# b_eggerthii_FD_core_likelihood_surface + ggtitle('Bacteroides eggerthii (FD) likelihood surface')

b_fragilis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv')
# b_fragilis_FD_core_likelihood_surface + ggtitle('Bacteroides fragilis (FD) likelihood surface')

b_massiliensis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/likelihood_surface.csv')
# b_massiliensis_FD_core_likelihood_surface + ggtitle('Bacteroides massiliensis (FD) likelihood surface')

b_ovatus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_ovatus_58035/likelihood_surface.csv')
# b_ovatus_FD_core_likelihood_surface + ggtitle('Bacteroides ovatus (FD) likelihood surface')

b_plebeius_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_plebeius_61623/likelihood_surface.csv')
# b_plebeius_FD_core_likelihood_surface + ggtitle('Bacteroides plebeius (FD) likelihood surface')

b_stercoris_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv')
# b_stercoris_FD_core_likelihood_surface + ggtitle('Bacteroides stercoris (FD) likelihood surface')

b_thetaiotaomicron_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv')
# b_thetaiotaomicron_FD_core_likelihood_surface + ggtitle('Bacteroides thetaiotaomicron (FD) likelihood surface')

b_uniformis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_uniformis_57318/likelihood_surface.csv')
# b_uniformis_FD_core_likelihood_surface + ggtitle('Bacteroides uniformis (FD) likelihood surface')

b_vulgatus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv')
# b_vulgatus_FD_core_likelihood_surface + ggtitle('Bacteroides vulgatus (FD) likelihood surface')

b_xylanisolvens_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/likelihood_surface.csv')
# b_xylanisolvens_FD_core_likelihood_surface + ggtitle('Bacteroides xylanisolvens (FD) likelihood surface')

b_intestinihominis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv')
# b_intestinihominis_FD_core_likelihood_surface + ggtitle('Barnesiella intestinihominis (FD) likelihood surface')

coprococcus_sp_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Coprococcus_sp_62244/likelihood_surface.csv')
# coprococcus_sp_FD_core_likelihood_surface + ggtitle('Coprococcus sp. (FD) likelihood surface')

d_invisus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Dialister_invisus_61905/likelihood_surface.csv')
# d_invisus_FD_core_likelihood_surface + ggtitle('Dialister invisus (FD) likelihood surface')

e_eligens_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_eligens_61678/likelihood_surface.csv')
# e_eligens_FD_core_likelihood_surface + ggtitle('Eubacterium eligens (FD) likelihood surface')

e_rectale_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv')
# e_rectale_FD_core_likelihood_surface + ggtitle('Eubacterium rectale (FD) likelihood surface')

e_siraeum_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_siraeum_57634/likelihood_surface.csv')
# e_siraeum_FD_core_likelihood_surface + ggtitle('Eubacterium siraeum (FD) likelihood surface')

f_prausnitzii_57453_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/likelihood_surface.csv')
# f_prausnitzii_57453_FD_core_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 57453 (FD) likelihood surface')

f_prausnitzii_61481_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/likelihood_surface.csv')
# f_prausnitzii_61481_FD_core_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 61481 (FD) likelihood surface')

f_prausnitzii_62201_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/likelihood_surface.csv')
# f_prausnitzii_62201_FD_core_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 62201 (FD) likelihood surface')

l_bacterium_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/likelihood_surface.csv')
# l_bacterium_FD_core_likelihood_surface + ggtitle('Lachnospiraceae bacterium (FD) likelihood surface')

o_splanchnicus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/likelihood_surface.csv')
# o_splanchnicus_FD_core_likelihood_surface + ggtitle('Odoribacter splanchnicus (FD) likelihood surface')

oscillibacter_sp_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv')
# oscillibacter_sp_FD_core_likelihood_surface + ggtitle('Oscillibacter sp. (FD) likelihood surface')

p_distasonis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv')
# p_distasonis_FD_core_likelihood_surface + ggtitle('Parabacteroides distasonis (FD) likelihood surface')

p_merdae_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv')
# p_merdae_FD_core_likelihood_surface + ggtitle('Parabacteroides merdae (FD) likelihood surface')

phascolarctobacterium_sp_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/likelihood_surface.csv')
# phascolarctobacterium_sp_FD_core_likelihood_surface + ggtitle('Phascolarctobacterium sp. (FD) likelihood surface')

p_copri_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Prevotella_copri_61740/likelihood_surface.csv')
# p_copri_FD_core_likelihood_surface + ggtitle('Prevotella copri (FD) likelihood surface')

r_intestinalis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Roseburia_intestinalis_56239/likelihood_surface.csv')
# r_intestinalis_FD_core_likelihood_surface + ggtitle('Roseburia intestinalis (FD) likelihood surface')

r_inulinivorans_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/likelihood_surface.csv')
# r_inulinivorans_FD_core_likelihood_surface + ggtitle('Roseburia inulinovrans (FD) likelihood surface')

r_bicirculans_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv')
# r_bicirculans_FD_core_likelihood_surface + ggtitle('Ruminococcus bicirculans (FD) likelihood surface')

r_bromii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv')
# r_bromii_FD_core_likelihood_surface + ggtitle('Ruminococcus bromii (FD) likelihood surface')

FD_core_demography = alistipes_sp_FD_core_demography + alistipes_sp_FD_core_likelihood_surface +
  a_putredinis_FD_core_demography + a_putredinis_FD_core_likelihood_surface +
  a_finegoldii_FD_core_demography + a_finegoldii_FD_core_likelihood_surface +
  a_onderdonkii_FD_core_demography + a_onderdonkii_FD_core_likelihood_surface +
  a_shahii_FD_core_demography + a_shahii_FD_core_likelihood_surface +
  b_bacterium_FD_core_demography + b_bacterium_FD_core_likelihood_surface +
  o_splanchnicus_FD_core_demography + o_splanchnicus_FD_core_likelihood_surface +
  p_distasonis_FD_core_demography + p_distasonis_FD_core_likelihood_surface +
  p_merdae_FD_core_demography + p_merdae_FD_core_likelihood_surface +
  p_copri_FD_core_demography + p_copri_FD_core_likelihood_surface +
  b_fragilis_FD_core_demography + b_fragilis_FD_core_likelihood_surface +
  b_cellulosilyticus_FD_core_demography + b_cellulosilyticus_FD_core_likelihood_surface +
  b_eggerthii_FD_core_demography + b_eggerthii_FD_core_likelihood_surface +
  b_stercoris_FD_core_demography + b_stercoris_FD_core_likelihood_surface +
  b_uniformis_FD_core_demography + b_uniformis_FD_core_likelihood_surface +
  b_thetaiotaomicron_FD_core_demography + b_thetaiotaomicron_FD_core_likelihood_surface +
  b_xylanisolvens_FD_core_demography + b_xylanisolvens_FD_core_likelihood_surface +
  b_caccae_FD_core_demography + b_caccae_FD_core_likelihood_surface +
  b_massiliensis_FD_core_demography + b_massiliensis_FD_core_likelihood_surface +
  b_vulgatus_FD_core_demography + b_vulgatus_FD_core_likelihood_surface +
  b_plebeius_FD_core_demography + b_plebeius_FD_core_likelihood_surface +
  b_coprocola_FD_core_demography + b_coprocola_FD_core_likelihood_surface +
  b_intestinihominis_FD_core_demography + b_intestinihominis_FD_core_likelihood_surface +
  a_muciniphila_FD_core_demography + a_muciniphila_FD_core_likelihood_surface +
  d_invisus_FD_core_demography + d_invisus_FD_core_likelihood_surface +
  phascolarctobacterium_sp_FD_core_demography + phascolarctobacterium_sp_FD_core_likelihood_surface +
  e_eligens_FD_core_demography + e_eligens_FD_core_likelihood_surface +
  e_rectale_FD_core_demography + e_rectale_FD_core_likelihood_surface +
  r_intestinalis_FD_core_demography + r_intestinalis_FD_core_likelihood_surface +
  r_inulinivorans_FD_core_demography + r_inulinivorans_FD_core_likelihood_surface +
  l_bacterium_FD_core_demography + l_bacterium_FD_core_likelihood_surface +
  coprococcus_sp_FD_core_demography + coprococcus_sp_FD_core_likelihood_surface +
  oscillibacter_sp_FD_core_demography + oscillibacter_sp_FD_core_likelihood_surface +
  r_bromii_FD_core_demography + r_bromii_FD_core_likelihood_surface +
  r_bicirculans_FD_core_demography + r_bicirculans_FD_core_likelihood_surface +
  e_siraeum_FD_core_demography + e_siraeum_FD_core_likelihood_surface +
  f_prausnitzii_57453_FD_core_demography + f_prausnitzii_57453_FD_core_likelihood_surface +
  f_prausnitzii_62201_FD_core_demography + f_prausnitzii_62201_FD_core_likelihood_surface +
  f_prausnitzii_61481_FD_core_demography + f_prausnitzii_61481_FD_core_likelihood_surface +
  plot_layout(ncol=2)
  
ggsave(filename='../Supplement/Supplemental_Figure_3.jpg', plot=FD_core_demography, width=10, height=125, units="in", limitsize=FALSE)

a_muciniphila_FD_accessory_demography = compare_sfs(proportional_sfs(a_muciniphila_FD_accessory_folded), 
  proportional_sfs(a_muciniphila_FD_accessory_one_epoch), 
  proportional_sfs(a_muciniphila_FD_accessory_two_epoch), 
  proportional_sfs(a_muciniphila_FD_accessory_three_epoch)) +
  ggtitle('Akkermansia muciniphila (FD, accessory) model fit')

a_finegoldii_FD_accessory_demography = compare_sfs(proportional_sfs(a_finegoldii_FD_accessory_folded), 
  proportional_sfs(a_finegoldii_FD_accessory_one_epoch), 
  proportional_sfs(a_finegoldii_FD_accessory_two_epoch), 
  proportional_sfs(a_finegoldii_FD_accessory_three_epoch)) +
  ggtitle('Alistipes finegoldii (FD, accessory) model fit')

a_onderdonkii_FD_accessory_demography = compare_sfs(proportional_sfs(a_onderdonkii_FD_accessory_folded), 
  proportional_sfs(a_onderdonkii_FD_accessory_one_epoch), 
  proportional_sfs(a_onderdonkii_FD_accessory_two_epoch), 
  proportional_sfs(a_onderdonkii_FD_accessory_three_epoch)) +
  ggtitle('Alistipes onderdonkii (FD, accessory) model fit')

a_putredinis_FD_accessory_demography = compare_sfs(proportional_sfs(a_putredinis_FD_accessory_folded), 
  proportional_sfs(a_putredinis_FD_accessory_one_epoch), 
  proportional_sfs(a_putredinis_FD_accessory_two_epoch), 
  proportional_sfs(a_putredinis_FD_accessory_three_epoch)) +
  ggtitle('Alistipes putredinis (FD, accessory) model fit')

a_shahii_FD_accessory_demography = compare_sfs(proportional_sfs(a_shahii_FD_accessory_folded), 
  proportional_sfs(a_shahii_FD_accessory_one_epoch), 
  proportional_sfs(a_shahii_FD_accessory_two_epoch), 
  proportional_sfs(a_shahii_FD_accessory_three_epoch)) +
  ggtitle('Alistipes shahii (FD, accessory) model fit')

alistipes_sp_FD_accessory_demography = compare_sfs(proportional_sfs(alistipes_sp_FD_accessory_folded), 
  proportional_sfs(alistipes_sp_FD_accessory_one_epoch), 
  proportional_sfs(alistipes_sp_FD_accessory_two_epoch), 
  proportional_sfs(alistipes_sp_FD_accessory_three_epoch)) +
  ggtitle('Alistipes sp. (FD, accessory) model fit')

b_bacterium_FD_accessory_demography = compare_sfs(proportional_sfs(b_bacterium_FD_accessory_folded), 
  proportional_sfs(b_bacterium_FD_accessory_one_epoch), 
  proportional_sfs(b_bacterium_FD_accessory_two_epoch), 
  proportional_sfs(b_bacterium_FD_accessory_three_epoch)) +
  ggtitle('Bacteroidales bacterium (FD, accessory) model fit')

b_caccae_FD_accessory_demography = compare_sfs(proportional_sfs(b_caccae_FD_accessory_folded), 
  proportional_sfs(b_caccae_FD_accessory_one_epoch), 
  proportional_sfs(b_caccae_FD_accessory_two_epoch), 
  proportional_sfs(b_caccae_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides caccae (FD, accessory) model fit')

b_cellulosilyticus_FD_accessory_demography = compare_sfs(proportional_sfs(b_cellulosilyticus_FD_accessory_folded), 
  proportional_sfs(b_cellulosilyticus_FD_accessory_one_epoch), 
  proportional_sfs(b_cellulosilyticus_FD_accessory_two_epoch), 
  proportional_sfs(b_cellulosilyticus_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides cellulosilyticus (FD, accessory) model fit')

b_coprocola_FD_accessory_demography = compare_sfs(proportional_sfs(b_coprocola_FD_accessory_folded), 
  proportional_sfs(b_coprocola_FD_accessory_one_epoch), 
  proportional_sfs(b_coprocola_FD_accessory_two_epoch), 
  proportional_sfs(b_coprocola_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides coprocola (FD, accessory) model fit')

b_eggerthii_FD_accessory_demography = compare_sfs(proportional_sfs(b_eggerthii_FD_accessory_folded), 
  proportional_sfs(b_eggerthii_FD_accessory_one_epoch), 
  proportional_sfs(b_eggerthii_FD_accessory_two_epoch), 
  proportional_sfs(b_eggerthii_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides eggerthii (FD, accessory) model fit')

b_fragilis_FD_accessory_demography = compare_sfs(proportional_sfs(b_fragilis_FD_accessory_folded), 
  proportional_sfs(b_fragilis_FD_accessory_one_epoch), 
  proportional_sfs(b_fragilis_FD_accessory_two_epoch), 
  proportional_sfs(b_fragilis_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides fragilis (FD, accessory) model fit')

b_massiliensis_FD_accessory_demography = compare_sfs(proportional_sfs(b_massiliensis_FD_accessory_folded), 
  proportional_sfs(b_massiliensis_FD_accessory_one_epoch), 
  proportional_sfs(b_massiliensis_FD_accessory_two_epoch), 
  proportional_sfs(b_massiliensis_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides massiliensis (FD, accessory) model fit')

b_ovatus_FD_accessory_demography = compare_sfs(proportional_sfs(b_ovatus_FD_accessory_folded), 
  proportional_sfs(b_ovatus_FD_accessory_one_epoch), 
  proportional_sfs(b_ovatus_FD_accessory_two_epoch), 
  proportional_sfs(b_ovatus_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides ovatus (FD, accessory) model fit')

b_plebeius_FD_accessory_demography = compare_sfs(proportional_sfs(b_plebeius_FD_accessory_folded), 
  proportional_sfs(b_plebeius_FD_accessory_one_epoch), 
  proportional_sfs(b_plebeius_FD_accessory_two_epoch), 
  proportional_sfs(b_plebeius_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides plebeius (FD, accessory) model fit')

b_stercoris_FD_accessory_demography = compare_sfs(proportional_sfs(b_stercoris_FD_accessory_folded), 
  proportional_sfs(b_stercoris_FD_accessory_one_epoch), 
  proportional_sfs(b_stercoris_FD_accessory_two_epoch), 
  proportional_sfs(b_stercoris_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides stercoris (FD, accessory) model fit')

b_thetaiotaomicron_FD_accessory_demography = compare_sfs(proportional_sfs(b_thetaiotaomicron_FD_accessory_folded), 
  proportional_sfs(b_thetaiotaomicron_FD_accessory_one_epoch), 
  proportional_sfs(b_thetaiotaomicron_FD_accessory_two_epoch), 
  proportional_sfs(b_thetaiotaomicron_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides thetaiotaomicron (FD, accessory) model fit')

b_uniformis_FD_accessory_demography = compare_sfs(proportional_sfs(b_uniformis_FD_accessory_folded), 
  proportional_sfs(b_uniformis_FD_accessory_one_epoch), 
  proportional_sfs(b_uniformis_FD_accessory_two_epoch), 
  proportional_sfs(b_uniformis_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides uniformis (FD, accessory) model fit')

b_vulgatus_FD_accessory_demography = compare_sfs(proportional_sfs(b_vulgatus_FD_accessory_folded), 
  proportional_sfs(b_vulgatus_FD_accessory_one_epoch), 
  proportional_sfs(b_vulgatus_FD_accessory_two_epoch), 
  proportional_sfs(b_vulgatus_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides vulgatus (FD, accessory) model fit')

b_xylanisolvens_FD_accessory_demography = compare_sfs(proportional_sfs(b_xylanisolvens_FD_accessory_folded), 
  proportional_sfs(b_xylanisolvens_FD_accessory_one_epoch), 
  proportional_sfs(b_xylanisolvens_FD_accessory_two_epoch), 
  proportional_sfs(b_xylanisolvens_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides xylanisolvens (FD, accessory) model fit')

b_intestinihominis_FD_accessory_demography = compare_sfs(proportional_sfs(b_intestinihominis_FD_accessory_folded), 
  proportional_sfs(b_intestinihominis_FD_accessory_one_epoch), 
  proportional_sfs(b_intestinihominis_FD_accessory_two_epoch), 
  proportional_sfs(b_intestinihominis_FD_accessory_three_epoch)) +
  ggtitle('Barnesiella intestinihominis (FD, accessory) model fit')

coprococcus_sp_FD_accessory_demography = compare_sfs(proportional_sfs(coprococcus_sp_FD_accessory_folded), 
  proportional_sfs(coprococcus_sp_FD_accessory_one_epoch), 
  proportional_sfs(coprococcus_sp_FD_accessory_two_epoch), 
  proportional_sfs(coprococcus_sp_FD_accessory_three_epoch)) +
  ggtitle('Coprococcus sp. (FD, accessory) model fit')

d_invisus_FD_accessory_demography = compare_sfs(proportional_sfs(d_invisus_FD_accessory_folded), 
  proportional_sfs(d_invisus_FD_accessory_one_epoch), 
  proportional_sfs(d_invisus_FD_accessory_two_epoch), 
  proportional_sfs(d_invisus_FD_accessory_three_epoch)) +
  ggtitle('Dialister invisus (FD, accessory) model fit')

e_eligens_FD_accessory_demography = compare_sfs(proportional_sfs(e_eligens_FD_accessory_folded), 
  proportional_sfs(e_eligens_FD_accessory_one_epoch), 
  proportional_sfs(e_eligens_FD_accessory_two_epoch), 
  proportional_sfs(e_eligens_FD_accessory_three_epoch)) +
  ggtitle('Eubacterium eligens (FD, accessory) model fit')

e_rectale_FD_accessory_demography = compare_sfs(proportional_sfs(e_rectale_FD_accessory_folded), 
  proportional_sfs(e_rectale_FD_accessory_one_epoch), 
  proportional_sfs(e_rectale_FD_accessory_two_epoch), 
  proportional_sfs(e_rectale_FD_accessory_three_epoch)) +
  ggtitle('Eubacterium rectale (FD, accessory) model fit')

e_siraeum_FD_accessory_demography = compare_sfs(proportional_sfs(e_siraeum_FD_accessory_folded), 
  proportional_sfs(e_siraeum_FD_accessory_one_epoch), 
  proportional_sfs(e_siraeum_FD_accessory_two_epoch), 
  proportional_sfs(e_siraeum_FD_accessory_three_epoch)) +
  ggtitle('Eubacterium siraeum (FD, accessory) model fit')

f_prausnitzii_57453_FD_accessory_demography = compare_sfs(proportional_sfs(f_prausnitzii_57453_FD_accessory_folded), 
  proportional_sfs(f_prausnitzii_57453_FD_accessory_one_epoch), 
  proportional_sfs(f_prausnitzii_57453_FD_accessory_two_epoch), 
  proportional_sfs(f_prausnitzii_57453_FD_accessory_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 57453 (FD, accessory) model fit')

f_prausnitzii_61481_FD_accessory_demography = compare_sfs(proportional_sfs(f_prausnitzii_61481_FD_accessory_folded), 
  proportional_sfs(f_prausnitzii_61481_FD_accessory_one_epoch), 
  proportional_sfs(f_prausnitzii_61481_FD_accessory_two_epoch), 
  proportional_sfs(f_prausnitzii_61481_FD_accessory_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 61481 (FD, accessory) model fit')

f_prausnitzii_62201_FD_accessory_demography = compare_sfs(proportional_sfs(f_prausnitzii_62201_FD_accessory_folded), 
  proportional_sfs(f_prausnitzii_62201_FD_accessory_one_epoch), 
  proportional_sfs(f_prausnitzii_62201_FD_accessory_two_epoch), 
  proportional_sfs(f_prausnitzii_62201_FD_accessory_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 62201 (FD, accessory) model fit')

l_bacterium_FD_accessory_demography = compare_sfs(proportional_sfs(l_bacterium_FD_accessory_folded), 
  proportional_sfs(l_bacterium_FD_accessory_one_epoch), 
  proportional_sfs(l_bacterium_FD_accessory_two_epoch), 
  proportional_sfs(l_bacterium_FD_accessory_three_epoch)) +
  ggtitle('Lachnospiraceae bacterium (FD, accessory) model fit')

o_splanchnicus_FD_accessory_demography = compare_sfs(proportional_sfs(o_splanchnicus_FD_accessory_folded), 
  proportional_sfs(o_splanchnicus_FD_accessory_one_epoch), 
  proportional_sfs(o_splanchnicus_FD_accessory_two_epoch), 
  proportional_sfs(o_splanchnicus_FD_accessory_three_epoch)) +
  ggtitle('Odoribacter splanchnicus (FD, accessory) model fit')

oscillibacter_sp_FD_accessory_demography = compare_sfs(proportional_sfs(oscillibacter_sp_FD_accessory_folded), 
  proportional_sfs(oscillibacter_sp_FD_accessory_one_epoch), 
  proportional_sfs(oscillibacter_sp_FD_accessory_two_epoch), 
  proportional_sfs(oscillibacter_sp_FD_accessory_three_epoch)) +
  ggtitle('Oscillibacter sp. (FD, accessory) model fit')

p_distasonis_FD_accessory_demography = compare_sfs(proportional_sfs(p_distasonis_FD_accessory_folded), 
  proportional_sfs(p_distasonis_FD_accessory_one_epoch), 
  proportional_sfs(p_distasonis_FD_accessory_two_epoch), 
  proportional_sfs(p_distasonis_FD_accessory_three_epoch)) +
  ggtitle('Parabacteroides distasonis (FD, accessory) model fit')

p_merdae_FD_accessory_demography = compare_sfs(proportional_sfs(p_merdae_FD_accessory_folded), 
  proportional_sfs(p_merdae_FD_accessory_one_epoch), 
  proportional_sfs(p_merdae_FD_accessory_two_epoch), 
  proportional_sfs(p_merdae_FD_accessory_three_epoch)) +
  ggtitle('Parabacteroides merdae (FD, accessory) model fit')

phascolarctobacterium_sp_FD_accessory_demography = compare_sfs(proportional_sfs(phascolarctobacterium_sp_FD_accessory_folded), 
  proportional_sfs(phascolarctobacterium_sp_FD_accessory_one_epoch), 
  proportional_sfs(phascolarctobacterium_sp_FD_accessory_two_epoch), 
  proportional_sfs(phascolarctobacterium_sp_FD_accessory_three_epoch)) +
  ggtitle('Phascolarctobacterium sp. (FD, accessory) model fit')

p_copri_FD_accessory_demography = compare_sfs(proportional_sfs(p_copri_FD_accessory_folded), 
  proportional_sfs(p_copri_FD_accessory_one_epoch), 
  proportional_sfs(p_copri_FD_accessory_two_epoch), 
  proportional_sfs(p_copri_FD_accessory_three_epoch)) +
  ggtitle('Prevotella copri (FD, accessory) model fit')

r_intestinalis_FD_accessory_demography = compare_sfs(proportional_sfs(r_intestinalis_FD_accessory_folded), 
  proportional_sfs(r_intestinalis_FD_accessory_one_epoch), 
  proportional_sfs(r_intestinalis_FD_accessory_two_epoch), 
  proportional_sfs(r_intestinalis_FD_accessory_three_epoch)) +
  ggtitle('Roseburia intestinalis (FD, accessory) model fit')

r_inulinivorans_FD_accessory_demography = compare_sfs(proportional_sfs(r_inulinivorans_FD_accessory_folded), 
  proportional_sfs(r_inulinivorans_FD_accessory_one_epoch), 
  proportional_sfs(r_inulinivorans_FD_accessory_two_epoch), 
  proportional_sfs(r_inulinivorans_FD_accessory_three_epoch)) +
  ggtitle('Roseburia inulinivorans (FD, accessory) model fit')

r_bicirculans_FD_accessory_demography = compare_sfs(proportional_sfs(r_bicirculans_FD_accessory_folded), 
  proportional_sfs(r_bicirculans_FD_accessory_one_epoch), 
  proportional_sfs(r_bicirculans_FD_accessory_two_epoch), 
  proportional_sfs(r_bicirculans_FD_accessory_three_epoch)) +
  ggtitle('Ruminococcus bicirculans (FD, accessory) model fit')

r_bromii_FD_accessory_demography = compare_sfs(proportional_sfs(r_bromii_FD_accessory_folded), 
  proportional_sfs(r_bromii_FD_accessory_one_epoch), 
  proportional_sfs(r_bromii_FD_accessory_two_epoch), 
  proportional_sfs(r_bromii_FD_accessory_three_epoch)) +
  ggtitle('Ruminococcus bromii (FD, accessory) model fit')

a_muciniphila_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_likelihood_surface.csv')
# a_muciniphila_FD_accessory_likelihood_surface + ggtitle('Akkermansia muciniphila (FD) likelihood surface')

a_finegoldii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_likelihood_surface.csv')
# a_finegoldii_FD_accessory_likelihood_surface + ggtitle('Alistipes finegoldi (FD) likelihood surface')

a_onderdonkii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_likelihood_surface.csv')
# a_onderdonkii_FD_accessory_likelihood_surface + ggtitle('Alistipes onderdonkii (FD) likelihood surface')

a_putredinis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_likelihood_surface.csv')
# a_putredinis_FD_accessory_likelihood_surface + ggtitle('Alistipes putredinis (FD) likelihood surface')

a_shahii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_likelihood_surface.csv')
# a_shahii_FD_accessory_likelihood_surface + ggtitle('Alistipes shahii (FD) likelihood surface')

alistipes_sp_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_likelihood_surface.csv')
# alistipes_sp_FD_accessory_likelihood_surface + ggtitle('Alistipes sp. (FD) likelihood surface')

b_bacterium_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_likelihood_surface.csv')
# b_bacterium_FD_accessory_likelihood_surface + ggtitle('Bacteroides bacterium (FD) likelihood surface')

b_caccae_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_likelihood_surface.csv')
# b_caccae_FD_accessory_likelihood_surface + ggtitle('Bacteroides caccae (FD) likelihood surface')

b_cellulosilyticus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_likelihood_surface.csv')
# b_cellulosilyticus_FD_accessory_likelihood_surface + ggtitle('Bacteroides cellulosilyticus (FD) likelihood surface')

b_coprocola_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_likelihood_surface.csv')
# b_coprocola_FD_accessory_likelihood_surface + ggtitle('Bacteroides coprocola (FD) likelihood surface')

b_eggerthii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_likelihood_surface.csv')
# b_eggerthii_FD_accessory_likelihood_surface + ggtitle('Bacteroides eggerthii (FD) likelihood surface')

b_fragilis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_likelihood_surface.csv')
# b_fragilis_FD_accessory_likelihood_surface + ggtitle('Bacteroides fragilis (FD) likelihood surface')

b_massiliensis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_likelihood_surface.csv')
# b_massiliensis_FD_accessory_likelihood_surface + ggtitle('Bacteroides massiliensis (FD) likelihood surface')

b_ovatus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_likelihood_surface.csv')
# b_ovatus_FD_accessory_likelihood_surface + ggtitle('Bacteroides ovatus (FD) likelihood surface')

b_plebeius_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_likelihood_surface.csv')
# b_plebeius_FD_accessory_likelihood_surface + ggtitle('Bacteroides plebeius (FD) likelihood surface')

b_stercoris_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_likelihood_surface.csv')
# b_stercoris_FD_accessory_likelihood_surface + ggtitle('Bacteroides stercoris (FD) likelihood surface')

b_thetaiotaomicron_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_likelihood_surface.csv')
# b_thetaiotaomicron_FD_accessory_likelihood_surface + ggtitle('Bacteroides thetaiotaomicron (FD) likelihood surface')

b_uniformis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_likelihood_surface.csv')
# b_uniformis_FD_accessory_likelihood_surface + ggtitle('Bacteroides uniformis (FD) likelihood surface')

b_vulgatus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_likelihood_surface.csv')
# b_vulgatus_FD_accessory_likelihood_surface + ggtitle('Bacteroides vulgatus (FD) likelihood surface')

b_xylanisolvens_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_likelihood_surface.csv')
# b_xylanisolvens_FD_accessory_likelihood_surface + ggtitle('Bacteroides xylanisolvens (FD) likelihood surface')

b_intestinihominis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_likelihood_surface.csv')
# b_intestinihominis_FD_accessory_likelihood_surface + ggtitle('Barnesiella intestinihominis (FD) likelihood surface')

coprococcus_sp_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_likelihood_surface.csv')
# coprococcus_sp_FD_accessory_likelihood_surface + ggtitle('Coprococcus sp. (FD) likelihood surface')

d_invisus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_likelihood_surface.csv')
# d_invisus_FD_accessory_likelihood_surface + ggtitle('Dialister invisus (FD) likelihood surface')

e_eligens_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_likelihood_surface.csv')
# e_eligens_FD_accessory_likelihood_surface + ggtitle('Eubacterium eligens (FD) likelihood surface')

e_rectale_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_likelihood_surface.csv')
# e_rectale_FD_accessory_likelihood_surface + ggtitle('Eubacterium rectale (FD) likelihood surface')

e_siraeum_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_likelihood_surface.csv')
# e_siraeum_FD_accessory_likelihood_surface + ggtitle('Eubacterium siraeum (FD) likelihood surface')

f_prausnitzii_57453_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_likelihood_surface.csv')
# f_prausnitzii_57453_FD_accessory_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 57453 (FD) likelihood surface')

f_prausnitzii_61481_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_likelihood_surface.csv')
# f_prausnitzii_61481_FD_accessory_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 61481 (FD) likelihood surface')

f_prausnitzii_62201_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_likelihood_surface.csv')
# f_prausnitzii_62201_FD_accessory_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 62201 (FD) likelihood surface')

l_bacterium_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_likelihood_surface.csv')
# l_bacterium_FD_accessory_likelihood_surface + ggtitle('Lachnospiraceae bacterium (FD) likelihood surface')

o_splanchnicus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_likelihood_surface.csv')
# o_splanchnicus_FD_accessory_likelihood_surface + ggtitle('Odoribacter splanchnicus (FD) likelihood surface')

oscillibacter_sp_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_likelihood_surface.csv')
# oscillibacter_sp_FD_accessory_likelihood_surface + ggtitle('Oscillibacter sp. (FD) likelihood surface')

p_distasonis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_likelihood_surface.csv')
# p_distasonis_FD_accessory_likelihood_surface + ggtitle('Parabacteroides distasonis (FD) likelihood surface')

p_merdae_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_likelihood_surface.csv')
# p_merdae_FD_accessory_likelihood_surface + ggtitle('Parabacteroides merdae (FD) likelihood surface')

phascolarctobacterium_sp_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_likelihood_surface.csv')
# phascolarctobacterium_sp_FD_accessory_likelihood_surface + ggtitle('Phascolarctobacterium sp. (FD) likelihood surface')

p_copri_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_likelihood_surface.csv')
# p_copri_FD_accessory_likelihood_surface + ggtitle('Prevotella copri (FD) likelihood surface')

r_intestinalis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_likelihood_surface.csv')
# r_intestinalis_FD_accessory_likelihood_surface + ggtitle('Roseburia intestinalis (FD) likelihood surface')

r_inulinivorans_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_likelihood_surface.csv')
# r_inulinivorans_FD_accessory_likelihood_surface + ggtitle('Roseburia inulinovrans (FD) likelihood surface')

r_bicirculans_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_likelihood_surface.csv')
# r_bicirculans_FD_accessory_likelihood_surface + ggtitle('Ruminococcus bicirculans (FD) likelihood surface')

r_bromii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_likelihood_surface.csv')
# r_bromii_FD_accessory_likelihood_surface + ggtitle('Ruminococcus bromii (FD) likelihood surface')

FD_accessory_demography = alistipes_sp_FD_accessory_demography + alistipes_sp_FD_accessory_likelihood_surface +
  a_putredinis_FD_accessory_demography + a_putredinis_FD_accessory_likelihood_surface +
  a_finegoldii_FD_accessory_demography + a_finegoldii_FD_accessory_likelihood_surface +
  a_onderdonkii_FD_accessory_demography + a_onderdonkii_FD_accessory_likelihood_surface +
  a_shahii_FD_accessory_demography + a_shahii_FD_accessory_likelihood_surface +
  b_bacterium_FD_accessory_demography + b_bacterium_FD_accessory_likelihood_surface +
  o_splanchnicus_FD_accessory_demography + o_splanchnicus_FD_accessory_likelihood_surface +
  p_distasonis_FD_accessory_demography + p_distasonis_FD_accessory_likelihood_surface +
  p_merdae_FD_accessory_demography + p_merdae_FD_accessory_likelihood_surface +
  p_copri_FD_accessory_demography + p_copri_FD_accessory_likelihood_surface +
  b_fragilis_FD_accessory_demography + b_fragilis_FD_accessory_likelihood_surface +
  b_cellulosilyticus_FD_accessory_demography + b_cellulosilyticus_FD_accessory_likelihood_surface +
  b_eggerthii_FD_accessory_demography + b_eggerthii_FD_accessory_likelihood_surface +
  b_stercoris_FD_accessory_demography + b_stercoris_FD_accessory_likelihood_surface +
  b_uniformis_FD_accessory_demography + b_uniformis_FD_accessory_likelihood_surface +
  b_thetaiotaomicron_FD_accessory_demography + b_thetaiotaomicron_FD_accessory_likelihood_surface +
  b_xylanisolvens_FD_accessory_demography + b_xylanisolvens_FD_accessory_likelihood_surface +
  b_caccae_FD_accessory_demography + b_caccae_FD_accessory_likelihood_surface +
  b_massiliensis_FD_accessory_demography + b_massiliensis_FD_accessory_likelihood_surface +
  b_vulgatus_FD_accessory_demography + b_vulgatus_FD_accessory_likelihood_surface +
  b_plebeius_FD_accessory_demography + b_plebeius_FD_accessory_likelihood_surface +
  b_coprocola_FD_accessory_demography + b_coprocola_FD_accessory_likelihood_surface +
  b_intestinihominis_FD_accessory_demography + b_intestinihominis_FD_accessory_likelihood_surface +
  a_muciniphila_FD_accessory_demography + a_muciniphila_FD_accessory_likelihood_surface +
  d_invisus_FD_accessory_demography + d_invisus_FD_accessory_likelihood_surface +
  phascolarctobacterium_sp_FD_accessory_demography + phascolarctobacterium_sp_FD_accessory_likelihood_surface +
  e_eligens_FD_accessory_demography + e_eligens_FD_accessory_likelihood_surface +
  e_rectale_FD_accessory_demography + e_rectale_FD_accessory_likelihood_surface +
  r_intestinalis_FD_accessory_demography + r_intestinalis_FD_accessory_likelihood_surface +
  r_inulinivorans_FD_accessory_demography + r_inulinivorans_FD_accessory_likelihood_surface +
  l_bacterium_FD_accessory_demography + l_bacterium_FD_accessory_likelihood_surface +
  coprococcus_sp_FD_accessory_demography + coprococcus_sp_FD_accessory_likelihood_surface +
  oscillibacter_sp_FD_accessory_demography + oscillibacter_sp_FD_accessory_likelihood_surface +
  r_bromii_FD_accessory_demography + r_bromii_FD_accessory_likelihood_surface +
  r_bicirculans_FD_accessory_demography + r_bicirculans_FD_accessory_likelihood_surface +
  e_siraeum_FD_accessory_demography + e_siraeum_FD_accessory_likelihood_surface +
  f_prausnitzii_57453_FD_accessory_demography + f_prausnitzii_57453_FD_accessory_likelihood_surface +
  f_prausnitzii_62201_FD_accessory_demography + f_prausnitzii_62201_FD_accessory_likelihood_surface +
  f_prausnitzii_61481_FD_accessory_demography + f_prausnitzii_61481_FD_accessory_likelihood_surface +
  plot_layout(ncol=2)

ggsave(filename='../Supplement/Supplemental_Figure_8.jpg', plot=FD_accessory_demography, width=10, height=125, units="in", limitsize=FALSE)

# Supplemental Figure 4

nu_tau_distribution = data.frame(species=supplementary_species_list,
  nu_mle = numeric(39),
  time_mle = numeric(39),
  nu_low = numeric(39),
  nu_high = numeric(39),
  time_low = numeric(39),
  time_high = numeric(39))

nu_tau_distribution

for (i in 1:length(core_likelihood_surface_file_list)) {
  # nu_mle
  nu_tau_distribution[i, 2] = return_nu_mle(core_likelihood_surface_file_list[i])
  # nu_low
  nu_tau_distribution[i, 4] = return_nu_low(core_likelihood_surface_file_list[i])
  # nu_high
  nu_tau_distribution[i, 5] =  return_nu_high(core_likelihood_surface_file_list[i])
  # tau_mle
  nu_tau_distribution[i, 3] = return_time_mle(core_likelihood_surface_file_list[i],
    core_synonymous_sfs_file_list[i],
    core_two_epoch_file_list[i])
  # tau_low
  nu_tau_distribution[i, 6] = return_time_low(core_likelihood_surface_file_list[i],
    core_synonymous_sfs_file_list[i],
    core_two_epoch_file_list[i])
  # tau_high
  nu_tau_distribution[i, 7] =  return_time_high(core_likelihood_surface_file_list[i],
    core_synonymous_sfs_file_list[i],
    core_two_epoch_file_list[i])
}

nu_tau_distribution$species = factor(nu_tau_distribution$species, levels=FD_phylogenetic_levels)

nu_tau_distribution <- nu_tau_distribution[order(nu_tau_distribution$species), ]

nu_tau_distribution

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
tau_label_text = 'Estimated time in years since most recent demographic event'

plot_nu_distribution_fig = ggplot() +
  geom_linerange(data=nu_tau_distribution, mapping=aes(x=fct_rev(species), ymin=nu_low, ymax=nu_high, col=species), size=1, show.legend = FALSE) + 
  geom_point(data=nu_tau_distribution, mapping=aes(x=fct_rev(species), y=nu_mle, col=species), size=4, shape=18,  show.legend = FALSE) +
  scale_y_log10() +
  coord_flip() +
  theme_bw() +
  xlab('') +
  ylab(nu_label_text) +
  geom_hline(yintercept=1.0, color='red', linewidth=1, linetype='dashed') +
  theme(axis.text.y = element_blank()) +
  theme(axis.text=element_text(size=12),
  axis.title=element_text(size=16))

plot_nu_distribution_fig

plot_tau_distribution_fig = ggplot() +
  geom_linerange(data=nu_tau_distribution, mapping=aes(x=fct_rev(species), ymin=time_low, ymax=time_high, col=species), size=1, show.legend = FALSE) + 
  geom_point(data=nu_tau_distribution, mapping=aes(x=fct_rev(species), y=time_mle, col=species), size=4, shape=18, show.legend = FALSE) +
  scale_y_log10() +
  coord_flip() +
  theme_bw() +
  xlab('') +
  ylab(tau_label_text) +
  theme(axis.text.y = element_blank()) +
  theme(axis.text=element_text(size=12),
  axis.title=element_text(size=16))

plot_tau_distribution_fig

# 2000 x 1100 dimensions for saved image
png("../Supplement/Supplemental_Figure_4A.jpg", width = 2000, height = 2000)
plot_nu_distribution_fig + plot_tau_distribution_fig + plot_layout(ncol=2)
dev.off()

# Supplemental Figure 5

# FD DFE comparison (core)

a_muciniphila_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt')
a_muciniphila_fd_core_dfe_params$species = 'Akkermansia muciniphila'

a_finegoldii_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt')
a_finegoldii_fd_core_dfe_params$species = 'Alistipes finegoldii'

a_onderdonkii_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt')
a_onderdonkii_fd_core_dfe_params$species = 'Alistipes onderdonkii'

a_putredinis_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt')
a_putredinis_fd_core_dfe_params$species = 'Alistipes putredinis'

a_shahii_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt')
a_shahii_fd_core_dfe_params$species = 'Alistipes shahii'

alistipes_sp_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt')
alistipes_sp_fd_core_dfe_params$species = 'Alistipes sp.'

b_bacterium_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt')
b_bacterium_fd_core_dfe_params$species = 'Bacteroidales bacterium'

b_caccae_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt')
b_caccae_fd_core_dfe_params$species = 'Bacteroides caccae'

b_cellulosilyticus_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt')
b_cellulosilyticus_fd_core_dfe_params$species = 'Bacteroides cellulosilyticus'

b_coprocola_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt')
b_coprocola_fd_core_dfe_params$species = 'Bacteroides coprocola'

b_eggerthii_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt')
b_eggerthii_fd_core_dfe_params$species = 'Bacteroides eggerthii'

b_fragilis_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt')
b_fragilis_fd_core_dfe_params$species = 'Bacteroides fragilis'

b_massiliensis_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt')
b_massiliensis_fd_core_dfe_params$species = 'Bacteroides massiliensis'

b_plebeius_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt')
b_plebeius_fd_core_dfe_params$species = 'Bacteroides plebeius'

b_stercoris_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt')
b_stercoris_fd_core_dfe_params$species = 'Bacteroides stercoris'

b_thetaiotaomicron_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt')
b_thetaiotaomicron_fd_core_dfe_params$species = 'Bacteroides thetaiotaomicron'

b_uniformis_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt')
b_uniformis_fd_core_dfe_params$species = 'Bacteroides uniformis'

b_vulgatus_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt')
b_vulgatus_fd_core_dfe_params$species = 'Bacteroides vulgatus'

b_xylanisolvens_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt')
b_xylanisolvens_fd_core_dfe_params$species = 'Bacteroides xylanisolvens'

b_intestinihominis_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt')
b_intestinihominis_fd_core_dfe_params$species = 'Barnesiella intestinihominis'

coprococcus_sp_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt')
coprococcus_sp_fd_core_dfe_params$species = 'Coprococcus sp.'

d_invisus_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt')
d_invisus_fd_core_dfe_params$species = 'Dialister invisus'

e_eligens_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt')
e_eligens_fd_core_dfe_params$species = 'Eubacterium eligens'

e_rectale_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt')
e_rectale_fd_core_dfe_params$species = 'Eubacterium rectale'

e_siraeum_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt')
e_siraeum_fd_core_dfe_params$species = 'Eubacterium siraeum'

f_prausnitzii_57453_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt')
f_prausnitzii_57453_fd_core_dfe_params$species = 'Faecalibacterium prausnitzii (57453)'

f_prausnitzii_61481_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt')
f_prausnitzii_61481_fd_core_dfe_params$species = 'Faecalibacterium prausnitzii (61481)'

f_prausnitzii_62201_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt')
f_prausnitzii_62201_fd_core_dfe_params$species = 'Faecalibacterium prausnitzii (62201)'

l_bacterium_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt')
l_bacterium_fd_core_dfe_params$species = 'Lachnospiraceae bacterium'

o_splanchnicus_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt')
o_splanchnicus_fd_core_dfe_params$species = 'Odoribacter splanchnicus'

oscillibacter_sp_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt')
oscillibacter_sp_fd_core_dfe_params$species = 'Oscillibacter sp.'

p_distasonis_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt')
p_distasonis_fd_core_dfe_params$species = 'Parabacteroides distasonis'

p_merdae_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt')
p_merdae_fd_core_dfe_params$species = 'Parabacteroides merdae'

phascolarctobacterium_sp_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt')
phascolarctobacterium_sp_fd_core_dfe_params$species = 'Phascolarctobacterium sp.'

p_copri_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt')
p_copri_fd_core_dfe_params$species = 'Prevotella copri'

r_intestinalis_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt')
r_intestinalis_fd_core_dfe_params$species = 'Roseburia intestinalis'

r_inulinivorans_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt')
r_inulinivorans_fd_core_dfe_params$species = 'Roseburia inulinivorans'

r_bicirculans_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt')
r_bicirculans_fd_core_dfe_params$species = 'Ruminococcus bicirculans'

r_bromii_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt')
r_bromii_fd_core_dfe_params$species = 'Ruminococcus bromii'

fd_core_dfe_df = rbind(
  melt(a_muciniphila_fd_core_dfe_params),
  melt(a_finegoldii_fd_core_dfe_params),
  melt(a_onderdonkii_fd_core_dfe_params),
  melt(a_putredinis_fd_core_dfe_params),
  melt(a_shahii_fd_core_dfe_params),
  melt(alistipes_sp_fd_core_dfe_params),
  melt(b_bacterium_fd_core_dfe_params),
  melt(b_caccae_fd_core_dfe_params),
  melt(b_cellulosilyticus_fd_core_dfe_params),
  melt(b_coprocola_fd_core_dfe_params),
  melt(b_eggerthii_fd_core_dfe_params),
  melt(b_fragilis_fd_core_dfe_params),
  melt(b_massiliensis_fd_core_dfe_params),
  melt(b_plebeius_fd_core_dfe_params),
  melt(b_stercoris_fd_core_dfe_params),
  melt(b_thetaiotaomicron_fd_core_dfe_params),
  melt(b_uniformis_fd_core_dfe_params),
  melt(b_vulgatus_fd_core_dfe_params),
  melt(b_xylanisolvens_fd_core_dfe_params),
  melt(b_intestinihominis_fd_core_dfe_params),
  melt(coprococcus_sp_fd_core_dfe_params),
  melt(d_invisus_fd_core_dfe_params),
  melt(e_eligens_fd_core_dfe_params),
  melt(e_rectale_fd_core_dfe_params),
  melt(e_siraeum_fd_core_dfe_params),
  melt(f_prausnitzii_57453_fd_core_dfe_params),
  melt(f_prausnitzii_61481_fd_core_dfe_params),
  melt(f_prausnitzii_62201_fd_core_dfe_params),
  melt(l_bacterium_fd_core_dfe_params),
  melt(o_splanchnicus_fd_core_dfe_params),
  melt(oscillibacter_sp_fd_core_dfe_params),
  melt(p_distasonis_fd_core_dfe_params),
  melt(p_merdae_fd_core_dfe_params),
  melt(phascolarctobacterium_sp_fd_core_dfe_params),
  melt(p_copri_fd_core_dfe_params),
  melt(r_intestinalis_fd_core_dfe_params),
  melt(r_inulinivorans_fd_core_dfe_params),
  melt(r_bicirculans_fd_core_dfe_params),
  melt(r_bromii_fd_core_dfe_params)
)

# dfe_df

fd_core_dfe_df$species = factor(fd_core_dfe_df$species, levels=FD_phylogenetic_levels)

fd_core_dfe_df <- fd_core_dfe_df[order(fd_core_dfe_df$species), ]

fd_core_dfe_df

fd_core_dfe_df$value[fd_core_dfe_df$value <= 1e-11] = 1e-11
fd_core_dfe_df$value[fd_core_dfe_df$value >= 0.5] = 0.5

### Figure 4
# 600 x 1000

# png("../Supplement/Supplemental_Figure_5A.jpg", width = 600, height = 2000)
figure_s5a = ggplot(fd_core_dfe_df[fd_core_dfe_df$variable == 'neugamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Neugamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  #) +  
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e1)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") + 
  xlab('Selection Coefficient')

# dev.off()

ggsave('../Supplement/Supplemental_Figure_5A.jpg', figure_s5a, width=9, height=15, units='in', dpi=600)


# Supplemental Figure 6
dfe_comparison_matrix = read.csv('../SupplementaryAnalysis/cross_species_dfe/dfe_comparison_matrix.csv', header=TRUE)

dfe_comparison_matrix = dfe_comparison_matrix[, -1]
rownames(dfe_comparison_matrix) = FD_phylogenetic_levels
colnames(dfe_comparison_matrix) = FD_phylogenetic_levels
dfe_comparison_matrix

dfe_constant_s_matrix = read.csv('../SupplementaryAnalysis/cross_species_dfe/dfe_constant_s_matrix.csv', header=TRUE)

dfe_constant_s_matrix = dfe_constant_s_matrix[, -1]
rownames(dfe_constant_s_matrix) = FD_phylogenetic_levels
colnames(dfe_constant_s_matrix) = FD_phylogenetic_levels
dfe_constant_s_matrix

color_scale = colorRampPalette(c('white', 'yellow', 'orange', 'red'), bias=2.5)(100)

# col_scheme = c(rep('black', each=1), rep('darkorange', each=4), rep('black', each=4), rep('darkviolet', each=8), rep('black', each=10))

### Figure S6A
png("../Supplement/Supplemental_Figure_6A.jpg", width = 1800, height = 1000)
# 1000 x 1500 dimensions of saved image
Heatmap(dfe_comparison_matrix, rect_gp = gpar(type = "none"),
  col=color_scale,
  cluster_rows = FALSE, cluster_columns = FALSE,
  cell_fun = function(j, i, x, y, w, h, fill) {
    if (dfe_comparison_matrix[i, j] > 19.20747 && i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white', fontface='italic'))
      grid.text(sprintf("%.1f", dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
    }
    else if(i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
      grid.text(sprintf("%.1f", dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
    }
  },
  row_names_side='left',
  column_names_gp = gpar(fontsize = 16,fontface='italic', col='black'),
  row_names_gp = gpar(fontsize = 16,fontface='italic', col='black'),
  show_heatmap_legend = T,
  name='LRT Statistic'
  )
dev.off()

### Figure S6B

png("../Supplement/Supplemental_Figure_6B.jpg", width = 1800, height = 1000)
# 800 x 1200 dimensions of saved image
Heatmap(dfe_constant_s_matrix, rect_gp = gpar(type = "none"),
  col=color_scale,
  cluster_rows = FALSE, cluster_columns = FALSE,
  cell_fun = function(j, i, x, y, w, h, fill) {
    if (dfe_constant_s_matrix[i, j] > 19.20747 && i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col = 'white', fontface='italic'))
      grid.text(sprintf("%.1f", dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
    }
    else if(i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
      grid.text(sprintf("%.1f", dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
    }
  },
  row_names_side='left',
  column_names_gp = gpar(fontsize = 16,fontface='italic', col='black'),
  row_names_gp = gpar(fontsize = 16,fontface='italic', col='black'),
  show_heatmap_legend = T,
  name='LRT Statistic'
  )
dev.off()

# Supplemental Figure 7

fig_s7_1 = compare_core_accessory_sfs_syn_ns(alistipes_sp_FD_core_folded,
  alistipes_sp_FD_core_nonsyn,
  alistipes_sp_FD_accessory_folded,
  alistipes_sp_FD_accessory_nonsyn) + ggtitle('Alistipes sp.')

fig_s7_2 = compare_core_accessory_sfs_syn_ns(a_finegoldii_FD_core_folded,
  a_finegoldii_FD_core_nonsyn,
  a_finegoldii_FD_accessory_folded,
  a_finegoldii_FD_accessory_nonsyn) + ggtitle('Alistipes finegoldii')

fig_s7_3 = compare_core_accessory_sfs_syn_ns(a_onderdonkii_FD_core_folded,
  a_onderdonkii_FD_core_nonsyn,
  a_onderdonkii_FD_accessory_folded,
  a_onderdonkii_FD_accessory_nonsyn) + ggtitle('Alistipes onderdonkii')

fig_s7_4 = compare_core_accessory_sfs_syn_ns(a_shahii_FD_core_folded,
  a_shahii_FD_core_nonsyn,
  a_shahii_FD_accessory_folded,
  a_shahii_FD_accessory_nonsyn) + ggtitle('Alistipes shahiii')

fig_s7_5 = compare_core_accessory_sfs_syn_ns(a_putredinis_FD_core_folded,
  a_putredinis_FD_core_nonsyn,
  a_putredinis_FD_accessory_folded,
  a_putredinis_FD_accessory_nonsyn) + ggtitle('Alistipes putredinis')

fig_s7_6 = compare_core_accessory_sfs_syn_ns(b_bacterium_FD_core_folded,
  b_bacterium_FD_core_nonsyn,
  b_bacterium_FD_accessory_folded,
  b_bacterium_FD_accessory_nonsyn) + ggtitle('Bacteroidales bacterium')

fig_s7_7 = compare_core_accessory_sfs_syn_ns(o_splanchnicus_FD_core_folded,
  o_splanchnicus_FD_core_nonsyn,
  o_splanchnicus_FD_accessory_folded,
  o_splanchnicus_FD_accessory_nonsyn) + ggtitle('Odoribacter splanchnicus')

fig_s7_8 = compare_core_accessory_sfs_syn_ns(p_distasonis_FD_core_folded,
  p_distasonis_FD_core_nonsyn,
  p_distasonis_FD_accessory_folded,
  p_distasonis_FD_accessory_nonsyn) + ggtitle('Parabacteroides distasonis')

fig_s7_9 = compare_core_accessory_sfs_syn_ns(p_merdae_FD_core_folded,
  p_merdae_FD_core_nonsyn,
  p_merdae_FD_accessory_folded,
  p_merdae_FD_accessory_nonsyn) + ggtitle('Parabacteroides merdae')

fig_s7_10 = compare_core_accessory_sfs_syn_ns(p_copri_FD_core_folded,
  p_copri_FD_core_nonsyn,
  p_copri_FD_accessory_folded,
  p_copri_FD_accessory_nonsyn) + ggtitle('Prevotella copri')

fig_s7_11 = compare_core_accessory_sfs_syn_ns(b_fragilis_FD_core_folded,
  b_fragilis_FD_core_nonsyn,
  b_fragilis_FD_accessory_folded,
  b_fragilis_FD_accessory_nonsyn) + ggtitle('Bacteroides fragilis')

fig_s7_12 = compare_core_accessory_sfs_syn_ns(b_cellulosilyticus_FD_core_folded,
  b_cellulosilyticus_FD_core_nonsyn,
  b_cellulosilyticus_FD_accessory_folded,
  b_cellulosilyticus_FD_accessory_nonsyn) + ggtitle('Bacteroides cellulosilyticus')

fig_s7_13 = compare_core_accessory_sfs_syn_ns(b_eggerthii_FD_core_folded,
  b_eggerthii_FD_core_nonsyn,
  b_eggerthii_FD_accessory_folded,
  b_eggerthii_FD_accessory_nonsyn) + ggtitle('Species')

fig_s7_14 = compare_core_accessory_sfs_syn_ns(b_stercoris_FD_core_folded,
  b_stercoris_FD_core_nonsyn,
  b_stercoris_FD_accessory_folded,
  b_stercoris_FD_accessory_nonsyn) + ggtitle('Bacteroides stercoris')

fig_s7_15 = compare_core_accessory_sfs_syn_ns(b_uniformis_FD_core_folded,
  b_uniformis_FD_core_nonsyn,
  b_uniformis_FD_accessory_folded,
  b_uniformis_FD_accessory_nonsyn) + ggtitle('Bacteroides uniformis')

fig_s7_16 = compare_core_accessory_sfs_syn_ns(b_thetaiotaomicron_FD_core_folded,
  b_thetaiotaomicron_FD_core_nonsyn,
  b_thetaiotaomicron_FD_accessory_folded,
  b_thetaiotaomicron_FD_accessory_nonsyn) + ggtitle('Bacteroides thetaiotaomicron')

fig_s7_17 = compare_core_accessory_sfs_syn_ns(b_xylanisolvens_FD_core_folded,
  b_xylanisolvens_FD_core_nonsyn,
  b_xylanisolvens_FD_accessory_folded,
  b_xylanisolvens_FD_accessory_nonsyn) + ggtitle('Bacteroides xylanisolvens')

fig_s7_18 = compare_core_accessory_sfs_syn_ns(b_caccae_FD_core_folded,
  b_caccae_FD_core_nonsyn,
  b_caccae_FD_accessory_folded,
  b_caccae_FD_accessory_nonsyn) + ggtitle('Bacteroides caccae')

fig_s7_19 = compare_core_accessory_sfs_syn_ns(b_massiliensis_FD_core_folded,
  b_massiliensis_FD_core_nonsyn,
  b_massiliensis_FD_accessory_folded,
  b_massiliensis_FD_accessory_nonsyn) + ggtitle('Bacteroides massiliensis')

fig_s7_20 = compare_core_accessory_sfs_syn_ns(b_vulgatus_FD_core_folded,
  b_vulgatus_FD_core_nonsyn,
  b_vulgatus_FD_accessory_folded,
  b_vulgatus_FD_accessory_nonsyn) + ggtitle('Bacteroides vulgatus')

fig_s7_21 = compare_core_accessory_sfs_syn_ns(b_plebeius_FD_core_folded,
  b_plebeius_FD_core_nonsyn,
  b_plebeius_FD_accessory_folded,
  b_plebeius_FD_accessory_nonsyn) + ggtitle('Bacteroides plebeius')

fig_s7_22 = compare_core_accessory_sfs_syn_ns(b_coprocola_FD_core_folded,
  b_coprocola_FD_core_nonsyn,
  b_coprocola_FD_accessory_folded,
  b_coprocola_FD_accessory_nonsyn) + ggtitle('Bacteroides coprocola')

fig_s7_23 = compare_core_accessory_sfs_syn_ns(b_intestinihominis_FD_core_folded,
  b_intestinihominis_FD_core_nonsyn,
  b_intestinihominis_FD_accessory_folded,
  b_intestinihominis_FD_accessory_nonsyn) + ggtitle('Barnesiella intestinihominis')

fig_s7_24 = compare_core_accessory_sfs_syn_ns(a_muciniphila_FD_core_folded,
  a_muciniphila_FD_core_nonsyn,
  a_muciniphila_FD_accessory_folded,
  a_muciniphila_FD_accessory_nonsyn) + ggtitle('Akkermansia muciniphila')

fig_s7_25 = compare_core_accessory_sfs_syn_ns(d_invisus_FD_core_folded,
  d_invisus_FD_core_nonsyn,
  d_invisus_FD_accessory_folded,
  d_invisus_FD_accessory_nonsyn) + ggtitle('Dialister invisus')

fig_s7_26 = compare_core_accessory_sfs_syn_ns(phascolarctobacterium_sp_FD_core_folded,
  phascolarctobacterium_sp_FD_core_nonsyn,
  phascolarctobacterium_sp_FD_accessory_folded,
  phascolarctobacterium_sp_FD_accessory_nonsyn) + ggtitle('Phascolarctobacterium sp.')

fig_s7_27 = compare_core_accessory_sfs_syn_ns(e_eligens_FD_core_folded,
  e_eligens_FD_core_nonsyn,
  e_eligens_FD_accessory_folded,
  e_eligens_FD_accessory_nonsyn) + ggtitle('Eubacterium eligens')

fig_s7_28 = compare_core_accessory_sfs_syn_ns(e_rectale_FD_core_folded,
  e_rectale_FD_core_nonsyn,
  e_rectale_FD_accessory_folded,
  e_rectale_FD_accessory_nonsyn) + ggtitle('Eubacterium rectale')

fig_s7_29 = compare_core_accessory_sfs_syn_ns(r_inulinivorans_FD_core_folded,
  r_inulinivorans_FD_core_nonsyn,
  r_inulinivorans_FD_accessory_folded,
  r_inulinivorans_FD_accessory_nonsyn) + ggtitle('Roseburia inulinivorans')

fig_s7_30 = compare_core_accessory_sfs_syn_ns(r_intestinalis_FD_core_folded,
  r_intestinalis_FD_core_nonsyn,
  r_intestinalis_FD_accessory_folded,
  r_intestinalis_FD_accessory_nonsyn) + ggtitle('Roseburia intestinalis')

fig_s7_31 = compare_core_accessory_sfs_syn_ns(l_bacterium_FD_core_folded,
  l_bacterium_FD_core_nonsyn,
  l_bacterium_FD_accessory_folded,
  l_bacterium_FD_accessory_nonsyn) + ggtitle('Lachnospiraceae bacterium')

fig_s7_32 = compare_core_accessory_sfs_syn_ns(coprococcus_sp_FD_core_folded,
  coprococcus_sp_FD_core_nonsyn,
  coprococcus_sp_FD_accessory_folded,
  coprococcus_sp_FD_accessory_nonsyn) + ggtitle('Coprococcus sp.')

fig_s7_33 = compare_core_accessory_sfs_syn_ns(oscillibacter_sp_FD_core_folded,
  oscillibacter_sp_FD_core_nonsyn,
  oscillibacter_sp_FD_accessory_folded,
  oscillibacter_sp_FD_accessory_nonsyn) + ggtitle('Oscillibacter sp.')

fig_s7_34 = compare_core_accessory_sfs_syn_ns(r_bromii_FD_core_folded,
  r_bromii_FD_core_nonsyn,
  r_bromii_FD_accessory_folded,
  r_bromii_FD_accessory_nonsyn) + ggtitle('Ruminococcus bromii')

fig_s7_35 = compare_core_accessory_sfs_syn_ns(r_bicirculans_FD_core_folded,
  r_bicirculans_FD_core_nonsyn,
  r_bicirculans_FD_accessory_folded,
  r_bicirculans_FD_accessory_nonsyn) + ggtitle('Ruminococcus bicirculans')

fig_s7_36 = compare_core_accessory_sfs_syn_ns(e_siraeum_FD_core_folded,
  e_siraeum_FD_core_nonsyn,
  e_siraeum_FD_accessory_folded,
  e_siraeum_FD_accessory_nonsyn) + ggtitle('Eubacterium siraeum')

fig_s7_37 = compare_core_accessory_sfs_syn_ns(f_prausnitzii_57453_FD_core_folded,
  f_prausnitzii_57453_FD_core_nonsyn,
  f_prausnitzii_57453_FD_accessory_folded,
  f_prausnitzii_57453_FD_accessory_nonsyn) + ggtitle('Faecalibacterium prausnitzii (57453)')

fig_s7_38 = compare_core_accessory_sfs_syn_ns(f_prausnitzii_62201_FD_core_folded,
  f_prausnitzii_62201_FD_core_nonsyn,
  f_prausnitzii_62201_FD_accessory_folded,
  f_prausnitzii_62201_FD_accessory_nonsyn) + ggtitle('Faecalibacterium prausnitzii (62201)')

fig_s7_39 = compare_core_accessory_sfs_syn_ns(f_prausnitzii_61481_FD_core_folded,
  f_prausnitzii_61481_FD_core_nonsyn,
  f_prausnitzii_61481_FD_accessory_folded,
  f_prausnitzii_61481_FD_accessory_nonsyn) + ggtitle('Faecalibacterium prausnitzii (61481)')

png("../Supplement/Supplemental_Figure_7.jpg", width = 800, height = 20000)
# 1200 x 2800 dimensions of saved image
fig_s7_1 +
  fig_s7_2 +
  fig_s7_3 +
  fig_s7_4 +
  fig_s7_5 +
  fig_s7_6 +
  fig_s7_7 +
  fig_s7_8 +
  fig_s7_9 +
  fig_s7_10 +
  fig_s7_11 +
  fig_s7_12 +
  fig_s7_13 +
  fig_s7_14 +
  fig_s7_15 +
  fig_s7_16 +
  fig_s7_17 +
  fig_s7_18 +
  fig_s7_19 +
  fig_s7_20 +
  fig_s7_21 +
  fig_s7_22 +
  fig_s7_23 +
  fig_s7_24 +
  fig_s7_25 +
  fig_s7_26 +
  fig_s7_27 +
  fig_s7_28 +
  fig_s7_29 +
  fig_s7_30 +
  fig_s7_31 +
  fig_s7_32 +
  fig_s7_33 +
  fig_s7_34 +
  fig_s7_35 +
  fig_s7_36 +
  fig_s7_37 +
  fig_s7_38 +
  fig_s7_39 +
  plot_layout(ncol=1)
dev.off()

# Supplemental Figure 8

# Supplemental Figure 9
shared_species_list = FD_accessory_phylogenetic_levels

supplementary_demography_df = data.frame(species=supplementary_species_list,
  nu_mle = numeric(39),
  time_mle = numeric(39)
)

for (i in 1:length(supplementary_species_list)) {
  # nu_mle
  supplementary_demography_df[i, 2] = return_nu_mle(core_likelihood_surface_file_list[i])
  # tau_mle
  supplementary_demography_df[i, 3] = return_time_mle(core_likelihood_surface_file_list[i],
    core_synonymous_sfs_file_list[i],
    core_two_epoch_file_list[i])
}

supplementary_demography_df

fd_accessory_likelihood_surface_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_likelihood_surface.csv'
)

fd_accessory_sfs_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_empirical_syn_downsampled_sfs.txt'
)

fd_accessory_demography_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt'
)

accessory_demography_df = data.frame(species=shared_species_list,
  nu_mle = numeric(18),
  time_mle = numeric(18)
)

for (i in 1:length(shared_species_list)) {
  # nu_mle
  accessory_demography_df[i, 2] = return_nu_mle(fd_accessory_likelihood_surface_list[i])
  # tau_mle
  accessory_demography_df[i, 3] = return_time_mle(fd_accessory_likelihood_surface_list[i],
    fd_accessory_sfs_list[i],
    fd_accessory_demography_list[i])
}

accessory_demography_df

options(ggrepel.max.overlaps = Inf)

supplementary_demography_scatter = ggscatter(supplementary_demography_df, x="nu_mle", y="time_mle", color='species', size=3) +
  ylab('Estimated time in years since most recent demographic event') +
  xlab(nu_label_text) +
  geom_vline(xintercept=1.0, color='red', linewidth=1, linetype='dashed') +
  scale_shape_manual(name = "Best-Fit Demographic Model",
                     labels = c("Three Epoch", "Two Epoch"),
                     values = c(17, 19)) +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=3) +
  guides(color=guide_legend(title="Species")) +
  scale_x_log10(limits=c(1e-2, 2e5)) +
  scale_y_log10(limits=c(2e2, 1e7)) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16))

supplementary_demography_scatter

temp_supp_df = supplementary_demography_df[which(supplementary_demography_df$species %in% shared_species_list), ]

temp_supplementary_demography_scatter = ggscatter(temp_supp_df, x="nu_mle", y="time_mle", color='species', size=3) +
  ylab('Estimated time in years since most recent demographic event') +
  xlab(nu_label_text) +
  geom_vline(xintercept=1.0, color='red', linewidth=1, linetype='dashed') +
  scale_shape_manual(name = "Best-Fit Demographic Model",
                     labels = c("Three Epoch", "Two Epoch"),
                     values = c(17, 19)) +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  guides(color=guide_legend(title="Species")) +
  scale_x_log10(limits=c(1e-2, 2e5)) +
  scale_y_log10(limits=c(2e2, 1e7)) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16))

temp_supplementary_demography_scatter

plot_build <- ggplot_build(temp_supplementary_demography_scatter)
color_mapping <- plot_build$data[[1]]$colour
print(color_mapping)

difference_plot =
  temp_supplementary_demography_scatter +
  geom_segment(aes(x=temp_supp_df$nu_mle, y=temp_supp_df$time_mle,
    xend=accessory_demography_df$nu_mle, yend=accessory_demography_df$time_mle),
    linejoin='round',
    lineend='round',
    linetype=1,
    color=color_mapping,
    arrow = arrow(length=unit(0.2, 'cm'))) +
  # geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  ggtitle('Core gene to accessory gene demography')

difference_plot

# png("../Supplement/Supplemental_Figure_9.jpg", width = 800, height = 750)
# # 800 x 750 dimensions of saved image
# difference_plot
# dev.off()

# Supplemental Figure 10

# # FD DFE comparison (core)

a_muciniphila_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt') + ggtitle('A. muciniphila, core genes')
a_finegoldii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt') + ggtitle('A. finegoldii, core genes')
a_onderdonkii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt') + ggtitle('A. onderdonkii, core genes')
a_putredinis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt') + ggtitle('A. putredinis, core genes')
a_shahii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt') + ggtitle('A. shahii, core genes')
alistipes_sp_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt') + ggtitle('Alistipes sp., core genes')
b_bacterium_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt') + ggtitle('B. bacterium, core genes') + theme(plot.title = element_text(colour = "red"))
b_caccae_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt') + ggtitle('B. caccae, core genes') + theme(plot.title = element_text(colour = "red"))
b_cellulosilyticus_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt') + ggtitle('B. cellulosilyticus, core genes') + theme(plot.title = element_text(colour = "red"))
b_coprocola_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt') + ggtitle('B. coprocola, core genes')
b_eggerthii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt') + ggtitle('B. eggerthii, core genes')
b_fragilis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt') + ggtitle('B. fragilis, core genes')
b_massiliensis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt') + ggtitle('B. massiliensis, core genes')
b_plebeius_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt') + ggtitle('B. plebeius, core genes')
b_stercoris_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt') + ggtitle('B. stercoris, core genes')
b_thetaiotaomicron_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt') + ggtitle('B. thetaiotaomicron, core genes') + theme(plot.title = element_text(colour = "red"))
b_uniformis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt') + ggtitle('B. uniformis, core genes')
b_vulgatus_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt') + ggtitle('B. vulgatus, core genes') + theme(plot.title = element_text(colour = "red"))
b_xylanisolvens_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt') + ggtitle('B. xylanisolvens, core genes')
b_intestinihominis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt') + ggtitle('B. intestinihominis, core genes')
coprococcus_sp_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt') + ggtitle('Coprococcus sp., core genes')
d_invisus_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt') + ggtitle('D. invisus, core genes')
e_eligens_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt') + ggtitle('E. eligens, core genes')
e_rectale_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt') + ggtitle('E. rectale, core genes')
e_siraeum_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt') + ggtitle('E. siraeum, core genes')
f_prausnitzii_57453_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt') + ggtitle('F. prausnitzii (57453), core genes')
f_prausnitzii_61481_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt') + ggtitle('F. prausnitzii (61481), core genes')
f_prausnitzii_62201_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt') + ggtitle('F. prausnitzii (62201), core genes')
l_bacterium_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt') + ggtitle('L. bacterium, core genes')
o_splanchnicus_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt') + ggtitle('O. splanchnicus, core genes')
oscillibacter_sp_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt') + ggtitle('Oscillibacter sp., core genes')
p_distasonis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt') + ggtitle('P. distasonis, core genes') + theme(plot.title = element_text(colour = "red"))
p_merdae_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt') + ggtitle('P. merdae, core genes')
phascolarctobacterium_sp_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt') + ggtitle('Phascolarctobacterium sp., core genes')
p_copri_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt') + ggtitle('P. copri, core genes')
r_intestinalis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt') + ggtitle('R. intestinalis, core genes')
r_inulinivorans_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt') + ggtitle('R. inulinivorans, core genes')
r_bicirculans_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt') + ggtitle('R. bicirculans, core genes')
r_bromii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt') + ggtitle('R. bromii, core genes')

a_muciniphila_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt') + ggtitle('A. muciniphila, accessory genes')
a_finegoldii_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt') + ggtitle('A. finegoldii, accessory genes')
a_onderdonkii_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt') + ggtitle('A. onderdonkii, accessory genes')
a_putredinis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt') + ggtitle('A. putredinis, accessory genes')
a_shahii_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt') + ggtitle('A. shahii, accessory genes')
alistipes_sp_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt') + ggtitle('Alistipes sp., accessory genes')
b_bacterium_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt') + ggtitle('B. bacterium, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_caccae_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt') + ggtitle('B. caccae, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_cellulosilyticus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt') + ggtitle('B. cellulosilyticus, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_coprocola_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt') + ggtitle('B. coprocola, accessory genes')
b_eggerthii_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt') + ggtitle('B. eggerthii, accessory genes')
b_fragilis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt') + ggtitle('B. fragilis, accessory genes')
b_massiliensis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt') + ggtitle('B. massiliensis, accessory genes')
b_plebeius_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt') + ggtitle('B. plebeius, accessory genes')
b_stercoris_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt') + ggtitle('B. stercoris, accessory genes')
b_thetaiotaomicron_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt') + ggtitle('B. thetaiotaomicron, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_uniformis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt') + ggtitle('B. uniformis, accessory genes')
b_vulgatus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt') + ggtitle('B. vulgatus, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_xylanisolvens_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt') + ggtitle('B. xylanisolvens, accessory genes')
b_intestinihominis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt') + ggtitle('B. intestinihominis, accessory genes')
coprococcus_sp_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt') + ggtitle('Coprococcus sp., accessory genes')
d_invisus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt') + ggtitle('D. invisus, accessory genes')
e_eligens_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt') + ggtitle('E. eligens, accessory genes')
e_rectale_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt') + ggtitle('E. rectale, accessory genes')
e_siraeum_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt') + ggtitle('E. siraeum, accessory genes')
f_prausnitzii_57453_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt') + ggtitle('F. prausnitzii (57453), accessory genes')
f_prausnitzii_61481_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt') + ggtitle('F. prausnitzii (61481), accessory genes')
f_prausnitzii_62201_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt') + ggtitle('F. prausnitzii (62201), accessory genes')
l_bacterium_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt') + ggtitle('L. bacterium, accessory genes')
o_splanchnicus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt') + ggtitle('Oscillibacter sp., accessory genes')
oscillibacter_sp_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt') + ggtitle('Oscillibacter sp., accessory genes')
p_distasonis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt') + ggtitle('P. distasonis, accessory genes') + theme(plot.title = element_text(colour = "red"))
p_merdae_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt') + ggtitle('P. merdae, accessory genes') + theme(plot.title = element_text(colour = "red"))
phascolarctobacterium_sp_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt') + ggtitle('Phascolarctobacterium sp., accessory genes')
p_copri_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt') + ggtitle('P. copri, accessory genes')
r_intestinalis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt') + ggtitle('R. intestinalist, accessory genes')
r_inulinivorans_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt') + ggtitle('R. inulinivorans, accessory genes')
r_bicirculans_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt') + ggtitle('R. bicirculans, accessory genes')
r_bromii_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt') + ggtitle('R. bromii, accessory genes')

FD_core_accessory_DFE_reduced = a_putredinis_fd_core_dfe_plot + a_finegoldii_fd_core_dfe_plot +
  a_putredinis_fd_accessory_dfe_plot + a_finegoldii_fd_accessory_dfe_plot +
  a_onderdonkii_fd_core_dfe_plot + a_shahii_fd_core_dfe_plot +
  a_onderdonkii_fd_accessory_dfe_plot + a_shahii_fd_accessory_dfe_plot +
  b_bacterium_fd_core_dfe_plot + p_distasonis_fd_core_dfe_plot +
  b_bacterium_fd_accessory_dfe_plot + p_distasonis_fd_accessory_dfe_plot +
  p_merdae_fd_core_dfe_plot + b_cellulosilyticus_fd_core_dfe_plot +
  p_merdae_fd_accessory_dfe_plot + b_cellulosilyticus_fd_accessory_dfe_plot +
  b_stercoris_fd_core_dfe_plot + b_thetaiotaomicron_fd_core_dfe_plot +
  b_stercoris_fd_accessory_dfe_plot + b_thetaiotaomicron_fd_accessory_dfe_plot +
  b_caccae_fd_core_dfe_plot + b_massiliensis_fd_core_dfe_plot +
  b_caccae_fd_accessory_dfe_plot + b_massiliensis_fd_accessory_dfe_plot +
  b_vulgatus_fd_core_dfe_plot + d_invisus_fd_core_dfe_plot +
  b_vulgatus_fd_accessory_dfe_plot + d_invisus_fd_accessory_dfe_plot +
  e_eligens_fd_core_dfe_plot + e_rectale_fd_core_dfe_plot +
  e_eligens_fd_accessory_dfe_plot + e_rectale_fd_accessory_dfe_plot +
  e_siraeum_fd_core_dfe_plot + r_bromii_fd_core_dfe_plot +
  e_siraeum_fd_accessory_dfe_plot + r_bromii_fd_accessory_dfe_plot +
  plot_layout(ncol=2)

ggsave(filename='../Supplement/Supplemental_Figure_10.jpg', 
  plot=FD_core_accessory_DFE_reduced, 
  width=20, height=40, units="in", limitsize=FALSE, dpi=300)

# Supplemental Figure 11
N_anc = table_s3$`Two.epoch..Ancestral.effective.population.size`

N_curr_low = nu_tau_distribution$`nu_low` * N_anc
N_curr_high = nu_tau_distribution$`nu_high` * N_anc
N_curr_MLE = nu_tau_distribution$`nu_mle` * N_anc

N_curr_data = data.frame(
  species=FD_phylogenetic_levels,
  N_curr_MLE = N_curr_MLE,
  N_curr_low = N_curr_low,
  N_curr_high = N_curr_high
)

N_curr_label = expression(N[current])

N_curr_data$species = factor(N_curr_data$species, levels=FD_phylogenetic_levels)

plot_N_curr_distribution = ggplot() +
  geom_linerange(data=N_curr_data, mapping=aes(x=fct_rev(species), ymin=N_curr_low, ymax=N_curr_high, col=species), size=1, show.legend=FALSE) + 
  geom_point(data=N_curr_data, mapping=aes(x=fct_rev(species), y=N_curr_MLE, col=species), size=3, shape=18, show.legend=FALSE) +
  scale_y_log10() +
  coord_flip() +
  theme_bw() +
  xlab('') +
  ylab(N_curr_label) +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(axis.text=element_text(size=16)) +
  theme(axis.title=element_text(size=16,face="bold"))

png("../Supplement/Supplemental_Figure_11A.jpg", width = 800, height = 1200)
# 800 x 1200 dimensions of saved image
plot_N_curr_distribution
dev.off()

# Supplemental Figure 12
# 
# species_list = c('A. muciniphila',
#                  'A. finegoldii',
#                  'A. onderdonkii',
#                  'A. putredinis',
#                  'A. shahii',
#                  'B. bacterium',
#                  'B. caccae',
#                  'B. cellulosilyticus',
#                  'B. fragilis',
#                  'B. ovatus',
#                  'B. stercoris',
#                  'B. thetaiotaomicron',
#                  'B. uniformis',
#                  'B. vulgatus',
#                  'B. xylanisolvens',
#                  'B. intestinihominis',
#                  'D. invisus',
#                  'E. eligens',
#                  'E. rectale',
#                  'F. prausnitzii',
#                  'O. splanchnicus',
#                  'Oscillibacter species',
#                  'P. distasonis',
#                  'P. merdae',
#                  'Phasolarctobacterium species',
#                  'P. copri',
#                  'R. bicirculans',
#                  'R. bromii')
# 
# num_qp_samples = c(25, 45, 62, 41, 58,
#                    31, 35, 35, 31, 
#                    51, 71, 67, 88, 44, 
#                    50, 50, 36, 25, 
#                    74, 30, 32, 47, 40, 
#                    43, 17, 15, 71, 36)
# 
# qp_samples_per_species = data.frame(species_list, as.numeric(num_qp_samples))
# 
# png("../Supplement/Supplemental_Figure_12.jpg", width = 800, height = 1200)

# ggplot(qp_samples_per_species, aes(x = reorder(species_list, num_qp_samples), y = num_qp_samples)) +  geom_bar(stat='identity', fill='grey') +
#   theme(legend.position = "none") +
#   coord_flip() +
#   xlab('Species') +
#   ylab('Number of Quasi-phaseable samples') +
#   ggtitle('Number of Quasi-phaseable samples per species from core genes')  +
#   theme_bw() + theme(panel.border = element_blank(), 
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   theme(legend.position = "none")  +
#   geom_hline(yintercept=14, linetype="dashed", color = "red") +
#   theme(axis.text.y=element_text(face="italic")) +
#   scale_y_continuous(breaks = seq(0, 90, by = 5))
# dev.off()

# Supplemental Figure 13
# accessory_core_demography = data.frame(species=phylogenetic_levels, 
#   core_nu = numeric(39),
#   core_years = numeric(39),
#   core_na = numeric(39),
#   acc_nu = numeric(39),
#   acc_years = numeric(39),
#   acc_na = numeric(39))
# 
# accessory_core_two_epoch_file_list = c(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Prevotella_copri_61740_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Dialister_invisus_61905_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_two_epoch_demography.txt',
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_two_epoch_demography.txt'
# )
# 
# for (i in 1:length(core_two_epoch_file_list)) {
#   accessory_core_demography[i, 2:4] = read_demography_info(core_two_epoch_file_list[i])
#   accessory_core_demography[i, 5:7] = read_demography_info(accessory_core_two_epoch_file_list[i])
# }
# 
# colnames(accessory_core_demography) = c('Species', 
#   'Core, Nu',
#   'Core, Years',
#   'Core, N_anc',
#   'Accessory, Nu',
#   'Accessory, Years',
#   'Accessory, N_Anc')

# write.csv(accessory_core_demography, '../Summary/accessory_core_demography_comparison.csv', row.names=FALSE)

# accessory_core_demography$`Accessory, N_Anc`
# accessory_core_demography[c(7, 13, 14, 17, 18, 22, 23, 27), ]
# accessory_core_demography_reduced = accessory_core_demography[c(7, 13, 14, 17, 18, 23, 27), ]
# 
# accessory_core_demography_reduced$`Core, N_anc`
# accessory_core_demography_reduced$`Accessory, N_Anc`
# 
# accessory_core_demography_scatter = ggscatter(accessory_core_demography_reduced, x="Core, N_anc", y="Accessory, N_Anc", color="Species", shape=18, size=4) +
#   ylab('Estimated current effective population size') +
#   xlab('species accessory_core_demography') +
#   geom_text_repel(aes(label = Species, color=Species, fontface = 'italic'), size=3) +
#   guides(color=guide_legend(title="species")) +
#   theme(legend.position = 'none') +
#   guides(color = 'none') +
#   guides(shape = 'none')  +
#   theme(axis.text=element_text(size=12),
#     axis.title=element_text(size=16)) +
#   ylim(0, 3E7) +
#   xlim(0, 3E7) +
#   xlab('Ancestral effective population size, Accessory genes') +
#   ylab('Ancestral effective population size, Core genes') +
#   geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed")
# 
# png("../Supplement/Supplemental_Figure_13.jpg", width = 800, height = 800)
# accessory_core_demography_scatter
# dev.off()

# Supplemental Figure SA

dfe_comparison_matrix = read.table('../SupplementaryAnalysis/cross_species_dfe/dfe_comparison_matrix.csv', header=TRUE, row.names=NULL, sep=',')[, -c(1)]

FD_alistipes = c(2, 3, 4, 5, 6)
FD_bacteroides = c(8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)
FD_eubacterium = c(23, 24, 25)
FD_faecalibacterium = c(26, 27, 28)
FD_parabacteroides = c(32, 33)
FD_roseburia = c(36, 37)
FD_ruminococcus = c(38, 39)

core_2ns_within_genera_LRT = c()
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_alistipes, FD_alistipes][lower.tri(dfe_comparison_matrix[FD_alistipes, FD_alistipes])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_bacteroides, FD_bacteroides][lower.tri(dfe_comparison_matrix[FD_bacteroides, FD_bacteroides])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_eubacterium, FD_eubacterium][lower.tri(dfe_comparison_matrix[FD_eubacterium, FD_eubacterium])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium][lower.tri(dfe_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_parabacteroides, FD_parabacteroides][lower.tri(dfe_comparison_matrix[FD_parabacteroides, FD_parabacteroides])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_roseburia, FD_roseburia][lower.tri(dfe_comparison_matrix[FD_roseburia, FD_roseburia])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_ruminococcus, FD_ruminococcus][lower.tri(dfe_comparison_matrix[FD_ruminococcus, FD_ruminococcus])])
length(core_2ns_within_genera_LRT) # 85 total within-genera comparisons
sum(core_2ns_within_genera_LRT > 19.20747) # 40 within genera are significant

core_2ns_between_genera_LRT = dfe_comparison_matrix[lower.tri(dfe_comparison_matrix)][!dfe_comparison_matrix[lower.tri(dfe_comparison_matrix)] %in% core_2ns_within_genera_LRT]

LRT_list <- melt(list(within_genera = core_2ns_within_genera_LRT, between_genera = core_2ns_between_genera_LRT))

mean(core_2ns_within_genera_LRT)
mean(core_2ns_between_genera_LRT)

between_within_mean_diff = mean(core_2ns_between_genera_LRT) - mean(core_2ns_within_genera_LRT)

set.seed(1)
LRT_scramble_within_genera = sample(LRT_list$value, size=85, replace=FALSE)
LRT_scramble_between_genera = sample(LRT_list$value, size=656, replace=FALSE)

LRT_list <- melt(
  list(
    within_genera = core_2ns_within_genera_LRT, between_genera = core_2ns_between_genera_LRT, scrambled_within = LRT_scramble_within_genera, scrambled_between = LRT_scramble_between_genera
  )
)

LRT_list$L1 = factor(LRT_list$L1, levels=c('between_genera', 'within_genera', 'scrambled_between', 'scrambled_within'))

comparison_1 = list(c("within_genera", "between_genera"))
comparison_2 = list(c("scrambled_between", "scrambled_within"))
comparison_3 = list(c("between_genera", "scrambled_between"))
comparison_4 = list(c("within_genera", "scrambled_within"))

my_comparisons <- list( c("within_genera", "between_genera"), 
  c("scrambled_between", "scrambled_within")
)

my_other_comparisons <- list( c("between_genera", "scrambled_between"),
  c("within_genera", "scrambled_within"))

vertical_adjustments = c(0, -0.25, -0.5, -0.75)

mean_s_file_list = c(
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt'
)

# 
mean_s_comparison_matrix = matrix(, nrow=39, ncol=39)

for (i in 1:39) {
  for (j in i:39) {  # This change ensures only the upper right triangle is compared
    mean_i = compute_selection_coefficients(mean_s_file_list[i])[1]
    mean_j = compute_selection_coefficients(mean_s_file_list[j])[1]
    comparison = abs(mean_i - mean_j)
    mean_s_comparison_matrix[i, j] = comparison
    mean_s_comparison_matrix[j, i] = comparison  # Mirror the value across the diagonal
  }
}

core_within_genera_mean_s = c()
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_alistipes, FD_alistipes][lower.tri(mean_s_comparison_matrix[FD_alistipes, FD_alistipes])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_bacteroides, FD_bacteroides][lower.tri(mean_s_comparison_matrix[FD_bacteroides, FD_bacteroides])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_eubacterium, FD_eubacterium][lower.tri(mean_s_comparison_matrix[FD_eubacterium, FD_eubacterium])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium][lower.tri(mean_s_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_parabacteroides, FD_parabacteroides][lower.tri(mean_s_comparison_matrix[FD_parabacteroides, FD_parabacteroides])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_roseburia, FD_roseburia][lower.tri(mean_s_comparison_matrix[FD_roseburia, FD_roseburia])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_ruminococcus, FD_ruminococcus][lower.tri(mean_s_comparison_matrix[FD_ruminococcus, FD_ruminococcus])])
length(core_within_genera_mean_s) # 85 total within-genera comparisons

core_between_genera_mean_s = mean_s_comparison_matrix[lower.tri(mean_s_comparison_matrix)][!mean_s_comparison_matrix[lower.tri(mean_s_comparison_matrix)] %in% core_within_genera_mean_s]

mean_s_list <- melt(list(within_genera = core_within_genera_mean_s, between_genera = core_between_genera_mean_s))

between_within_mean_s_diff = abs(mean(core_between_genera_mean_s) - mean(core_within_genera_mean_s))

set.seed(1)
mean_s_scramble_within_genera = sample(mean_s_list$value, size=85, replace=FALSE)
mean_s_scramble_between_genera = sample(mean_s_list$value, size=656, replace=FALSE)

mean_s_list <- melt(
  list(
    within_genera = core_within_genera_mean_s, between_genera = core_between_genera_mean_s, scrambled_within = mean_s_scramble_within_genera, scrambled_between = mean_s_scramble_between_genera
  )
)


mean_s_list$L1 = factor(mean_s_list$L1, levels=c('between_genera', 'within_genera', 'scrambled_between', 'scrambled_within'))


mean_2ns_demography_list = c(
  '../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt'
)

mean_2ns_dfe_list = c(
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt'
)

mean_2ns_comparison_matrix = matrix(, nrow=39, ncol=39)

for (i in 1:39) {
  for (j in i:39) {  # This change ensures only the upper right triangle is compared
    mean_i = compute_selection_coefficients(mean_2ns_dfe_list[i])[1]
    mean_j = compute_selection_coefficients(mean_2ns_dfe_list[j])[1]
    nanc_i = nanc_from_demography(mean_2ns_demography_list[i])
    nanc_j = nanc_from_demography(mean_2ns_demography_list[j])
    mean_2ns_i = 2 * mean_i * nanc_i
    mean_2ns_j = 2 * mean_j * nanc_j
    comparison = abs(mean_2ns_i - mean_2ns_j)
    mean_2ns_comparison_matrix[i, j] = comparison
    mean_2ns_comparison_matrix[j, i] = comparison  # Mirror the value across the diagonal
  }
}

core_within_genera_mean_2ns = c()
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_alistipes, FD_alistipes][lower.tri(mean_2ns_comparison_matrix[FD_alistipes, FD_alistipes])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_bacteroides, FD_bacteroides][lower.tri(mean_2ns_comparison_matrix[FD_bacteroides, FD_bacteroides])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_eubacterium, FD_eubacterium][lower.tri(mean_2ns_comparison_matrix[FD_eubacterium, FD_eubacterium])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium][lower.tri(mean_2ns_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_parabacteroides, FD_parabacteroides][lower.tri(mean_2ns_comparison_matrix[FD_parabacteroides, FD_parabacteroides])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_roseburia, FD_roseburia][lower.tri(mean_2ns_comparison_matrix[FD_roseburia, FD_roseburia])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_ruminococcus, FD_ruminococcus][lower.tri(mean_2ns_comparison_matrix[FD_ruminococcus, FD_ruminococcus])])
length(core_within_genera_mean_2ns) # 85 total within-genera comparisons

core_between_genera_mean_2ns = mean_2ns_comparison_matrix[lower.tri(mean_2ns_comparison_matrix)][!mean_2ns_comparison_matrix[lower.tri(mean_2ns_comparison_matrix)] %in% core_within_genera_mean_2ns]

mean_2ns_list <- melt(list(within_genera = core_within_genera_mean_2ns, between_genera = core_between_genera_mean_2ns))

between_within_mean_2ns_diff = abs(mean(core_between_genera_mean_2ns) - mean(core_within_genera_mean_2ns))

# permutation_mean_2ns_diff = numeric(100000)
# 
# for (i in 1:100000) {
#   this_scramble_between = sample(mean_2ns_list$value, size=656, replace=FALSE)
#   this_scramble_within = sample(mean_2ns_list$value, size=85, replace=FALSE)
#   permutation_mean_2ns_diff[i] = abs(mean(this_scramble_between) - mean(this_scramble_within))
# }

# permutation_mean_2ns_data = data.frame(permutation_mean_2ns_diff)
#
# names(permutation_mean_2ns_data) = c('value')
#
# sum(between_within_mean_2ns_diff > permutation_mean_2ns_data) / 100000
#
# quantile_label = "Proportion of area:"
#
# quantile_label = paste(quantile_label, sum(between_within_mean_2ns_diff > permutation_mean_2ns_data) / 100000, sep=' ')
#
# permutation_mean_2ns = ggplot(permutation_mean_2ns_data, aes(x=value, y=..count..)) +
#   geom_histogram(bins=100) +
#   xlab('Absolute difference of mean population-scale selection coefficient') +
#   ylab('Number of simulations') +
#   geom_vline(xintercept = between_within_mean_2ns_diff, color='green', linetype='dotted', linewidth=3) +
#   theme_minimal() +
#   ggtitle('Simulated difference of mean population-scaled selection coefficients') +
#   annotate("text", x=3E6, y=3500, label= quantile_label, size=5) +
#   theme(axis.title=element_text(size=18)) +
#   theme(plot.title=element_text(size=20))
#
# ggsave('../Summary/permutation_mean_2ns.svg', permutation_mean_2ns, width=18, height=12, dpi=600)

set.seed(1)
mean_2ns_scramble_within_genera = sample(mean_2ns_list$value, size=85, replace=FALSE)
mean_2ns_scramble_between_genera = sample(mean_2ns_list$value, size=656, replace=FALSE)

mean_2ns_list <- melt(
  list(
    within_genera = core_within_genera_mean_2ns, between_genera = core_between_genera_mean_2ns, scrambled_within = mean_2ns_scramble_within_genera, scrambled_between = mean_2ns_scramble_between_genera
  )
)
#
mean_2ns_list$L1 = factor(mean_2ns_list$L1, levels=c('between_genera', 'within_genera', 'scrambled_between', 'scrambled_within'))

LRT_distribution = ggplot(LRT_list, aes(x=L1, y=value, fill=L1)) +
  geom_boxplot() +
  ylab('LRT statistic') +
  xlab('') +
  scale_fill_manual(labels=c('Between-genera', 'Within-genera', 'Permutation test (within)', 'Permutation test (between)'),
    breaks=c('between_genera', 'within_genera', 'scrambled_within', 'scrambled_between'),
    values=c("#69b3a2", "#95fd34", 'black', 'grey'),) +
  theme_minimal() +
  theme(axis.text.x=element_blank(),) +
  guides(fill=guide_legend(title="Type of DFE comparison")) +
  ggtitle('LRT statistics for between-genera and within-genera DFE comparisons') +
  geom_abline(intercept=19.20747, color='red', linetype='dashed') +
  geom_signif(position='identity', size=1, y_position=750, textsize=6,
    comparisons = comparison_1,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1, y_position=850, textsize=6,
    comparisons = comparison_2,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', 
    comparisons = comparison_3, size=1, y_position=800, textsize=6,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=2,
    comparisons = comparison_4, y_position=900, textsize=6,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  theme(axis.title=element_text(size=22)) +
  theme(plot.title=element_text(size=24)) +
  theme(legend.title=element_text(size=22)) +
  theme(legend.text=element_text(size=22)) +
  theme(axis.text = element_text(size=18))

mean_s_LRT_distribution = ggplot(mean_s_list, aes(x=L1, y=value, fill=L1)) +
  geom_boxplot() +
  ylab('Absolute value of difference') +
  xlab('') +
  scale_fill_manual(labels=c('Between-genera', 'Within-genera', 'Permutation test (within)', 'Permutation test (between)'),
    breaks=c('between_genera', 'within_genera', 'scrambled_within', 'scrambled_between'),
    values=c("#69b3a2", "#95fd34", 'black', 'grey'),) +
  theme_minimal() +
  theme(axis.text.x=element_blank(),) +
  guides(fill=guide_legend(title="Type of DFE comparison")) +
  ggtitle('Absolute difference in mean *s* for between-genera and within-genera DFE comparisons') +
  geom_signif(position='identity', y_position=0.75,
    comparisons = comparison_1, size=1, textsize=6,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', y_position=0.83,
    comparisons = comparison_2, size=1, textsize=6,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1, textsize=6,
    comparisons = comparison_3, y_position=0.91,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1, textsize=6,
    comparisons = comparison_4, y_position=0.99,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  theme(axis.title=element_text(size=22)) +
  theme(plot.title=element_text(size=24)) +
  theme(legend.title=element_text(size=22)) +
  theme(legend.text=element_text(size=22)) +
  theme(axis.text = element_text(size=18)) +
  theme(plot.title = ggtext::element_markdown())

mean_2ns_LRT_distribution = ggplot(mean_2ns_list, aes(x=L1, y=value, fill=L1)) +
  geom_boxplot() +
  ylab('Absolute value of difference') +
  xlab('Comparison') +
  scale_fill_manual(labels=c('Between-genera', 'Within-genera', 'Permutation test (within)', 'Permutation test (between)'),
    breaks=c('between_genera', 'within_genera', 'scrambled_within', 'scrambled_between'),
    values=c("#69b3a2", "#95fd34", 'black', 'grey'),) +
  theme_minimal() +
  theme(axis.text.x=element_blank(),) +
  guides(fill=guide_legend(title="Type of DFE comparison")) +
  ggtitle('Absolute difference in mean *2N~Anc~s* for between-genera and within-genera DFE comparisons') +
  geom_signif(position='identity', y_position=7E7,
    comparisons = comparison_1, size=1, textsize=6,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1, y_position=7.5E7, textsize=6,
    comparisons = comparison_2,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1, textsize=6,
    comparisons = comparison_3, y_position=8E7,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1, textsize=6,
    comparisons = comparison_4, y_position=8.5E7,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  theme(axis.title=element_text(size=22)) +
  theme(plot.title=element_text(size=24)) +
  theme(legend.title=element_text(size=22)) +
  theme(legend.text=element_text(size=22)) +
  theme(axis.text = element_text(size=18)) +
  theme(plot.title = ggtext::element_markdown())


LRT_box_and_whiskers = LRT_distribution + 
  mean_s_LRT_distribution + theme(legend.position = 'none') +
  mean_2ns_LRT_distribution + theme(legend.position = 'none') + plot_layout(ncol=1)

ggsave('../Supplement/Supplemental_Figure_SB_output.svg', LRT_box_and_whiskers, width=16, height=20, dpi=600)

