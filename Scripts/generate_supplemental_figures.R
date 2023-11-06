setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

plot_best_fit_sfs = function(input_data) {
  input_data = data.frame(input_data)
  colnames(input_data) = c(
    'Empirical Synonymous', 
    'Model Synonymous',
    'Empirical Nonsynonymous',
    'Model Nonsynonymous',
    'Species',
    'X.axis')
  fig = ggplot(melt(input_data, id=c('Species', 'X.axis')), aes(x=X.axis, y=as.numeric(value), fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    xlab('Minor allele frequency') + 
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    scale_fill_manual(values=c("blue4", "steelblue3", "goldenrod3", "goldenrod1")) +
    # theme(legend.position="none") +
    theme(plot.title = element_text(face = "italic"))
  return(fig)
}

# Supplemental Figure 1

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

table_s3 = read.csv('../Supplement/Supplemental_Table_3.csv')

table_s3$Species = factor(table_s3$Species, levels=phylogenetic_levels_MIDAS)
table_s3 = table_s3[order(table_s3$Species), ]

plot_AIC_table = data.frame(table_s3$Species, table_s3$`Three.epoch..AIC`, table_s3$`Two.epoch..AIC`, table_s3$`One.epoch..AIC`)
names(plot_AIC_table) = c('Species', 'Three-epoch', 'Two-epoch', 'One-epoch')
plot_AIC_table = melt(plot_AIC_table)
names(plot_AIC_table) = c('Species', 'Model', 'AIC')

plot_AIC = ggplot(data=plot_AIC_table) +
  geom_jitter(mapping=aes(x=Species, y=AIC, colour=Model, fill=Model), size=2, shape=21, width = 0.15) +
  scale_y_log10() +
  # coord_flip() +
  theme_bw() +
  xlab('') +
  ylab('Aikake information criteria') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(axis.text=element_text(size=16)) +
  theme(axis.title=element_text(size=16,face="bold")) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

png("../Supplement/Supplemental_Figure_1.png", width = 1200, height = 1200)
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

b_vulgatus_clade_control_downsampled_syn = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_vulgatus_clade_control_downsampled_nonsyn = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')

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

png("../Supplement/Supplemental_Figure_2.png", width = 2400, height = 800)
# 2400 x 800 dimensions for saved image
fig_s2
dev.off()

# Supplemental Figure 3

a_muciniphila_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
a_finegoldii_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
a_onderdonkii_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
a_putredinis_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
a_shahii_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_bacterium_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_caccae_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_cellulosilyticus_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_fragilis_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
# b_massiliensis_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_ovatus_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_stercoris_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_thetaiotaomicron_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_uniformis_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_vulgatus_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_xylanisolvens_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_intestinihominis_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
# c_sp_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Coprococcus_sp_62244_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
d_invisus_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
e_eligens_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
e_rectale_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
f_prausnitzii_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
o_splanchnicus_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
oscillibacter_sp_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
p_distasonis_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
p_merdae_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
phascolarctobacterium_sp_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
p_copri_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Prevotella_copri_61740_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
r_bicirculans_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
r_bromii_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))

a_muciniphila_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
a_finegoldii_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
a_onderdonkii_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
a_putredinis_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
a_shahii_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_bacterium_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_caccae_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_cellulosilyticus_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_fragilis_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
# b_massiliensis_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_ovatus_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_stercoris_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_thetaiotaomicron_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_uniformis_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_vulgatus_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_xylanisolvens_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_intestinihominis_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
# c_sp_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Coprococcus_sp_62244_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
d_invisus_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
e_eligens_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
e_rectale_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
f_prausnitzii_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
o_splanchnicus_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
oscillibacter_sp_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
p_distasonis_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
p_merdae_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
phascolarctobacterium_sp_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
p_copri_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Prevotella_copri_61740_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
r_bicirculans_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
r_bromii_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))

a_muciniphila_core_two_epoch = sfs_from_demography('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_two_epoch_demography.txt')
a_finegoldii_core_two_epoch = sfs_from_demography('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_two_epoch_demography.txt') 
a_onderdonkii_core_two_epoch = sfs_from_demography('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_two_epoch_demography.txt') 
a_putredinis_core_two_epoch = sfs_from_demography('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_two_epoch_demography.txt') 
a_shahii_core_two_epoch = sfs_from_demography('../Analysis/Alistipes_shahii_62199_downsampled_14/core_two_epoch_demography.txt') 
b_bacterium_core_two_epoch = sfs_from_demography('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_two_epoch_demography.txt') 
b_caccae_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_two_epoch_demography.txt') 
b_cellulosilyticus_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_two_epoch_demography.txt') 
b_fragilis_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_two_epoch_demography.txt') 
b_ovatus_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_two_epoch_demography.txt') 
b_stercoris_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_two_epoch_demography.txt') 
b_thetaiotaomicron_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_two_epoch_demography.txt') 
b_uniformis_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_two_epoch_demography.txt') 
b_vulgatus_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_two_epoch_demography.txt') 
b_xylanisolvens_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_two_epoch_demography.txt') 
b_intestinihominis_core_two_epoch = sfs_from_demography('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_two_epoch_demography.txt') 
d_invisus_core_two_epoch = sfs_from_demography('../Analysis/Dialister_invisus_61905_downsampled_14/core_two_epoch_demography.txt') 
e_eligens_core_two_epoch = sfs_from_demography('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_two_epoch_demography.txt') 
e_rectale_core_two_epoch = sfs_from_demography('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_two_epoch_demography.txt') 
f_prausnitzii_core_two_epoch = sfs_from_demography('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_two_epoch_demography.txt') 
o_splanchnicus_core_two_epoch = sfs_from_demography('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_two_epoch_demography.txt') 
oscillibacter_sp_core_two_epoch = sfs_from_demography('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_two_epoch_demography.txt') 
p_distasonis_core_two_epoch = sfs_from_demography('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_two_epoch_demography.txt') 
p_merdae_core_two_epoch = sfs_from_demography('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_two_epoch_demography.txt') 
phascolarctobacterium_sp_core_two_epoch = sfs_from_demography('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_two_epoch_demography.txt') 
p_copri_core_two_epoch = sfs_from_demography('../Analysis/Prevotella_copri_61740_downsampled_14/core_two_epoch_demography.txt') 
r_bicirculans_core_two_epoch = sfs_from_demography('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_two_epoch_demography.txt') 
r_bromii_core_two_epoch = sfs_from_demography('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_two_epoch_demography.txt') 

a_muciniphila_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_inferred_DFE.txt')
a_finegoldii_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_inferred_DFE.txt') 
a_onderdonkii_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_inferred_DFE.txt') 
a_putredinis_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_inferred_DFE.txt') 
a_shahii_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_shahii_62199_downsampled_14/core_inferred_DFE.txt') 
b_bacterium_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_inferred_DFE.txt') 
b_caccae_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_inferred_DFE.txt') 
b_cellulosilyticus_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_inferred_DFE.txt') 
b_fragilis_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_inferred_DFE.txt') 
b_ovatus_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_inferred_DFE.txt') 
b_stercoris_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_inferred_DFE.txt') 
b_thetaiotaomicron_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt') 
b_uniformis_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt') 
b_vulgatus_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt') 
b_xylanisolvens_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_inferred_DFE.txt') 
b_intestinihominis_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt') 
d_invisus_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/core_inferred_DFE.txt') 
e_eligens_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_inferred_DFE.txt') 
e_rectale_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt') 
f_prausnitzii_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt') 
o_splanchnicus_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_inferred_DFE.txt') 
oscillibacter_sp_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_inferred_DFE.txt') 
p_distasonis_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt') 
p_merdae_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_inferred_DFE.txt') 
phascolarctobacterium_sp_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_inferred_DFE.txt') 
p_copri_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/core_inferred_DFE.txt') 
r_bicirculans_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_inferred_DFE.txt') 
r_bromii_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_inferred_DFE.txt') 

one_epoch_14 = sfs_from_demography('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_one_epoch_demography.txt')
x_axis = 1:length(one_epoch_14)

a_muciniphila_best_fit = cbind(
  proportional_sfs(a_muciniphila_hmp_qp_syn[-1]),
  proportional_sfs(a_muciniphila_core_two_epoch),
  proportional_sfs(a_muciniphila_hmp_qp_nonsyn[-1]),
  proportional_sfs(a_muciniphila_core_gamma_dfe),
  rep('A. muciniphila', length(a_muciniphila_hmp_qp_syn[-1])),
  x_axis
)

a_finegoldii_best_fit = cbind(
  proportional_sfs(a_finegoldii_hmp_qp_syn[-1]),
  proportional_sfs(a_finegoldii_core_two_epoch),
  proportional_sfs(a_finegoldii_hmp_qp_nonsyn[-1]),
  proportional_sfs(a_finegoldii_core_gamma_dfe),
  rep('A. finegoldii', length(a_finegoldii_hmp_qp_syn[-1])),
  x_axis
)

a_onderdonkii_best_fit = cbind(
  proportional_sfs(a_onderdonkii_hmp_qp_syn[-1]),
  proportional_sfs(a_onderdonkii_core_two_epoch),
  proportional_sfs(a_onderdonkii_hmp_qp_nonsyn[-1]),
  proportional_sfs(a_onderdonkii_core_gamma_dfe),
  rep('A. onderdonkii', length(a_onderdonkii_hmp_qp_syn[-1])),
  x_axis
)

a_putredinis_best_fit = cbind(
  proportional_sfs(a_putredinis_hmp_qp_syn[-1]),
  proportional_sfs(a_putredinis_core_two_epoch),
  proportional_sfs(a_putredinis_hmp_qp_nonsyn[-1]),
  proportional_sfs(a_putredinis_core_gamma_dfe),
  rep('A. putredinis', length(a_putredinis_hmp_qp_syn[-1])),
  x_axis
)

a_shahii_best_fit = cbind(
  proportional_sfs(a_shahii_hmp_qp_syn[-1]),
  proportional_sfs(a_shahii_core_two_epoch),
  proportional_sfs(a_shahii_hmp_qp_nonsyn[-1]),
  proportional_sfs(a_shahii_core_gamma_dfe),
  rep('A. shahii', length(a_shahii_hmp_qp_syn[-1])),
  x_axis
)

b_bacterium_best_fit = cbind(
  proportional_sfs(b_bacterium_hmp_qp_syn[-1]),
  proportional_sfs(b_bacterium_core_two_epoch),
  proportional_sfs(b_bacterium_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_bacterium_core_gamma_dfe),
  rep('B. bacterium', length(b_bacterium_hmp_qp_syn[-1])),
  x_axis
)

b_caccae_best_fit = cbind(
  proportional_sfs(b_caccae_hmp_qp_syn[-1]),
  proportional_sfs(b_caccae_core_two_epoch),
  proportional_sfs(b_caccae_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_caccae_core_gamma_dfe),
  rep('B. caccae', length(b_caccae_hmp_qp_syn[-1])),
  x_axis
)


b_cellulosilyticus_best_fit = cbind(
  proportional_sfs(b_cellulosilyticus_hmp_qp_syn[-1]),
  proportional_sfs(b_cellulosilyticus_core_two_epoch),
  proportional_sfs(b_cellulosilyticus_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_cellulosilyticus_core_gamma_dfe),
  rep('B. cellulosilyticus', length(b_cellulosilyticus_hmp_qp_syn[-1])),
  x_axis
)

b_fragilis_best_fit = cbind(
  proportional_sfs(b_fragilis_hmp_qp_syn[-1]),
  proportional_sfs(b_fragilis_core_two_epoch),
  proportional_sfs(b_fragilis_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_fragilis_core_gamma_dfe),
  rep('B. fragilis', length(b_fragilis_hmp_qp_syn[-1])),
  x_axis
)

b_ovatus_best_fit = cbind(
  proportional_sfs(b_ovatus_hmp_qp_syn[-1]),
  proportional_sfs(b_ovatus_core_two_epoch),
  proportional_sfs(b_ovatus_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_ovatus_core_gamma_dfe),
  rep('B. ovatus', length(b_ovatus_hmp_qp_syn[-1])),
  x_axis
)


b_stercoris_best_fit = cbind(
  proportional_sfs(b_stercoris_hmp_qp_syn[-1]),
  proportional_sfs(b_stercoris_core_two_epoch),
  proportional_sfs(b_stercoris_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_stercoris_core_gamma_dfe),
  rep('B. stercoris', length(b_stercoris_hmp_qp_syn[-1])),
  x_axis
)

b_thetaiotaomicron_best_fit = cbind(
  proportional_sfs(b_thetaiotaomicron_hmp_qp_syn[-1]),
  proportional_sfs(b_thetaiotaomicron_core_two_epoch),
  proportional_sfs(b_thetaiotaomicron_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_thetaiotaomicron_core_gamma_dfe),
  rep('B. thetaiotaomicron', length(b_thetaiotaomicron_hmp_qp_syn[-1])),
  x_axis
)

