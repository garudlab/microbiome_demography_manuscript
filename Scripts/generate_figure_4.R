setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# DFE Comparison

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

### Figure 4
# 600 x 1000

png("../Summary/figure_4_output.png", width = 600, height = 1000)
ggplot(dfe_df[dfe_df$variable == 'gamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
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