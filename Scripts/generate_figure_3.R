setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

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

b_fragilis_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
b_fragilis_core_two_epoch = sfs_from_demography('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_two_epoch_demography.txt') 
b_fragilis_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
b_fragilis_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_inferred_DFE.txt') 

r_bromii_hmp_qp_syn = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_syn_downsampled_sfs.txt'))
r_bromii_core_two_epoch = sfs_from_demography('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_two_epoch_demography.txt') 
r_bromii_hmp_qp_nonsyn = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt'))
r_bromii_core_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_inferred_DFE.txt') 

one_epoch_14 = sfs_from_demography('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_one_epoch_demography.txt')
x_axis = 1:length(one_epoch_14)

b_fragilis_best_fit = cbind(
  proportional_sfs(b_fragilis_hmp_qp_syn[-1]),
  proportional_sfs(b_fragilis_core_two_epoch),
  proportional_sfs(b_fragilis_hmp_qp_nonsyn[-1]),
  proportional_sfs(b_fragilis_core_gamma_dfe),
  rep('B. fragilis', length(b_fragilis_hmp_qp_syn[-1])),
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

# 2000 x 900

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

demography_scatter

design = c(
  area(1, 1, 1, 1),
  area(1, 2, 1, 2),
  area(2, 1, 2, 1),
  area(2, 2, 2, 2),
  area(1, 3, 2, 6)
)

p9 = plot_best_fit_sfs_3A(b_fragilis_best_fit) + ggtitle('Bacteroides fragilis')
p9_l = plot_likelihood_surface_contour_3C('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_likelihood_surface.csv')

p30 = plot_best_fit_sfs_3B(r_bromii_best_fit) + ggtitle('Ruminococcus bromii')
p30_l = plot_likelihood_surface_contour_3D('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_likelihood_surface.csv')

### Figure 3
# 2000 x 900 dimensions for saved image


png("../Summary/figure_3_output.png", width = 2000, height = 900)
p9 + p9_l + # B. fragilis
  p30 + p30_l + #R. bicirculans
  demography_scatter +
  plot_layout(design=design)

dev.off()
