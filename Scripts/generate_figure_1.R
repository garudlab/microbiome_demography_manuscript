setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

supplementary_demography_file_list = c(
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

supplementary_likelihood_surface_list = c(
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

supplementary_downsampled_sfs_file_list = c(
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

old_full_sfs_file_list = c(
  '../Analysis/Akkermansia_muciniphila_55290/core_empirical_syn_sfs.txt',
  '../Analysis/Alistipes_finegoldii_56071/core_empirical_syn_sfs.txt',
  '../Analysis/Alistipes_onderdonkii_55464/core_empirical_syn_sfs.txt',
  '../Analysis/Alistipes_putredinis_61533/core_empirical_syn_sfs.txt',
  '../Analysis/Alistipes_shahii_62199/core_empirical_syn_sfs.txt',
  '../Analysis/Alistipes_sp_60764/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroidales_bacterium_58650/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_caccae_53434/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_coprocola_61586/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_eggerthii_54457/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_fragilis_54507/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_massiliensis_44749/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_plebeius_61623/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_stercoris_56735/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_uniformis_57318/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_vulgatus_57955/core_empirical_syn_sfs.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185/core_empirical_syn_sfs.txt',
  '../Analysis/Barnesiella_intestinihominis_62208/core_empirical_syn_sfs.txt',
  '../Analysis/Coprococcus_sp_62244/core_empirical_syn_sfs.txt',
  '../Analysis/Dialister_invisus_61905/core_empirical_syn_sfs.txt',
  '../Analysis/Eubacterium_eligens_61678/core_empirical_syn_sfs.txt',
  '../Analysis/Eubacterium_rectale_56927/core_empirical_syn_sfs.txt',
  '../Analysis/Eubacterium_siraeum_57634/core_empirical_syn_sfs.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453/core_empirical_syn_sfs.txt',
  '../Analysis/Faecalibacterium_prausnitzii_61481/core_empirical_syn_sfs.txt',
  '../Analysis/Faecalibacterium_prausnitzii_62201/core_empirical_syn_sfs.txt',
  '../Analysis/Lachnospiraceae_bacterium_51870/core_empirical_syn_sfs.txt',
  '../Analysis/Odoribacter_splanchnicus_62174/core_empirical_syn_sfs.txt',
  '../Analysis/Oscillibacter_sp_60799/core_empirical_syn_sfs.txt',
  '../Analysis/Parabacteroides_distasonis_56985/core_empirical_syn_sfs.txt',
  '../Analysis/Parabacteroides_merdae_56972/core_empirical_syn_sfs.txt',
  '../Analysis/Phascolarctobacterium_sp_59817/core_empirical_syn_sfs.txt',
  '../Analysis/Prevotella_copri_61740/core_empirical_syn_sfs.txt',
  '../Analysis/Roseburia_intestinalis_56239/core_empirical_syn_sfs.txt',
  '../Analysis/Roseburia_inulinivorans_61943/core_empirical_syn_sfs.txt',
  '../Analysis/Ruminococcus_bicirculans_59300/core_empirical_syn_sfs.txt',
  '../Analysis/Ruminococcus_bromii_62047/core_empirical_syn_sfs.txt'
)

supplementary_full_sfs_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_empirical_syn_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_syn_sfs.txt'
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

prevalence_df = read.csv('../Data/species_prevalence.csv')
prevalence_df = prevalence_df[, c(1, 6)]
prevalence_df = prevalence_df %>% arrange(species_id)

supplementary_demography_df = data.frame(species=supplementary_species_list,
  new_sample_size=numeric(39),
  old_sample_size=numeric(39)
)

for (i in 1:length(supplementary_species_list)) {
  supplementary_demography_df[i, 2] = get_species_prevalence(supplementary_full_sfs_file_list[i])
  if (file.exists(old_full_sfs_file_list[i])) {
    supplementary_demography_df[i, 3] = get_species_prevalence(old_full_sfs_file_list[i])
  }
}

supplementary_demography_df

prevalence_df = cbind(supplementary_demography_df, prevalence_df)

prevalence_df = prevalence_df[, c(1, 2, 5)]
prevalence_df$species = reorder(prevalence_df$species, prevalence_df$prevalence)
prevalence_df = prevalence_df %>% arrange(desc(prevalence))

prevalence_df = prevalence_df[, c(1, 3, 2)]

ggplot(melt(prevalence_df), aes(x=species, y=value, fill=variable)) +
  geom_bar(stat='identity', position = "identity") +
  coord_flip() +
  labs(title = "Sample Size by Species",
       x = "Species",
       y = "Sample Size",
  fill = "Data") +
  scale_fill_manual(labels = c("Non-QP samples", "QP samples"), values = c("lightblue", "blue")) +
  theme_minimal() +
  theme(axis.text.y = element_text(face = 'italic'))

supplementary_demography_df = supplementary_demography_df %>% arrange(desc(new_sample_size))
supplementary_demography_df$species = reorder(supplementary_demography_df$species, supplementary_demography_df$new_sample_size)

### Fig 1A

fig_1A = ggplot(supplementary_demography_df, aes(x = reorder(species, new_sample_size), y = new_sample_size)) +
  geom_bar(stat = "identity", color='black', fill='darkblue') +
  coord_flip() +
  # labs(title = "Number of QP samples by species",
  #      x = "Species",
  #      y = "Number of QP samples",
  #   ) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(axis.text.y = element_text(face = 'italic')) +
  theme(axis.text.y = element_text(size=16)) +
  theme(axis.text.x = element_text(size=16)) +
  theme(axis.title = element_blank()) +
  theme(plot.title = element_text(size=20))

ggsave('../Summary/figure_1_output.svg', fig_1A, width=6, height=4, units='in', dpi=600)