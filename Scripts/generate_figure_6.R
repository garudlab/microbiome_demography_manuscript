setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# # FD DFE comparison (core)

a_muciniphila_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt') + ggtitle('A. muciniphila, core genes')
a_finegoldii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt') + ggtitle('A. finegoldii, core genes')
a_onderdonkii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt') + ggtitle('A. onderdonkii, core genes')
a_putredinis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt') + ggtitle('A. putredinis, core genes')
a_shahii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt') + ggtitle('A. shahii, core genes')
alistipes_sp_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt') + ggtitle('Alistipes sp., core genes')
b_bacterium_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt') + ggtitle('B. bacterium, core genes')
b_caccae_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt') + ggtitle('B. caccae, core genes')
b_cellulosilyticus_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt') + ggtitle('B. cellulosilyticus, core genes')
b_coprocola_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt') + ggtitle('B. coprocola, core genes')
b_eggerthii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt') + ggtitle('B. eggerthii, core genes')
b_fragilis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt') + ggtitle('B. fragilis, core genes')
b_massiliensis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt') + ggtitle('B. massiliensis, core genes')
b_plebeius_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt') + ggtitle('B. plebeius, core genes')
b_stercoris_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt') + ggtitle('B. stercoris, core genes')
b_thetaiotaomicron_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt') + ggtitle('B. thetaiotaomicron, core genes')
b_uniformis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt') + ggtitle('B. uniformis, core genes')
b_vulgatus_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt') + ggtitle('B. vulgatus, core genes')
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
p_distasonis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt') + ggtitle('P. distasonis, core genes')
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
b_bacterium_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt') + ggtitle('B. bacterium, accessory genes')
b_caccae_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt') + ggtitle('B. caccae, accessory genes')
b_cellulosilyticus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt') + ggtitle('B. cellulosilyticus, accessory genes')
b_coprocola_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt') + ggtitle('B. coprocola, accessory genes')
b_eggerthii_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt') + ggtitle('B. eggerthii, accessory genes')
b_fragilis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt') + ggtitle('B. fragilis, accessory genes')
b_massiliensis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt') + ggtitle('B. massiliensis, accessory genes')
b_plebeius_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt') + ggtitle('B. plebeius, accessory genes')
b_stercoris_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt') + ggtitle('B. stercoris, accessory genes')
b_thetaiotaomicron_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt') + ggtitle('B. thetaiotaomicron, accessory genes')
b_uniformis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt') + ggtitle('B. uniformis, accessory genes')
b_vulgatus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt') + ggtitle('B. vulgatus, accessory genes')
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
o_splanchnicus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt') + ggtitle('O. splanchnicus, accessory genes')
oscillibacter_sp_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt') + ggtitle('Phascolarctobacterium sp., accessory genes')
p_distasonis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt') + ggtitle('P. copri, accessory genes')
p_merdae_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt') + ggtitle('R. intestinalis, accessory genes')
phascolarctobacterium_sp_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt') + ggtitle('R. inulinivorans, accessory genes')
p_copri_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt') + ggtitle('P. copri, accessory genes')
r_intestinalis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt') + ggtitle('R. bicirculans, accessory genes')
r_inulinivorans_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt') + ggtitle('R. bromii, accessory genes')
r_bicirculans_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt') + ggtitle('R. bicirculans, accessory genes')
r_bromii_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt') + ggtitle('R. bromii, accessory genes')

# # FD DFE comparison (core, dadi scaling)

a_muciniphila_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt') + ggtitle('A. muciniphila, core genes')
a_finegoldii_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt') + ggtitle('A. finegoldii, core genes')
a_onderdonkii_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt') + ggtitle('A. onderdonkii, core genes')
a_putredinis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt') + ggtitle('A. putredinis, core genes')
a_shahii_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt') + ggtitle('A. shahii, core genes')
alistipes_sp_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt') + ggtitle('Alistipes sp., core genes')
b_bacterium_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt') + ggtitle('B. bacterium, core genes')
b_caccae_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt') + ggtitle('B. caccae, core genes')
b_cellulosilyticus_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt') + ggtitle('B. cellulosilyticus, core genes')
b_coprocola_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt') + ggtitle('B. coprocola, core genes')
b_eggerthii_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt') + ggtitle('B. eggerthii, core genes')
b_fragilis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt') + ggtitle('B. fragilis, core genes')
b_massiliensis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt') + ggtitle('B. massiliensis, core genes')
b_plebeius_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt') + ggtitle('B. plebeius, core genes')
b_stercoris_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt') + ggtitle('B. stercoris, core genes')
b_thetaiotaomicron_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt') + ggtitle('B. thetaiotaomicron, core genes')
b_uniformis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt') + ggtitle('B. uniformis, core genes')
b_vulgatus_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt') + ggtitle('B. vulgatus, core genes')
b_xylanisolvens_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt') + ggtitle('B. xylanisolvens, core genes')
b_intestinihominis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt') + ggtitle('B. intestinihominis, core genes')
coprococcus_sp_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt') + ggtitle('Coprococcus sp., core genes')
d_invisus_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt') + ggtitle('D. invisus, core genes')
e_eligens_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt') + ggtitle('E. eligens, core genes')
e_rectale_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt') + ggtitle('E. rectale, core genes')
e_siraeum_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt') + ggtitle('E. siraeum, core genes')
f_prausnitzii_57453_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt') + ggtitle('F. prausnitzii (57453), core genes')
f_prausnitzii_61481_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt') + ggtitle('F. prausnitzii (61481), core genes')
f_prausnitzii_62201_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt') + ggtitle('F. prausnitzii (62201), core genes')
l_bacterium_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt') + ggtitle('L. bacterium, core genes')
o_splanchnicus_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt') + ggtitle('O. splanchnicus, core genes')
oscillibacter_sp_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt') + ggtitle('Oscillibacter sp., core genes')
p_distasonis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt') + ggtitle('P. distasonis, core genes')
p_merdae_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt') + ggtitle('P. merdae, core genes')
phascolarctobacterium_sp_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt') + ggtitle('Phascolarctobacterium sp., core genes')
p_copri_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt') + ggtitle('P. copri, core genes')
r_intestinalis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt') + ggtitle('R. intestinalis, core genes')
r_inulinivorans_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt') + ggtitle('R. inulinivorans, core genes')
r_bicirculans_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt') + ggtitle('R. bicirculans, core genes')
r_bromii_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt') + ggtitle('R. bromii, core genes')