b_uniformis_best_fit = cbind(
  proportional_sfs(b_uniformis_hmp_qp_syn[-1]),
  proportional_sfs(b_uniformis_core_two_epoch),
  proportional_sfs(b_uniformis_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_uniformis_core_gamma_dfe),
  rep('B. uniformis', length(b_uniformis_hmp_qp_syn[-1])),
  x_axis
)


b_vulgatus_best_fit = cbind(
  proportional_sfs(b_vulgatus_hmp_qp_syn[-1]),
  proportional_sfs(b_vulgatus_core_two_epoch),
  proportional_sfs(b_vulgatus_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_vulgatus_core_gamma_dfe),
  rep('B. vulgatus', length(b_vulgatus_hmp_qp_syn[-1])),
  x_axis
)

b_xylanisolvens_best_fit = cbind(
  proportional_sfs(b_xylanisolvens_hmp_qp_syn[-1]),
  proportional_sfs(b_xylanisolvens_core_two_epoch),
  proportional_sfs(b_xylanisolvens_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_xylanisolvens_core_gamma_dfe),
  rep('B. xylanisolvens', length(b_xylanisolvens_hmp_qp_syn[-1])),
  x_axis
)

b_intestinihominis_best_fit = cbind(
  proportional_sfs(b_intestinihominis_hmp_qp_syn[-1]),
  proportional_sfs(b_intestinihominis_core_two_epoch),
  proportional_sfs(b_intestinihominis_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_intestinihominis_core_gamma_dfe),
  rep('B. intestinihominis', length(b_intestinihominis_hmp_qp_syn[-1])),
  x_axis
)

d_invisus_best_fit = cbind(
  proportional_sfs(d_invisus_hmp_qp_syn[-1]),
  proportional_sfs(d_invisus_core_two_epoch),
  proportional_sfs(d_invisus_hmp_qp_nonsyn[-1]),
  proportional_sfs(d_invisus_core_gamma_dfe),
  rep('D. invisus', length(d_invisus_hmp_qp_syn[-1])),
  x_axis
)

e_eligens_best_fit = cbind(
  proportional_sfs(e_eligens_hmp_qp_syn[-1]),
  proportional_sfs(e_eligens_core_two_epoch),
  proportional_sfs(e_eligens_hmp_qp_nonsyn[-1]),
  proportional_sfs(e_eligens_core_gamma_dfe),
  rep('E. eligens', length(e_eligens_hmp_qp_syn[-1])),
  x_axis
)

e_rectale_best_fit = cbind(
  proportional_sfs(e_rectale_hmp_qp_syn[-1]),
  proportional_sfs(e_rectale_core_two_epoch),
  proportional_sfs(e_rectale_hmp_qp_nonsyn[-1]),
  proportional_sfs(e_rectale_core_gamma_dfe),
  rep('E. rectale', length(e_rectale_hmp_qp_syn[-1])),
  x_axis
)

f_prausnitzii_best_fit = cbind(
  proportional_sfs(f_prausnitzii_hmp_qp_syn[-1]),
  proportional_sfs(f_prausnitzii_core_two_epoch),
  proportional_sfs(f_prausnitzii_hmp_qp_nonsyn[-1]),
  proportional_sfs(f_prausnitzii_core_gamma_dfe),
  rep('F. prausnitzii', length(f_prausnitzii_hmp_qp_syn[-1])),
  x_axis
)

o_splanchnicus_best_fit = cbind(
  proportional_sfs(o_splanchnicus_hmp_qp_syn[-1]),
  proportional_sfs(o_splanchnicus_core_two_epoch),
  proportional_sfs(o_splanchnicus_hmp_qp_nonsyn[-1]),
  proportional_sfs(o_splanchnicus_core_gamma_dfe),
  rep('O. splanchnicus', length(o_splanchnicus_hmp_qp_syn[-1])),
  x_axis
)

oscillibacter_sp_best_fit = cbind(
  proportional_sfs(oscillibacter_sp_hmp_qp_syn[-1]),
  proportional_sfs(oscillibacter_sp_core_two_epoch),
  proportional_sfs(oscillibacter_sp_hmp_qp_nonsyn[-1]),
  proportional_sfs(oscillibacter_sp_core_gamma_dfe),
  rep('Oscilibacter sp', length(oscillibacter_sp_hmp_qp_syn[-1])),
  x_axis
)

p_distasonis_best_fit = cbind(
  proportional_sfs(p_distasonis_hmp_qp_syn[-1]),
  proportional_sfs(p_distasonis_core_two_epoch),
  proportional_sfs(p_distasonis_hmp_qp_nonsyn[-1]),
  proportional_sfs(p_distasonis_core_gamma_dfe),
  rep('P. distasonis', length(p_distasonis_hmp_qp_syn[-1])),
  x_axis
)

p_merdae_best_fit = cbind(
  proportional_sfs(p_merdae_hmp_qp_syn[-1]),
  proportional_sfs(p_merdae_core_two_epoch),
  proportional_sfs(p_merdae_hmp_qp_nonsyn[-1]),
  proportional_sfs(p_merdae_core_gamma_dfe),
  rep('P. merdae', length(p_merdae_hmp_qp_syn[-1])),
  x_axis
)

phascolarctobacterium_sp_best_fit = cbind(
  proportional_sfs(phascolarctobacterium_sp_hmp_qp_syn[-1]),
  proportional_sfs(phascolarctobacterium_sp_core_two_epoch),
  proportional_sfs(phascolarctobacterium_sp_hmp_qp_nonsyn[-1]),
  proportional_sfs(phascolarctobacterium_sp_core_gamma_dfe),
  rep('Phascolarctobacterium sp', length(phascolarctobacterium_sp_hmp_qp_syn[-1])),
  x_axis
)

p_copri_best_fit = cbind(
  proportional_sfs(p_copri_hmp_qp_syn[-1]),
  proportional_sfs(p_copri_core_two_epoch),
  proportional_sfs(p_copri_hmp_qp_nonsyn[-1]),
  proportional_sfs(p_copri_core_gamma_dfe),
  rep('P. copri', length(p_copri_hmp_qp_syn[-1])),
  x_axis
)

