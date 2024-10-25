setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# DFE Comparison

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

### Figure 3
# 600 x 1000

figure_3 = ggplot(fd_core_dfe_df[fd_core_dfe_df$variable == 'gamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e1)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic', hjust=0, size=18)) +
  theme(axis.text.x = element_text(size=18)) + 
  theme(legend.position = "none") + 
  xlab('Selection Coefficient')

# dev.off()

ggsave('../Summary/figure_3_output.svg', figure_3, width=9, height=15, units='in', dpi=600)