a_muciniphila_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_two_epoch_demography.txt') + ggtitle('A. muciniphila, accessory genes')
a_finegoldii_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_two_epoch_demography.txt') + ggtitle('A. finegoldii, accessory genes')
a_onderdonkii_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_two_epoch_demography.txt') + ggtitle('A. onderdonkii, accessory genes')
a_putredinis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_two_epoch_demography.txt') + ggtitle('A. putredinis, accessory genes')
a_shahii_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_two_epoch_demography.txt') + ggtitle('A. shahii, accessory genes')
alistipes_sp_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/accessory_two_epoch_demography.txt') + ggtitle('Alistipes sp., accessory genes')
b_bacterium_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt') + ggtitle('B. bacterium, accessory genes')
b_caccae_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt') + ggtitle('B. caccae, accessory genes')
b_cellulosilyticus_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt') + ggtitle('B. cellulosilyticus, accessory genes')
b_coprocola_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_two_epoch_demography.txt') + ggtitle('B. coprocola, accessory genes')
b_eggerthii_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_two_epoch_demography.txt') + ggtitle('B. eggerthii, accessory genes')
b_fragilis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_two_epoch_demography.txt') + ggtitle('B. fragilis, accessory genes')
b_massiliensis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_two_epoch_demography.txt') + ggtitle('B. massiliensis, accessory genes')
b_plebeius_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_two_epoch_demography.txt') + ggtitle('B. plebeius, accessory genes')
b_stercoris_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt') + ggtitle('B. stercoris, accessory genes')
b_thetaiotaomicron_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt') + ggtitle('B. thetaiotaomicron, accessory genes')
b_uniformis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_two_epoch_demography.txt') + ggtitle('B. uniformis, accessory genes')
b_vulgatus_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt') + ggtitle('B. vulgatus, accessory genes')
b_xylanisolvens_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_two_epoch_demography.txt') + ggtitle('B. xylanisolvens, accessory genes')
b_intestinihominis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_two_epoch_demography.txt') + ggtitle('B. intestinihominis, accessory genes')
coprococcus_sp_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_two_epoch_demography.txt') + ggtitle('Coprococcus sp., accessory genes')
d_invisus_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt') + ggtitle('D. invisus, accessory genes')
e_eligens_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_two_epoch_demography.txt') + ggtitle('E. eligens, accessory genes')
e_rectale_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_two_epoch_demography.txt') + ggtitle('E. rectale, accessory genes')
e_siraeum_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_two_epoch_demography.txt') + ggtitle('E. siraeum, accessory genes')
f_prausnitzii_57453_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_two_epoch_demography.txt') + ggtitle('F. prausnitzii (57453), accessory genes')
f_prausnitzii_61481_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_two_epoch_demography.txt') + ggtitle('F. prausnitzii (61481), accessory genes')
f_prausnitzii_62201_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_two_epoch_demography.txt') + ggtitle('F. prausnitzii (62201), accessory genes')
l_bacterium_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_two_epoch_demography.txt') + ggtitle('L. bacterium, accessory genes')
o_splanchnicus_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_two_epoch_demography.txt') + ggtitle('O. splanchnicus, accessory genes')
oscillibacter_sp_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_two_epoch_demography.txt') + ggtitle('Oscillibacter sp., accessory genes')
p_distasonis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt') + ggtitle('P. distasonis, accessory genes')
p_merdae_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt') + ggtitle('P. merdae, accessory genes')
phascolarctobacterium_sp_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_two_epoch_demography.txt') + ggtitle('Phascolarctobacterium sp., accessory genes')
p_copri_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/accessory_two_epoch_demography.txt') + ggtitle('P. copri, accessory genes')
r_intestinalis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_two_epoch_demography.txt') + ggtitle('R. intestinalis, accessory genes')
r_inulinivorans_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_two_epoch_demography.txt') + ggtitle('R. inulinivorans, accessory genes')
r_bicirculans_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_two_epoch_demography.txt') + ggtitle('R. bicirculans, accessory genes')
r_bromii_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt') + ggtitle('R. bromii, accessory genes')


figure_6 = FD_core_accessory_DFE_reduced = a_putredinis_fd_core_dfe_plot + a_finegoldii_fd_core_dfe_plot +
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

ggsave('../Summary/figure_6_output.svg', figure_6, width=10, height=35, units='in', dpi=300, limitsize = FALSE)