r_bicirculans_best_fit = cbind(
  proportional_sfs(r_bicirculans_hmp_qp_syn[-1]),
  proportional_sfs(r_bicirculans_core_two_epoch),
  proportional_sfs(r_bicirculans_hmp_qp_nonsyn[-1]),
  proportional_sfs(r_bicirculans_core_gamma_dfe),
  rep('R. bicirculans', length(r_bicirculans_hmp_qp_syn[-1])),
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

p1 = plot_best_fit_sfs(a_muciniphila_best_fit) + ggtitle('Akkermansia muciniphila')
p2 = plot_best_fit_sfs(a_finegoldii_best_fit) + ggtitle('Alistipes finegoldii')
p3 = plot_best_fit_sfs(a_onderdonkii_best_fit) + ggtitle('Alistipes onderdonkii')
p4 = plot_best_fit_sfs(a_putredinis_best_fit)  + ggtitle('Alistipes putredinis')
p5 = plot_best_fit_sfs(a_shahii_best_fit) + ggtitle('Alistipes shahii')
p6 = plot_best_fit_sfs(b_bacterium_best_fit) + ggtitle('Bacteroidales bacterium')
p7 = plot_best_fit_sfs(b_caccae_best_fit) + ggtitle('Bacteroides caccae')
p8 = plot_best_fit_sfs(b_cellulosilyticus_best_fit) + ggtitle('Bacteroides cellulosilyticus')
p9 = plot_best_fit_sfs(b_fragilis_best_fit) + ggtitle('Bacteroides fragilis')
# p10 = plot_best_fit_sfs(_best_fit)
p11 = plot_best_fit_sfs(b_ovatus_best_fit) + ggtitle('Bacteroides ovatus')
p12 = plot_best_fit_sfs(b_stercoris_best_fit) + ggtitle('Bacteroides stercoris')
p13 = plot_best_fit_sfs(b_thetaiotaomicron_best_fit) + ggtitle('Bacteroides thetaiotaomicron')
p14 = plot_best_fit_sfs(b_uniformis_best_fit) + ggtitle('Bacteroides uniformis')
p15 = plot_best_fit_sfs(b_vulgatus_best_fit) + ggtitle('Bacteroides vulgatus')
p16 = plot_best_fit_sfs(b_xylanisolvens_best_fit) + ggtitle('Bacteroides xylanisolvens')
p17 = plot_best_fit_sfs(b_intestinihominis_best_fit) + ggtitle('Barnesiella intestinihominis')
# p18 = plot_best_fit_sfs(_best_fit)
p19 = plot_best_fit_sfs(d_invisus_best_fit) + ggtitle('Dialister invisus')
p20 = plot_best_fit_sfs(e_eligens_best_fit) + ggtitle('Eubacterium eligens')
p21 = plot_best_fit_sfs(e_rectale_best_fit) + ggtitle('Eubacterium rectale')
p22 = plot_best_fit_sfs(f_prausnitzii_best_fit) + ggtitle('Faecalibacterium prausnitzii')
p23 = plot_best_fit_sfs(o_splanchnicus_best_fit) + ggtitle('Odoribacter splanchnicus')
p24 = plot_best_fit_sfs(oscillibacter_sp_best_fit) + ggtitle('Oscillibacter species')
p25 = plot_best_fit_sfs(p_distasonis_best_fit) + ggtitle('Parabacteroides distasonis')
p26 = plot_best_fit_sfs(p_merdae_best_fit) + ggtitle('Parabacteroides merdae')
p27 = plot_best_fit_sfs(phascolarctobacterium_sp_best_fit) + ggtitle('Phascolarctobacterium species')
p28 = plot_best_fit_sfs(p_copri_best_fit) + ggtitle('Prevotella copri')
p29 = plot_best_fit_sfs(r_bicirculans_best_fit) + ggtitle('Ruminococcus bicirculans')
p30 = plot_best_fit_sfs(r_bromii_best_fit) + ggtitle('Ruminococcus bromii')

p1_l = plot_likelihood_surface_contour('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_likelihood_surface.csv')
p2_l = plot_likelihood_surface_contour('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_likelihood_surface.csv')
p3_l = plot_likelihood_surface_contour('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_likelihood_surface.csv')
p4_l = plot_likelihood_surface_contour('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_likelihood_surface.csv')
p5_l = plot_likelihood_surface_contour('../Analysis/Alistipes_shahii_62199_downsampled_14/core_likelihood_surface.csv')
p6_l = plot_likelihood_surface_contour('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_likelihood_surface.csv')
p7_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_likelihood_surface.csv')
p8_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_likelihood_surface.csv')
p9_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_likelihood_surface.csv')
# p10 = plot_likelihood_surface_contour('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/core_likelihood_surface.csv')
p11_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_likelihood_surface.csv')
p12_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_likelihood_surface.csv')
p13_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_likelihood_surface.csv')
p14_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_likelihood_surface.csv')
p15_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_likelihood_surface.csv')
p16_l = plot_likelihood_surface_contour('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_likelihood_surface.csv')
p17_l = plot_likelihood_surface_contour('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_likelihood_surface.csv')
# p18 = plot_likelihood_surface_contour('../Analysis/Coprococcus_sp_62244_downsampled_14/core_likelihood_surface.csv')
p19_l = plot_likelihood_surface_contour('../Analysis/Dialister_invisus_61905_downsampled_14/core_likelihood_surface.csv')
p20_l = plot_likelihood_surface_contour('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_likelihood_surface.csv')
p21_l = plot_likelihood_surface_contour('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_likelihood_surface.csv')
p22_l = plot_likelihood_surface_contour('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_likelihood_surface.csv')
p23_l = plot_likelihood_surface_contour('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_likelihood_surface.csv')
p24_l = plot_likelihood_surface_contour('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_likelihood_surface.csv')
p25_l = plot_likelihood_surface_contour('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_likelihood_surface.csv')
p26_l = plot_likelihood_surface_contour('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_likelihood_surface.csv')
p27_l = plot_likelihood_surface_contour('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_likelihood_surface.csv')
p28_l = plot_likelihood_surface_contour('../Analysis/Prevotella_copri_61740_downsampled_14/core_likelihood_surface.csv')
p29_l = plot_likelihood_surface_contour('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_likelihood_surface.csv')
p30_l = plot_likelihood_surface_contour('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_likelihood_surface.csv')

# 1600 x 16000
sfs_and_likelihood = p6 + p6_l +
  p4 + p4_l +
  p2 + p2_l + 
  p3 + p3_l + 
  p5 + p5_l +
  p23 + p23_l +
  p25 + p25_l +
  p26 + p26_l  +
  p28 + p28_l +
  p9 + p9_l +
  p8 + p8_l +
  p12 + p12_l +
  p14 + p14_l +
  p13 + p13_l +
  # p11 + p11_l +
  p16 + p16_l +
  p7 + p7_l +
  p15 + p15_l +
  p17 + p17_l +
  p1 + p1_l +
  p19 + p19_l +
  p27 + p27_l +
  p20 + p20_l +
  p21 + p21_l +
  p24 + p24_l +
  p30 + p30_l +
  p29 + p29_l +
  p22 + p22_l +
  plot_layout(ncol=2) 

png("../Supplement/Supplemental_Figure_3.png", width = 1600, height = 16000)
# 1600 x 16000 dimensions for saved image
sfs_and_likelihood
dev.off()

# Supplemental Figure 4
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

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
# tau_label_text = expression(tau == frac(generations, 2 * N[ancestral]))
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
png("../Supplement/Supplemental_Figure_4A.png", width = 2000, height = 1100)
plot_nu_distribution_fig + plot_tau_distribution_fig + plot_layout(ncol=2)
dev.off()

# Supplemental Figure 5
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

a_muciniphila_dfe_params = read_dfe_params('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_inferred_DFE.txt')
a_muciniphila_dfe_params$species = 'Akkermansia muciniphila'

a_finegoldii_dfe_params = read_dfe_params('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_inferred_DFE.txt')
a_finegoldii_dfe_params$species = 'Alistipes finegoldii'

a_onderdonkii_dfe_params = read_dfe_params('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_inferred_DFE.txt')
a_onderdonkii_dfe_params$species = 'Alistipes onderdonkii'

a_putredinis_dfe_params = read_dfe_params('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_inferred_DFE.txt')
a_putredinis_dfe_params$species = 'Alistipes putredinis'

a_shahii_dfe_params = read_dfe_params('../Analysis/Alistipes_shahii_62199_downsampled_14/core_inferred_DFE.txt')
a_shahii_dfe_params$species = 'Alistipes shahii'

b_bacterium_dfe_params = read_dfe_params('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_inferred_DFE.txt')
b_bacterium_dfe_params$species = 'Bacteroidales bacterium'

b_caccae_dfe_params = read_dfe_params('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_inferred_DFE.txt')
b_caccae_dfe_params$species = 'Bacteroides caccae'

b_cellulosilyticus_dfe_params = read_dfe_params('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_inferred_DFE.txt')
b_cellulosilyticus_dfe_params$species = 'Bacteroides cellulosilyticus'

b_fragilis_dfe_params = read_dfe_params('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_inferred_DFE.txt')
b_fragilis_dfe_params$species = 'Bacteroides fragilis'

b_ovatus_dfe_params = read_dfe_params('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_inferred_DFE.txt')
b_ovatus_dfe_params$species = 'Bacteroides ovatus'

b_stercoris_dfe_params = read_dfe_params('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_inferred_DFE.txt')
b_stercoris_dfe_params$species = 'Bacteroides stercoris'

b_thetaiotaomicron_dfe_params = read_dfe_params('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt')
b_thetaiotaomicron_dfe_params$species = 'Bacteroides thetaiotaomicron'

b_uniformis_dfe_params = read_dfe_params('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt')
b_uniformis_dfe_params$species = 'Bacteroides uniformis'

b_vulgatus_dfe_params = read_dfe_params('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt')
b_vulgatus_dfe_params$species = 'Bacteroides vulgatus'

b_xylanisolvens_dfe_params = read_dfe_params('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_inferred_DFE.txt')
b_xylanisolvens_dfe_params$species = 'Bacteroides xylanisolvens'

b_intestinihominis_dfe_params = read_dfe_params('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt')
b_intestinihominis_dfe_params$species = 'Barnesiella intestinihominis'

d_invisus_dfe_params = read_dfe_params('../Analysis/Dialister_invisus_61905_downsampled_14/core_inferred_DFE.txt')
d_invisus_dfe_params$species = 'Dialister invisus'

e_eligens_dfe_params = read_dfe_params('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_inferred_DFE.txt')
e_eligens_dfe_params$species = 'Eubacterium eligens'

e_rectale_dfe_params = read_dfe_params('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt')
e_rectale_dfe_params$species = 'Eubacterium rectale'

f_prausnitzii_dfe_params = read_dfe_params('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt')
f_prausnitzii_dfe_params$species = 'Faecalibacterium prausnitzii'

o_splanchnicus_dfe_params = read_dfe_params('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_inferred_DFE.txt')
o_splanchnicus_dfe_params$species = 'Odoribacter splanchnicus'

oscillibacter_sp_dfe_params = read_dfe_params('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_inferred_DFE.txt')
oscillibacter_sp_dfe_params$species = 'Oscillibacter species'

p_distasonis_dfe_params = read_dfe_params('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt')
p_distasonis_dfe_params$species = 'Parabacteroides distasonis'

p_merdae_dfe_params = read_dfe_params('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_inferred_DFE.txt')
p_merdae_dfe_params$species = 'Parabacteroides merdae'

phascolarctobacterium_sp_dfe_params = read_dfe_params('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_inferred_DFE.txt')
phascolarctobacterium_sp_dfe_params$species = 'Phascolarctobacterium species'

p_copri_dfe_params = read_dfe_params('../Analysis/Prevotella_copri_61740_downsampled_14/core_inferred_DFE.txt')
p_copri_dfe_params$species = 'Prevotella copri'

r_bicirculans_dfe_params = read_dfe_params('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_inferred_DFE.txt')
r_bicirculans_dfe_params$species = 'Ruminococcus bicirculans'

r_bromii_dfe_params = read_dfe_params('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_inferred_DFE.txt')
r_bromii_dfe_params$species = 'Ruminococcus bromii'

dfe_df = rbind(
  melt(a_muciniphila_dfe_params),
  melt(a_finegoldii_dfe_params),
  melt(a_onderdonkii_dfe_params),
  melt(a_putredinis_dfe_params),
  melt(a_shahii_dfe_params),
  melt(b_bacterium_dfe_params),
  melt(b_caccae_dfe_params),
  melt(b_cellulosilyticus_dfe_params),
  melt(b_fragilis_dfe_params),
  # melt(b_ovatus_dfe_params),
  melt(b_stercoris_dfe_params),
  melt(b_thetaiotaomicron_dfe_params),
  melt(b_uniformis_dfe_params),
  melt(b_vulgatus_dfe_params),
  melt(b_xylanisolvens_dfe_params),
  melt(b_intestinihominis_dfe_params),
  melt(d_invisus_dfe_params),
  melt(e_eligens_dfe_params),
  melt(e_rectale_dfe_params),
  melt(f_prausnitzii_dfe_params),
  melt(o_splanchnicus_dfe_params),
  melt(oscillibacter_sp_dfe_params),
  melt(p_distasonis_dfe_params),
  melt(p_merdae_dfe_params),
  melt(phascolarctobacterium_sp_dfe_params),
  melt(p_copri_dfe_params),
  melt(r_bicirculans_dfe_params),
  melt(r_bromii_dfe_params)
)

dfe_df$species = factor(dfe_df$species, levels=phylogenetic_levels)

# dfe_df$value = dfe_df$value * 2
dfe_df$value[dfe_df$value <= 1e-11] = 1e-11
dfe_df$value[dfe_df$value >= 0.5] = 0.5

png("../Supplement/Supplemental_Figure_5A.png", width = 600, height = 1000)
# 600 x 1000 dimensions for saved image
ggplot(dfe_df[dfe_df$variable == 'neugamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 0.95) +
  #labs(
  #  title = 'Neutral + Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e1)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") + 
  xlab('Selection Coefficient')
dev.off()

# Supplemental Figure 6
dfe_comparison_matrix = read.csv('../Analysis/cross_species_dfe/dfe_comparison_matrix.csv', header=TRUE)

dfe_comparison_matrix = dfe_comparison_matrix[, -1]
rownames(dfe_comparison_matrix) = phylogenetic_levels
colnames(dfe_comparison_matrix) = phylogenetic_levels
dfe_comparison_matrix

dfe_constant_s_matrix = read.csv('../Analysis/cross_species_dfe/dfe_comparison_constant_s_matrix.csv', header=TRUE)

dfe_constant_s_matrix = dfe_constant_s_matrix[, -1]
rownames(dfe_constant_s_matrix) = phylogenetic_levels
colnames(dfe_constant_s_matrix) = phylogenetic_levels
dfe_constant_s_matrix

color_scale = colorRampPalette(c('white', 'yellow', 'orange', 'red'), bias=2.5)(100)

# col_scheme = c(rep('black', each=1), rep('darkorange', each=4), rep('black', each=4), rep('darkviolet', each=8), rep('black', each=10))

### Figure S6A
png("../Supplement/Supplemental_Figure_6A.png", width = 1200, height = 800)
# 800 x 1200 dimensions of saved image
Heatmap(dfe_comparison_matrix, rect_gp = gpar(type = "none"),
  col=color_scale,
  cluster_rows = FALSE, cluster_columns = FALSE,
  cell_fun = function(j, i, x, y, w, h, fill) {
    if (dfe_comparison_matrix[i, j] > 17.7 && i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white', fontface='italic'))
      grid.text(sprintf("%.1f", dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
    }
    else if(i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
      grid.text(sprintf("%.1f", dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8))      
    }
  },
  row_names_side='left',
  column_names_gp = gpar(fontsize = 12,fontface='italic', col='black'),
  row_names_gp = gpar(fontsize = 12,fontface='italic', col='black'),
  show_heatmap_legend = T,
  name='LRT Statistic'
  )
dev.off()

### Figure S6B

png("../Supplement/Supplemental_Figure_6B.png", width = 1200, height = 800)
# 800 x 1200 dimensions of saved image
Heatmap(dfe_constant_s_matrix, rect_gp = gpar(type = "none"),
  col=color_scale,
  cluster_rows = FALSE, cluster_columns = FALSE,
  cell_fun = function(j, i, x, y, w, h, fill) {
    if (dfe_constant_s_matrix[i, j] > 17.7 && i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col = 'white', fontface='italic'))
      grid.text(sprintf("%.1f", dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
    }
    else if(i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
      grid.text(sprintf("%.1f", dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8))      
    }
  },
  row_names_side='left',
  column_names_gp = gpar(fontsize = 12,fontface='italic', col='black'),
  row_names_gp = gpar(fontsize = 12,fontface='italic', col='black'),
  show_heatmap_legend = T,
  name='LRT Statistic'
  )
dev.off()

# Supplemental Figure 7
b_bacterium_core = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_bacterium_accessory = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

a_finegoldii_core = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_finegoldii_accessory = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

a_onderdonkii_core = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_onderdonkii_accessory = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

a_shahii_core = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_shahii_accessory = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

o_splanchnicus_core = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
o_splanchnicus_accessory = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

p_distasonis_core = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
p_distasonis_accessory = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

p_merdae_core = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
p_merdae_accessory = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

p_copri_core = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
p_copri_accessory = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

b_fragilis_core = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_fragilis_accessory = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

b_cellulosilyticus_core = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_cellulosilyticus_accessory = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

b_stercoris_core = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_stercoris_accessory = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

b_thetaiotaomicron_core = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_thetaiotaomicron_accessory = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

b_xylanisolvens_core = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_xylanisolvens_accessory = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

b_vulgatus_core = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_vulgatus_accessory = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

b_intestinihominis_core = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_intestinihominis_accessory = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

a_muciniphila_core = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_muciniphila_accessory = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

p_sp_core = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
p_sp_accessory = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

e_eligens_core = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
e_eligens_accessory = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

e_rectale_core = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
e_rectale_accessory = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

o_sp_core = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
o_sp_accessory = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

r_bromii_core = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
r_bromii_accessory = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

r_bicirculans_core = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
r_bicirculans_accessory = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

f_prausnitzii_core = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_accessory = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

# Nonsyn

b_bacterium_core_ns = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
b_bacterium_accessory_ns = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

a_finegoldii_core_ns = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_finegoldii_accessory_ns = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

a_onderdonkii_core_ns = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_onderdonkii_accessory_ns = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

a_shahii_core_ns = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_shahii_accessory_ns = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

o_splanchnicus_core_ns = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
o_splanchnicus_accessory_ns = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

p_distasonis_core_ns = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
p_distasonis_accessory_ns = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

p_merdae_core_ns = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
p_merdae_accessory_ns = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

p_copri_core_ns = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
p_copri_accessory_ns = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

b_fragilis_core_ns = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_fragilis_accessory_ns = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

b_cellulosilyticus_core_ns = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_cellulosilyticus_accessory_ns = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

b_stercoris_core_ns = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_stercoris_accessory_ns = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

b_thetaiotaomicron_core_ns = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_thetaiotaomicron_accessory_ns = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

b_xylanisolvens_core_ns = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_xylanisolvens_accessory_ns = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

b_vulgatus_core_ns = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_vulgatus_accessory_ns = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

b_intestinihominis_core_ns = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_intestinihominis_accessory_ns = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

a_muciniphila_core_ns = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_muciniphila_accessory_ns = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

p_sp_core_ns = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
p_sp_accessory_ns = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

e_eligens_core_ns = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
e_eligens_accessory_ns = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

e_rectale_core_ns = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
e_rectale_accessory_ns = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

o_sp_core_ns = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
o_sp_accessory_ns = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

r_bromii_core_ns = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
r_bromii_accessory_ns = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

r_bicirculans_core_ns = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
r_bicirculans_accessory_ns = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

f_prausnitzii_core_ns = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
f_prausnitzii_accessory_ns = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

a_putredinis_core = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_putredinis_accessory = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

a_putredinis_core_ns = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_putredinis_accessory_ns = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

b_uniformis_core = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_uniformis_accessory = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

b_uniformis_core_ns = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
b_uniformis_accessory_ns = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

b_ovatus_core = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_ovatus_accessory = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

b_ovatus_core_ns = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
b_ovatus_accessory_ns = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

b_caccae_core = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_caccae_accessory = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

b_caccae_core_ns = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
b_caccae_accessory_ns = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

d_invisus_core = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
d_invisus_accessory = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

d_invisus_core_ns = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
d_invisus_accessory_ns = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

fig_s7_1 = compare_core_accessory_sfs_syn_ns(b_bacterium_core,
  b_bacterium_core_ns,
  b_bacterium_accessory,
  b_bacterium_accessory_ns) + ggtitle('B. bacterium')

fig_s7_2 = compare_core_accessory_sfs_syn_ns(a_putredinis_core,
  a_putredinis_core_ns,
  a_putredinis_accessory,
  a_putredinis_accessory_ns) + ggtitle('A. putredinis')

fig_s7_3 = compare_core_accessory_sfs_syn_ns(a_finegoldii_core,
  a_finegoldii_core_ns,
  a_finegoldii_accessory,
  a_finegoldii_accessory_ns) + ggtitle('A. finegoldii')

fig_s7_4 = compare_core_accessory_sfs_syn_ns(a_onderdonkii_core,
  a_onderdonkii_core_ns,
  a_onderdonkii_accessory,
  a_onderdonkii_accessory_ns) + ggtitle('A. onderdonkii')

fig_s7_5 = compare_core_accessory_sfs_syn_ns(a_shahii_core,
  a_shahii_core_ns,
  a_shahii_accessory,
  a_shahii_accessory_ns) + ggtitle('A. shahii')

fig_s7_6 = compare_core_accessory_sfs_syn_ns(o_splanchnicus_core,
  o_splanchnicus_core_ns,
  o_splanchnicus_accessory,
  o_splanchnicus_accessory_ns) + ggtitle('O. splanchnicus')

fig_s7_7 = compare_core_accessory_sfs_syn_ns(p_distasonis_core,
  p_distasonis_core_ns,
  p_distasonis_accessory,
  p_distasonis_accessory_ns) + ggtitle('P. distasonis')

fig_s7_8 = compare_core_accessory_sfs_syn_ns(p_merdae_core,
  p_merdae_core_ns,
  p_merdae_accessory,
  p_merdae_accessory_ns) + ggtitle('P. merdae')

fig_s7_9 = compare_core_accessory_sfs_syn_ns(p_copri_core,
  p_copri_core_ns,
  p_copri_accessory,
  p_copri_accessory_ns) + ggtitle('P. copri')

fig_s7_10 = compare_core_accessory_sfs_syn_ns(b_fragilis_core,
  b_fragilis_core_ns,
  b_fragilis_accessory,
  b_fragilis_accessory_ns) + ggtitle('B. fragilis')

fig_s7_11 = compare_core_accessory_sfs_syn_ns(b_cellulosilyticus_core,
  b_cellulosilyticus_core_ns,
  b_cellulosilyticus_accessory,
  b_cellulosilyticus_accessory_ns) + ggtitle('B. cellulosilyticus')

fig_s7_12 = compare_core_accessory_sfs_syn_ns(b_stercoris_core,
  b_stercoris_core_ns,
  b_stercoris_accessory,
  b_stercoris_accessory_ns) + ggtitle('B. stercoris')

fig_s7_13 = compare_core_accessory_sfs_syn_ns(b_uniformis_core,
  b_uniformis_core_ns,
  b_vulgatus_accessory,
  b_vulgatus_accessory_ns) +  ggtitle('B. uniformis')

### used in Figure 5

fig_s7_14 = compare_core_accessory_sfs_syn_ns(b_thetaiotaomicron_core,
  b_thetaiotaomicron_core_ns,
  b_thetaiotaomicron_accessory,
  b_thetaiotaomicron_accessory_ns) + ggtitle('B. thetaiotaomicron')

fig_s7_15 = compare_core_accessory_sfs_syn_ns(b_xylanisolvens_core,
  b_xylanisolvens_core_ns,
  b_xylanisolvens_accessory,
  b_xylanisolvens_accessory_ns) + ggtitle('B. xylanisolvens')

fig_s7_16 = compare_core_accessory_sfs_syn_ns(b_caccae_core,
  b_caccae_core_ns,
  b_caccae_accessory,
  b_caccae_accessory_ns) + ggtitle('B. caccae')

fig_s7_17 = compare_core_accessory_sfs_syn_ns(b_vulgatus_core,
  b_vulgatus_core_ns,
  b_vulgatus_accessory,
  b_vulgatus_accessory_ns) + ggtitle('B. vulgatus')

fig_s7_18 = compare_core_accessory_sfs_syn_ns(b_intestinihominis_core,
  b_intestinihominis_core_ns,
  b_intestinihominis_accessory,
  b_intestinihominis_accessory_ns) + ggtitle('B. intestinihominis')

fig_s7_19 = compare_core_accessory_sfs_syn_ns(a_muciniphila_core,
  a_muciniphila_core_ns,
  a_muciniphila_accessory,
  a_muciniphila_accessory_ns)  + ggtitle('A. muciniphila')

fig_s7_20 = compare_core_accessory_sfs_syn_ns(d_invisus_core,
  d_invisus_core_ns,
  d_invisus_accessory,
  d_invisus_accessory_ns) + ggtitle('D. invisus')

fig_s7_21 = compare_core_accessory_sfs_syn_ns(p_sp_core,
  p_sp_core_ns,
  p_sp_accessory,
  p_sp_accessory_ns) + ggtitle('Phascolarctobacterium species')

fig_s7_22 = compare_core_accessory_sfs_syn_ns(e_eligens_core,
  e_eligens_core_ns,
  e_eligens_accessory,
  e_eligens_accessory_ns) + ggtitle('E. eligens')

### used in Figure 5

fig_s7_23 = compare_core_accessory_sfs_syn_ns(e_rectale_core,
  e_rectale_core_ns,
  e_rectale_accessory,
  e_rectale_accessory_ns) + ggtitle('E. rectale')

fig_s7_24 = compare_core_accessory_sfs_syn_ns(o_sp_core,
  o_sp_core_ns,
  o_sp_accessory,
  o_sp_accessory_ns) + ggtitle('Oscillibacter species')

fig_s7_25 = compare_core_accessory_sfs_syn_ns(r_bromii_core,
  r_bromii_core_ns,
  r_bromii_accessory,
  r_bromii_accessory_ns) + ggtitle('Ruminococcus bromii')

fig_s7_26 = compare_core_accessory_sfs_syn_ns(r_bicirculans_core,
  r_bicirculans_core_ns,
  r_bicirculans_accessory,
  r_bicirculans_accessory_ns) + ggtitle('Ruminococcus bicirculans')

fig_s7_27 = compare_core_accessory_sfs_syn_ns(f_prausnitzii_core,
  f_prausnitzii_core_ns,
  f_prausnitzii_accessory,
  f_prausnitzii_accessory_ns) + ggtitle('F. prausnitzii')

png("../Supplement/Supplemental_Figure_7.png", width = 800, height = 16000)
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
  plot_layout(ncol=1)
dev.off()

# Supplemental Figure 8
a_muciniphila_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
a_finegoldii_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
a_onderdonkii_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
a_putredinis_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
a_shahii_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_bacterium_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_caccae_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_cellulosilyticus_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_fragilis_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
# b_massiliensis_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_ovatus_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_stercoris_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_thetaiotaomicron_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_uniformis_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_vulgatus_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_xylanisolvens_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
b_intestinihominis_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
# c_sp_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Coprococcus_sp_62244_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
d_invisus_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
e_eligens_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
e_rectale_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
f_prausnitzii_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
o_splanchnicus_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
oscillibacter_sp_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
p_distasonis_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
p_merdae_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
phascolarctobacterium_sp_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
p_copri_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
r_bicirculans_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))
r_bromii_hmp_qp_syn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt'))

a_muciniphila_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
a_finegoldii_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
a_onderdonkii_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
a_putredinis_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
a_shahii_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_bacterium_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_caccae_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_cellulosilyticus_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_fragilis_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
# b_massiliensis_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_ovatus_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_stercoris_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_thetaiotaomicron_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_uniformis_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_vulgatus_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_xylanisolvens_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
b_intestinihominis_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
# c_sp_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Coprococcus_sp_62244_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
d_invisus_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
e_eligens_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
e_rectale_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
f_prausnitzii_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
o_splanchnicus_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
oscillibacter_sp_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
p_distasonis_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
p_merdae_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
phascolarctobacterium_sp_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
p_copri_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
r_bicirculans_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))
r_bromii_hmp_qp_nonsyn_accessory = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt'))

a_muciniphila_accessory_two_epoch = sfs_from_demography('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_two_epoch_demography.txt')
a_finegoldii_accessory_two_epoch = sfs_from_demography('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_two_epoch_demography.txt') 
a_onderdonkii_accessory_two_epoch = sfs_from_demography('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_two_epoch_demography.txt') 
a_putredinis_accessory_two_epoch = sfs_from_demography('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_two_epoch_demography.txt') 
a_shahii_accessory_two_epoch = sfs_from_demography('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_two_epoch_demography.txt') 
b_bacterium_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_two_epoch_demography.txt') 
b_caccae_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_two_epoch_demography.txt') 
b_cellulosilyticus_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_two_epoch_demography.txt') 
b_fragilis_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_two_epoch_demography.txt') 
b_ovatus_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_two_epoch_demography.txt') 
b_stercoris_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_two_epoch_demography.txt') 
b_thetaiotaomicron_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_two_epoch_demography.txt') 
b_uniformis_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_two_epoch_demography.txt') 
b_vulgatus_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_two_epoch_demography.txt') 
b_xylanisolvens_accessory_two_epoch = sfs_from_demography('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_two_epoch_demography.txt') 
b_intestinihominis_accessory_two_epoch = sfs_from_demography('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_two_epoch_demography.txt') 
d_invisus_accessory_two_epoch = sfs_from_demography('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_two_epoch_demography.txt') 
e_eligens_accessory_two_epoch = sfs_from_demography('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_two_epoch_demography.txt') 
e_rectale_accessory_two_epoch = sfs_from_demography('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_two_epoch_demography.txt') 
f_prausnitzii_accessory_two_epoch = sfs_from_demography('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_two_epoch_demography.txt') 
o_splanchnicus_accessory_two_epoch = sfs_from_demography('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_two_epoch_demography.txt') 
oscillibacter_sp_accessory_two_epoch = sfs_from_demography('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_two_epoch_demography.txt') 
p_distasonis_accessory_two_epoch = sfs_from_demography('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_two_epoch_demography.txt') 
p_merdae_accessory_two_epoch = sfs_from_demography('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_two_epoch_demography.txt') 
phascolarctobacterium_sp_accessory_two_epoch = sfs_from_demography('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_two_epoch_demography.txt') 
p_copri_accessory_two_epoch = sfs_from_demography('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_two_epoch_demography.txt') 
r_bicirculans_accessory_two_epoch = sfs_from_demography('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_two_epoch_demography.txt') 
r_bromii_accessory_two_epoch = sfs_from_demography('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_two_epoch_demography.txt') 

a_muciniphila_accessory_three_epoch = sfs_from_demography('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_three_epoch_demography.txt')
a_finegoldii_accessory_three_epoch = sfs_from_demography('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_three_epoch_demography.txt') 
a_onderdonkii_accessory_three_epoch = sfs_from_demography('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_three_epoch_demography.txt') 
a_putredinis_accessory_three_epoch = sfs_from_demography('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_three_epoch_demography.txt') 
a_shahii_accessory_three_epoch = sfs_from_demography('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_three_epoch_demography.txt') 
b_bacterium_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_three_epoch_demography.txt') 
b_caccae_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_three_epoch_demography.txt') 
b_cellulosilyticus_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_three_epoch_demography.txt') 
b_fragilis_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_three_epoch_demography.txt') 
b_ovatus_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_three_epoch_demography.txt') 
b_stercoris_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_three_epoch_demography.txt') 
b_thetaiotaomicron_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_three_epoch_demography.txt') 
b_uniformis_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_three_epoch_demography.txt') 
b_vulgatus_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_three_epoch_demography.txt') 
b_xylanisolvens_accessory_three_epoch = sfs_from_demography('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_three_epoch_demography.txt') 
b_intestinihominis_accessory_three_epoch = sfs_from_demography('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_three_epoch_demography.txt') 
d_invisus_accessory_three_epoch = sfs_from_demography('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_three_epoch_demography.txt') 
e_eligens_accessory_three_epoch = sfs_from_demography('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_three_epoch_demography.txt') 
e_rectale_accessory_three_epoch = sfs_from_demography('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_three_epoch_demography.txt') 
f_prausnitzii_accessory_three_epoch = sfs_from_demography('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_three_epoch_demography.txt') 
o_splanchnicus_accessory_three_epoch = sfs_from_demography('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_three_epoch_demography.txt') 
oscillibacter_sp_accessory_three_epoch = sfs_from_demography('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_three_epoch_demography.txt') 
p_distasonis_accessory_three_epoch = sfs_from_demography('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_three_epoch_demography.txt') 
p_merdae_accessory_three_epoch = sfs_from_demography('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_three_epoch_demography.txt') 
phascolarctobacterium_sp_accessory_three_epoch = sfs_from_demography('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_three_epoch_demography.txt') 
p_copri_accessory_three_epoch = sfs_from_demography('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_three_epoch_demography.txt') 
r_bicirculans_accessory_three_epoch = sfs_from_demography('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_three_epoch_demography.txt') 
r_bromii_accessory_three_epoch = sfs_from_demography('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_three_epoch_demography.txt') 

a_muciniphila_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_inferred_DFE.txt')
a_finegoldii_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_inferred_DFE.txt') 
a_onderdonkii_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_inferred_DFE.txt') 
a_putredinis_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_inferred_DFE.txt') 
a_shahii_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_inferred_DFE.txt') 
b_bacterium_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_inferred_DFE.txt') 
b_caccae_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_inferred_DFE.txt') 
b_cellulosilyticus_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_inferred_DFE.txt') 
b_fragilis_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_inferred_DFE.txt') 
b_ovatus_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_inferred_DFE.txt') 
b_stercoris_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_inferred_DFE.txt') 
b_thetaiotaomicron_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_inferred_DFE.txt') 
b_uniformis_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_inferred_DFE.txt') 
b_vulgatus_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_inferred_DFE.txt') 
b_xylanisolvens_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_inferred_DFE.txt') 
b_intestinihominis_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_inferred_DFE.txt') 
d_invisus_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_inferred_DFE.txt') 
e_eligens_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_inferred_DFE.txt') 
e_rectale_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_inferred_DFE.txt') 
f_prausnitzii_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_inferred_DFE.txt') 
o_splanchnicus_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_inferred_DFE.txt') 
oscillibacter_sp_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_inferred_DFE.txt') 
p_distasonis_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_inferred_DFE.txt') 
p_merdae_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_inferred_DFE.txt') 
phascolarctobacterium_sp_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_inferred_DFE.txt') 
p_copri_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_inferred_DFE.txt') 
r_bicirculans_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_inferred_DFE.txt') 
r_bromii_accessory_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_inferred_DFE.txt') 

a_muciniphila_best_fit_accessory = cbind(
  proportional_sfs(a_muciniphila_hmp_qp_syn_accessory[-1]),
  proportional_sfs(a_muciniphila_accessory_two_epoch),
  proportional_sfs(a_muciniphila_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(a_muciniphila_accessory_gamma_dfe),
  rep('A. muciniphila', length(a_muciniphila_hmp_qp_syn_accessory[-1])),
  x_axis
)

a_finegoldii_best_fit_accessory = cbind(
  proportional_sfs(a_finegoldii_hmp_qp_syn_accessory[-1]),
  proportional_sfs(a_finegoldii_accessory_two_epoch),
  proportional_sfs(a_finegoldii_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(a_finegoldii_accessory_gamma_dfe),
  rep('A. finegoldii', length(a_finegoldii_hmp_qp_syn_accessory[-1])),
  x_axis
)

a_onderdonkii_best_fit_accessory = cbind(
  proportional_sfs(a_onderdonkii_hmp_qp_syn_accessory[-1]),
  proportional_sfs(a_onderdonkii_accessory_two_epoch),
  proportional_sfs(a_onderdonkii_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(a_onderdonkii_accessory_gamma_dfe),
  rep('A. onderdonkii', length(a_onderdonkii_hmp_qp_syn_accessory[-1])),
  x_axis
)

a_putredinis_best_fit_accessory = cbind(
  proportional_sfs(a_putredinis_hmp_qp_syn_accessory[-1]),
  proportional_sfs(a_putredinis_accessory_two_epoch),
  proportional_sfs(a_putredinis_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(a_putredinis_accessory_gamma_dfe),
  rep('A. putredinis', length(a_putredinis_hmp_qp_syn_accessory[-1])),
  x_axis
)

a_shahii_best_fit_accessory = cbind(
  proportional_sfs(a_shahii_hmp_qp_syn_accessory[-1]),
  proportional_sfs(a_shahii_accessory_two_epoch),
  proportional_sfs(a_shahii_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(a_shahii_accessory_gamma_dfe),
  rep('A. shahii', length(a_shahii_hmp_qp_syn_accessory[-1])),
  x_axis
)

b_bacterium_best_fit_accessory = cbind(
  proportional_sfs(b_bacterium_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_bacterium_accessory_two_epoch),
  proportional_sfs(b_bacterium_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_bacterium_accessory_gamma_dfe),
  rep('B. bacterium', length(b_bacterium_hmp_qp_syn_accessory[-1])),
  x_axis
)

b_caccae_best_fit_accessory = cbind(
  proportional_sfs(b_caccae_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_caccae_accessory_two_epoch),
  proportional_sfs(b_caccae_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_caccae_accessory_gamma_dfe),
  rep('B. caccae', length(b_caccae_hmp_qp_syn_accessory[-1])),
  x_axis
)


b_cellulosilyticus_best_fit_accessory = cbind(
  proportional_sfs(b_cellulosilyticus_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_cellulosilyticus_accessory_two_epoch),
  proportional_sfs(b_cellulosilyticus_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_cellulosilyticus_accessory_gamma_dfe),
  rep('B. cellulosilyticus', length(b_cellulosilyticus_hmp_qp_syn_accessory[-1])),
  x_axis
)

b_fragilis_best_fit_accessory = cbind(
  proportional_sfs(b_fragilis_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_fragilis_accessory_two_epoch),
  proportional_sfs(b_fragilis_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_fragilis_accessory_gamma_dfe),
  rep('B. fragilis', length(b_fragilis_hmp_qp_syn_accessory[-1])),
  x_axis
)

b_ovatus_best_fit_accessory = cbind(
  proportional_sfs(b_ovatus_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_ovatus_accessory_two_epoch),
  proportional_sfs(b_ovatus_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_ovatus_accessory_gamma_dfe),
  rep('B. ovatus', length(b_ovatus_hmp_qp_syn_accessory[-1])),
  x_axis
)


b_stercoris_best_fit_accessory = cbind(
  proportional_sfs(b_stercoris_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_stercoris_accessory_two_epoch),
  proportional_sfs(b_stercoris_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_stercoris_accessory_gamma_dfe),
  rep('B. stercoris', length(b_stercoris_hmp_qp_syn_accessory[-1])),
  x_axis
)

b_thetaiotaomicron_best_fit_accessory = cbind(
  proportional_sfs(b_thetaiotaomicron_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_thetaiotaomicron_accessory_two_epoch),
  proportional_sfs(b_thetaiotaomicron_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_thetaiotaomicron_accessory_gamma_dfe),
  rep('B. thetaiotaomicron', length(b_thetaiotaomicron_hmp_qp_syn_accessory[-1])),
  x_axis
)

b_uniformis_best_fit_accessory = cbind(
  proportional_sfs(b_uniformis_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_uniformis_accessory_two_epoch),
  proportional_sfs(b_uniformis_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_uniformis_accessory_gamma_dfe),
  rep('B. uniformis', length(b_uniformis_hmp_qp_syn_accessory[-1])),
  x_axis
)


b_vulgatus_best_fit_accessory = cbind(
  proportional_sfs(b_vulgatus_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_vulgatus_accessory_two_epoch),
  proportional_sfs(b_vulgatus_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_vulgatus_accessory_gamma_dfe),
  rep('B. vulgatus', length(b_vulgatus_hmp_qp_syn_accessory[-1])),
  x_axis
)

b_xylanisolvens_best_fit_accessory = cbind(
  proportional_sfs(b_xylanisolvens_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_xylanisolvens_accessory_two_epoch),
  proportional_sfs(b_xylanisolvens_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_xylanisolvens_accessory_gamma_dfe),
  rep('B. xylanisolvens', length(b_xylanisolvens_hmp_qp_syn_accessory[-1])),
  x_axis
)

b_intestinihominis_best_fit_accessory = cbind(
  proportional_sfs(b_intestinihominis_hmp_qp_syn_accessory[-1]),
  proportional_sfs(b_intestinihominis_accessory_two_epoch),
  proportional_sfs(b_intestinihominis_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(b_intestinihominis_accessory_gamma_dfe),
  rep('B. intestinihominis', length(b_intestinihominis_hmp_qp_syn_accessory[-1])),
  x_axis
)

d_invisus_best_fit_accessory = cbind(
  proportional_sfs(d_invisus_hmp_qp_syn_accessory[-1]),
  proportional_sfs(d_invisus_accessory_two_epoch),
  proportional_sfs(d_invisus_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(d_invisus_accessory_gamma_dfe),
  rep('D. invisus', length(d_invisus_hmp_qp_syn_accessory[-1])),
  x_axis
)

e_eligens_best_fit_accessory = cbind(
  proportional_sfs(e_eligens_hmp_qp_syn_accessory[-1]),
  proportional_sfs(e_eligens_accessory_two_epoch),
  proportional_sfs(e_eligens_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(e_eligens_accessory_gamma_dfe),
  rep('E. eligens', length(e_eligens_hmp_qp_syn_accessory[-1])),
  x_axis
)

e_rectale_best_fit_accessory = cbind(
  proportional_sfs(e_rectale_hmp_qp_syn_accessory[-1]),
  proportional_sfs(e_rectale_accessory_two_epoch),
  proportional_sfs(e_rectale_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(e_rectale_accessory_gamma_dfe),
  rep('E. rectale', length(e_rectale_hmp_qp_syn_accessory[-1])),
  x_axis
)

f_prausnitzii_best_fit_accessory = cbind(
  proportional_sfs(f_prausnitzii_hmp_qp_syn_accessory[-1]),
  proportional_sfs(f_prausnitzii_accessory_two_epoch),
  proportional_sfs(f_prausnitzii_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(f_prausnitzii_accessory_gamma_dfe),
  rep('F. prausnitzii', length(f_prausnitzii_hmp_qp_syn_accessory[-1])),
  x_axis
)

o_splanchnicus_best_fit_accessory = cbind(
  proportional_sfs(o_splanchnicus_hmp_qp_syn_accessory[-1]),
  proportional_sfs(o_splanchnicus_accessory_two_epoch),
  proportional_sfs(o_splanchnicus_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(o_splanchnicus_accessory_gamma_dfe),
  rep('O. splanchnicus', length(o_splanchnicus_hmp_qp_syn_accessory[-1])),
  x_axis
)

oscillibacter_sp_best_fit_accessory = cbind(
  proportional_sfs(oscillibacter_sp_hmp_qp_syn_accessory[-1]),
  proportional_sfs(oscillibacter_sp_accessory_three_epoch),
  proportional_sfs(oscillibacter_sp_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(oscillibacter_sp_accessory_gamma_dfe),
  rep('Oscilibacter sp', length(oscillibacter_sp_hmp_qp_syn_accessory[-1])),
  x_axis
)

p_distasonis_best_fit_accessory = cbind(
  proportional_sfs(p_distasonis_hmp_qp_syn_accessory[-1]),
  proportional_sfs(p_distasonis_accessory_two_epoch),
  proportional_sfs(p_distasonis_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(p_distasonis_accessory_gamma_dfe),
  rep('P. distasonis', length(p_distasonis_hmp_qp_syn_accessory[-1])),
  x_axis
)

p_merdae_best_fit_accessory = cbind(
  proportional_sfs(p_merdae_hmp_qp_syn_accessory[-1]),
  proportional_sfs(p_merdae_accessory_two_epoch),
  proportional_sfs(p_merdae_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(p_merdae_accessory_gamma_dfe),
  rep('P. merdae', length(p_merdae_hmp_qp_syn_accessory[-1])),
  x_axis
)

phascolarctobacterium_sp_best_fit_accessory = cbind(
  proportional_sfs(phascolarctobacterium_sp_hmp_qp_syn_accessory[-1]),
  proportional_sfs(phascolarctobacterium_sp_accessory_two_epoch),
  proportional_sfs(phascolarctobacterium_sp_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(phascolarctobacterium_sp_accessory_gamma_dfe),
  rep('Phascolarctobacterium sp', length(phascolarctobacterium_sp_hmp_qp_syn_accessory[-1])),
  x_axis
)

p_copri_best_fit_accessory = cbind(
  proportional_sfs(p_copri_hmp_qp_syn_accessory[-1]),
  proportional_sfs(p_copri_accessory_two_epoch),
  proportional_sfs(p_copri_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(p_copri_accessory_gamma_dfe),
  rep('P. copri', length(p_copri_hmp_qp_syn_accessory[-1])),
  x_axis
)

r_bicirculans_best_fit_accessory = cbind(
  proportional_sfs(r_bicirculans_hmp_qp_syn_accessory[-1]),
  proportional_sfs(r_bicirculans_accessory_two_epoch),
  proportional_sfs(r_bicirculans_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(r_bicirculans_accessory_gamma_dfe),
  rep('R. bicirculans', length(r_bicirculans_hmp_qp_syn_accessory[-1])),
  x_axis
)

r_bromii_best_fit_accessory = cbind(
  proportional_sfs(r_bromii_hmp_qp_syn_accessory[-1]),
  proportional_sfs(r_bromii_accessory_two_epoch),
  proportional_sfs(r_bromii_hmp_qp_nonsyn_accessory[-1]),
  proportional_sfs(r_bromii_accessory_gamma_dfe),
  rep('R. bromii', length(r_bromii_hmp_qp_syn_accessory[-1])),
  x_axis
)

p1a = plot_best_fit_sfs(a_muciniphila_best_fit_accessory) + ggtitle('Akkermansia muciniphila')
p2a = plot_best_fit_sfs(a_finegoldii_best_fit_accessory) + ggtitle('Alistipes finegoldii')
p3a = plot_best_fit_sfs(a_onderdonkii_best_fit_accessory) + ggtitle('Alistipes onderdonkii')
p4a = plot_best_fit_sfs(a_putredinis_best_fit_accessory)  + ggtitle('Alistipes putredinis')
p5a = plot_best_fit_sfs(a_shahii_best_fit_accessory) + ggtitle('Alistipes shahii')
p6a = plot_best_fit_sfs(b_bacterium_best_fit_accessory) + ggtitle('Bacteroidales bacterium')
p7a = plot_best_fit_sfs(b_caccae_best_fit_accessory) + ggtitle('Bacteroides caccae')
p8a = plot_best_fit_sfs(b_cellulosilyticus_best_fit_accessory) + ggtitle('Bacteroides cellulosilyticus')
p9a = plot_best_fit_sfs(b_fragilis_best_fit_accessory) + ggtitle('Bacteroides fragilis')
# p10a = plot_best_fit_sfs(_best_fit_accessory)
p11a = plot_best_fit_sfs(b_ovatus_best_fit_accessory) + ggtitle('Bacteroides ovatus')
p12a = plot_best_fit_sfs(b_stercoris_best_fit_accessory) + ggtitle('Bacteroides stercoris')
p13a = plot_best_fit_sfs(b_thetaiotaomicron_best_fit_accessory) + ggtitle('Bacteroides thetaiotaomicron')
p14a = plot_best_fit_sfs(b_uniformis_best_fit_accessory) + ggtitle('Bacteroides uniformis')
p15a = plot_best_fit_sfs(b_vulgatus_best_fit_accessory) + ggtitle('Bacteroides vulgatus')
p16a = plot_best_fit_sfs(b_xylanisolvens_best_fit_accessory) + ggtitle('Bacteroides xylanisolvens')
p17a = plot_best_fit_sfs(b_intestinihominis_best_fit_accessory) + ggtitle('Barnesiella intestinihominis')
# p18a = plot_best_fit_sfs(_best_fit_accessory)
p19a = plot_best_fit_sfs(d_invisus_best_fit_accessory) + ggtitle('Dialister invisus')
p20a = plot_best_fit_sfs(e_eligens_best_fit_accessory) + ggtitle('Eubacterium eligens')
p21a = plot_best_fit_sfs(e_rectale_best_fit_accessory) + ggtitle('Eubacterium rectale')
p22a = plot_best_fit_sfs(f_prausnitzii_best_fit_accessory) + ggtitle('Faecalibacterium prausnitzii')
p23a = plot_best_fit_sfs(o_splanchnicus_best_fit_accessory) + ggtitle('Odoribacter splanchnicus')
p24a = plot_best_fit_sfs(oscillibacter_sp_best_fit_accessory) + ggtitle('Oscillibacter species')
p25a = plot_best_fit_sfs(p_distasonis_best_fit_accessory) + ggtitle('Parabacteroides distasonis')
p26a = plot_best_fit_sfs(p_merdae_best_fit_accessory) + ggtitle('Parabacteroides merdae')
p27a = plot_best_fit_sfs(phascolarctobacterium_sp_best_fit_accessory) + ggtitle('Phascolarctobacterium species')
p28a = plot_best_fit_sfs(p_copri_best_fit_accessory) + ggtitle('Prevotella copri')
p29a = plot_best_fit_sfs(r_bicirculans_best_fit_accessory) + ggtitle('Ruminococcus bicirculans')
p30a = plot_best_fit_sfs(r_bromii_best_fit_accessory) + ggtitle('Ruminococcus bromii')

p1_l_accessory = plot_likelihood_surface_contour('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_likelihood_surface.csv')
p2_l_accessory = plot_likelihood_surface_contour('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_likelihood_surface.csv')
p3_l_accessory = plot_likelihood_surface_contour('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_likelihood_surface.csv')
p4_l_accessory = plot_likelihood_surface_contour('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_likelihood_surface.csv')
p5_l_accessory = plot_likelihood_surface_contour('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_likelihood_surface.csv')
p6_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_likelihood_surface.csv')
p7_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_likelihood_surface.csv')
p8_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_likelihood_surface.csv')
p9_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_likelihood_surface.csv')
# p10 = plot_likelihood_surface_contour('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/accessory_likelihood_surface.csv')
p11_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_likelihood_surface.csv')
p12_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_likelihood_surface.csv')
p13_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_likelihood_surface.csv')
p14_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_likelihood_surface.csv')
p15_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_likelihood_surface.csv')
p16_l_accessory = plot_likelihood_surface_contour('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_likelihood_surface.csv')
p17_l_accessory = plot_likelihood_surface_contour('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_likelihood_surface.csv')
# p18 = plot_likelihood_surface_contour('../Analysis/Coprococcus_sp_62244_downsampled_14/accessory_likelihood_surface.csv')
p19_l_accessory = plot_likelihood_surface_contour('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_likelihood_surface.csv')
p20_l_accessory = plot_likelihood_surface_contour('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_likelihood_surface.csv')
p21_l_accessory = plot_likelihood_surface_contour('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_likelihood_surface.csv')
p22_l_accessory = plot_likelihood_surface_contour('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_likelihood_surface.csv')
p23_l_accessory = plot_likelihood_surface_contour('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_likelihood_surface.csv')
p24_l_accessory = plot_likelihood_surface_contour('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_likelihood_surface.csv')
p25_l_accessory = plot_likelihood_surface_contour('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_likelihood_surface.csv')
p26_l_accessory = plot_likelihood_surface_contour('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_likelihood_surface.csv')
p27_l_accessory = plot_likelihood_surface_contour('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_likelihood_surface.csv')
p28_l_accessory = plot_likelihood_surface_contour('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_likelihood_surface.csv')
p29_l_accessory = plot_likelihood_surface_contour('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_likelihood_surface.csv')
p30_l_accessory = plot_likelihood_surface_contour('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_likelihood_surface.csv')

sfs_and_likelihood_accessory = p6a + p6_l_accessory +
  p4a + p4_l_accessory +
  p2a + p2_l_accessory + 
  p3a + p3_l_accessory + 
  p5a + p5_l_accessory +
  p23a + p23_l_accessory +
  p25a + p25_l_accessory +
  p26a + p26_l_accessory  +
  p28a + p28_l_accessory +
  p9a + p9_l_accessory +
  p8a + p8_l_accessory +
  p12a + p12_l_accessory +
  p14a + p14_l_accessory +
  p13a + p13_l_accessory +
  # p11a + p11_l_accessory +
  p16a + p16_l_accessory +
  p7a + p7_l_accessory +
  p15a + p15_l_accessory +
  p17a + p17_l_accessory +
  p1a + p1_l_accessory +
  p19a + p19_l_accessory +
  p27a + p27_l_accessory +
  p20a + p20_l_accessory +
  p21a + p21_l_accessory +
  p24a + p24_l_accessory +
  p30a + p30_l_accessory +
  p29a + p29_l_accessory +
  p22a + p22_l_accessory +
  plot_layout(ncol=2) 

png("../Supplement/Supplemental_Figure_8.png", width = 1600, height = 16000)
# 1600 x 16000 dimensions of saved image
sfs_and_likelihood_accessory
dev.off()

# Supplemental Figure 9
all_genes_phylogenetic_levels = c(
  'Bacteroidales bacterium',
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
  'Bacteroides thetaiotaomicron',
  'Bacteroides xylanisolvens',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Akkermansia muciniphila',
  'Phascolarctobacterium species',
  'Eubacterium eligens',
  'Eubacterium rectale',
  'Oscillibacter species',
  'Ruminococcus bromii',
  'Ruminococcus bicirculans',
  'Faecalibacterium prausnitzii'
)

demography_df = nu_tau_distribution[1:3]

names(demography_df) = c(
  'species',
  'nu_mle',
  'time_mle'
)

demography_df$species = factor(demography_df$species, levels=phylogenetic_levels)

species_highlight = c('Bacteroides fragilis', 'Ruminococcus bromii')

# species_highlight = c('Ruminococcus bromii')

typeface = ifelse(demography_df$species %in% species_highlight, 6, 4)

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
  #scale_x_log10(limits=c(1e-2, 2e4)) +
  #scale_y_log10(limits=c(3e2, 5e6)) +
  scale_x_log10() +
  scale_y_log10() +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16))

temp_demography_df = demography_df
temp_demography_df
temp_demography_df$species = factor(demography_df$species, levels=all_genes_phylogenetic_levels)
temp_demography_df = na.omit(temp_demography_df)

temp_demography_df <- temp_demography_df[order(temp_demography_df$species), ]
row.names(temp_demography_df) = NULL
temp_demography_df

all_genes_two_epoch_nu_tau = read.csv('../Summary/all_genes_two_epoch_demography_interpretation.csv')
all_genes_three_epoch_nu_tau = read.csv('../Summary/all_genes_three_epoch_demography_interpretation.csv', nrows=1)

all_genes_two_epoch_nu_tau$demography = 'Two Epoch'
all_genes_three_epoch_nu_tau$demography = 'Three Epoch'

all_genes_three_epoch_nu_tau = all_genes_three_epoch_nu_tau[-c(2,4:7)]

colnames(all_genes_two_epoch_nu_tau) = c('species', 'nu_mle', 'time_mle', 'time_high', 'n_anc', 'demography')
colnames(all_genes_three_epoch_nu_tau) = c('species', 'nu_mle', 'time_mle', 'time_high', 'n_anc', 'demography')
all_genes_demography_df =  rbind(all_genes_two_epoch_nu_tau, all_genes_three_epoch_nu_tau)

all_genes_demography_df

all_genes_demography_df$species = factor(all_genes_demography_df$species, levels=all_genes_phylogenetic_levels)
all_genes_demography_df <- all_genes_demography_df[order(all_genes_demography_df$species), ]
row.names(all_genes_demography_df) = NULL

all_genes_demography_df

all_genes_species_highlight = c()

all_genes_typeface = ifelse(all_genes_demography_df$species %in% all_genes_species_highlight, 4, 3)

all_genes_demography_df_highlight = all_genes_demography_df[all_genes_demography_df$species %in% all_genes_species_highlight, ]
options(ggrepel.max.overlaps = Inf)
x_label_text = expression(nu == frac(N[current], N[ancestral]))

temp_demography_scatter = ggscatter(temp_demography_df, x="nu_mle", y="time_mle", color='species', size=3) +
  ylab('Estimated time in years since most recent demographic event') +
  xlab(x_label_text) +
  geom_vline(xintercept=1.0, color='red', linewidth=1, linetype='dashed') +
  scale_shape_manual(name = "Best-Fit Demographic Model",
                     labels = c("Three Epoch", "Two Epoch"),
                     values = c(17, 19)) +
  # geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=all_genes_typeface) +
  guides(color=guide_legend(title="Species")) +
  scale_x_log10(limits=c(1e-2, 2e5)) +
  scale_y_log10(limits=c(2e2, 1e7)) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16))

temp_demography_scatter

plot_build <- ggplot_build(temp_demography_scatter)
color_mapping <- plot_build$data[[1]]$colour
print(color_mapping)

difference_plot = 
  temp_demography_scatter +
  # geom_point(data = all_genes_demography_df,  color=color_mapping, shape=18, size=1) +
  geom_segment(aes(x=temp_demography_df$nu_mle, y=temp_demography_df$time_mle,
    xend=all_genes_demography_df$nu_mle, yend=all_genes_demography_df$time_mle),
    linejoin='round',
    lineend='round',
    linetype=1,
    color=color_mapping,
    arrow = arrow(length=unit(.2, 'cm'))) +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4)

png("../Supplement/Supplemental_Figure_9.png", width = 800, height = 750)
# 800 x 750 dimensions of saved image
difference_plot
dev.off()

# Supplemental Figure 10

design = "
ABB
ACC
DEE
DFF
GHH
GII
JKK
JLL
MNN
MOO
PQQ
PRR
STT
SUU
"
p1a = plot_best_fit_sfs(a_muciniphila_best_fit_accessory) + ggtitle('Akkermansia muciniphila')
p2a = plot_best_fit_sfs(a_finegoldii_best_fit_accessory) + ggtitle('Alistipes finegoldii')
p3a = plot_best_fit_sfs(a_onderdonkii_best_fit_accessory) + ggtitle('Alistipes onderdonkii')
p4a = plot_best_fit_sfs(a_putredinis_best_fit_accessory)  + ggtitle('Alistipes putredinis')
p5a = plot_best_fit_sfs(a_shahii_best_fit_accessory) + ggtitle('Alistipes shahii')
p6a = plot_best_fit_sfs(b_bacterium_best_fit_accessory) + ggtitle('Bacteroidales bacterium')
p7a = plot_best_fit_sfs(b_caccae_best_fit_accessory) + ggtitle('Bacteroides caccae')
p8a = plot_best_fit_sfs(b_cellulosilyticus_best_fit_accessory) + ggtitle('Bacteroides cellulosilyticus')
p9a = plot_best_fit_sfs(b_fragilis_best_fit_accessory) + ggtitle('Bacteroides fragilis')
# p10a = plot_best_fit_sfs(_best_fit_accessory)
p11a = plot_best_fit_sfs(b_ovatus_best_fit_accessory) + ggtitle('Bacteroides ovatus')
p12a = plot_best_fit_sfs(b_stercoris_best_fit_accessory) + ggtitle('Bacteroides stercoris')
p13a = plot_best_fit_sfs(b_thetaiotaomicron_best_fit_accessory) + ggtitle('Bacteroides thetaiotaomicron')
p14a = plot_best_fit_sfs(b_uniformis_best_fit_accessory) + ggtitle('Bacteroides uniformis')
p15a = plot_best_fit_sfs(b_vulgatus_best_fit_accessory) + ggtitle('Bacteroides vulgatus')
p16a = plot_best_fit_sfs(b_xylanisolvens_best_fit_accessory) + ggtitle('Bacteroides xylanisolvens')
p17a = plot_best_fit_sfs(b_intestinihominis_best_fit_accessory) + ggtitle('Barnesiella intestinihominis')
# p18a = plot_best_fit_sfs(_best_fit_accessory)
p19a = plot_best_fit_sfs(d_invisus_best_fit_accessory) + ggtitle('Dialister invisus')
p20a = plot_best_fit_sfs(e_eligens_best_fit_accessory) + ggtitle('Eubacterium eligens')
p21a = plot_best_fit_sfs(e_rectale_best_fit_accessory) + ggtitle('Eubacterium rectale')
p22a = plot_best_fit_sfs(f_prausnitzii_best_fit_accessory) + ggtitle('Faecalibacterium prausnitzii')
p23a = plot_best_fit_sfs(o_splanchnicus_best_fit_accessory) + ggtitle('Odoribacter splanchnicus')
p24a = plot_best_fit_sfs(oscillibacter_sp_best_fit_accessory) + ggtitle('Oscillibacter species')
p25a = plot_best_fit_sfs(p_distasonis_best_fit_accessory) + ggtitle('Parabacteroides distasonis')
p26a = plot_best_fit_sfs(p_merdae_best_fit_accessory) + ggtitle('Parabacteroides merdae')
p27a = plot_best_fit_sfs(phascolarctobacterium_sp_best_fit_accessory) + ggtitle('Phascolarctobacterium species')
p28a = plot_best_fit_sfs(p_copri_best_fit_accessory) + ggtitle('Prevotella copri')
p29a = plot_best_fit_sfs(r_bicirculans_best_fit_accessory) + ggtitle('Ruminococcus bicirculans')
p30a = plot_best_fit_sfs(r_bromii_best_fit_accessory) + ggtitle('Ruminococcus bromii')

p1_core_dfe = plot_core_accessory_dfe('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_inferred_DFE.txt') + ggtitle('A. muciniphila, Core Genes')
p2_core_dfe = plot_core_accessory_dfe('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_inferred_DFE.txt') + ggtitle('A. finegoldii, Core Genes')
p3_core_dfe = plot_core_accessory_dfe('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_inferred_DFE.txt') + ggtitle('A. onderdonkii, Core Genes')
p4_core_dfe = plot_core_accessory_dfe('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_inferred_DFE.txt') + ggtitle('A. putredinis, Core Genes')
p5_core_dfe = plot_core_accessory_dfe('../Analysis/Alistipes_shahii_62199_downsampled_14/core_inferred_DFE.txt') + ggtitle('A. shahii, Core Genes')
p6_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. bacterium, Core Genes')
p7_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. caccae, Core Genes')
p8_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. cellulosilyticus, Core Genes')
p9_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. fragilis, Core Genes')
# p10 = plot_core_accessory_dfe('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. massiliensis, Core Genes')
p11_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. ovatus, Core Genes')
p12_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. stercoris, Core Genes')
p13_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p14_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p15_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. vulgatus, Core Genes')
p16_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. xylanisolvens, Core Genes')
p17_core_dfe = plot_core_accessory_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. intestinihominis, Core Genes')
# p18 = plot_core_accessory_dfe('../Analysis/Coprococcus_sp_62244_downsampled_14/core_inferred_DFE.txt') + ggtitle('Coprococcus species, Core Genes')
p19_core_dfe = plot_core_accessory_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/core_inferred_DFE.txt') + ggtitle('D. invisus, Core Genes')
p20_core_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_inferred_DFE.txt') + ggtitle('E. eligens, Core Genes')
p21_core_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p22_core_dfe = plot_core_accessory_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p23_core_dfe = plot_core_accessory_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_inferred_DFE.txt') + ggtitle('O. splanchnicus, Core Genes')
p24_core_dfe = plot_core_accessory_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_inferred_DFE.txt') + ggtitle('Oscillibacter species, Core Genes')
p25_core_dfe = plot_core_accessory_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt') + ggtitle('P. distasonis, Core Genes')
p26_core_dfe = plot_core_accessory_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_inferred_DFE.txt') + ggtitle('P. merdae, Core Genes')
p27_core_dfe = plot_core_accessory_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_inferred_DFE.txt') + ggtitle('Phascolarctobacterium species, Core Genes')
p28_core_dfe = plot_core_accessory_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/core_inferred_DFE.txt') + ggtitle('P.  copri, Core Genes')
p29_core_dfe = plot_core_accessory_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_inferred_DFE.txt') + ggtitle('R. bicirculans, Core Genes')
p30_core_dfe = plot_core_accessory_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_inferred_DFE.txt') + ggtitle('R.  bromii, Core Genes')

p1_acc_dfe = plot_core_accessory_dfe('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('A. muciniphila, Accessory Genes')
p2_acc_dfe = plot_core_accessory_dfe('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('A. finegoldii, Accessory Genes')
p3_acc_dfe = plot_core_accessory_dfe('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('A. onderdonkii, Accessory Genes')
p4_acc_dfe = plot_core_accessory_dfe('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('A. putredinis, Accessory Genes')
p5_acc_dfe = plot_core_accessory_dfe('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('A. shahii, Accessory Genes')
p6_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. bacterium, Accessory Genes')
p7_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. caccae, Accessory Genes')
p8_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. cellulosilyticus, Accessory Genes')
p9_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. fragilis, Accessory Genes')
# p10 = plot_core_accessory_dfe('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. massiliensis, Accessory Genes')
p11_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. ovatus, Accessory Genes')
p12_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. stercoris, Accessory Genes')
p13_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')
p14_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')
p15_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. vulgatus, Accessory Genes')
p16_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. xylanisolvens, Accessory Genes')
p17_acc_dfe = plot_core_accessory_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. intestinihominis, Accessory Genes')
# p18 = plot_core_accessory_dfe('../Analysis/Coprococcus_sp_62244_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Coprococcus species, Accessory Genes')
p19_acc_dfe = plot_core_accessory_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('D. invisus, Accessory Genes')
p20_acc_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('E. eligens, Accessory Genes')
p21_acc_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')
p22_acc_dfe = plot_core_accessory_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')
p23_acc_dfe = plot_core_accessory_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('O. splanchnicus, Accessory Genes')
p24_acc_dfe = plot_core_accessory_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Oscillibacter species, Accessory Genes')
p25_acc_dfe = plot_core_accessory_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('P. distasonis, Accessory Genes')
p26_acc_dfe = plot_core_accessory_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('P. merdae, Accessory Genes')
p27_acc_dfe = plot_core_accessory_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Phascolarctobacterium species, Accessory Genes')
p28_acc_dfe = plot_core_accessory_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('P. copri, Accessory Genes')
p29_acc_dfe = plot_core_accessory_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('R. bicirculans, Accessory Genes')
p30_acc_dfe = plot_core_accessory_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('R. bromii, Accessory Genes')

core_accessory_comparison = 
  p25a + p25_core_dfe + p25_acc_dfe +
  p14a + p14_core_dfe + p14_acc_dfe +
  p13a + p13_core_dfe + p13_acc_dfe +
  p15a + p15_core_dfe + p15_acc_dfe +
  p17a + p17_core_dfe + p17_acc_dfe +
  p21a + p21_core_dfe + p21_acc_dfe +
  p22a + p22_core_dfe + p22_acc_dfe +
  plot_layout(design=design)

png("../Supplement/Supplemental_Figure_10.png", width = 1200, height = 2800)
# 1200 x 2800 dimensions of saved image
core_accessory_comparison
dev.off()

# Supplemental Figure 11
N_anc = table_s3$`Two.epoch..Ancestral.effective.population.size`

N_curr_low = nu_tau_distribution$`nu_low` * N_anc
N_curr_high = nu_tau_distribution$`nu_high` * N_anc
N_curr_MLE = nu_tau_distribution$`nu_mle` * N_anc

N_curr_data = data.frame(
  species=phylogenetic_levels,
  N_curr_MLE = N_curr_MLE,
  N_curr_low = N_curr_low,
  N_curr_high = N_curr_high
)

N_curr_label = expression(N[current])

N_curr_data$species = factor(N_curr_data$species, levels=phylogenetic_levels)

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

png("../Supplement/Supplemental_Figure_11A.png", width = 800, height = 1200)
# 800 x 1200 dimensions of saved image
plot_N_curr_distribution
dev.off()

# Supplemental Figure 12

species_list = c('A. muciniphila',
                 'A. finegoldii',
                 'A. onderdonkii',
                 'A. putredinis',
                 'A. shahii',
                 'B. bacterium',
                 'B. caccae',
                 'B. cellulosilyticus',
                 'B. fragilis',
                 'B. ovatus',
                 'B. stercoris',
                 'B. thetaiotaomicron',
                 'B. uniformis',
                 'B. vulgatus',
                 'B. xylanisolvens',
                 'B. intestinihominis',
                 'D. invisus',
                 'E. eligens',
                 'E. rectale',
                 'F. prausnitzii',
                 'O. splanchnicus',
                 'Oscillibacter species',
                 'P. distasonis',
                 'P. merdae',
                 'Phasolarctobacterium species',
                 'P. copri',
                 'R. bicirculans',
                 'R. bromii')

num_qp_samples = c(25, 45, 62, 41, 58,
                   31, 35, 35, 31, 
                   51, 71, 67, 88, 44, 
                   50, 50, 36, 25, 
                   74, 30, 32, 47, 40, 
                   43, 17, 15, 71, 36)

core_qp_samples_per_species_csv = 
'Akkermansia_muciniphila_55200, 25
Alistipes_finegoldii_56071, 45
Alistipes_onderdonkii_55464, 62
Alistipes_putredinis_61533, 41
Alistipes_shahii_62199, 58
Bacteroidales_bacterium_58650, 31
Bacteroides_caccae_53434, 35
Bacteroides_cellulosilyticus, 35
Bacteroides_fragilis_5507, 31
Bacteroides_massiliensis_44749, 13
Bacteroides_ovatus_58035, 51
Bacteroides_stercoris, 71
Bacteroides_thetaiotaomicron_56941, 67
Bacteroides_uniformis_57318, 88
Bacteroides_vulgatus_57955, 44
Bacteroides_xylanisolvens_57185, 50
Barnesiella_intestinihominis_62208, 50
Coprococcus_sp_62244, 10
Dialest_invisus_61905, 36
Eubacterium_eligens_61678, 25
Eubacterium_rectale_56927, 74
Faecalibacterium_prausnitzii_57453, 30
Odoribacter_splanchnicus_62174, 32
Oscillibacter_sp_60799, 47
Parabacteroides_distasonis_56985, 40
Parabacteroides_merdae_56972, 43
Phasolarctobacterium_sp_59817, 17
Prevotella_copri_61740, 15
Ruminococcus_bicirculans_59300, 71
Ruminococcus_bromii_62047, 36
'

qp_samples_per_species = data.frame(species_list, as.numeric(num_qp_samples))

png("../Supplement/Supplemental_Figure_12.png", width = 800, height = 1200)
ggplot(qp_samples_per_species, aes(x = reorder(species_list, num_qp_samples), y = num_qp_samples)) +  geom_bar(stat='identity', fill='grey') +
  theme(legend.position = "none") +
  coord_flip() +
  xlab('Species') +
  ylab('Number of Quasi-phaseable samples') +
  ggtitle('Number of Quasi-phaseable samples per species from core genes')  +
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.position = "none")  +
  geom_hline(yintercept=14, linetype="dashed", color = "red") +
  theme(axis.text.y=element_text(face="italic")) +
  scale_y_continuous(breaks = seq(0, 90, by = 5))
dev.off()

# Supplemental Figure 13
pangenome_size = numeric(27)

pangenome_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650/compute_pangenome_size.log',
  '../Analysis/Alistipes_putredinis_61533/compute_pangenome_size.log',
  '../Analysis/Alistipes_finegoldii_56071/compute_pangenome_size.log',
  '../Analysis/Alistipes_onderdonkii_55464/compute_pangenome_size.log',
  '../Analysis/Alistipes_shahii_62199/compute_pangenome_size.log',
  '../Analysis/Odoribacter_splanchnicus_62174/compute_pangenome_size.log',
  '../Analysis/Parabacteroides_distasonis_56985/compute_pangenome_size.log',
  '../Analysis/Parabacteroides_merdae_56972/compute_pangenome_size.log',
  '../Analysis/Prevotella_copri_61740/compute_pangenome_size.log',
  '../Analysis/Bacteroides_fragilis_54507/compute_pangenome_size.log',
  '../Analysis/Bacteroides_cellulosilyticus_58046/compute_pangenome_size.log',
  '../Analysis/Bacteroides_stercoris_56735/compute_pangenome_size.log',
  '../Analysis/Bacteroides_uniformis_57318/compute_pangenome_size.log',
  '../Analysis/Bacteroides_thetaiotaomicron_56941/compute_pangenome_size.log',
  '../Analysis/Bacteroides_xylanisolvens_57185/compute_pangenome_size.log',
  '../Analysis/Bacteroides_caccae_53434/compute_pangenome_size.log',
  '../Analysis/Bacteroides_vulgatus_57955/compute_pangenome_size.log',
  '../Analysis/Barnesiella_intestinihominis_62208/compute_pangenome_size.log',
  '../Analysis/Akkermansia_muciniphila_55290/compute_pangenome_size.log',
  '../Analysis/Dialister_invisus_61905/compute_pangenome_size.log',
  '../Analysis/Phascolarctobacterium_sp_59817/compute_pangenome_size.log',
  '../Analysis/Eubacterium_eligens_61678/compute_pangenome_size.log',
  '../Analysis/Eubacterium_rectale_56927/compute_pangenome_size.log',
  '../Analysis/Oscillibacter_sp_60799/compute_pangenome_size.log',
  '../Analysis/Ruminococcus_bromii_62047/compute_pangenome_size.log',
  '../Analysis/Ruminococcus_bicirculans_59300/compute_pangenome_size.log',
  '../Analysis/Faecalibacterium_prausnitzii_57453/compute_pangenome_size.log'
)

for (i in 1:length(pangenome_file_list)) {
  pangenome_size[i] = get_pangenome_size(pangenome_file_list[i])
}

pangenome_size_data = data.frame(
  species=phylogenetic_levels,
  pangenome_size=pangenome_size,
  N_curr=N_curr_MLE,
  N_anc=N_anc
)

cor_pangenome_size_N_curr = cor(pangenome_size, N_curr_MLE)
plot(pangenome_size, N_curr_MLE)
abline(lm(N_curr_MLE ~ pangenome_size))
text(3000, 2E10, paste("Correlation:", round(cor_pangenome_size_N_curr, 2)), pos = 3)
text(3000, 1.5E10, paste("P-value:", round(cor.test(pangenome_size, N_curr_MLE)$p.value, 2)), pos = 3)
title('No correlation between N_curr and pangenome size')

cor_pangenome_size_N_anc = cor(pangenome_size, N_anc)
plot(pangenome_size, N_anc)
abline(lm(N_anc ~ pangenome_size))
text(3000, 3E7, paste("Correlation:", round(cor_pangenome_size_N_anc, 2)), pos = 3)
text(3000, 2.5E7, paste("P-value:", round(cor.test(pangenome_size, N_anc)$p.value, 2)), pos = 3)
title('No correlation between N_anc and pangenome size')

pangenome_size_regression = lm(N_curr_MLE ~ pangenome_size)

pangenome_size_data_reduced <- pangenome_size_data[-c(5, 17, 20, 24), ]

pangenome_size_regression_reduced = lm(pangenome_size_data_reduced$N_curr ~ pangenome_size_data_reduced$pangenome_size)

pangenome_size_scatter = ggscatter(pangenome_size_data_reduced, x="pangenome_size", y="N_curr", color="species", shape=18, size=4) +
  ylab('Estimated current effective population size') +
  xlab('Number of core and accessory genes') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=3) +
  guides(color=guide_legend(title="Species")) +
  geom_abline(intercept=pangenome_size_regression_reduced$coefficients[1], slope = pangenome_size_regression_reduced$coefficients[2],
    color="red", 
    linetype="dashed", size=1.5) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16))
  
pangenome_size_scatter

cor.test(pangenome_size_data_reduced$N_curr, pangenome_size_data_reduced$pangenome_size)

pangenome_size_scatter = ggscatter(pangenome_size_data_reduced, x="pangenome_size", y="N_anc", color="species", shape=18, size=4) +
  ylab('Estimated ancestral effective population size') +
  xlab('Number of core and accessory genes') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=3) +
  guides(color=guide_legend(title="Species")) +
  geom_abline(intercept=lm(pangenome_size_data_reduced$N_anc ~ pangenome_size_data_reduced$pangenome_size)$coefficients[1], 
    slope = lm(pangenome_size_data_reduced$N_anc ~ pangenome_size_data_reduced$pangenome_size)$coefficients[2],
    color="red", 
    linetype="dashed", size=1.5) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16))

pangenome_size_scatter

cor.test(pangenome_size_data_reduced$N_anc, pangenome_size_data_reduced$pangenome_size)

### Correlation between mean relative abundance and N_curr

N_curr_reduced = pangenome_size_data_reduced$N_curr

mean_relative_abundance = read.table(
  '../Analysis/HMP1_2_relative_abundance_prevalence/species_mean_relative_abundance.txt', 
  header=TRUE)

mean_relative_abundance

mean_relative_abundance_reduced <- mean_relative_abundance[-c(5, 17, 20, 24), ]

mean_relative_abundance_reduced = cbind(mean_relative_abundance_reduced, N_curr_reduced
  )

relative_abundance_regression = lm(N_curr_reduced ~ mean_relative_abundance_reduced$mean_relative_abundance)

cor_N_curr_relative_abundance = cor(N_curr_reduced, mean_relative_abundance_reduced$mean_relative_abundance)
plot(mean_relative_abundance_reduced$mean_relative_abundance, N_curr_reduced,
  ylab='Current effective population size',
  xlab='Mean relative abundance')
abline(lm(N_curr_reduced ~ mean_relative_abundance_reduced$mean_relative_abundance))
text(0.04, 3E7, paste("Correlation:", round(cor_N_curr_relative_abundance, 2)), pos = 3)
text(0.04, 2.5E7, paste("P-value:", round(cor.test(N_curr_reduced, mean_relative_abundance_reduced$mean_relative_abundance)$p.value, 2)), pos = 3)
title('No correlation between current effective population size and mean relative abundance')

# 1000 x 1000

mean_relative_abundance_scatter = ggscatter(mean_relative_abundance_reduced, x="mean_relative_abundance", y="N_curr_reduced", color="species_id", shape=18, size=4) +
  ylab('Estimated current effective population size') +
  xlab('Mean relative abundance') +
  geom_text_repel(aes(label = species_id, color=species_id, fontface = 'italic'), size=3) +
  guides(color=guide_legend(title="Species")) +
  geom_abline(intercept=relative_abundance_regression$coefficients[1], slope = relative_abundance_regression$coefficients[2],
    color="red", 
    linetype="dashed", size=1.5) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Correlation: 0.13, P-value: 0.54')
  
png("../Supplement/Supplemental_Figure_13A.png", width = 1200, height = 1200)
mean_relative_abundance_scatter
dev.off()

### Correlation between prevalence and N_curr

species_prevalence = read.table(
  '../Analysis/HMP1_2_relative_abundance_prevalence/species_prevalence_filtered.txt',
  header=TRUE
)

species_prevalence
species_prevalence$species_id = factor(species_prevalence$species_id,
  levels=phylogenetic_levels_MIDAS)

species_prevalence = species_prevalence[order(species_prevalence$species_id), ]
row.names(species_prevalence) = NULL

species_prevalence

species_prevalence_reduced <- species_prevalence[-c(5, 17, 20, 24), ]

species_prevalence_reduced <- species_prevalence[-c(5, 17, 20, 24), ]

species_prevalence_reduced = cbind(species_prevalence_reduced, N_curr_reduced
  )

species_prevalence_regression = lm(N_curr_reduced ~ species_prevalence_reduced$prevalence)

cor_N_curr_prevalence = cor(N_curr_reduced, species_prevalence_reduced$prevalence)
plot(species_prevalence_reduced$prevalence, N_curr_reduced,
  ylab='Current effective population size',
  xlab='Species prevalence')
abline(lm(N_curr_reduced ~ species_prevalence_reduced$prevalence))
text(100, 3E7, paste("Correlation:", round(cor_N_curr_prevalence, 2)), pos = 3)
text(100, 2.5E7, paste("P-value:", round(cor.test(N_curr_reduced, species_prevalence_reduced$prevalence)$p.value, 2)), pos = 3)
title('No correlation between current effective population size and species prevalence')
  
prevalence_scatter = ggscatter(species_prevalence_reduced, x="prevalence", y="N_curr_reduced", color="species_id", shape=18, size=4) +
  ylab('Estimated current effective population size') +
  xlab('Species prevalence') +
  geom_text_repel(aes(label = species_id, color=species_id, fontface = 'italic'), size=3) +
  guides(color=guide_legend(title="Species")) +
  geom_abline(intercept=species_prevalence_regression$coefficients[1], slope = species_prevalence_regression$coefficients[2],
    color="red", 
    linetype="dashed", size=1.5) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Correlation: -0.08, P-value: 0.72')
  
png("../Supplement/Supplemental_Figure_13B.png", width = 1200, height = 1200)
prevalence_scatter
dev.off()

# Supplemental Figure 14
accessory_core_demography = data.frame(species=phylogenetic_levels, 
  core_nu = numeric(27),
  core_years = numeric(27),
  core_na = numeric(27),
  acc_nu = numeric(27),
  acc_years = numeric(27),
  acc_na = numeric(27))

accessory_two_epoch_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Prevotella_copri_61740_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_two_epoch_demography.txt'
)


for (i in 1:length(two_epoch_file_list)) {
  accessory_core_demography[i, 2:4] = read_demography_info(two_epoch_file_list[i])
  accessory_core_demography[i, 5:7] = read_demography_info(accessory_two_epoch_file_list[i])
}

colnames(accessory_core_demography) = c('Species', 
  'Core, Nu',
  'Core, Years',
  'Core, N_anc',
  'Accessory, Nu',
  'Accessory, Years',
  'Accessory, N_Anc')

# write.csv(accessory_core_demography, '../Summary/accessory_core_demography_comparison.csv', row.names=FALSE)

accessory_core_demography$`Accessory, N_Anc`
accessory_core_demography[c(7, 13, 14, 17, 18, 22, 23, 27), ]
accessory_core_demography_reduced = accessory_core_demography[c(7, 13, 14, 17, 18, 23, 27), ]

accessory_core_demography_reduced$`Core, N_anc`
accessory_core_demography_reduced$`Accessory, N_Anc`

accessory_core_demography_scatter = ggscatter(accessory_core_demography_reduced, x="Core, N_anc", y="Accessory, N_Anc", color="Species", shape=18, size=4) +
  ylab('Estimated current effective population size') +
  xlab('species accessory_core_demography') +
  geom_text_repel(aes(label = Species, color=Species, fontface = 'italic'), size=3) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none')  +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ylim(0, 3E7) +
  xlim(0, 3E7) +
  xlab('Ancestral effective population size, Accessory genes') +
  ylab('Ancestral effective population size, Core genes') +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed")

png("../Supplement/Supplemental_Figure_14.png", width = 800, height = 800)
accessory_core_demography_scatter
dev.off()