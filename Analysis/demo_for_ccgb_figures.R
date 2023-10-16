# nsf_grfp_preliminary_results
library(ggplot2)
library(ggrepel)
library(ggsignif)
# install.packages("ggpubr")
library(ggpubr)
library(dplyr)
library(fitdistrplus)
library(scales)
library(reshape2)
library(patchwork)

fold_sfs = function(input_sfs) {
  input_length = length(input_sfs)
  folded_length = length(input_sfs) / 2
  if (input_length %% 2 == 0) {
    folded_length = folded_length + 1
  }
  output_sfs = c()
  for (i in 1:folded_length) {
    if (input_sfs[i] == input_sfs[input_length - i + 1]) {
      output_sfs[i] = input_sfs[i]
    } else {
      output_sfs[i] = input_sfs[i] + input_sfs[input_length - i + 1]
    }
  }
  return(output_sfs)
}

proportional_sfs = function(input_sfs) {
  input_sfs[1] = 0
  return (input_sfs / sum(input_sfs))
}

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Pi comparison

pi_summary_df = data.frame(read.csv('summarized_pi.csv', header=TRUE))
# write.csv(pi_summary_df, file='summarized_pi.csv',  row.names=FALSE)
names(pi_summary_df) = c('species', 'Cohort', 'average_pi', 'num_sites', 
                         'num_samples', 'aggregate_across_pi', 'pairwise_across_pi')

# pi_summary_df$num_samples * pi_summary_df$across_pi
# actual_across_pi = pi_summary_df$num_samples * pi_summary_df$across_pi
# pi_summary_df$across_pi = actual_across_pi
# pi_summary_df
# write.csv(pi_summary_df, './summarized_pi_fixed.csv', row.names=FALSE)
# write.csv(Your DataFrame,"Path to export the DataFrame\\File Name.csv", row.names = FALSE)

overlapping_list = c('Akkermansia_muciniphila_55290',
                     'Alistipes_finegoldii_56071',
                     'Alistipes_onderdonkii_55464',
                     'Alistipes_putredinis_61533',
                     'Alistipes_senegalensis_58364',
                     'Alistipes_shahii_62199',
                     'Anaerostipes_hadrus_55206',
                     'Bacteroides_caccae_53434',
                     'Bacteroides_finegoldii_57739',
                     'Bacteroides_fragilis_54507',
                     'Bacteroides_thetaiotaomicron_56941',
                     'Bacteroides_uniformis_57318',
                     'Bacteroides_vulgatus_57955',
                     'Bacteroides_xylanisolvens_57185'	,
                     'Barnesiella_intestinihominis_62208',
                     'Bifidobacterium_longum_57796',
                     'Bifidobacterium_pseudocatenulatum_57754',
                     'Bilophila_wadsworthia_57364',
                     'Blautia_wexlerae_56130',
                     'Butyricimonas_virosa_58742',
                     'Butyrivibrio_crossotus_61674',
                     'Clostridiales_bacterium_56470',
                     'Clostridiales_bacterium_61057',
                     'Clostridium_sp_61482',
                     'Collinsella_sp_62205',
                     'Coprococcus_sp_62244',
                     'Dialister_invisus_61905',
                     'Dorea_longicatena_59913',
                     'Dorea_longicatena_61473',
                     'Escherichia_coli_58110',
                     'Eubacterium_eligens_61678',
                     'Eubacterium_hallii_61477',
                     'Eubacterium_ramulus_59802',
                     'Eubacterium_rectale_56927',
                     'Eubacterium_siraeum_57634',
                     'Faecalibacterium_cf_62236',
                     'Faecalibacterium_prausnitzii_57453',
                     'Faecalibacterium_prausnitzii_61481',
                     'Faecalibacterium_prausnitzii_62201',
                     'Guyana_massiliensis_60772',
                     'Haemophilus_parainfluenzae_62356',
                     'Intestinimonas_butyriciproducens_60001',
                     'Odoribacter_splanchnicus_62174',
                     'Oscillibacter_sp_60799',
                     'Parabacteroides_distasonis_56985',
                     'Parabacteroides_merdae_56972',
                     'Phascolarctobacterium_sp_59817',
                     'Phascolarctobacterium_succinatutens_61948',
                     'Prevotella_copri_61740',
                     'Roseburia_hominis_61877',
                     'Roseburia_intestinalis_56239',
                     'Roseburia_inulinivorans_61943',
                     'Ruminococcus_bicirculans_59300',
                     'Ruminococcus_bromii_62047',
                     'Ruminococcus_gnavus_57638',
                     'Ruminococcus_lactaris_55568',
                     'Ruminococcus_obeum_61472',
                     'Ruminococcus_sp_55468',
                     'Ruminococcus_torques_62045',
                     'Sutterella_wadsworthensis_56828',
                     'Veillonella_atypica_58169',
                     'Veillonella_dispar_61763',
                     'Veillonella_parvula_57794')

list_over_20 = c('Eubacterium_eligens_61678',
                 'Faecalibacterium_cf_62236',
                 'Faecalibacterium_prausnitzii_57453',
                 'Faecalibacterium_prausnitzii_61481',
                 'Faecalibacterium_prausnitzii_62201',
                 'Oscillibacter_sp_60799',
                 'Prevotella_copri_61740',
                 'Roseburia_inulinivorans_61943',
                 'Ruminococcus_bromii_62047',
                 'Ruminococcus_torques_62045')

list_over_10 = c('Bifidobacterium_longum_57796',
                 'Blautia_wexlerae_56130',
                 'Butyrivibrio_crossotus_61674',
                 'Clostridium_sp_61482',
                 'Escherichia_coli_58110',
                 'Eubacterium_eligens_61678',
                 'Faecalibacterium_cf_62236',
                 'Faecalibacterium_prausnitzii_57453',
                 'Faecalibacterium_prausnitzii_61481',
                 'Faecalibacterium_prausnitzii_62201',
                 'Oscillibacter_sp_60799',
                 'Prevotella_copri_61740',
                 'Roseburia_inulinivorans_61943',
                 'Ruminococcus_bromii_62047',
                 'Ruminococcus_torques_62045')

list_iid = c('Bifidobacterium_longum_57796',
             'Blautia_wexlerae_56130',
             'Butyrivibrio_crossotus_61674',
             'Escherichia_coli_58110',
             'Eubacterium_eligens_61678',
             'Faecalibacterium_cf_62236',
             'Faecalibacterium_prausnitzii_57453',
             'Faecalibacterium_prausnitzii_61481',
             'Faecalibacterium_prausnitzii_62201',
             'Oscillibacter_sp_60799',
             'Prevotella_copri_61740',
             'Roseburia_inulinivorans_61943',
             'Ruminococcus_bromii_62047')

over_iid_df = subset(pi_summary_df, species %in% list_iid)

over_20_df = subset(pi_summary_df, 
                    species %in% list_over_20)

species_labels_20 = c('Eubacterium eligens',
                      'Faecalibacterium cf',
                      'Faecalibacterium prausnitzii (57453)',
                      'Faecalibacterium prausnitzii (61481)',
                      'Faecalibacterium prausnitzii (62201)',
                      'Oscillibacter species',
                      'Prevotella copri',
                      'Ruminococcus inulinivorans',
                      'Ruminococcus bromii',
                      'Ruminococcus torques')

species_labels_10 = c('Bifidobacterium longum',
                      'Blautia wexlerae',
                      'Butyrivibrio crossotus',
                      'Coprococcus species',
                      'Escherichia coli',
                      'Eubacterium eligens',
                      'Faecalibacterium cf',
                      'Faecalibacterium prausnitzii (57453)',
                      'Faecalibacterium prausnitzii (61481)',
                      'Faecalibacterium prausnitzii (62201)',
                      'Oscillibacter species',
                      'Prevotella copri',
                      'Roseburia inulinivorans',
                      'Ruminococcus bromii',
                      'Ruminococcus torques')

over_10_df = subset(pi_summary_df,
                    species %in% list_over_10)

# Aggregate
aggregate_pi_comparison_20 <- ggplot(data=over_20_df, aes(x=species, y=average_pi, fill=Cohort)) +
  geom_boxplot(position=position_dodge(width=1)) +
  geom_point(aes(x=species, y=aggregate_across_pi, color=Cohort), size=3, shape=18) +
  theme(axis.text.x = element_text(angle=50, vjust=1.0, hjust=1)) +
  scale_shape_manual(values = c(21:23)) + 
  stat_compare_means(label = "p.signif", method = "t.test") +
  scale_x_discrete(breaks=list_over_20) +
  guides(fill=guide_legend(title="Cohort")) +
  ggtitle('Pi within hosts and aggregated across hosts, Minimum #samples >= 20') +
  xlab('Species') + 
  ylab('Average within-host pi') +
  theme(plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank())
  
aggregate_pi_comparison_20

position_jitterdodge(
  jitter.width = NULL,
  jitter.height = 0,
  dodge.width = 0.5,
  seed = NA
)

better_pi_comparison_20 <- ggplot(data=over_20_df, aes(x=species, y=average_pi, fill=Cohort)) +
  geom_boxplot(aes(fill=Cohort), outlier.shape=NA) +
  geom_point(pch = 21, position = position_jitterdodge(), size=1.5) +
  geom_point(aes(x=species, y=aggregate_across_pi, color=Cohort), size=4, shape=18, position=position_dodge(width=0.75)) +
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(axis.text.x = element_text(angle=90, vjust=1.0, hjust=1)) +
  xlab('Species') + 
  ylab('Average within-host pi') +
  ggtitle('Pi within hosts and aggregated across hosts, Minimum #samples >= 20')
better_pi_comparison_20

temp = subset(over_20_df, Cohort==" African", select=c(species, Cohort, average_pi, num_sites, num_samples, aggregate_across_pi, pairwise_across_pi))
temp$aggregate_across_pi = temp$aggregate_across_pi / 2

better_pi_comparison_20 <- ggplot(data=temp, aes(x=species, y=average_pi, fill=Cohort)) +
  geom_boxplot(aes(fill=Cohort), outlier.shape=NA) +
  geom_point(pch = 21, position = position_jitterdodge(), size=1.5) +
  geom_point(aes(x=species, y=aggregate_across_pi, color=Cohort), size=4, shape=18, position=position_dodge(width=0.75)) +
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(axis.text.x = element_text(angle=90, vjust=1.0, hjust=1)) +
  xlab('Species') + 
  ylab('Average within-host pi') +
  ggtitle('Pi within hosts and aggregated across hosts, Minimum #samples >= 20')
better_pi_comparison_20

aggregate_pi_comparison_10 <- ggplot(data=over_10_df, aes(x=species, y=average_pi, fill=Cohort)) +
  geom_boxplot(position=position_dodge(width=1)) +
  # geom_point(position=position_dodge(width=0.75),aes(group=cohort), size=1) +
  # geom_jitter(aes(color=cohort), size=0.2) +
  geom_point(aes(x=species, y=aggregate_across_pi, color=Cohort), size=3, shape=18) +
  theme(axis.text.x = element_text(angle=50, vjust=1.0, hjust=1)) +
  scale_shape_manual(values = c(21:23)) + 
  stat_compare_means(label = "p.signif", method = "t.test") +
  scale_x_discrete(breaks=list_over_10,
                   labels=species_labels_10) +
  guides(fill=guide_legend(title="Cohort")) +
  ggtitle('Pi within hosts and aggregated across hosts, Minimum #samples >= 10') +
  xlab('Species') +
  ylab('Average within-host pi')

aggregate_pi_comparison_10

better_pi_comparison_10 <- ggplot(data=over_10_df, aes(x=species, y=average_pi, fill=Cohort)) +
  geom_boxplot(aes(fill=Cohort), outlier.shape=NA) +
  geom_point(pch = 21, position = position_jitterdodge(), size=1.5) +
  geom_point(aes(x=species, y=aggregate_across_pi, color=Cohort), size=4, shape=18, position=position_dodge(width=0.75)) +
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(axis.text.x = element_text(angle=90, vjust=1.0, hjust=1)) +
  xlab('Species') + 
  ylab('Average within-host pi') +
  ggtitle('Pi within hosts and aggregated across hosts, Minimum #samples >= 10')
better_pi_comparison_10

# Pairwise
pairwise_pi_comparison_20 <- ggplot(data=over_20_df, aes(x=species, y=average_pi, fill=Cohort)) +
  geom_boxplot(position=position_dodge(width=1)) +
  # geom_point(position=position_dodge(width=0.75),aes(group=cohort), size=1) +
  # geom_jitter(aes(color=cohort), size=0.2) +
  geom_point(aes(x=species, y=pairwise_across_pi, color=Cohort), size=3, shape=18) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
  scale_shape_manual(values = c(21:23))  +
  stat_compare_means(label = "p.signif", method = "t.test") +
  ggtitle('Pi within hosts and distributed across hosts, Minimum #samples >= 10') +
  xlab('Species') +
  ylab('Average within-host pi')

pairwise_pi_comparison_20

pairwise_pi_comparison_10 <- ggplot(data=over_10_df, aes(x=species, y=average_pi, fill=Cohort)) +
  geom_boxplot(position=position_dodge(width=1)) +
  # geom_point(position=position_dodge(width=0.75),aes(group=cohort), size=1) +
  # geom_jitter(aes(color=cohort), size=0.2) +
  geom_point(aes(x=species, y=pairwise_across_pi, color=Cohort), size=3, shape=18) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
  scale_shape_manual(values = c(21:23)) + 
  stat_compare_means(label = "p.signif", method = "t.test") +
  ggtitle('Pi within hosts and distributed across hosts, Minimum #samples >= 10') +
  xlab('Species') +
  ylab('Average within-host pi')

pairwise_pi_comparison_20 <- ggplot(data=over_20_df, aes(x=species, y=average_pi, fill=Cohort)) +
  geom_boxplot(position=position_dodge(width=1)) +
  # geom_point(position=position_dodge(width=0.75),aes(group=cohort), size=1) +
  # geom_jitter(aes(color=cohort), size=0.2) +
  # geom_point(aes(x=species, y=pairwise_across_pi, color=cohort), size=3, shape=18) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
  scale_shape_manual(values = c(21:23))  +
  stat_compare_means(label = "p.signif", method = "t.test") +
  ggtitle('Pi within hosts, Minimum #samples >= 20') +
  xlab('Species') +
  ylab('Average within-host pi') +
  scale_x_discrete(breaks=unique(over_20_df$species), labels=c('E. eligens', 'F. cf', 'F. prausnitzii1 ',
                                                               'F. prausnitzii 2', 'F. prausnitzii 3',
                                                               'O. sp', 'P. copri', 'R. inulinivorans',
                                                               'R. bromii', 'R. torques'))

pairwise_pi_comparison_20

pairwise_pi_comparison_10 + stat_compare_means(label = "p.signif", method = "t.test")

across_host_pi_comparison_10 <- ggplot(data=over_10_df, aes(x=aggregate_across_pi, y=pairwise_across_pi, color=Cohort)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  xlab('Aggregate across-host pi') +
  ylab('Pairwise distributed across-host pi')
across_host_pi_comparison_10

# aggregate across host pi
aggregate_over_10 = over_10_df[c('species', 'Cohort', 'aggregate_across_pi')]
aggregate_over_10 = distinct(aggregate_over_10)
aggregate_HMP_over_10 = aggregate_over_10[aggregate_over_10$cohort==' HMP', ]
aggregate_African_over_10 = aggregate_over_10[aggregate_over_10$cohort==' African', ]
aggregate_over_10 = rbind(aggregate_African_over_10, aggregate_HMP_over_10)
# cohort aggregate_comparison

# cohort_aggregate_comparison <- ggpaired(data=aggregate_over_10, x='Cohort', y='aggregate_across_pi', color='cohort', line.color='grey') +
#   theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
#   scale_shape_manual(values = c(21:23)) + 
#   stat_compare_means(method = "t.test", paired=TRUE, label.y=0.06, label.x=1.5) +
#   ggtitle('Aggregate pi across hosts by cohort, Minimum #samples >= 10') +
#   xlab('Cohort') +
#   ylab('Aggregate across-host pi')
# cohort_aggregate_comparison

# pairwise across host pi
# pairwise_over_10 = over_10_df[c('species', 'cohort', 'pairwise_across_pi')]
# pairwise_over_10 = distinct(pairwise_over_10)
# pairwise_HMP_over_10 = pairwise_over_10[pairwise_over_10$cohort==' HMP', ]
# pairwise_African_over_10 = pairwise_over_10[pairwise_over_10$cohort==' African', ]
# pairwise_over_10 = rbind(pairwise_African_over_10, pairwise_HMP_over_10)
# cohort aggregate_comparison

# cohort_pairwise_comparison <- ggpaired(data=pairwise_over_10, x='cohort', y='pairwise_across_pi', color='cohort', line.color='grey') +
#   theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
#   scale_shape_manual(values = c(21:23)) + 
#   stat_compare_means(method = "t.test", paired=TRUE, label.y=0.06, label.x=1.5) +
#   ggtitle('Pairwise distributed pi across hosts by cohort, Minimum #samples >= 10') +
#   xlab('Cohort') +
#   ylab('Pairwise distributed across-host pi')
# cohort_pairwise_comparison

set.seed(1)

over_iid_df$ordered_pi = 0

over_iid_df[over_iid_df$species=='Bifidobacterium_longum_57796' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Bifidobacterium_longum_57796' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Bifidobacterium_longum_57796' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Bifidobacterium_longum_57796' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Blautia_wexlerae_56130' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Blautia_wexlerae_56130' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Blautia_wexlerae_56130' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Blautia_wexlerae_56130' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Butyrivibrio_crossotus_61674' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Butyrivibrio_crossotus_61674' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Butyrivibrio_crossotus_61674' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Butyrivibrio_crossotus_61674' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Eubacterium_eligens_61678' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Eubacterium_eligens_61678' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Eubacterium_eligens_61678' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Eubacterium_eligens_61678' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Escherichia_coli_58110' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Escherichia_coli_58110' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Escherichia_coli_58110' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Escherichia_coli_58110' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Faecalibacterium_cf_62236' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Faecalibacterium_cf_62236' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Faecalibacterium_cf_62236' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Faecalibacterium_cf_62236' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_61481' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_61481' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_61481' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_61481' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_57453' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_57453' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_57453' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_57453' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_62201' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_62201' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_62201' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Faecalibacterium_prausnitzii_62201' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Oscillibacter_sp_60799' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Oscillibacter_sp_60799' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Oscillibacter_sp_60799' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Oscillibacter_sp_60799' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Prevotella_copri_61740' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Prevotella_copri_61740' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Prevotella_copri_61740' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Prevotella_copri_61740' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Roseburia_inulinivorans_61943' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Roseburia_inulinivorans_61943' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Roseburia_inulinivorans_61943' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Roseburia_inulinivorans_61943' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Ruminococcus_bromii_62047' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Ruminococcus_bromii_62047' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Ruminococcus_bromii_62047' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Ruminococcus_bromii_62047' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

over_iid_df[over_iid_df$species=='Ruminococcus_bromii_62047' & over_iid_df$Cohort==' HMP', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Ruminococcus_bromii_62047' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)
over_iid_df[over_iid_df$species=='Ruminococcus_bromii_62047' & over_iid_df$Cohort==' African', ]$ordered_pi = 
  mean(over_iid_df[over_iid_df$species=='Ruminococcus_bromii_62047' & over_iid_df$Cohort==' African', ]$pairwise_across_pi)

# better_pi_comparison_10 <- ggplot(data=over_10_df, aes(x=reorder(species, ordered_pi), y=average_pi, fill=Cohort)) +
#   geom_boxplot(aes(fill=Cohort), outlier.shape=NA) +
#   geom_point(pch = 21, position = position_jitterdodge(), size=1.5) +
#   geom_point(aes(x=species, y=pairwise_across_pi, color=Cohort), size=4, shape=16, position=position_dodge(width=0.75)) +
#   theme_bw() +
#   theme(plot.background = element_blank(),
#         panel.grid.major = element_blank(),
#         panel.grid.minor = element_blank()) +
#   theme(axis.text.x = element_text(angle=90, vjust=1.0, hjust=1)) +
#   xlab('Species') + 
#   ylab('Average within-host pi') +
#   ggtitle('Pi within hosts and aggregated across hosts, Minimum #samples >= 20')
# better_pi_comparison_10

unique(over_iid_df$species)
over_iid_df$species[over_iid_df$species == 'Bifidobacterium_longum_57796'] = 'Bifidobacterium longum'
over_iid_df$species[over_iid_df$species == 'Blautia_wexlerae_56130'] = 'Blautia wexlerae'
over_iid_df$species[over_iid_df$species == 'Butyrivibrio_crossotus_61674'] = 'Butyrivibrio crossotus'
over_iid_df$species[over_iid_df$species == 'Eubacterium_eligens_61678'] = 'Eubacterium eligens'
over_iid_df$species[over_iid_df$species == 'Escherichia_coli_58110'] = 'Escherichia coli'
over_iid_df$species[over_iid_df$species == 'Faecalibacterium_prausnitzii_61481'] = 'Faecalibacterium prausnitzii (61481)'
over_iid_df$species[over_iid_df$species == 'Faecalibacterium_prausnitzii_57453'] = 'Faecalibacterium prausnitzii (57453)'
over_iid_df$species[over_iid_df$species == 'Faecalibacterium_prausnitzii_62201'] = 'Faecalibacterium prausnitzii (62201)'
over_iid_df$species[over_iid_df$species == 'Faecalibacterium_cf_62236'] = 'Faecalibacterium cf'
over_iid_df$species[over_iid_df$species == 'Oscillibacter_sp_60799'] = 'Oscillibacter species'
over_iid_df$species[over_iid_df$species == 'Prevotella_copri_61740'] = 'Prevotella copri'
over_iid_df$species[over_iid_df$species == 'Roseburia_inulinivorans_61943'] = 'Roseburia inulinovrans'
over_iid_df$species[over_iid_df$species == 'Ruminococcus_bromii_62047'] = 'Ruminococcus bromii'

better_pi_comparison_iid <- ggplot(data=over_iid_df, aes(x=reorder(species, ordered_pi), y=average_pi, fill=Cohort)) +
  geom_boxplot(aes(fill=Cohort), outlier.shape=NA) +
  geom_point(pch = 21, position = position_jitterdodge(), size=1.5) +
  geom_point(aes(x=species, y=pairwise_across_pi, color=Cohort), size=4, shape=16, position=position_dodge(width=0.75)) +
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(axis.text.x = element_text(size=rel(1.5), angle=60, vjust=1.0, hjust=1)) +
  theme(axis.text.y = element_text(size=rel(1.5))) +
  theme(axis.title.x = element_text(size=rel(1.5))) +
  theme(axis.title.y = element_text(size=rel(1.5))) +
  theme(legend.text = element_text(size=rel(1.25))) +
  theme(legend.title = element_text(size=rel(1.5))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x,)),
                limits = c(0.0001, 0.2)) +
  theme(legend.position = "none") +
  xlab('Species') + 
  ylab('Nucleotide Diversity') +
  ggtitle('Distribution of nucleotide diversity within and between hosts') +
  stat_compare_means(method='wilcox.test', label='p.signif', size=6)
better_pi_comparison_iid

distinct_iid_df = distinct(over_iid_df, pairwise_across_pi, .keep_all=TRUE)
distinct_df = distinct(pi_summary_df, pairwise_across_pi, .keep_all=TRUE)
HMP_distinct = distinct_df[distinct_df$Cohort==' HMP', ]$pairwise_across_pi
African_distinct = distinct_df[distinct_df$Cohort==' African', ]$pairwise_across_pi

HMP_distinct_pairwise = distinct_iid_df[distinct_iid_df$Cohort==' HMP', ]$pairwise_across_pi
African_distinct_pairwise = distinct_iid_df[distinct_iid_df$Cohort==' African', ]$pairwise_across_pi

wilcox.test(HMP_distinct_pairwise, African_distinct_pairwise, paired=TRUE, exact=TRUE)
wilcox.test(HMP_distinct, African_distinct, paired=FALSE, exact=TRUE)

hmp_summary_df = pi_summary_df[pi_summary_df$Cohort==' HMP', ]
afr_summary_df = pi_summary_df[pi_summary_df$Cohort==' African', ]

# Number of species in each cohort
length(unique(hmp_summary_df$species))
length(unique(afr_summary_df$species))

# Number of shared species
sum(unique(afr_summary_df$species) %in% unique(hmp_summary_df$species))

afr_species_freq = data.frame(table(afr_summary_df$species))
hmp_species_freq = data.frame(table(hmp_summary_df$species))

over_5_afr_species = afr_species_freq[afr_species_freq$Freq > 5, ]$Var1
over_5_hmp_species = hmp_species_freq[hmp_species_freq$Freq > 5, ]$Var1

over_5_species = unique(c(over_5_afr_species, over_5_hmp_species))

over_5_species_df = pi_summary_df[pi_summary_df$species %in% over_5_species, ]

# over_5_species_df = drop_duplicates(over_5_species_df, keep=False)
over_5_species_df = over_5_species_df[!duplicated(over_5_species_df$pairwise_across_pi), ]

over_5_species_df = over_5_species_df[order(over_5_species_df$species), ]
over_5_species_df

compare_iid_over_5_means <- ggplot(data=over_5_species_df, aes(x=Cohort, y=pairwise_across_pi, fill=Cohort)) +
  geom_boxplot(aes(fill=Cohort), outlier.shape=NA) +
  geom_point(pch = 21, position = position_jitterdodge(), size=1.5) +
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(axis.text.x = element_text(size=rel(1.5), angle=60, vjust=1.0, hjust=1)) +
  theme(axis.text.y = element_text(size=rel(1.5))) +
  theme(axis.title.x = element_text(size=rel(1.5))) +
  theme(axis.title.y = element_text(size=rel(1.5))) +
  theme(legend.text = element_text(size=rel(1.25))) +
  theme(legend.title = element_text(size=rel(1.5))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x,)),
                limits = c(0.0001, 0.2)) +
  xlab('Cohort') + 
  ylab('Mean Nucleotide Diversity per Species') +
  # ylim(0, 0.03) +
  stat_compare_means(method='wilcox.test', label='p.signif', size=6) +
  ggtitle('Mean Nucleotide Diversity per Species between Cohorts')
compare_iid_over_5_means

better_pi_comparison_iid + compare_iid_over_5_means + plot_layout(widths = c(3, 1))
# 1500 x 900 dimensions for saved image


afr_mean_pi_values = over_5_species_df[over_5_species_df$Cohort==' African', ]$pairwise_across_pi
hmp_mean_pi_values = over_5_species_df[over_5_species_df$Cohort==' HMP', ]$pairwise_across_pi
wilcox.test(afr_mean_pi_values, hmp_mean_pi_values, alternative='two.sided', exact=TRUE)

# Species prevalence
species_prevalence = read.csv('../Summary/species_prevalence.txt', sep=',')
species_prevalence = data.frame(species_prevalence$species, species_prevalence$prevalence)
names(species_prevalence) = c('species', 'prevalence')
species_prevalence$prevalence=species_prevalence$prevalence-2
species_prevalence = subset(species_prevalence, prevalence > 20)
# names(species_prevalence) = c('species', 'prevalence')
ggplot(species_prevalence, aes(x = reorder(species, prevalence), y=prevalence, fill=species)) +
  geom_bar(stat='identity') +
  theme(legend.position = "none") +
  coord_flip() +
  xlab('Species') +
  ylab('Prevalence') +
  ggtitle('Highest Prevalence Gut Microbial Species in North American Microbiomes')  +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.position = "none")
# species_prevalence = species_prevalence[species_prevalence$species_prevalence.prevalence>= 0]


rho_mu = read.csv('../Data/r_mu_dic.csv', header = FALSE)
rho_mu$significant = c('Yes', 'Yes', 'Yes', 'No', 'No', 
                       'No', 'Yes', 'No', 'No', 'No', 
                       'No', 'No', 'No', 'No', 'No', 
                       'No', 'No', 'Yes', 'No', 'No', 
                       'No', 'Yes', 'No', 'No', 'No', 
                       'No', 'No', 'No', 'No', 'No', 
                       'No', 'No', 'No', 'Yes', 'Yes', 
                       'Yes', 'No', 'No', 'No', 'No', 
                       'No')
names(rho_mu) = c('species', 'rho_ratio', 'Significant')

rho_mu = rho_mu[!(rho_mu$species %in% c('Bacteroides_coprocola_61586', 
                                        'Alistipes_sp_60764', 
                                        'Bacteroides_eggerthii_54457', 
                                        'Roseburia_inulinivorans_61943', 
                                        'Lachnospiraceae_bacterium_51870', 
                                        'Eubacterium_siraeum_57634', 
                                        'Bacteroides_plebeius_61623',
                                        'Roseburia_intestinalis_56239',
                                        'Bacteroides_finegoldii_57739')), ]


rho_mu_plot = ggplot(aes(x=species, y=rho_ratio), data = rho_mu) +
  geom_bar(aes(fill = Significant), stat = 'identity', position = 'dodge') +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle('Significance of demographic model vs. ratio of recombination to mutation') +
  xlab('Species') +
  ylab('Rho / mu')

rho_mu_plot

rho_mu_plot = ggplot(aes(x = reorder(species, rho_ratio), y = rho_ratio, fill=species), data = rho_mu) +
  geom_bar(stat = 'identity', position = 'dodge') +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle('Rate of recombination vs. Rate of Mutation in commensal gut species') +
  coord_flip() +
  xlab('Species') +
  ylab('Ratio between Recombination rate and Mutation rate') +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.position = "none")

rho_mu_plot

# Number of QP samples per species

species_list = c('Akkermansia_muciniphila_55200',
                 'Alistipes_finegoldii_56071',
                 'Alistipes_onderdonkii_55464',
                 'Alistipes_putredinis_61533',
                 'Alistipes_shahii_62199',
                 'Bacteroidales_bacterium_58650',
                 'Bacteroides_caccae_53434',
                 'Bacteroides_cellulosilyticus',
                 'Bacteroides_fragilis_5507',
                 'Bacteroides_massiliensis_44749',
                 'Bacteroides_ovatus_58035',
                 'Bacteroides_stercoris',
                 'Bacteroides_thetaiotaomicron_56941',
                 'Bacteroides_uniformis_57318',
                 'Bacteroides_vulgatus_57955',
                 'Bacteroides_xylanisolvens_57185',
                 'Barnesiella_intestinihominis_62208',
                 'Coprococcus_sp_62244',
                 'Dialest_invisus_61905',
                 'Eubacterium_eligens_61678',
                 'Eubacterium_rectale_56927',
                 'Faecalibacterium_prausnitzii_57453',
                 'Odoribacter_splanchnicus_62174',
                 'Oscillibacter_sp_60799',
                 'Parabacteroides_distasonis_56985',
                 'Parabacteroides_merdae_56972',
                 'Phasolarctobacterium_sp_59817',
                 'Prevotella_copri_61740',
                 'Ruminococcus_bicirculans_59300',
                 'Ruminococcus_bromii_62047')

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

# Core Genes

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

# qp_samples_per_species = data.frame(qp_samples_per_species_csv, header=TRUE)

qp_samples_per_species_plot = ggplot(aes(x=species_list, y=num_qp_samples, fill=species_list), 
                                     data = qp_samples_per_species) +
  geom_bar(stat = 'identity', position = 'dodge') +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle('QP samples per species') +
  xlab('Species') +
  ylab('Number of QP samples')
qp_samples_per_species_plot

qp_samples_per_species_plot_ordered = ggplot(qp_samples_per_species, aes(x = reorder(species_list, num_qp_samples), y = num_qp_samples, fill=species_list)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  coord_flip() +
  ggtitle('Number of Quasi-phaseable samples per species') +
  xlab('Species') +
  ylab('Number of Qausi-phaseable samples') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(panel.border = element_blank()) +
  theme(panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.position = "none")
qp_samples_per_species_plot_ordered

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

# Accessory Genes

accessory_qp_samples_per_species_csv = 
'Akkermansia_muciniphila_55200, 25
Alistipes_finegoldii_56071, 45
Alistipes_onderdonkii_55464, 59
Alistipes_putredinis_61533, 40
Alistipes_shahii_62199, 55
Bacteroidales_bacterium_58650, 27
Bacteroides_caccae_53434, 35
Bacteroides_cellulosilyticus, 35
Bacteroides_fragilis_5507, 31
Bacteroides_massiliensis_44749, 13
Bacteroides_ovatus_58035, 51
Bacteroides_stercoris, 71
Bacteroides_thetaiotaomicron_56941, 66
Bacteroides_uniformis_57318, 88
Bacteroides_vulgatus_57955, 44
Bacteroides_xylanisolvens_57185, 50
Barnesiella_intestinihominis_62208, 47
Coprococcus_sp_62244, 10
Dialest_invisus_61905, 35
Eubacterium_eligens_61678, 22
Eubacterium_rectale_56927, 74
Faecalibacterium_prausnitzii_57453, 30
Odoribacter_splanchnicus_62174, 25
Oscillibacter_sp_60799, 47
Parabacteroides_distasonis_56985, 40
Parabacteroides_merdae_56972, 41
Phasolarctobacterium_sp_59817, 17
Prevotella_copri_61740, 15
Ruminococcus_bicirculans_59300, 64
Ruminococcus_bromii_62047, 30
'

accessory_qp_samples_per_species = data.frame(species_list, num_qp_samples)


# write.csv(core_qp_samples_per_species_csv, '../Summary/core_num_qp.csv')
# write.csv(accessory_qp_samples_per_species_csv, '../Summary/accessory_num_qp.csv')

num_qp_samples = c(25, 45, 59, 40, 55,
                   27, 35, 35, 31, 
                   51, 71, 66, 88, 44, 
                   50, 47, 35, 22, 
                   74, 30, 25, 47, 40, 
                   41, 17, 15, 64, 30)

ggplot(accessory_qp_samples_per_species, aes(x = reorder(species_list, num_qp_samples), y = num_qp_samples)) +  geom_bar(stat='identity', fill='grey') +
  theme(legend.position = "none") +
  coord_flip() +
  xlab('Species') +
  ylab('Number of Quasi-phaseable samples') +
  ggtitle('Number of Quasi-phaseable samples per species from accessory genes')  +
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.position = "none")  +
  geom_hline(yintercept=14, linetype="dashed", color = "red") +
  scale_y_continuous(breaks = seq(0, 75, by = 5))


set.seed(1)

fold_sfs = function(input_sfs) {
  input_length = length(input_sfs)
  folded_length = length(input_sfs) / 2
  if (input_length %% 2 == 1) {
    folded_length = folded_length + 1
  }
  output_sfs = c()
  for (i in 1:folded_length) {
    output_sfs[i] = input_sfs[i] + input_sfs[input_length - i]
  }
  return(output_sfs)
}

proportional_sfs = function(input_sfs) {
  return (input_sfs / sum(input_sfs))
}

# 
# 
# e_eligens_pi = read.csv('../Scripts/e_eligens_pi_values.txt', header=TRUE)
# 
# b_thetaiotaomicron_downsampled_empirical = proportional_sfs(c(11329.94672695546, 
#                                                               6167.075485250698,
#                                                               4239.177625142324,
#                                                               3342.60586700556,
#                                                               2929.626632089841,
#                                                               2725.643057081244,
#                                                               2635.300969843948,
#                                                               2579.444903486481,
#                                                               2545.779751971833,
#                                                               1267.150917730179))
# 
# b_thetaiotaomicron_downsampled_one_epoch = proportional_sfs(fold_sfs(c(11395.016421153823, 
#                                                                        5697.509294687101,
#                                                                        3798.3396167211836,
#                                                                        2848.7547698431354,
#                                                                        2279.0038585801676,
#                                                                        1899.1699154494872,
#                                                                        1627.8599542022703,
#                                                                        1424.377481668122,
#                                                                        1266.113334959331,
#                                                                        1139.5020163371091,
#                                                                        1035.910936328398,
#                                                                        949.5850352831061,
#                                                                        876.5400411349472,
#                                                                        813.9300452646684,
#                                                                        759.6680480177727,
#                                                                        712.188799653274,
#                                                                        670.2953444866343,
#                                                                        633.0567169853921,
#                                                                        599.7379443605873)))
# 
# b_thetaiotaomicron_downsampled_two_epoch = proportional_sfs(fold_sfs(c(8664.919870727774,
#                                                                        5410.886429304165,
#                                                                        3793.1174736529974,
#                                                                        2881.691449665706,
#                                                                        2313.2722795865775,
#                                                                        1929.5172163186119,
#                                                                        1654.2900929663722,
#                                                                        1447.6034828585334,
#                                                                        1286.7826375194118,
#                                                                        1158.1101597985346,
#                                                                        1052.828809778185,
#                                                                        965.0934105406639,
#                                                                        890.8555390240017,
#                                                                        827.2230241899715,
#                                                                        772.0748319217155,
#                                                                        723.820160327517,
#                                                                        681.2425076585495,
#                                                                        643.3957044905935,
#                                                                        609.5327746634593)))
# 
# b_thetaiotaomicron_downsampled_exponential = proportional_sfs(fold_sfs(c(10187.526135309816,
#                                                                          5227.044599884645,
#                                                                          3563.621850201483,
#                                                                          2727.3004953552727,
#                                                                          2222.9082682087164,
#                                                                          1885.0050092572908,
#                                                                          1642.5279426703821,
#                                                                          1459.8676681937545,
#                                                                          1317.1988255364213,
#                                                                          1202.6013280281009,
#                                                                          1108.4741630743192,
#                                                                          1029.739855850399,
#                                                                          962.8763478354583,
#                                                                          905.3630546950819,
#                                                                          855.3480686875307,
#                                                                          811.4398933124559,
#                                                                          772.5725127938603,
#                                                                          737.9153260169305,
#                                                                          706.8114463671081)))
# 
# b_thetaiotaomicron_downsampled_bottleneck = proportional_sfs(fold_sfs(c(8717.037555032524,
#                                                                         5310.474345322664,
#                                                                         3748.8643888138054,
#                                                                         2873.723809926384,
#                                                                         2321.016005698025,
#                                                                         1942.9554470128837,
#                                                                         1669.1777593196819,
#                                                                         1462.2643030012487,
#                                                                         1300.6200461207936,
#                                                                         1170.9684986786854,
#                                                                         1064.7251166497713,
#                                                                         976.1057198156356,
#                                                                         901.0770666862816,
#                                                                         836.7441818986339,
#                                                                         780.9769787756552,
#                                                                         732.174217565379,
#                                                                         689.1094802578586,
#                                                                         650.8278440587161,
#                                                                         616.5748554746294)))
# 
# b_thetaiotaomicron_downsampled_three_epoch = proportional_sfs(fold_sfs(c(8689.269010159136,
#                                                                          5417.315212120648,
#                                                                          3793.8944085777216,
#                                                                          2881.1151931885984,
#                                                                          2312.4701639083023,
#                                                                          1928.7523709984505,
#                                                                          1653.6077971646323,
#                                                                          1446.9991763032233,
#                                                                          1286.2435100988198,
#                                                                          1157.6244240487513,
#                                                                          1052.3870965152491,
#                                                                          964.6884724782393,
#                                                                          890.4817416585565,
#                                                                          826.8759246652239,
#                                                                          771.7508719243848,
#                                                                          723.5164477365333,
#                                                                          680.9566604946273,
#                                                                          643.1257377201415,
#                                                                          609.2770166692798)))
# 
# b_thetaiotaomicron_downsampled_x_axis = 1:length(b_thetaiotaomicron_downsampled_one_epoch)
# 
# b_thetaiotaomicron_downsampled_df = data.frame(b_thetaiotaomicron_downsampled_empirical,
#                                                b_thetaiotaomicron_downsampled_two_epoch,
#                                                b_thetaiotaomicron_downsampled_one_epoch,
#                                                b_thetaiotaomicron_downsampled_x_axis)
# 
# 
# names(b_thetaiotaomicron_downsampled_df) = c('Observed',
#                                              'Expected under two-epoch demography',
#                                              'Null expectation, i.e., standard neutral model',
#                                              'x_axis')
# 
# p_b_thetaiotaomicron_downsampled_comparison <- ggplot(data = melt(b_thetaiotaomicron_downsampled_df, id='x_axis'),
#                                                       aes(x=x_axis, 
#                                                           y=value,
#                                                           fill=variable)) +
#   geom_bar(position='dodge2', stat='identity') +
#   labs(x = "", fill = "") +
#   scale_x_continuous(name='Minor Allele Frequency in Sample', breaks=b_thetaiotaomicron_downsampled_x_axis, limits=c(1.5, length(b_thetaiotaomicron_downsampled_x_axis) + 0.5)) +
#   ggtitle('B. Thetaiotaomicron Site Frequency Spectrum, Downsampled to 20 samples') +
#   ylim(0, 0.25) +
#   ylab('Proportion of Segregating Sites') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
# 
# p_b_thetaiotaomicron_downsampled_comparison
# 
# b_thetaiotaomicron_downsampled_small_df = data.frame(b_thetaiotaomicron_downsampled_empirical,
#                                                      b_thetaiotaomicron_downsampled_one_epoch,
#                                                      b_thetaiotaomicron_downsampled_two_epoch,
#                                                      b_thetaiotaomicron_downsampled_x_axis)
# 
# 
# names(b_thetaiotaomicron_downsampled_small_df) = c('Empirical',
#                                                    'One-epoch',
#                                                    'Two-epoch',
#                                                    'x_axis')
# 
# b_thetaiotaomicron_downsampled_one_epoch_delta = abs(b_thetaiotaomicron_downsampled_empirical - b_thetaiotaomicron_downsampled_one_epoch)
# b_thetaiotaomicron_downsampled_two_epoch_delta = abs(b_thetaiotaomicron_downsampled_empirical - b_thetaiotaomicron_downsampled_two_epoch)
# b_thetaiotaomicron_downsampled_delta_df = data.frame(b_thetaiotaomicron_downsampled_one_epoch_delta,
#                                                      b_thetaiotaomicron_downsampled_two_epoch_delta,
#                                                      b_thetaiotaomicron_downsampled_x_axis)
# names(b_thetaiotaomicron_downsampled_delta_df) = c('One-epoch Delta',
#                                                    'Two-epoch Delta',
#                                                    'x_axis')
# 
# 
# p_b_thetaiotaomicron_downsampled_delta <- ggplot(data = melt(b_thetaiotaomicron_downsampled_delta_df, id='x_axis'),
#                                                  aes(x=x_axis, 
#                                                      y=value,
#                                                      fill=variable)) +
#   geom_line(aes(color=variable)) +
#   labs(x = "", fill = "Demographic Model") +
#   scale_x_continuous(name='Frequency in Sample', breaks=b_thetaiotaomicron_downsampled_x_axis, limits=c(1.5, length(b_thetaiotaomicron_downsampled_x_axis) + 0.5)) +
#   ggtitle('B. Thetaiotaomicron (Downsampled to 20)') +
#   ylab('Absolute difference in proportional frequency') +
#   geom_text(aes(label = paste0("One-Epoch Delta Sum = ", sum(b_thetaiotaomicron_downsampled_one_epoch_delta)), 
#                 x = (9), 
#                 y = 0.0025)) +
#   geom_text(aes(label = paste0("Two-Epoch Delta Sum = ", sum(b_thetaiotaomicron_downsampled_two_epoch_delta)), 
#                 x = (9),
#                 y = 0.0015)) 
# 
# p_b_thetaiotaomicron_downsampled_delta
# 
# # Oral Data
# 
# actinomyces_sp_masked_surface = read.csv('oral_likelihood_surfaces/actinomyces_sp_masked.csv', header=FALSE)
# names(actinomyces_sp_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# actinomyces_sp_masked_surface_expansion = actinomyces_sp_masked_surface[actinomyces_sp_masked_surface$nu > 1.0, ]
# actinomyces_sp_masked_surface_contraction = actinomyces_sp_masked_surface[actinomyces_sp_masked_surface$nu <= 1.0, ]
# 
# actinomyces_sp_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = actinomyces_sp_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = actinomyces_sp_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Actinomyces sp. histogram of likelihoods [singletons masked]')
# actinomyces_sp_masked_surface_hist
# 
# actinomyces_sp_masked_surface_cutoff = quantile(actinomyces_sp_masked_surface$likelihood, 0.80)
# 
# actinomyces_sp_masked_surface[actinomyces_sp_masked_surface$likelihood < actinomyces_sp_masked_surface_cutoff, ]$likelihood = actinomyces_sp_masked_surface_cutoff
# 
# actinomyces_sp_masked_surface_scatter = ggplot(data=actinomyces_sp_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Actinomyces sp. rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# actinomyces_sp_masked_surface_scatter
# 
# actinomyces_sp_unmasked_surface = read.csv('oral_likelihood_surfaces/actinomyces_sp_unmasked.csv', header=FALSE)
# names(actinomyces_sp_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# actinomyces_sp_unmasked_surface_expansion = actinomyces_sp_unmasked_surface[actinomyces_sp_unmasked_surface$nu > 1.0, ]
# actinomyces_sp_unmasked_surface_contraction = actinomyces_sp_unmasked_surface[actinomyces_sp_unmasked_surface$nu <= 1.0, ]
# 
# actinomyces_sp_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = actinomyces_sp_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = actinomyces_sp_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Actinomyces sp. histogram of likelihoods')
# actinomyces_sp_unmasked_surface_hist
# 
# actinomyces_sp_unmasked_surface_cutoff = quantile(actinomyces_sp_unmasked_surface$likelihood, 0.80)
# 
# actinomyces_sp_unmasked_surface[actinomyces_sp_unmasked_surface$likelihood < actinomyces_sp_unmasked_surface_cutoff, ]$likelihood = actinomyces_sp_unmasked_surface_cutoff
# 
# actinomyces_sp_unmasked_surface_scatter = ggplot(data=actinomyces_sp_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Actinomyces sp. rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# actinomyces_sp_unmasked_surface_scatter
# 
# aggregatibacter_sp_masked_surface = read.csv('oral_likelihood_surfaces/aggregatibacter_sp_masked.csv', header=FALSE)
# names(aggregatibacter_sp_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# aggregatibacter_sp_masked_surface_expansion = aggregatibacter_sp_masked_surface[aggregatibacter_sp_masked_surface$nu > 1.0, ]
# aggregatibacter_sp_masked_surface_contraction = aggregatibacter_sp_masked_surface[aggregatibacter_sp_masked_surface$nu <= 1.0, ]
# 
# aggregatibacter_sp_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = aggregatibacter_sp_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = aggregatibacter_sp_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Aggregatibacter sp. histogram of likelihoods [singletons masked]')
# aggregatibacter_sp_masked_surface_hist
# 
# aggregatibacter_sp_masked_surface_cutoff = quantile(aggregatibacter_sp_masked_surface$likelihood, 0.80)
# 
# aggregatibacter_sp_masked_surface[aggregatibacter_sp_masked_surface$likelihood < aggregatibacter_sp_masked_surface_cutoff, ]$likelihood = aggregatibacter_sp_masked_surface_cutoff
# 
# aggregatibacter_sp_masked_surface_scatter = ggplot(data=aggregatibacter_sp_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Aggregatibacter sp. rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# aggregatibacter_sp_masked_surface_scatter
# 
# aggregatibacter_sp_unmasked_surface = read.csv('oral_likelihood_surfaces/aggregatibacter_sp_unmasked.csv', header=FALSE)
# names(aggregatibacter_sp_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# aggregatibacter_sp_unmasked_surface_expansion = aggregatibacter_sp_unmasked_surface[aggregatibacter_sp_unmasked_surface$nu > 1.0, ]
# aggregatibacter_sp_unmasked_surface_contraction = aggregatibacter_sp_unmasked_surface[aggregatibacter_sp_unmasked_surface$nu <= 1.0, ]
# 
# aggregatibacter_sp_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = aggregatibacter_sp_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = aggregatibacter_sp_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Aggregatibacter sp. histogram of likelihoods')
# aggregatibacter_sp_unmasked_surface_hist
# 
# aggregatibacter_sp_unmasked_surface_cutoff = quantile(aggregatibacter_sp_unmasked_surface$likelihood, 0.80)
# 
# aggregatibacter_sp_unmasked_surface[aggregatibacter_sp_unmasked_surface$likelihood < aggregatibacter_sp_unmasked_surface_cutoff, ]$likelihood = aggregatibacter_sp_unmasked_surface_cutoff
# 
# aggregatibacter_sp_unmasked_surface_scatter = ggplot(data=aggregatibacter_sp_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Aggregatibacter sp. rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# aggregatibacter_sp_unmasked_surface_scatter
# 
# capnocytophaga_gingivalis_masked_surface = read.csv('oral_likelihood_surfaces/capnocytophaga_gingivalis_masked.csv', header=FALSE)
# names(capnocytophaga_gingivalis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# capnocytophaga_gingivalis_masked_surface_expansion = capnocytophaga_gingivalis_masked_surface[capnocytophaga_gingivalis_masked_surface$nu > 1.0, ]
# capnocytophaga_gingivalis_masked_surface_contraction = capnocytophaga_gingivalis_masked_surface[capnocytophaga_gingivalis_masked_surface$nu <= 1.0, ]
# 
# capnocytophaga_gingivalis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = capnocytophaga_gingivalis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = capnocytophaga_gingivalis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Capnocytophaga gingivalis histogram of likelihoods [singletons masked]')
# capnocytophaga_gingivalis_masked_surface_hist
# 
# capnocytophaga_gingivalis_masked_surface_cutoff = quantile(capnocytophaga_gingivalis_masked_surface$likelihood, 0.80)
# 
# capnocytophaga_gingivalis_masked_surface[capnocytophaga_gingivalis_masked_surface$likelihood < capnocytophaga_gingivalis_masked_surface_cutoff, ]$likelihood = capnocytophaga_gingivalis_masked_surface_cutoff
# 
# capnocytophaga_gingivalis_masked_surface_scatter = ggplot(data=capnocytophaga_gingivalis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Capnocytophaga gingivalis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# capnocytophaga_gingivalis_masked_surface_scatter
# 
# capnocytophaga_gingivalis_unmasked_surface = read.csv('oral_likelihood_surfaces/capnocytophaga_gingivalis_unmasked.csv', header=FALSE)
# names(capnocytophaga_gingivalis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# capnocytophaga_gingivalis_unmasked_surface_expansion = capnocytophaga_gingivalis_unmasked_surface[capnocytophaga_gingivalis_unmasked_surface$nu > 1.0, ]
# capnocytophaga_gingivalis_unmasked_surface_contraction = capnocytophaga_gingivalis_unmasked_surface[capnocytophaga_gingivalis_unmasked_surface$nu <= 1.0, ]
# 
# capnocytophaga_gingivalis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = capnocytophaga_gingivalis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = capnocytophaga_gingivalis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Capnocytophaga gingivalis histogram of likelihoods')
# capnocytophaga_gingivalis_unmasked_surface_hist
# 
# capnocytophaga_gingivalis_unmasked_surface_cutoff = quantile(capnocytophaga_gingivalis_unmasked_surface$likelihood, 0.80)
# 
# capnocytophaga_gingivalis_unmasked_surface[capnocytophaga_gingivalis_unmasked_surface$likelihood < capnocytophaga_gingivalis_unmasked_surface_cutoff, ]$likelihood = capnocytophaga_gingivalis_unmasked_surface_cutoff
# 
# capnocytophaga_gingivalis_unmasked_surface_scatter = ggplot(data=capnocytophaga_gingivalis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Capnocytophaga gingivalis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# capnocytophaga_gingivalis_unmasked_surface_scatter
# 
# capnocytophaga_sputigena_masked_surface = read.csv('oral_likelihood_surfaces/capnocytophaga_sputigena_masked.csv', header=FALSE)
# names(capnocytophaga_sputigena_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# capnocytophaga_sputigena_masked_surface_expansion = capnocytophaga_sputigena_masked_surface[capnocytophaga_sputigena_masked_surface$nu > 1.0, ]
# capnocytophaga_sputigena_masked_surface_contraction = capnocytophaga_sputigena_masked_surface[capnocytophaga_sputigena_masked_surface$nu <= 1.0, ]
# 
# capnocytophaga_sputigena_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = capnocytophaga_sputigena_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = capnocytophaga_sputigena_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Capnocytophaga sputigena histogram of likelihoods [singletons masked]')
# capnocytophaga_sputigena_masked_surface_hist
# 
# capnocytophaga_sputigena_masked_surface_cutoff = quantile(capnocytophaga_sputigena_masked_surface$likelihood, 0.80)
# 
# capnocytophaga_sputigena_masked_surface[capnocytophaga_sputigena_masked_surface$likelihood < capnocytophaga_sputigena_masked_surface_cutoff, ]$likelihood = capnocytophaga_sputigena_masked_surface_cutoff
# 
# capnocytophaga_sputigena_masked_surface_scatter = ggplot(data=capnocytophaga_sputigena_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Capnocytophaga sputigena rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# capnocytophaga_sputigena_masked_surface_scatter
# 
# capnocytophaga_sputigena_unmasked_surface = read.csv('oral_likelihood_surfaces/capnocytophaga_sputigena_unmasked.csv', header=FALSE)
# names(capnocytophaga_sputigena_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# capnocytophaga_sputigena_unmasked_surface_expansion = capnocytophaga_sputigena_unmasked_surface[capnocytophaga_sputigena_unmasked_surface$nu > 1.0, ]
# capnocytophaga_sputigena_unmasked_surface_contraction = capnocytophaga_sputigena_unmasked_surface[capnocytophaga_sputigena_unmasked_surface$nu <= 1.0, ]
# 
# capnocytophaga_sputigena_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = capnocytophaga_sputigena_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = capnocytophaga_sputigena_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Capnocytophaga sputigena histogram of likelihoods')
# capnocytophaga_sputigena_unmasked_surface_hist
# 
# capnocytophaga_sputigena_unmasked_surface_cutoff = quantile(capnocytophaga_sputigena_unmasked_surface$likelihood, 0.80)
# 
# capnocytophaga_sputigena_unmasked_surface[capnocytophaga_sputigena_unmasked_surface$likelihood < capnocytophaga_sputigena_unmasked_surface_cutoff, ]$likelihood = capnocytophaga_sputigena_unmasked_surface_cutoff
# 
# capnocytophaga_sputigena_unmasked_surface_scatter = ggplot(data=capnocytophaga_sputigena_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Capnocytophaga sputigena rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# capnocytophaga_sputigena_unmasked_surface_scatter
# 
# corynebacterium_matruchotii_masked_surface = read.csv('oral_likelihood_surfaces/corynebacterium_matruchotii_masked.csv', header=FALSE)
# names(corynebacterium_matruchotii_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# corynebacterium_matruchotii_masked_surface_expansion = corynebacterium_matruchotii_masked_surface[corynebacterium_matruchotii_masked_surface$nu > 1.0, ]
# corynebacterium_matruchotii_masked_surface_contraction = corynebacterium_matruchotii_masked_surface[corynebacterium_matruchotii_masked_surface$nu <= 1.0, ]
# 
# corynebacterium_matruchotii_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = corynebacterium_matruchotii_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = corynebacterium_matruchotii_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Corynebacterium matruchotii histogram of likelihoods [singletons masked]')
# corynebacterium_matruchotii_masked_surface_hist
# 
# corynebacterium_matruchotii_masked_surface_cutoff = quantile(corynebacterium_matruchotii_masked_surface$likelihood, 0.80)
# 
# corynebacterium_matruchotii_masked_surface[corynebacterium_matruchotii_masked_surface$likelihood < corynebacterium_matruchotii_masked_surface_cutoff, ]$likelihood = corynebacterium_matruchotii_masked_surface_cutoff
# 
# corynebacterium_matruchotii_masked_surface_scatter = ggplot(data=corynebacterium_matruchotii_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Corynebacterium matruchotii rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# corynebacterium_matruchotii_masked_surface_scatter
# 
# corynebacterium_matruchotii_unmasked_surface = read.csv('oral_likelihood_surfaces/corynebacterium_matruchotii_unmasked.csv', header=FALSE)
# names(corynebacterium_matruchotii_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# corynebacterium_matruchotii_unmasked_surface_expansion = corynebacterium_matruchotii_unmasked_surface[corynebacterium_matruchotii_unmasked_surface$nu > 1.0, ]
# corynebacterium_matruchotii_unmasked_surface_contraction = corynebacterium_matruchotii_unmasked_surface[corynebacterium_matruchotii_unmasked_surface$nu <= 1.0, ]
# 
# corynebacterium_matruchotii_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = corynebacterium_matruchotii_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = corynebacterium_matruchotii_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Corynebacterium matruchotii histogram of likelihoods')
# corynebacterium_matruchotii_unmasked_surface_hist
# 
# corynebacterium_matruchotii_unmasked_surface_cutoff = quantile(corynebacterium_matruchotii_unmasked_surface$likelihood, 0.80)
# 
# corynebacterium_matruchotii_unmasked_surface[corynebacterium_matruchotii_unmasked_surface$likelihood < corynebacterium_matruchotii_unmasked_surface_cutoff, ]$likelihood = corynebacterium_matruchotii_unmasked_surface_cutoff
# 
# corynebacterium_matruchotii_unmasked_surface_scatter = ggplot(data=corynebacterium_matruchotii_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Corynebacterium matruchotii rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# corynebacterium_matruchotii_unmasked_surface_scatter
# 
# fusobacterium_nucleatum_masked_surface = read.csv('oral_likelihood_surfaces/fusobacterium_nucleatum_masked.csv', header=FALSE)
# names(fusobacterium_nucleatum_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# fusobacterium_nucleatum_masked_surface_expansion = fusobacterium_nucleatum_masked_surface[fusobacterium_nucleatum_masked_surface$nu > 1.0, ]
# fusobacterium_nucleatum_masked_surface_contraction = fusobacterium_nucleatum_masked_surface[fusobacterium_nucleatum_masked_surface$nu <= 1.0, ]
# 
# fusobacterium_nucleatum_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = fusobacterium_nucleatum_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = fusobacterium_nucleatum_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Fusobacterium nucleatum histogram of likelihoods [singletons masked]')
# fusobacterium_nucleatum_masked_surface_hist
# 
# fusobacterium_nucleatum_masked_surface_cutoff = quantile(fusobacterium_nucleatum_masked_surface$likelihood, 0.80)
# 
# fusobacterium_nucleatum_masked_surface[fusobacterium_nucleatum_masked_surface$likelihood < fusobacterium_nucleatum_masked_surface_cutoff, ]$likelihood = fusobacterium_nucleatum_masked_surface_cutoff
# 
# fusobacterium_nucleatum_masked_surface_scatter = ggplot(data=fusobacterium_nucleatum_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Fusobacterium nucleatum rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# fusobacterium_nucleatum_masked_surface_scatter
# 
# fusobacterium_nucleatum_unmasked_surface = read.csv('oral_likelihood_surfaces/fusobacterium_nucleatum_unmasked.csv', header=FALSE)
# names(fusobacterium_nucleatum_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# fusobacterium_nucleatum_unmasked_surface_expansion = fusobacterium_nucleatum_unmasked_surface[fusobacterium_nucleatum_unmasked_surface$nu > 1.0, ]
# fusobacterium_nucleatum_unmasked_surface_contraction = fusobacterium_nucleatum_unmasked_surface[fusobacterium_nucleatum_unmasked_surface$nu <= 1.0, ]
# 
# fusobacterium_nucleatum_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = fusobacterium_nucleatum_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = fusobacterium_nucleatum_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Fusobacterium nucleatum histogram of likelihoods')
# fusobacterium_nucleatum_unmasked_surface_hist
# 
# fusobacterium_nucleatum_unmasked_surface_cutoff = quantile(fusobacterium_nucleatum_unmasked_surface$likelihood, 0.80)
# 
# fusobacterium_nucleatum_unmasked_surface[fusobacterium_nucleatum_unmasked_surface$likelihood < fusobacterium_nucleatum_unmasked_surface_cutoff, ]$likelihood = fusobacterium_nucleatum_unmasked_surface_cutoff
# 
# fusobacterium_nucleatum_unmasked_surface_scatter = ggplot(data=fusobacterium_nucleatum_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Fusobacterium nucleatum rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# fusobacterium_nucleatum_unmasked_surface_scatter
# 
# granulicatella_adiacens_masked_surface = read.csv('oral_likelihood_surfaces/granulicatella_adiacens_masked.csv', header=FALSE)
# names(granulicatella_adiacens_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# granulicatella_adiacens_masked_surface_expansion = granulicatella_adiacens_masked_surface[granulicatella_adiacens_masked_surface$nu > 1.0, ]
# granulicatella_adiacens_masked_surface_contraction = granulicatella_adiacens_masked_surface[granulicatella_adiacens_masked_surface$nu <= 1.0, ]
# 
# granulicatella_adiacens_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = granulicatella_adiacens_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = granulicatella_adiacens_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Granulicatella adiacens histogram of likelihoods [singletons masked]')
# granulicatella_adiacens_masked_surface_hist
# 
# granulicatella_adiacens_masked_surface_cutoff = quantile(granulicatella_adiacens_masked_surface$likelihood, 0.80)
# 
# granulicatella_adiacens_masked_surface[granulicatella_adiacens_masked_surface$likelihood < granulicatella_adiacens_masked_surface_cutoff, ]$likelihood = granulicatella_adiacens_masked_surface_cutoff
# 
# granulicatella_adiacens_masked_surface_scatter = ggplot(data=granulicatella_adiacens_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Granulicatella adiacens rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# granulicatella_adiacens_masked_surface_scatter
# 
# granulicatella_adiacens_unmasked_surface = read.csv('oral_likelihood_surfaces/granulicatella_adiacens_unmasked.csv', header=FALSE)
# names(granulicatella_adiacens_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# granulicatella_adiacens_unmasked_surface_expansion = granulicatella_adiacens_unmasked_surface[granulicatella_adiacens_unmasked_surface$nu > 1.0, ]
# granulicatella_adiacens_unmasked_surface_contraction = granulicatella_adiacens_unmasked_surface[granulicatella_adiacens_unmasked_surface$nu <= 1.0, ]
# 
# granulicatella_adiacens_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = granulicatella_adiacens_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = granulicatella_adiacens_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Granulicatella adiacens histogram of likelihoods')
# granulicatella_adiacens_unmasked_surface_hist
# 
# granulicatella_adiacens_unmasked_surface_cutoff = quantile(granulicatella_adiacens_unmasked_surface$likelihood, 0.80)
# 
# granulicatella_adiacens_unmasked_surface[granulicatella_adiacens_unmasked_surface$likelihood < granulicatella_adiacens_unmasked_surface_cutoff, ]$likelihood = granulicatella_adiacens_unmasked_surface_cutoff
# 
# granulicatella_adiacens_unmasked_surface_scatter = ggplot(data=granulicatella_adiacens_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Granulicatella adiacens rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# granulicatella_adiacens_unmasked_surface_scatter
# 
# haemophilus_haemolyticus_58348_masked_surface = read.csv('oral_likelihood_surfaces/haemophilus_haemolyticus_58348_masked.csv', header=FALSE)
# names(haemophilus_haemolyticus_58348_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# haemophilus_haemolyticus_58348_masked_surface_expansion = haemophilus_haemolyticus_58348_masked_surface[haemophilus_haemolyticus_58348_masked_surface$nu > 1.0, ]
# haemophilus_haemolyticus_58348_masked_surface_contraction = haemophilus_haemolyticus_58348_masked_surface[haemophilus_haemolyticus_58348_masked_surface$nu <= 1.0, ]
# 
# haemophilus_haemolyticus_58348_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = haemophilus_haemolyticus_58348_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = haemophilus_haemolyticus_58348_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Haemophilus haemolyticus 58348 histogram of likelihoods [singletons masked]')
# haemophilus_haemolyticus_58348_masked_surface_hist
# 
# haemophilus_haemolyticus_58348_masked_surface_cutoff = quantile(haemophilus_haemolyticus_58348_masked_surface$likelihood, 0.80)
# 
# haemophilus_haemolyticus_58348_masked_surface[haemophilus_haemolyticus_58348_masked_surface$likelihood < haemophilus_haemolyticus_58348_masked_surface_cutoff, ]$likelihood = haemophilus_haemolyticus_58348_masked_surface_cutoff
# 
# haemophilus_haemolyticus_58348_masked_surface_scatter = ggplot(data=haemophilus_haemolyticus_58348_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Haemophilus haemolyticus 58348 rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# haemophilus_haemolyticus_58348_masked_surface_scatter
# 
# haemophilus_haemolyticus_58348_unmasked_surface = read.csv('oral_likelihood_surfaces/haemophilus_haemolyticus_58348_unmasked.csv', header=FALSE)
# names(haemophilus_haemolyticus_58348_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# haemophilus_haemolyticus_58348_unmasked_surface_expansion = haemophilus_haemolyticus_58348_unmasked_surface[haemophilus_haemolyticus_58348_unmasked_surface$nu > 1.0, ]
# haemophilus_haemolyticus_58348_unmasked_surface_contraction = haemophilus_haemolyticus_58348_unmasked_surface[haemophilus_haemolyticus_58348_unmasked_surface$nu <= 1.0, ]
# 
# haemophilus_haemolyticus_58348_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = haemophilus_haemolyticus_58348_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = haemophilus_haemolyticus_58348_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Haemophilus haemolyticus 58348 histogram of likelihoods')
# haemophilus_haemolyticus_58348_unmasked_surface_hist
# 
# haemophilus_haemolyticus_58348_unmasked_surface_cutoff = quantile(haemophilus_haemolyticus_58348_unmasked_surface$likelihood, 0.80)
# 
# haemophilus_haemolyticus_58348_unmasked_surface[haemophilus_haemolyticus_58348_unmasked_surface$likelihood < haemophilus_haemolyticus_58348_unmasked_surface_cutoff, ]$likelihood = haemophilus_haemolyticus_58348_unmasked_surface_cutoff
# 
# haemophilus_haemolyticus_58348_unmasked_surface_scatter = ggplot(data=haemophilus_haemolyticus_58348_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Haemophilus haemolyticus 58348 rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# haemophilus_haemolyticus_58348_unmasked_surface_scatter
# 
# haemophilus_haemolyticus_58350_masked_surface = read.csv('oral_likelihood_surfaces/haemophilus_haemolyticus_58350_masked.csv', header=FALSE)
# names(haemophilus_haemolyticus_58350_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# haemophilus_haemolyticus_58350_masked_surface_expansion = haemophilus_haemolyticus_58350_masked_surface[haemophilus_haemolyticus_58350_masked_surface$nu > 1.0, ]
# haemophilus_haemolyticus_58350_masked_surface_contraction = haemophilus_haemolyticus_58350_masked_surface[haemophilus_haemolyticus_58350_masked_surface$nu <= 1.0, ]
# 
# haemophilus_haemolyticus_58350_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = haemophilus_haemolyticus_58350_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = haemophilus_haemolyticus_58350_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Haemophilus haemolyticus 58350 histogram of likelihoods [singletons masked]')
# haemophilus_haemolyticus_58350_masked_surface_hist
# 
# haemophilus_haemolyticus_58350_masked_surface_cutoff = quantile(haemophilus_haemolyticus_58350_masked_surface$likelihood, 0.80)
# 
# haemophilus_haemolyticus_58350_masked_surface[haemophilus_haemolyticus_58350_masked_surface$likelihood < haemophilus_haemolyticus_58350_masked_surface_cutoff, ]$likelihood = haemophilus_haemolyticus_58350_masked_surface_cutoff
# 
# haemophilus_haemolyticus_58350_masked_surface_scatter = ggplot(data=haemophilus_haemolyticus_58350_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Haemophilus haemolyticus 58350 rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# haemophilus_haemolyticus_58350_masked_surface_scatter
# 
# haemophilus_haemolyticus_58350_unmasked_surface = read.csv('oral_likelihood_surfaces/haemophilus_haemolyticus_58350_unmasked.csv', header=FALSE)
# names(haemophilus_haemolyticus_58350_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# haemophilus_haemolyticus_58350_unmasked_surface_expansion = haemophilus_haemolyticus_58350_unmasked_surface[haemophilus_haemolyticus_58350_unmasked_surface$nu > 1.0, ]
# haemophilus_haemolyticus_58350_unmasked_surface_contraction = haemophilus_haemolyticus_58350_unmasked_surface[haemophilus_haemolyticus_58350_unmasked_surface$nu <= 1.0, ]
# 
# haemophilus_haemolyticus_58350_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = haemophilus_haemolyticus_58350_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = haemophilus_haemolyticus_58350_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Haemophilus haemolyticus 58350 histogram of likelihoods')
# haemophilus_haemolyticus_58350_unmasked_surface_hist
# 
# haemophilus_haemolyticus_58350_unmasked_surface_cutoff = quantile(haemophilus_haemolyticus_58350_unmasked_surface$likelihood, 0.80)
# 
# haemophilus_haemolyticus_58350_unmasked_surface[haemophilus_haemolyticus_58350_unmasked_surface$likelihood < haemophilus_haemolyticus_58350_unmasked_surface_cutoff, ]$likelihood = haemophilus_haemolyticus_58350_unmasked_surface_cutoff
# 
# haemophilus_haemolyticus_58350_unmasked_surface_scatter = ggplot(data=haemophilus_haemolyticus_58350_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Haemophilus haemolyticus 58350 rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# haemophilus_haemolyticus_58350_unmasked_surface_scatter
# 
# kingella_oralis_masked_surface = read.csv('oral_likelihood_surfaces/kingella_oralis_masked.csv', header=FALSE)
# names(kingella_oralis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# kingella_oralis_masked_surface_expansion = kingella_oralis_masked_surface[kingella_oralis_masked_surface$nu > 1.0, ]
# kingella_oralis_masked_surface_contraction = kingella_oralis_masked_surface[kingella_oralis_masked_surface$nu <= 1.0, ]
# 
# kingella_oralis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = kingella_oralis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = kingella_oralis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Kingella oralis histogram of likelihoods [singletons masked]')
# kingella_oralis_masked_surface_hist
# 
# kingella_oralis_masked_surface_cutoff = quantile(kingella_oralis_masked_surface$likelihood, 0.80)
# 
# kingella_oralis_masked_surface[kingella_oralis_masked_surface$likelihood < kingella_oralis_masked_surface_cutoff, ]$likelihood = kingella_oralis_masked_surface_cutoff
# 
# kingella_oralis_masked_surface_scatter = ggplot(data=kingella_oralis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Kingella oralis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# kingella_oralis_masked_surface_scatter
# 
# kingella_oralis_unmasked_surface = read.csv('oral_likelihood_surfaces/kingella_oralis_unmasked.csv', header=FALSE)
# names(kingella_oralis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# kingella_oralis_unmasked_surface_expansion = kingella_oralis_unmasked_surface[kingella_oralis_unmasked_surface$nu > 1.0, ]
# kingella_oralis_unmasked_surface_contraction = kingella_oralis_unmasked_surface[kingella_oralis_unmasked_surface$nu <= 1.0, ]
# 
# kingella_oralis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = kingella_oralis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = kingella_oralis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Kingella oralis histogram of likelihoods')
# kingella_oralis_unmasked_surface_hist
# 
# kingella_oralis_unmasked_surface_cutoff = quantile(kingella_oralis_unmasked_surface$likelihood, 0.80)
# 
# kingella_oralis_unmasked_surface[kingella_oralis_unmasked_surface$likelihood < kingella_oralis_unmasked_surface_cutoff, ]$likelihood = kingella_oralis_unmasked_surface_cutoff
# 
# kingella_oralis_unmasked_surface_scatter = ggplot(data=kingella_oralis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Kingella oralis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# kingella_oralis_unmasked_surface_scatter
# 
# lautropia_mirabilis_masked_surface = read.csv('oral_likelihood_surfaces/lautropia_mirabilis_masked.csv', header=FALSE)
# names(lautropia_mirabilis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# lautropia_mirabilis_masked_surface_expansion = lautropia_mirabilis_masked_surface[lautropia_mirabilis_masked_surface$nu > 1.0, ]
# lautropia_mirabilis_masked_surface_contraction = lautropia_mirabilis_masked_surface[lautropia_mirabilis_masked_surface$nu <= 1.0, ]
# 
# lautropia_mirabilis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = lautropia_mirabilis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = lautropia_mirabilis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Lautropia mirabilis histogram of likelihoods [singletons masked]')
# lautropia_mirabilis_masked_surface_hist
# 
# lautropia_mirabilis_masked_surface_cutoff = quantile(lautropia_mirabilis_masked_surface$likelihood, 0.80)
# 
# lautropia_mirabilis_masked_surface[lautropia_mirabilis_masked_surface$likelihood < lautropia_mirabilis_masked_surface_cutoff, ]$likelihood = lautropia_mirabilis_masked_surface_cutoff
# 
# lautropia_mirabilis_masked_surface_scatter = ggplot(data=lautropia_mirabilis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Lautropia mirabilis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# lautropia_mirabilis_masked_surface_scatter
# 
# lautropia_mirabilis_unmasked_surface = read.csv('oral_likelihood_surfaces/lautropia_mirabilis_unmasked.csv', header=FALSE)
# names(lautropia_mirabilis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# lautropia_mirabilis_unmasked_surface_expansion = lautropia_mirabilis_unmasked_surface[lautropia_mirabilis_unmasked_surface$nu > 1.0, ]
# lautropia_mirabilis_unmasked_surface_contraction = lautropia_mirabilis_unmasked_surface[lautropia_mirabilis_unmasked_surface$nu <= 1.0, ]
# 
# lautropia_mirabilis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = lautropia_mirabilis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = lautropia_mirabilis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Lautropia mirabilis histogram of likelihoods')
# lautropia_mirabilis_unmasked_surface_hist
# 
# lautropia_mirabilis_unmasked_surface_cutoff = quantile(lautropia_mirabilis_unmasked_surface$likelihood, 0.80)
# 
# lautropia_mirabilis_unmasked_surface[lautropia_mirabilis_unmasked_surface$likelihood < lautropia_mirabilis_unmasked_surface_cutoff, ]$likelihood = lautropia_mirabilis_unmasked_surface_cutoff
# 
# lautropia_mirabilis_unmasked_surface_scatter = ggplot(data=lautropia_mirabilis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Lautropia mirabilis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# lautropia_mirabilis_unmasked_surface_scatter
# 
# neisseria_cinerea_masked_surface = read.csv('oral_likelihood_surfaces/neisseria_cinerea_masked.csv', header=FALSE)
# names(neisseria_cinerea_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# neisseria_cinerea_masked_surface_expansion = neisseria_cinerea_masked_surface[neisseria_cinerea_masked_surface$nu > 1.0, ]
# neisseria_cinerea_masked_surface_contraction = neisseria_cinerea_masked_surface[neisseria_cinerea_masked_surface$nu <= 1.0, ]
# 
# neisseria_cinerea_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = neisseria_cinerea_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = neisseria_cinerea_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Neisseria cinerea histogram of likelihoods [singletons masked]')
# neisseria_cinerea_masked_surface_hist
# 
# neisseria_cinerea_masked_surface_cutoff = quantile(neisseria_cinerea_masked_surface$likelihood, 0.80)
# 
# neisseria_cinerea_masked_surface[neisseria_cinerea_masked_surface$likelihood < neisseria_cinerea_masked_surface_cutoff, ]$likelihood = neisseria_cinerea_masked_surface_cutoff
# 
# neisseria_cinerea_masked_surface_scatter = ggplot(data=neisseria_cinerea_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Neisseria cinerea rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# neisseria_cinerea_masked_surface_scatter
# 
# neisseria_cinerea_unmasked_surface = read.csv('oral_likelihood_surfaces/neisseria_cinerea_unmasked.csv', header=FALSE)
# names(neisseria_cinerea_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# neisseria_cinerea_unmasked_surface_expansion = neisseria_cinerea_unmasked_surface[neisseria_cinerea_unmasked_surface$nu > 1.0, ]
# neisseria_cinerea_unmasked_surface_contraction = neisseria_cinerea_unmasked_surface[neisseria_cinerea_unmasked_surface$nu <= 1.0, ]
# 
# neisseria_cinerea_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = neisseria_cinerea_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = neisseria_cinerea_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Neisseria cinerea histogram of likelihoods')
# neisseria_cinerea_unmasked_surface_hist
# 
# neisseria_cinerea_unmasked_surface_cutoff = quantile(neisseria_cinerea_unmasked_surface$likelihood, 0.80)
# 
# neisseria_cinerea_unmasked_surface[neisseria_cinerea_unmasked_surface$likelihood < neisseria_cinerea_unmasked_surface_cutoff, ]$likelihood = neisseria_cinerea_unmasked_surface_cutoff
# 
# neisseria_cinerea_unmasked_surface_scatter = ggplot(data=neisseria_cinerea_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Neisseria cinerea rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# neisseria_cinerea_unmasked_surface_scatter
# 
# neisseria_elongata_masked_surface = read.csv('oral_likelihood_surfaces/neisseria_elongata_masked.csv', header=FALSE)
# names(neisseria_elongata_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# neisseria_elongata_masked_surface_expansion = neisseria_elongata_masked_surface[neisseria_elongata_masked_surface$nu > 2.0, ]
# neisseria_elongata_masked_surface_contraction = neisseria_elongata_masked_surface[neisseria_elongata_masked_surface$nu <= 2.0, ]
# 
# neisseria_elongata_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = neisseria_elongata_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = neisseria_elongata_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Neisseria elongata histogram of likelihoods [singletons masked]')
# neisseria_elongata_masked_surface_hist
# 
# neisseria_elongata_masked_surface_cutoff = quantile(neisseria_elongata_masked_surface$likelihood, 0.80)
# 
# neisseria_elongata_masked_surface[neisseria_elongata_masked_surface$likelihood < neisseria_elongata_masked_surface_cutoff, ]$likelihood = neisseria_elongata_masked_surface_cutoff
# 
# neisseria_elongata_masked_surface_scatter = ggplot(data=neisseria_elongata_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Neisseria elongata rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# neisseria_elongata_masked_surface_scatter
# 
# neisseria_elongata_unmasked_surface = read.csv('oral_likelihood_surfaces/neisseria_elongata_unmasked.csv', header=FALSE)
# names(neisseria_elongata_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# neisseria_elongata_unmasked_surface_expansion = neisseria_elongata_unmasked_surface[neisseria_elongata_unmasked_surface$nu > 1.0, ]
# neisseria_elongata_unmasked_surface_contraction = neisseria_elongata_unmasked_surface[neisseria_elongata_unmasked_surface$nu <= 1.0, ]
# 
# neisseria_elongata_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = neisseria_elongata_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = neisseria_elongata_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Neisseria elongata histogram of likelihoods')
# neisseria_elongata_unmasked_surface_hist
# 
# neisseria_elongata_unmasked_surface_cutoff = quantile(neisseria_elongata_unmasked_surface$likelihood, 0.80)
# 
# neisseria_elongata_unmasked_surface[neisseria_elongata_unmasked_surface$likelihood < neisseria_elongata_unmasked_surface_cutoff, ]$likelihood = neisseria_elongata_unmasked_surface_cutoff
# 
# neisseria_elongata_unmasked_surface_scatter = ggplot(data=neisseria_elongata_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Neisseria elongata rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# neisseria_elongata_unmasked_surface_scatter
# 
# neisseria_subflava_masked_surface = read.csv('oral_likelihood_surfaces/neisseria_subflava_masked.csv', header=FALSE)
# names(neisseria_subflava_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# neisseria_subflava_masked_surface_expansion = neisseria_subflava_masked_surface[neisseria_subflava_masked_surface$nu > 1.0, ]
# neisseria_subflava_masked_surface_contraction = neisseria_subflava_masked_surface[neisseria_subflava_masked_surface$nu <= 1.0, ]
# 
# neisseria_subflava_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = neisseria_subflava_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = neisseria_subflava_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Neisseria subflava histogram of likelihoods [singletons masked]')
# neisseria_subflava_masked_surface_hist
# 
# neisseria_subflava_masked_surface_cutoff = quantile(neisseria_subflava_masked_surface$likelihood, 0.80)
# 
# neisseria_subflava_masked_surface[neisseria_subflava_masked_surface$likelihood < neisseria_subflava_masked_surface_cutoff, ]$likelihood = neisseria_subflava_masked_surface_cutoff
# 
# neisseria_subflava_masked_surface_scatter = ggplot(data=neisseria_subflava_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Neisseria subflava rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# neisseria_subflava_masked_surface_scatter
# 
# neisseria_subflava_unmasked_surface = read.csv('oral_likelihood_surfaces/neisseria_subflava_unmasked.csv', header=FALSE)
# names(neisseria_subflava_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# neisseria_subflava_unmasked_surface_expansion = neisseria_subflava_unmasked_surface[neisseria_subflava_unmasked_surface$nu > 1.0, ]
# neisseria_subflava_unmasked_surface_contraction = neisseria_subflava_unmasked_surface[neisseria_subflava_unmasked_surface$nu <= 1.0, ]
# 
# neisseria_subflava_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = neisseria_subflava_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = neisseria_subflava_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Neisseria subflava histogram of likelihoods')
# neisseria_subflava_unmasked_surface_hist
# 
# neisseria_subflava_unmasked_surface_cutoff = quantile(neisseria_subflava_unmasked_surface$likelihood, 0.80)
# 
# neisseria_subflava_unmasked_surface[neisseria_subflava_unmasked_surface$likelihood < neisseria_subflava_unmasked_surface_cutoff, ]$likelihood = neisseria_subflava_unmasked_surface_cutoff
# 
# neisseria_subflava_unmasked_surface_scatter = ggplot(data=neisseria_subflava_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Neisseria subflava rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# neisseria_subflava_unmasked_surface_scatter
# 
# rothia_dentocariosa_masked_surface = read.csv('oral_likelihood_surfaces/rothia_dentocariosa_masked.csv', header=FALSE)
# names(rothia_dentocariosa_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# rothia_dentocariosa_masked_surface_expansion = rothia_dentocariosa_masked_surface[rothia_dentocariosa_masked_surface$nu > 1.0, ]
# rothia_dentocariosa_masked_surface_contraction = rothia_dentocariosa_masked_surface[rothia_dentocariosa_masked_surface$nu <= 1.0, ]
# 
# rothia_dentocariosa_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = rothia_dentocariosa_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = rothia_dentocariosa_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Rothia dentocariosa histogram of likelihoods [singletons masked]')
# rothia_dentocariosa_masked_surface_hist
# 
# rothia_dentocariosa_masked_surface_cutoff = quantile(rothia_dentocariosa_masked_surface$likelihood, 0.80)
# 
# rothia_dentocariosa_masked_surface[rothia_dentocariosa_masked_surface$likelihood < rothia_dentocariosa_masked_surface_cutoff, ]$likelihood = rothia_dentocariosa_masked_surface_cutoff
# 
# rothia_dentocariosa_masked_surface_scatter = ggplot(data=rothia_dentocariosa_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Rothia dentocariosa rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# rothia_dentocariosa_masked_surface_scatter
# 
# rothia_dentocariosa_unmasked_surface = read.csv('oral_likelihood_surfaces/rothia_dentocariosa_unmasked.csv', header=FALSE)
# names(rothia_dentocariosa_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# rothia_dentocariosa_unmasked_surface_expansion = rothia_dentocariosa_unmasked_surface[rothia_dentocariosa_unmasked_surface$nu > 1.0, ]
# rothia_dentocariosa_unmasked_surface_contraction = rothia_dentocariosa_unmasked_surface[rothia_dentocariosa_unmasked_surface$nu <= 1.0, ]
# 
# rothia_dentocariosa_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = rothia_dentocariosa_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = rothia_dentocariosa_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Rothia dentocariosa histogram of likelihoods')
# rothia_dentocariosa_unmasked_surface_hist
# 
# rothia_dentocariosa_unmasked_surface_cutoff = quantile(rothia_dentocariosa_unmasked_surface$likelihood, 0.80)
# 
# rothia_dentocariosa_unmasked_surface[rothia_dentocariosa_unmasked_surface$likelihood < rothia_dentocariosa_unmasked_surface_cutoff, ]$likelihood = rothia_dentocariosa_unmasked_surface_cutoff
# 
# rothia_dentocariosa_unmasked_surface_scatter = ggplot(data=rothia_dentocariosa_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Rothia dentocariosa rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# rothia_dentocariosa_unmasked_surface_scatter
# 
# rothia_mucilaginosa_masked_surface = read.csv('oral_likelihood_surfaces/rothia_mucilaginosa_masked.csv', header=FALSE)
# names(rothia_mucilaginosa_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# rothia_mucilaginosa_masked_surface_expansion = rothia_mucilaginosa_masked_surface[rothia_mucilaginosa_masked_surface$nu > 1.0, ]
# rothia_mucilaginosa_masked_surface_contraction = rothia_mucilaginosa_masked_surface[rothia_mucilaginosa_masked_surface$nu <= 1.0, ]
# 
# rothia_mucilaginosa_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = rothia_mucilaginosa_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = rothia_mucilaginosa_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Rothia mucilaginosa histogram of likelihoods [singletons masked]')
# rothia_mucilaginosa_masked_surface_hist
# 
# rothia_mucilaginosa_masked_surface_cutoff = quantile(rothia_mucilaginosa_masked_surface$likelihood, 0.80)
# 
# rothia_mucilaginosa_masked_surface[rothia_mucilaginosa_masked_surface$likelihood < rothia_mucilaginosa_masked_surface_cutoff, ]$likelihood = rothia_mucilaginosa_masked_surface_cutoff
# 
# rothia_mucilaginosa_masked_surface_scatter = ggplot(data=rothia_mucilaginosa_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Rothia mucilaginosa rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# rothia_mucilaginosa_masked_surface_scatter
# 
# rothia_mucilaginosa_unmasked_surface = read.csv('oral_likelihood_surfaces/rothia_mucilaginosa_unmasked.csv', header=FALSE)
# names(rothia_mucilaginosa_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# rothia_mucilaginosa_unmasked_surface_expansion = rothia_mucilaginosa_unmasked_surface[rothia_mucilaginosa_unmasked_surface$nu > 1.0, ]
# rothia_mucilaginosa_unmasked_surface_contraction = rothia_mucilaginosa_unmasked_surface[rothia_mucilaginosa_unmasked_surface$nu <= 1.0, ]
# 
# rothia_mucilaginosa_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = rothia_mucilaginosa_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = rothia_mucilaginosa_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Rothia mucilaginosa histogram of likelihoods')
# rothia_mucilaginosa_unmasked_surface_hist
# 
# rothia_mucilaginosa_unmasked_surface_cutoff = quantile(rothia_mucilaginosa_unmasked_surface$likelihood, 0.80)
# 
# rothia_mucilaginosa_unmasked_surface[rothia_mucilaginosa_unmasked_surface$likelihood < rothia_mucilaginosa_unmasked_surface_cutoff, ]$likelihood = rothia_mucilaginosa_unmasked_surface_cutoff
# 
# rothia_mucilaginosa_unmasked_surface_scatter = ggplot(data=rothia_mucilaginosa_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Rothia mucilaginosa rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# rothia_mucilaginosa_unmasked_surface_scatter
# 
# streptococcus_australis_masked_surface = read.csv('oral_likelihood_surfaces/streptococcus_australis_masked.csv', header=FALSE)
# names(streptococcus_australis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_australis_masked_surface_expansion = streptococcus_australis_masked_surface[streptococcus_australis_masked_surface$nu > 1.0, ]
# streptococcus_australis_masked_surface_contraction = streptococcus_australis_masked_surface[streptococcus_australis_masked_surface$nu <= 1.0, ]
# 
# streptococcus_australis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_australis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_australis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus australis histogram of likelihoods [singletons masked]')
# streptococcus_australis_masked_surface_hist
# 
# streptococcus_australis_masked_surface_cutoff = quantile(streptococcus_australis_masked_surface$likelihood, 0.80)
# 
# streptococcus_australis_masked_surface[streptococcus_australis_masked_surface$likelihood < streptococcus_australis_masked_surface_cutoff, ]$likelihood = streptococcus_australis_masked_surface_cutoff
# 
# streptococcus_australis_masked_surface_scatter = ggplot(data=streptococcus_australis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus australis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_australis_masked_surface_scatter
# 
# streptococcus_australis_unmasked_surface = read.csv('oral_likelihood_surfaces/streptococcus_australis_unmasked.csv', header=FALSE)
# names(streptococcus_australis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_australis_unmasked_surface_expansion = streptococcus_australis_unmasked_surface[streptococcus_australis_unmasked_surface$nu > 1.0, ]
# streptococcus_australis_unmasked_surface_contraction = streptococcus_australis_unmasked_surface[streptococcus_australis_unmasked_surface$nu <= 1.0, ]
# 
# streptococcus_australis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_australis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_australis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus australis histogram of likelihoods')
# streptococcus_australis_unmasked_surface_hist
# 
# streptococcus_australis_unmasked_surface_cutoff = quantile(streptococcus_australis_unmasked_surface$likelihood, 0.80)
# 
# streptococcus_australis_unmasked_surface[streptococcus_australis_unmasked_surface$likelihood < streptococcus_australis_unmasked_surface_cutoff, ]$likelihood = streptococcus_australis_unmasked_surface_cutoff
# 
# streptococcus_australis_unmasked_surface_scatter = ggplot(data=streptococcus_australis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus australis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_australis_unmasked_surface_scatter
# 
# streptococcus_mitis_masked_surface = read.csv('oral_likelihood_surfaces/streptococcus_mitis_masked.csv', header=FALSE)
# names(streptococcus_mitis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_mitis_masked_surface_expansion = streptococcus_mitis_masked_surface[streptococcus_mitis_masked_surface$nu > 1.0, ]
# streptococcus_mitis_masked_surface_contraction = streptococcus_mitis_masked_surface[streptococcus_mitis_masked_surface$nu <= 1.0, ]
# 
# streptococcus_mitis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_mitis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_mitis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus mitis histogram of likelihoods [singletons masked]')
# streptococcus_mitis_masked_surface_hist
# 
# streptococcus_mitis_masked_surface_cutoff = quantile(streptococcus_mitis_masked_surface$likelihood, 0.80)
# 
# streptococcus_mitis_masked_surface[streptococcus_mitis_masked_surface$likelihood < streptococcus_mitis_masked_surface_cutoff, ]$likelihood = streptococcus_mitis_masked_surface_cutoff
# 
# streptococcus_mitis_masked_surface_scatter = ggplot(data=streptococcus_mitis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus mitis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_mitis_masked_surface_scatter
# 
# streptococcus_mitis_unmasked_surface = read.csv('oral_likelihood_surfaces/streptococcus_mitis_unmasked.csv', header=FALSE)
# names(streptococcus_mitis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_mitis_unmasked_surface_expansion = streptococcus_mitis_unmasked_surface[streptococcus_mitis_unmasked_surface$nu > 1.0, ]
# streptococcus_mitis_unmasked_surface_contraction = streptococcus_mitis_unmasked_surface[streptococcus_mitis_unmasked_surface$nu <= 1.0, ]
# 
# streptococcus_mitis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_mitis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_mitis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus mitis histogram of likelihoods')
# streptococcus_mitis_unmasked_surface_hist
# 
# streptococcus_mitis_unmasked_surface_cutoff = quantile(streptococcus_mitis_unmasked_surface$likelihood, 0.80)
# 
# streptococcus_mitis_unmasked_surface[streptococcus_mitis_unmasked_surface$likelihood < streptococcus_mitis_unmasked_surface_cutoff, ]$likelihood = streptococcus_mitis_unmasked_surface_cutoff
# 
# streptococcus_mitis_unmasked_surface_scatter = ggplot(data=streptococcus_mitis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus mitis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_mitis_unmasked_surface_scatter
# 
# streptococcus_salivarius_masked_surface = read.csv('oral_likelihood_surfaces/streptococcus_salivarius_masked.csv', header=FALSE)
# names(streptococcus_salivarius_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_salivarius_masked_surface_expansion = streptococcus_salivarius_masked_surface[streptococcus_salivarius_masked_surface$nu > 1.0, ]
# streptococcus_salivarius_masked_surface_contraction = streptococcus_salivarius_masked_surface[streptococcus_salivarius_masked_surface$nu <= 1.0, ]
# 
# streptococcus_salivarius_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_salivarius_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_salivarius_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus salivarius histogram of likelihoods [singletons masked]')
# streptococcus_salivarius_masked_surface_hist
# 
# streptococcus_salivarius_masked_surface_cutoff = quantile(streptococcus_salivarius_masked_surface$likelihood, 0.80)
# 
# streptococcus_salivarius_masked_surface[streptococcus_salivarius_masked_surface$likelihood < streptococcus_salivarius_masked_surface_cutoff, ]$likelihood = streptococcus_salivarius_masked_surface_cutoff
# 
# streptococcus_salivarius_masked_surface_scatter = ggplot(data=streptococcus_salivarius_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus salivarius rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_salivarius_masked_surface_scatter
# 
# streptococcus_salivarius_unmasked_surface = read.csv('oral_likelihood_surfaces/streptococcus_salivarius_unmasked.csv', header=FALSE)
# names(streptococcus_salivarius_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_salivarius_unmasked_surface_expansion = streptococcus_salivarius_unmasked_surface[streptococcus_salivarius_unmasked_surface$nu > 1.0, ]
# streptococcus_salivarius_unmasked_surface_contraction = streptococcus_salivarius_unmasked_surface[streptococcus_salivarius_unmasked_surface$nu <= 1.0, ]
# 
# streptococcus_salivarius_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_salivarius_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_salivarius_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus salivarius histogram of likelihoods')
# streptococcus_salivarius_unmasked_surface_hist
# 
# streptococcus_salivarius_unmasked_surface_cutoff = quantile(streptococcus_salivarius_unmasked_surface$likelihood, 0.80)
# 
# streptococcus_salivarius_unmasked_surface[streptococcus_salivarius_unmasked_surface$likelihood < streptococcus_salivarius_unmasked_surface_cutoff, ]$likelihood = streptococcus_salivarius_unmasked_surface_cutoff
# 
# streptococcus_salivarius_unmasked_surface_scatter = ggplot(data=streptococcus_salivarius_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus salivarius rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_salivarius_unmasked_surface_scatter
# 
# streptococcus_sanguinis_masked_surface = read.csv('oral_likelihood_surfaces/streptococcus_sanguinis_masked.csv', header=FALSE)
# names(streptococcus_sanguinis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_sanguinis_masked_surface_expansion = streptococcus_sanguinis_masked_surface[streptococcus_sanguinis_masked_surface$nu > 1.0, ]
# streptococcus_sanguinis_masked_surface_contraction = streptococcus_sanguinis_masked_surface[streptococcus_sanguinis_masked_surface$nu <= 1.0, ]
# 
# streptococcus_sanguinis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_sanguinis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_sanguinis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus sanguinis histogram of likelihoods [singletons masked]')
# streptococcus_sanguinis_masked_surface_hist
# 
# streptococcus_sanguinis_masked_surface_cutoff = quantile(streptococcus_sanguinis_masked_surface$likelihood, 0.80)
# 
# streptococcus_sanguinis_masked_surface[streptococcus_sanguinis_masked_surface$likelihood < streptococcus_sanguinis_masked_surface_cutoff, ]$likelihood = streptococcus_sanguinis_masked_surface_cutoff
# 
# streptococcus_sanguinis_masked_surface_scatter = ggplot(data=streptococcus_sanguinis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus sanguinis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_sanguinis_masked_surface_scatter
# 
# streptococcus_sanguinis_unmasked_surface = read.csv('oral_likelihood_surfaces/streptococcus_sanguinis_unmasked.csv', header=FALSE)
# names(streptococcus_sanguinis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_sanguinis_unmasked_surface_expansion = streptococcus_sanguinis_unmasked_surface[streptococcus_sanguinis_unmasked_surface$nu > 1.0, ]
# streptococcus_sanguinis_unmasked_surface_contraction = streptococcus_sanguinis_unmasked_surface[streptococcus_sanguinis_unmasked_surface$nu <= 1.0, ]
# 
# streptococcus_sanguinis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_sanguinis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_sanguinis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus sanguinis histogram of likelihoods')
# streptococcus_sanguinis_unmasked_surface_hist
# 
# streptococcus_sanguinis_unmasked_surface_cutoff = quantile(streptococcus_sanguinis_unmasked_surface$likelihood, 0.80)
# 
# streptococcus_sanguinis_unmasked_surface[streptococcus_sanguinis_unmasked_surface$likelihood < streptococcus_sanguinis_unmasked_surface_cutoff, ]$likelihood = streptococcus_sanguinis_unmasked_surface_cutoff
# 
# streptococcus_sanguinis_unmasked_surface_scatter = ggplot(data=streptococcus_sanguinis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus sanguinis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_sanguinis_unmasked_surface_scatter
# 
# streptococcus_sp_masked_surface = read.csv('oral_likelihood_surfaces/streptococcus_sp_masked.csv', header=FALSE)
# names(streptococcus_sp_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_sp_masked_surface_expansion = streptococcus_sp_masked_surface[streptococcus_sp_masked_surface$nu > 1.0, ]
# streptococcus_sp_masked_surface_contraction = streptococcus_sp_masked_surface[streptococcus_sp_masked_surface$nu <= 1.0, ]
# 
# streptococcus_sp_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_sp_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_sp_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus sp. histogram of likelihoods [singletons masked]')
# streptococcus_sp_masked_surface_hist
# 
# streptococcus_sp_masked_surface_cutoff = quantile(streptococcus_sp_masked_surface$likelihood, 0.80)
# 
# streptococcus_sp_masked_surface[streptococcus_sp_masked_surface$likelihood < streptococcus_sp_masked_surface_cutoff, ]$likelihood = streptococcus_sp_masked_surface_cutoff
# 
# streptococcus_sp_masked_surface_scatter = ggplot(data=streptococcus_sp_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus sp. rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_sp_masked_surface_scatter
# 
# streptococcus_sp_unmasked_surface = read.csv('oral_likelihood_surfaces/streptococcus_sp_unmasked.csv', header=FALSE)
# names(streptococcus_sp_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# streptococcus_sp_unmasked_surface_expansion = streptococcus_sp_unmasked_surface[streptococcus_sp_unmasked_surface$nu > 1.0, ]
# streptococcus_sp_unmasked_surface_contraction = streptococcus_sp_unmasked_surface[streptococcus_sp_unmasked_surface$nu <= 1.0, ]
# 
# streptococcus_sp_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = streptococcus_sp_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = streptococcus_sp_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Streptococcus sp. histogram of likelihoods')
# streptococcus_sp_unmasked_surface_hist
# 
# streptococcus_sp_unmasked_surface_cutoff = quantile(streptococcus_sp_unmasked_surface$likelihood, 0.80)
# 
# streptococcus_sp_unmasked_surface[streptococcus_sp_unmasked_surface$likelihood < streptococcus_sp_unmasked_surface_cutoff, ]$likelihood = streptococcus_sp_unmasked_surface_cutoff
# 
# streptococcus_sp_unmasked_surface_scatter = ggplot(data=streptococcus_sp_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Streptococcus sp. rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# streptococcus_sp_unmasked_surface_scatter
# 
# 
# veillonella_parvula_57794_masked_surface = read.csv('oral_likelihood_surfaces/veillonella_parvula_57794_masked.csv', header=FALSE)
# names(veillonella_parvula_57794_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# veillonella_parvula_57794_masked_surface_expansion = veillonella_parvula_57794_masked_surface[veillonella_parvula_57794_masked_surface$nu > 1.0, ]
# veillonella_parvula_57794_masked_surface_contraction = veillonella_parvula_57794_masked_surface[veillonella_parvula_57794_masked_surface$nu <= 1.0, ]
# 
# veillonella_parvula_57794_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = veillonella_parvula_57794_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = veillonella_parvula_57794_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('V. parvula 57794 histogram of likelihoods [singletons masked]')
# veillonella_parvula_57794_masked_surface_hist
# 
# veillonella_parvula_57794_masked_surface_cutoff = quantile(veillonella_parvula_57794_masked_surface$likelihood, 0.80)
# 
# veillonella_parvula_57794_masked_surface[veillonella_parvula_57794_masked_surface$likelihood < veillonella_parvula_57794_masked_surface_cutoff, ]$likelihood = veillonella_parvula_57794_masked_surface_cutoff
# 
# veillonella_parvula_57794_masked_surface_scatter = ggplot(data=veillonella_parvula_57794_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('V. parvula 57794 rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# veillonella_parvula_57794_masked_surface_scatter
# 
# veillonella_parvula_57794_unmasked_surface = read.csv('oral_likelihood_surfaces/veillonella_parvula_57794_unmasked.csv', header=FALSE)
# names(veillonella_parvula_57794_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# veillonella_parvula_57794_unmasked_surface_expansion = veillonella_parvula_57794_unmasked_surface[veillonella_parvula_57794_unmasked_surface$nu > 1.0, ]
# veillonella_parvula_57794_unmasked_surface_contraction = veillonella_parvula_57794_unmasked_surface[veillonella_parvula_57794_unmasked_surface$nu <= 1.0, ]
# 
# veillonella_parvula_57794_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = veillonella_parvula_57794_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = veillonella_parvula_57794_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('V. parvula 57794 histogram of likelihoods')
# veillonella_parvula_57794_unmasked_surface_hist
# 
# veillonella_parvula_57794_unmasked_surface_cutoff = quantile(veillonella_parvula_57794_unmasked_surface$likelihood, 0.80)
# 
# veillonella_parvula_57794_unmasked_surface[veillonella_parvula_57794_unmasked_surface$likelihood < veillonella_parvula_57794_unmasked_surface_cutoff, ]$likelihood = veillonella_parvula_57794_unmasked_surface_cutoff
# 
# veillonella_parvula_57794_unmasked_surface_scatter = ggplot(data=veillonella_parvula_57794_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('V. parvula 57794 rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# veillonella_parvula_57794_unmasked_surface_scatter
# 
# veillonella_parvula_58184_masked_surface = read.csv('oral_likelihood_surfaces/veillonella_parvula_58184_masked.csv', header=FALSE)
# names(veillonella_parvula_58184_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# veillonella_parvula_58184_masked_surface_expansion = veillonella_parvula_58184_masked_surface[veillonella_parvula_58184_masked_surface$nu > 1.0, ]
# veillonella_parvula_58184_masked_surface_contraction = veillonella_parvula_58184_masked_surface[veillonella_parvula_58184_masked_surface$nu <= 1.0, ]
# 
# veillonella_parvula_58184_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = veillonella_parvula_58184_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = veillonella_parvula_58184_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('V. parvula 58184 histogram of likelihoods [singletons masked]')
# veillonella_parvula_58184_masked_surface_hist
# 
# veillonella_parvula_58184_masked_surface_cutoff = quantile(veillonella_parvula_58184_masked_surface$likelihood, 0.80)
# 
# veillonella_parvula_58184_masked_surface[veillonella_parvula_58184_masked_surface$likelihood < veillonella_parvula_58184_masked_surface_cutoff, ]$likelihood = veillonella_parvula_58184_masked_surface_cutoff
# 
# veillonella_parvula_58184_masked_surface_scatter = ggplot(data=veillonella_parvula_58184_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('V. parvula 58184 rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# veillonella_parvula_58184_masked_surface_scatter
# 
# veillonella_parvula_58184_unmasked_surface = read.csv('oral_likelihood_surfaces/veillonella_parvula_58184_unmasked.csv', header=FALSE)
# names(veillonella_parvula_58184_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# veillonella_parvula_58184_unmasked_surface_expansion = veillonella_parvula_58184_unmasked_surface[veillonella_parvula_58184_unmasked_surface$nu > 1.0, ]
# veillonella_parvula_58184_unmasked_surface_contraction = veillonella_parvula_58184_unmasked_surface[veillonella_parvula_58184_unmasked_surface$nu <= 1.0, ]
# 
# veillonella_parvula_58184_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = veillonella_parvula_58184_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = veillonella_parvula_58184_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('V. parvula 58184 histogram of likelihoods')
# veillonella_parvula_58184_unmasked_surface_hist
# 
# veillonella_parvula_58184_unmasked_surface_cutoff = quantile(veillonella_parvula_58184_unmasked_surface$likelihood, 0.80)
# 
# veillonella_parvula_58184_unmasked_surface[veillonella_parvula_58184_unmasked_surface$likelihood < veillonella_parvula_58184_unmasked_surface_cutoff, ]$likelihood = veillonella_parvula_58184_unmasked_surface_cutoff
# 
# veillonella_parvula_58184_unmasked_surface_scatter = ggplot(data=veillonella_parvula_58184_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('V. parvula 58184 rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# veillonella_parvula_58184_unmasked_surface_scatter
# 
# # Gut Data likelihood surfaces
# 
# akkermansia_muciniphila_masked_surface = read.csv('gut_likelihood_surfaces/akkermansia_muciniphila_masked.csv', header=FALSE)
# names(akkermansia_muciniphila_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# akkermansia_muciniphila_masked_expansion = read.csv('gut_expansion_likelihood_surfaces/akkermansia_muciniphila_masked.csv', header=FALSE)
# names(akkermansia_muciniphila_masked_expansion) = c('likelihood', 'nu', 'tau')
# 
# akkermansia_muciniphila_masked_surface = rbind(akkermansia_muciniphila_masked_surface,
#                                             akkermansia_muciniphila_masked_expansion)
# 
# akkermansia_muciniphila_masked_surface_expansion = akkermansia_muciniphila_masked_surface[akkermansia_muciniphila_masked_surface$nu > 1.0, ]
# akkermansia_muciniphila_masked_surface_contraction = akkermansia_muciniphila_masked_surface[akkermansia_muciniphila_masked_surface$nu <= 1.0, ]
# 
# akkermansia_muciniphila_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = akkermansia_muciniphila_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = akkermansia_muciniphila_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Akkermansia muciniphila histogram of likelihoods [singletons masked]')
# akkermansia_muciniphila_masked_surface_hist
# 
# akkermansia_muciniphila_masked_surface_cutoff = max(akkermansia_muciniphila_masked_surface$likelihood) - 10
# 
# akkermansia_muciniphila_masked_surface[akkermansia_muciniphila_masked_surface$likelihood < akkermansia_muciniphila_masked_surface_cutoff, ]$likelihood = akkermansia_muciniphila_masked_surface_cutoff
# 
# akkermansia_muciniphila_masked_surface_scatter = ggplot(data=akkermansia_muciniphila_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Akkermansia muciniphila rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# akkermansia_muciniphila_masked_surface_scatter
# 
# akkermansia_muciniphila_unmasked_surface = read.csv('gut_likelihood_surfaces/akkermansia_muciniphila_unmasked.csv', header=FALSE)
# names(akkermansia_muciniphila_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# akkermansia_muciniphila_unmasked_expansion = read.csv('gut_expansion_likelihood_surfaces/akkermansia_muciniphila_unmasked.csv', header=FALSE)
# names(akkermansia_muciniphila_unmasked_expansion) = c('likelihood', 'nu', 'tau')
# 
# akkermansia_muciniphila_unmasked_surface = rbind(akkermansia_muciniphila_unmasked_surface,
#                                               akkermansia_muciniphila_unmasked_expansion)
# 
# akkermansia_muciniphila_unmasked_surface_expansion = akkermansia_muciniphila_unmasked_surface[akkermansia_muciniphila_unmasked_surface$nu > 1.0, ]
# akkermansia_muciniphila_unmasked_surface_contraction = akkermansia_muciniphila_unmasked_surface[akkermansia_muciniphila_unmasked_surface$nu <= 1.0, ]
# 
# akkermansia_muciniphila_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = akkermansia_muciniphila_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = akkermansia_muciniphila_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Akkermansia muciniphila histogram of likelihoods [singletons unmasked]')
# akkermansia_muciniphila_unmasked_surface_hist
# 
# akkermansia_muciniphila_unmasked_surface_cutoff = max(akkermansia_muciniphila_unmasked_surface$likelihood) - 10
# 
# akkermansia_muciniphila_unmasked_surface[akkermansia_muciniphila_unmasked_surface$likelihood < akkermansia_muciniphila_unmasked_surface_cutoff, ]$likelihood = akkermansia_muciniphila_unmasked_surface_cutoff
# 
# akkermansia_muciniphila_unmasked_surface_scatter = ggplot(data=akkermansia_muciniphila_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Akkermansia muciniphila rough likelihood surface [singletons unmasked]') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# akkermansia_muciniphila_unmasked_surface_scatter
# 
# alistipes_finegoldii_masked_surface = read.csv('gut_likelihood_surfaces/alistipes_finegoldii_masked.csv', header=FALSE)
# names(alistipes_finegoldii_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# alistipes_finegoldii_masked_expansion = read.csv('gut_expansion_likelihood_surfaces/alistipes_finegoldii_masked.csv', header=FALSE)
# names(alistipes_finegoldii_masked_expansion) = c('likelihood', 'nu', 'tau')
# 
# alistipes_finegoldii_masked_surface = rbind(alistipes_finegoldii_masked_surface,
#                                             alistipes_finegoldii_masked_expansion)
# 
# alistipes_finegoldii_masked_surface_expansion = alistipes_finegoldii_masked_surface[alistipes_finegoldii_masked_surface$nu > 1.0, ]
# alistipes_finegoldii_masked_surface_contraction = alistipes_finegoldii_masked_surface[alistipes_finegoldii_masked_surface$nu <= 1.0, ]
# 
# alistipes_finegoldii_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = alistipes_finegoldii_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = alistipes_finegoldii_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Alistipes finegoldii histogram of likelihoods [singletons masked]')
# alistipes_finegoldii_masked_surface_hist
# 
# alistipes_finegoldii_masked_surface_cutoff = max(alistipes_finegoldii_masked_surface$likelihood) - 10
# 
# alistipes_finegoldii_masked_surface[alistipes_finegoldii_masked_surface$likelihood < alistipes_finegoldii_masked_surface_cutoff, ]$likelihood = alistipes_finegoldii_masked_surface_cutoff
# 
# alistipes_finegoldii_masked_surface_scatter = ggplot(data=alistipes_finegoldii_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Alistipes finegoldii rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# alistipes_finegoldii_masked_surface_scatter
# 
# alistipes_finegoldii_unmasked_surface = read.csv('gut_likelihood_surfaces/alistipes_finegoldii_unmasked.csv', header=FALSE)
# names(alistipes_finegoldii_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# alistipes_finegoldii_unmasked_expansion = read.csv('gut_expansion_likelihood_surfaces/alistipes_finegoldii_unmasked.csv', header=FALSE)
# names(alistipes_finegoldii_unmasked_expansion) = c('likelihood', 'nu', 'tau')
# 
# alistipes_finegoldii_unmasked_surface = rbind(alistipes_finegoldii_unmasked_surface,
#                                             alistipes_finegoldii_unmasked_expansion)
# 
# alistipes_finegoldii_unmasked_surface_expansion = alistipes_finegoldii_unmasked_surface[alistipes_finegoldii_unmasked_surface$nu > 1.0, ]
# alistipes_finegoldii_unmasked_surface_contraction = alistipes_finegoldii_unmasked_surface[alistipes_finegoldii_unmasked_surface$nu <= 1.0, ]
# 
# alistipes_finegoldii_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = alistipes_finegoldii_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = alistipes_finegoldii_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Alistipes finegoldii histogram of likelihoods [singletons unmasked]')
# alistipes_finegoldii_unmasked_surface_hist
# 
# alistipes_finegoldii_unmasked_surface_cutoff = max(alistipes_finegoldii_unmasked_surface$likelihood) - 10
# 
# alistipes_finegoldii_unmasked_surface[alistipes_finegoldii_unmasked_surface$likelihood < alistipes_finegoldii_unmasked_surface_cutoff, ]$likelihood = alistipes_finegoldii_unmasked_surface_cutoff
# 
# alistipes_finegoldii_unmasked_surface_scatter = ggplot(data=alistipes_finegoldii_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Alistipes finegoldii rough likelihood surface [singletons unmasked]') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# alistipes_finegoldii_unmasked_surface_scatter
# 
# alistipes_onderdonkii_masked_surface = read.csv('gut_likelihood_surfaces/alistipes_onderdonkii_masked.csv', header=FALSE)
# names(alistipes_onderdonkii_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# alistipes_onderdonkii_masked_expansion = read.csv('gut_expansion_likelihood_surfaces/alistipes_onderdonkii_masked.csv', header=FALSE)
# names(alistipes_onderdonkii_masked_expansion) = c('likelihood', 'nu', 'tau')
# 
# alistipes_onderdonkii_masked_surface = rbind(alistipes_onderdonkii_masked_surface,
#                                             alistipes_onderdonkii_masked_expansion)
# 
# alistipes_onderdonkii_masked_surface_expansion = alistipes_onderdonkii_masked_surface[alistipes_onderdonkii_masked_surface$nu > 1.0, ]
# alistipes_onderdonkii_masked_surface_contraction = alistipes_onderdonkii_masked_surface[alistipes_onderdonkii_masked_surface$nu <= 1.0, ]
# 
# alistipes_onderdonkii_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = alistipes_onderdonkii_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = alistipes_onderdonkii_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Alistipes onderdonkii histogram of likelihoods [singletons masked]')
# alistipes_onderdonkii_masked_surface_hist
# 
# alistipes_onderdonkii_masked_surface_cutoff = max(alistipes_onderdonkii_masked_surface$likelihood) - 10
# 
# alistipes_onderdonkii_masked_surface[alistipes_onderdonkii_masked_surface$likelihood < alistipes_onderdonkii_masked_surface_cutoff, ]$likelihood = alistipes_onderdonkii_masked_surface_cutoff
# 
# alistipes_onderdonkii_masked_surface_scatter = ggplot(data=alistipes_onderdonkii_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Alistipes onderdonkii rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# alistipes_onderdonkii_masked_surface_scatter
# 
# alistipes_onderdonkii_unmasked_surface = read.csv('gut_likelihood_surfaces/alistipes_onderdonkii_unmasked.csv', header=FALSE)
# names(alistipes_onderdonkii_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# alistipes_onderdonkii_unmasked_expansion = read.csv('gut_expansion_likelihood_surfaces/alistipes_onderdonkii_unmasked.csv', header=FALSE)
# names(alistipes_onderdonkii_unmasked_expansion) = c('likelihood', 'nu', 'tau')
# 
# alistipes_onderdonkii_unmasked_surface = rbind(alistipes_onderdonkii_unmasked_surface,
#                                               alistipes_onderdonkii_unmasked_expansion)
# 
# alistipes_onderdonkii_unmasked_surface_expansion = alistipes_onderdonkii_unmasked_surface[alistipes_onderdonkii_unmasked_surface$nu > 1.0, ]
# alistipes_onderdonkii_unmasked_surface_contraction = alistipes_onderdonkii_unmasked_surface[alistipes_onderdonkii_unmasked_surface$nu <= 1.0, ]
# 
# alistipes_onderdonkii_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = alistipes_onderdonkii_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = alistipes_onderdonkii_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Alistipes onderdonkii histogram of likelihoods [singletons unmasked]')
# alistipes_onderdonkii_unmasked_surface_hist
# 
# alistipes_onderdonkii_unmasked_surface_cutoff = max(alistipes_onderdonkii_unmasked_surface$likelihood) - 10
# 
# alistipes_onderdonkii_unmasked_surface[alistipes_onderdonkii_unmasked_surface$likelihood < alistipes_onderdonkii_unmasked_surface_cutoff, ]$likelihood = alistipes_onderdonkii_unmasked_surface_cutoff
# 
# alistipes_onderdonkii_unmasked_surface_scatter = ggplot(data=alistipes_onderdonkii_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Alistipes onderdonkii rough likelihood surface [singletons unmasked]') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# alistipes_onderdonkii_unmasked_surface_scatter
# 
# alistipes_putredinis_masked_surface = read.csv('gut_likelihood_surfaces/alistipes_putredinis_masked.csv', header=FALSE)
# names(alistipes_putredinis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# alistipes_putredinis_masked_surface_expansion = alistipes_putredinis_masked_surface[alistipes_putredinis_masked_surface$nu > 1.0, ]
# alistipes_putredinis_masked_surface_contraction = alistipes_putredinis_masked_surface[alistipes_putredinis_masked_surface$nu <= 1.0, ]
# 
# alistipes_putredinis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = alistipes_putredinis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = alistipes_putredinis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Alistipes putredinis histogram of likelihoods [singletons masked]')
# alistipes_putredinis_masked_surface_hist
# 
# alistipes_putredinis_masked_surface_cutoff = quantile(alistipes_putredinis_masked_surface$likelihood, 0.80)
# 
# alistipes_putredinis_masked_surface[alistipes_putredinis_masked_surface$likelihood < alistipes_putredinis_masked_surface_cutoff, ]$likelihood = alistipes_putredinis_masked_surface_cutoff
# 
# alistipes_putredinis_masked_surface_scatter = ggplot(data=alistipes_putredinis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Alistipes putredinis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# alistipes_putredinis_masked_surface_scatter
# 
# alistipes_putredinis_unmasked_surface = read.csv('gut_likelihood_surfaces/alistipes_putredinis_unmasked.csv', header=FALSE)
# names(alistipes_putredinis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# alistipes_putredinis_unmasked_surface_expansion = alistipes_putredinis_unmasked_surface[alistipes_putredinis_unmasked_surface$nu > 1.0, ]
# alistipes_putredinis_unmasked_surface_contraction = alistipes_putredinis_unmasked_surface[alistipes_putredinis_unmasked_surface$nu <= 1.0, ]
# 
# alistipes_putredinis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = alistipes_putredinis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = alistipes_putredinis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Alistipes putredinis histogram of likelihoods')
# alistipes_putredinis_unmasked_surface_hist
# 
# alistipes_putredinis_unmasked_surface_cutoff = quantile(alistipes_putredinis_unmasked_surface$likelihood, 0.80)
# 
# alistipes_putredinis_unmasked_surface[alistipes_putredinis_unmasked_surface$likelihood < alistipes_putredinis_unmasked_surface_cutoff, ]$likelihood = alistipes_putredinis_unmasked_surface_cutoff
# 
# alistipes_putredinis_unmasked_surface_scatter = ggplot(data=alistipes_putredinis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Alistipes putredinis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# alistipes_putredinis_unmasked_surface_scatter
# 
# alistipes_shahii_masked_surface = read.csv('gut_likelihood_surfaces/alistipes_shahii_masked.csv', header=FALSE)
# names(alistipes_shahii_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# alistipes_shahii_masked_surface_expansion = alistipes_shahii_masked_surface[alistipes_shahii_masked_surface$nu > 1.0, ]
# alistipes_shahii_masked_surface_contraction = alistipes_shahii_masked_surface[alistipes_shahii_masked_surface$nu <= 1.0, ]
# 
# alistipes_shahii_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = alistipes_shahii_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = alistipes_shahii_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Alistipes shahii histogram of likelihoods [singletons masked]')
# alistipes_shahii_masked_surface_hist
# 
# # alistipes_shahii_masked_surface_cutoff = quantile(alistipes_shahii_masked_surface$likelihood, 0.80)
# 
# alistipes_shahii_masked_surface_cutoff=-49
# 
# alistipes_shahii_masked_surface[alistipes_shahii_masked_surface$likelihood < alistipes_shahii_masked_surface_cutoff, ]$likelihood = alistipes_shahii_masked_surface_cutoff
# 
# alistipes_shahii_masked_surface_scatter = ggplot(data=alistipes_shahii_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Alistipes shahii rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# alistipes_shahii_masked_surface_scatter
# 
# alistipes_shahii_unmasked_surface = read.csv('gut_likelihood_surfaces/alistipes_shahii_unmasked.csv', header=FALSE)
# names(alistipes_shahii_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# alistipes_shahii_unmasked_surface_expansion = alistipes_shahii_unmasked_surface[alistipes_shahii_unmasked_surface$nu > 1.0, ]
# alistipes_shahii_unmasked_surface_contraction = alistipes_shahii_unmasked_surface[alistipes_shahii_unmasked_surface$nu <= 1.0, ]
# 
# alistipes_shahii_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = alistipes_shahii_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = alistipes_shahii_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Alistipes shahii histogram of likelihoods')
# alistipes_shahii_unmasked_surface_hist
# 
# #  alistipes_shahii_unmasked_surface_cutoff = quantile(alistipes_shahii_unmasked_surface$likelihood, 0.80)
# 
# alistipes_shahii_unmasked_surface_cutoff=-49
# 
# alistipes_shahii_unmasked_surface[alistipes_shahii_unmasked_surface$likelihood < alistipes_shahii_unmasked_surface_cutoff, ]$likelihood = alistipes_shahii_unmasked_surface_cutoff
# 
# alistipes_shahii_unmasked_surface_scatter = ggplot(data=alistipes_shahii_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Alistipes shahii rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# alistipes_shahii_unmasked_surface_scatter
# 
# bacteroidales_bacterium_masked_surface = read.csv('gut_likelihood_surfaces/bacteroidales_bacterium_masked.csv', header=FALSE)
# names(bacteroidales_bacterium_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroidales_bacterium_masked_expansion = read.csv('gut_expansion_likelihood_surfaces/bacteroidales_bacterium_masked.csv', header=FALSE)
# names(bacteroidales_bacterium_masked_expansion) = c('likelihood', 'nu', 'tau')
# 
# bacteroidales_bacterium_masked_surface = rbind(bacteroidales_bacterium_masked_surface,
#                                             bacteroidales_bacterium_masked_expansion)
# 
# bacteroidales_bacterium_masked_surface_expansion = bacteroidales_bacterium_masked_surface[bacteroidales_bacterium_masked_surface$nu > 1.0, ]
# bacteroidales_bacterium_masked_surface_contraction = bacteroidales_bacterium_masked_surface[bacteroidales_bacterium_masked_surface$nu <= 1.0, ]
# 
# bacteroidales_bacterium_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroidales_bacterium_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroidales_bacterium_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroidales bacterium histogram of likelihoods [singletons masked]')
# bacteroidales_bacterium_masked_surface_hist
# 
# bacteroidales_bacterium_masked_surface_cutoff = max(bacteroidales_bacterium_masked_surface$likelihood) - 10
# 
# bacteroidales_bacterium_masked_surface[bacteroidales_bacterium_masked_surface$likelihood < bacteroidales_bacterium_masked_surface_cutoff, ]$likelihood = bacteroidales_bacterium_masked_surface_cutoff
# 
# bacteroidales_bacterium_masked_surface_scatter = ggplot(data=bacteroidales_bacterium_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroidales bacterium rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroidales_bacterium_masked_surface_scatter
# 
# bacteroidales_bacterium_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroidales_bacterium_unmasked.csv', header=FALSE)
# names(bacteroidales_bacterium_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroidales_bacterium_unmasked_expansion = read.csv('gut_expansion_likelihood_surfaces/bacteroidales_bacterium_unmasked.csv', header=FALSE)
# names(bacteroidales_bacterium_unmasked_expansion) = c('likelihood', 'nu', 'tau')
# 
# bacteroidales_bacterium_unmasked_surface = rbind(bacteroidales_bacterium_unmasked_surface,
#                                               bacteroidales_bacterium_unmasked_expansion)
# 
# bacteroidales_bacterium_unmasked_surface_expansion = bacteroidales_bacterium_unmasked_surface[bacteroidales_bacterium_unmasked_surface$nu > 1.0, ]
# bacteroidales_bacterium_unmasked_surface_contraction = bacteroidales_bacterium_unmasked_surface[bacteroidales_bacterium_unmasked_surface$nu <= 1.0, ]
# 
# bacteroidales_bacterium_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroidales_bacterium_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroidales_bacterium_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroidales bacterium histogram of likelihoods [singletons unmasked]')
# bacteroidales_bacterium_unmasked_surface_hist
# 
# bacteroidales_bacterium_unmasked_surface_cutoff = max(bacteroidales_bacterium_unmasked_surface$likelihood) - 10
# 
# bacteroidales_bacterium_unmasked_surface[bacteroidales_bacterium_unmasked_surface$likelihood < bacteroidales_bacterium_unmasked_surface_cutoff, ]$likelihood = bacteroidales_bacterium_unmasked_surface_cutoff
# 
# bacteroidales_bacterium_unmasked_surface_scatter = ggplot(data=bacteroidales_bacterium_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroidales bacterium rough likelihood surface [singletons unmasked]') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# bacteroidales_bacterium_unmasked_surface_scatter
# 
# bacteroides_caccae_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_caccae_masked.csv', header=FALSE)
# names(bacteroides_caccae_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_caccae_masked_surface_expansion = bacteroides_caccae_masked_surface[bacteroides_caccae_masked_surface$nu > 1.0, ]
# bacteroides_caccae_masked_surface_contraction = bacteroides_caccae_masked_surface[bacteroides_caccae_masked_surface$nu <= 1.0, ]
# 
# bacteroides_caccae_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_caccae_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_caccae_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides caccae histogram of likelihoods [singletons masked]')
# bacteroides_caccae_masked_surface_hist
# 
# bacteroides_caccae_masked_surface_cutoff = quantile(bacteroides_caccae_masked_surface$likelihood, 0.80)
# 
# bacteroides_caccae_masked_surface[bacteroides_caccae_masked_surface$likelihood < bacteroides_caccae_masked_surface_cutoff, ]$likelihood = bacteroides_caccae_masked_surface_cutoff
# 
# bacteroides_caccae_masked_surface_scatter = ggplot(data=bacteroides_caccae_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides caccae rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_caccae_masked_surface_scatter
# 
# bacteroides_caccae_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_caccae_unmasked.csv', header=FALSE)
# names(bacteroides_caccae_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_caccae_unmasked_surface_expansion = bacteroides_caccae_unmasked_surface[bacteroides_caccae_unmasked_surface$nu > 1.0, ]
# bacteroides_caccae_unmasked_surface_contraction = bacteroides_caccae_unmasked_surface[bacteroides_caccae_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_caccae_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_caccae_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_caccae_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides caccae histogram of likelihoods')
# bacteroides_caccae_unmasked_surface_hist
# 
# bacteroides_caccae_unmasked_surface_cutoff = quantile(bacteroides_caccae_unmasked_surface$likelihood, 0.80)
# 
# bacteroides_caccae_unmasked_surface[bacteroides_caccae_unmasked_surface$likelihood < bacteroides_caccae_unmasked_surface_cutoff, ]$likelihood = bacteroides_caccae_unmasked_surface_cutoff
# 
# bacteroides_caccae_unmasked_surface_scatter = ggplot(data=bacteroides_caccae_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides caccae rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# bacteroides_caccae_unmasked_surface_scatter
# 
# bacteroides_cellulosilyticus_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_cellulosilyticus_masked.csv', header=FALSE)
# names(bacteroides_cellulosilyticus_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_cellulosilyticus_masked_surface_expansion = bacteroides_cellulosilyticus_masked_surface[bacteroides_cellulosilyticus_masked_surface$nu > 1.0, ]
# bacteroides_cellulosilyticus_masked_surface_contraction = bacteroides_cellulosilyticus_masked_surface[bacteroides_cellulosilyticus_masked_surface$nu <= 1.0, ]
# 
# bacteroides_cellulosilyticus_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_cellulosilyticus_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_cellulosilyticus_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides cellulosilyticus histogram of likelihoods [singletons masked]')
# bacteroides_cellulosilyticus_masked_surface_hist
# 
# bacteroides_cellulosilyticus_masked_surface_cutoff = quantile(bacteroides_cellulosilyticus_masked_surface$likelihood, 0.80)
# 
# bacteroides_cellulosilyticus_masked_surface[bacteroides_cellulosilyticus_masked_surface$likelihood < bacteroides_cellulosilyticus_masked_surface_cutoff, ]$likelihood = bacteroides_cellulosilyticus_masked_surface_cutoff
# 
# bacteroides_cellulosilyticus_masked_surface_scatter = ggplot(data=bacteroides_cellulosilyticus_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides cellulosilyticus rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_cellulosilyticus_masked_surface_scatter
# 
# bacteroides_cellulosilyticus_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_cellulosilyticus_unmasked.csv', header=FALSE)
# names(bacteroides_cellulosilyticus_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_cellulosilyticus_unmasked_surface_expansion = bacteroides_cellulosilyticus_unmasked_surface[bacteroides_cellulosilyticus_unmasked_surface$nu > 1.0, ]
# bacteroides_cellulosilyticus_unmasked_surface_contraction = bacteroides_cellulosilyticus_unmasked_surface[bacteroides_cellulosilyticus_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_cellulosilyticus_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_cellulosilyticus_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_cellulosilyticus_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides cellulosilyticus histogram of likelihoods')
# bacteroides_cellulosilyticus_unmasked_surface_hist
# 
# bacteroides_cellulosilyticus_unmasked_surface_cutoff = quantile(bacteroides_cellulosilyticus_unmasked_surface$likelihood, 0.80)
# 
# bacteroides_cellulosilyticus_unmasked_surface[bacteroides_cellulosilyticus_unmasked_surface$likelihood < bacteroides_cellulosilyticus_unmasked_surface_cutoff, ]$likelihood = bacteroides_cellulosilyticus_unmasked_surface_cutoff
# 
# bacteroides_cellulosilyticus_unmasked_surface_scatter = ggplot(data=bacteroides_cellulosilyticus_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides cellulosilyticus rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')  +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# bacteroides_cellulosilyticus_unmasked_surface_scatter
# 
# bacteroides_fragilis_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_fragilis_masked.csv', header=FALSE)
# names(bacteroides_fragilis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_fragilis_masked_surface_expansion = bacteroides_fragilis_masked_surface[bacteroides_fragilis_masked_surface$nu > 1.0, ]
# bacteroides_fragilis_masked_surface_contraction = bacteroides_fragilis_masked_surface[bacteroides_fragilis_masked_surface$nu <= 1.0, ]
# 
# bacteroides_fragilis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_fragilis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_fragilis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides fragilis histogram of likelihoods [singletons masked]')
# bacteroides_fragilis_masked_surface_hist
# 
# bacteroides_fragilis_masked_surface_cutoff = quantile(bacteroides_fragilis_masked_surface$likelihood, 0.80)
# 
# bacteroides_fragilis_masked_surface[bacteroides_fragilis_masked_surface$likelihood < bacteroides_fragilis_masked_surface_cutoff, ]$likelihood = bacteroides_fragilis_masked_surface_cutoff
# 
# bacteroides_fragilis_masked_surface_scatter = ggplot(data=bacteroides_fragilis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides fragilis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_fragilis_masked_surface_scatter
# 
# bacteroides_fragilis_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_fragilis_unmasked.csv', header=FALSE)
# names(bacteroides_fragilis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_fragilis_unmasked_surface_expansion = bacteroides_fragilis_unmasked_surface[bacteroides_fragilis_unmasked_surface$nu > 1.0, ]
# bacteroides_fragilis_unmasked_surface_contraction = bacteroides_fragilis_unmasked_surface[bacteroides_fragilis_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_fragilis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_fragilis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_fragilis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides fragilis histogram of likelihoods')
# bacteroides_fragilis_unmasked_surface_hist
# 
# bacteroides_fragilis_unmasked_surface_cutoff = quantile(bacteroides_fragilis_unmasked_surface$likelihood, 0.80)
# 
# bacteroides_fragilis_unmasked_surface[bacteroides_fragilis_unmasked_surface$likelihood < bacteroides_fragilis_unmasked_surface_cutoff, ]$likelihood = bacteroides_fragilis_unmasked_surface_cutoff
# 
# bacteroides_fragilis_unmasked_surface_scatter = ggplot(data=bacteroides_fragilis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides fragilis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# bacteroides_fragilis_unmasked_surface_scatter
# 
# bacteroides_ovatus_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_ovatus_masked.csv', header=FALSE)
# names(bacteroides_ovatus_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_ovatus_masked_surface_expansion = bacteroides_ovatus_masked_surface[bacteroides_ovatus_masked_surface$nu > 1.0, ]
# bacteroides_ovatus_masked_surface_contraction = bacteroides_ovatus_masked_surface[bacteroides_ovatus_masked_surface$nu <= 1.0, ]
# 
# bacteroides_ovatus_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_ovatus_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_ovatus_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides ovatus histogram of likelihoods [singletons masked]')
# bacteroides_ovatus_masked_surface_hist
# 
# bacteroides_ovatus_masked_surface_cutoff = quantile(bacteroides_ovatus_masked_surface$likelihood, 0.80)
# 
# bacteroides_ovatus_masked_surface[bacteroides_ovatus_masked_surface$likelihood < bacteroides_ovatus_masked_surface_cutoff, ]$likelihood = bacteroides_ovatus_masked_surface_cutoff
# 
# bacteroides_ovatus_masked_surface_scatter = ggplot(data=bacteroides_ovatus_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides ovatus rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_ovatus_masked_surface_scatter
# 
# bacteroides_ovatus_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_ovatus_unmasked.csv', header=FALSE)
# names(bacteroides_ovatus_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_ovatus_unmasked_surface_expansion = bacteroides_ovatus_unmasked_surface[bacteroides_ovatus_unmasked_surface$nu > 1.0, ]
# bacteroides_ovatus_unmasked_surface_contraction = bacteroides_ovatus_unmasked_surface[bacteroides_ovatus_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_ovatus_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_ovatus_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_ovatus_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides ovatus histogram of likelihoods')
# bacteroides_ovatus_unmasked_surface_hist
# 
# bacteroides_ovatus_unmasked_surface_cutoff = quantile(bacteroides_ovatus_unmasked_surface$likelihood, 0.80)
# 
# bacteroides_ovatus_unmasked_surface[bacteroides_ovatus_unmasked_surface$likelihood < bacteroides_ovatus_unmasked_surface_cutoff, ]$likelihood = bacteroides_ovatus_unmasked_surface_cutoff
# 
# bacteroides_ovatus_unmasked_surface_scatter = ggplot(data=bacteroides_ovatus_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides ovatus rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')+
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# bacteroides_ovatus_unmasked_surface_scatter
# 
# bacteroides_stercoris_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_stercoris_masked.csv', header=FALSE)
# names(bacteroides_stercoris_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_stercoris_masked_surface_expansion = bacteroides_stercoris_masked_surface[bacteroides_stercoris_masked_surface$nu > 1.0, ]
# bacteroides_stercoris_masked_surface_contraction = bacteroides_stercoris_masked_surface[bacteroides_stercoris_masked_surface$nu <= 1.0, ]
# 
# bacteroides_stercoris_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_stercoris_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_stercoris_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides stercoris histogram of likelihoods [singletons masked]')
# bacteroides_stercoris_masked_surface_hist
# 
# bacteroides_stercoris_masked_surface_cutoff = quantile(bacteroides_stercoris_masked_surface$likelihood, 0.80)
# 
# bacteroides_stercoris_masked_surface[bacteroides_stercoris_masked_surface$likelihood < bacteroides_stercoris_masked_surface_cutoff, ]$likelihood = bacteroides_stercoris_masked_surface_cutoff
# 
# bacteroides_stercoris_masked_surface_scatter = ggplot(data=bacteroides_stercoris_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides stercoris rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_stercoris_masked_surface_scatter
# 
# bacteroides_stercoris_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_stercoris_unmasked.csv', header=FALSE)
# names(bacteroides_stercoris_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_stercoris_unmasked_surface_expansion = bacteroides_stercoris_unmasked_surface[bacteroides_stercoris_unmasked_surface$nu > 1.0, ]
# bacteroides_stercoris_unmasked_surface_contraction = bacteroides_stercoris_unmasked_surface[bacteroides_stercoris_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_stercoris_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_stercoris_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_stercoris_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides stercoris histogram of likelihoods')
# bacteroides_stercoris_unmasked_surface_hist
# 
# bacteroides_stercoris_unmasked_surface_cutoff = quantile(bacteroides_stercoris_unmasked_surface$likelihood, 0.80)
# 
# bacteroides_stercoris_unmasked_surface[bacteroides_stercoris_unmasked_surface$likelihood < bacteroides_stercoris_unmasked_surface_cutoff, ]$likelihood = bacteroides_stercoris_unmasked_surface_cutoff
# 
# bacteroides_stercoris_unmasked_surface_scatter = ggplot(data=bacteroides_stercoris_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides stercoris rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')  +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# bacteroides_stercoris_unmasked_surface_scatter
# 
# bacteroides_thetaiotaomicron_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_thetaiotaomicron_masked.csv', header=FALSE)
# names(bacteroides_thetaiotaomicron_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_thetaiotaomicron_masked_expansion = read.csv('gut_expansion_likelihood_surfaces/bacteroides_thetaiotaomicron_masked.csv', header=FALSE)
# names(bacteroides_thetaiotaomicron_masked_expansion) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_thetaiotaomicron_masked_surface = rbind(bacteroides_thetaiotaomicron_masked_surface,
#                                             bacteroides_thetaiotaomicron_masked_expansion)
# 
# bacteroides_thetaiotaomicron_masked_surface_expansion = bacteroides_thetaiotaomicron_masked_surface[bacteroides_thetaiotaomicron_masked_surface$nu > 1.0, ]
# bacteroides_thetaiotaomicron_masked_surface_contraction = bacteroides_thetaiotaomicron_masked_surface[bacteroides_thetaiotaomicron_masked_surface$nu <= 1.0, ]
# 
# bacteroides_thetaiotaomicron_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_thetaiotaomicron_masked_surface_expansion,  bins=200) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_thetaiotaomicron_masked_surface_contraction, bins=200) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides thetaiotaomicron histogram of likelihoods [singletons masked]')
# bacteroides_thetaiotaomicron_masked_surface_hist
# 
# bacteroides_thetaiotaomicron_masked_surface_cutoff = max(bacteroides_thetaiotaomicron_masked_surface$likelihood) - 10
# 
# bacteroides_thetaiotaomicron_masked_surface[bacteroides_thetaiotaomicron_masked_surface$likelihood < bacteroides_thetaiotaomicron_masked_surface_cutoff, ]$likelihood = bacteroides_thetaiotaomicron_masked_surface_cutoff
# 
# bacteroides_thetaiotaomicron_masked_surface_scatter = ggplot(data=bacteroides_thetaiotaomicron_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides thetaiotaomicron rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_thetaiotaomicron_masked_surface_scatter
# 
# bacteroides_thetaiotaomicron_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_thetaiotaomicron_unmasked.csv', header=FALSE)
# names(bacteroides_thetaiotaomicron_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_thetaiotaomicron_unmasked_expansion = read.csv('gut_expansion_likelihood_surfaces/bacteroides_thetaiotaomicron_unmasked.csv', header=FALSE)
# names(bacteroides_thetaiotaomicron_unmasked_expansion) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_thetaiotaomicron_unmasked_surface = rbind(bacteroides_thetaiotaomicron_unmasked_surface,
#                                               bacteroides_thetaiotaomicron_unmasked_expansion)
# 
# bacteroides_thetaiotaomicron_unmasked_surface_expansion = bacteroides_thetaiotaomicron_unmasked_surface[bacteroides_thetaiotaomicron_unmasked_surface$nu > 1.0, ]
# bacteroides_thetaiotaomicron_unmasked_surface_contraction = bacteroides_thetaiotaomicron_unmasked_surface[bacteroides_thetaiotaomicron_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_thetaiotaomicron_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_thetaiotaomicron_unmasked_surface_expansion,  bins=200) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_thetaiotaomicron_unmasked_surface_contraction, bins=200) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides thetaiotaomicron histogram of likelihoods [singletons unmasked]')
# bacteroides_thetaiotaomicron_unmasked_surface_hist
# 
# bacteroides_thetaiotaomicron_unmasked_surface_cutoff = max(bacteroides_thetaiotaomicron_unmasked_surface$likelihood) - 10
# 
# bacteroides_thetaiotaomicron_unmasked_surface[bacteroides_thetaiotaomicron_unmasked_surface$likelihood < bacteroides_thetaiotaomicron_unmasked_surface_cutoff, ]$likelihood = bacteroides_thetaiotaomicron_unmasked_surface_cutoff
# 
# bacteroides_thetaiotaomicron_unmasked_surface_scatter = ggplot(data=bacteroides_thetaiotaomicron_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides thetaiotaomicron rough likelihood surface [singletons unmasked]') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# bacteroides_thetaiotaomicron_unmasked_surface_scatter
# 
# bacteroides_uniformis_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_uniformis_masked.csv', header=FALSE)
# names(bacteroides_uniformis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_uniformis_masked_surface_expansion = bacteroides_uniformis_masked_surface[bacteroides_uniformis_masked_surface$nu > 1.0, ]
# bacteroides_uniformis_masked_surface_contraction = bacteroides_uniformis_masked_surface[bacteroides_uniformis_masked_surface$nu <= 1.0, ]
# 
# bacteroides_uniformis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_uniformis_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_uniformis_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides uniformis histogram of likelihoods [singletons masked]')
# bacteroides_uniformis_masked_surface_hist
# 
# bacteroides_uniformis_masked_surface_cutoff = quantile(bacteroides_uniformis_masked_surface$likelihood, 0.80)
# 
# bacteroides_uniformis_masked_surface[bacteroides_uniformis_masked_surface$likelihood < bacteroides_uniformis_masked_surface_cutoff, ]$likelihood = bacteroides_uniformis_masked_surface_cutoff
# 
# bacteroides_uniformis_masked_surface_scatter = ggplot(data=bacteroides_uniformis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides uniformis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_uniformis_masked_surface_scatter
# 
# bacteroides_uniformis_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_uniformis_unmasked.csv', header=FALSE)
# names(bacteroides_uniformis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_uniformis_unmasked_surface_expansion = bacteroides_uniformis_unmasked_surface[bacteroides_uniformis_unmasked_surface$nu > 1.0, ]
# bacteroides_uniformis_unmasked_surface_contraction = bacteroides_uniformis_unmasked_surface[bacteroides_uniformis_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_uniformis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_uniformis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_uniformis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides uniformis histogram of likelihoods')
# bacteroides_uniformis_unmasked_surface_hist
# 
# bacteroides_uniformis_unmasked_surface_cutoff = quantile(bacteroides_uniformis_unmasked_surface$likelihood, 0.80)
# 
# bacteroides_uniformis_unmasked_surface[bacteroides_uniformis_unmasked_surface$likelihood < bacteroides_uniformis_unmasked_surface_cutoff, ]$likelihood = bacteroides_uniformis_unmasked_surface_cutoff
# 
# bacteroides_uniformis_unmasked_surface_scatter = ggplot(data=bacteroides_uniformis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides uniformis rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')+
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# bacteroides_uniformis_unmasked_surface_scatter
# 
# bacteroides_vulgatus_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_vulgatus_masked.csv', header=FALSE)
# names(bacteroides_vulgatus_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_vulgatus_masked_surface_expansion = bacteroides_vulgatus_masked_surface[bacteroides_vulgatus_masked_surface$nu > 1.0, ]
# bacteroides_vulgatus_masked_surface_contraction = bacteroides_vulgatus_masked_surface[bacteroides_vulgatus_masked_surface$nu <= 1.0, ]
# 
# bacteroides_vulgatus_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_vulgatus_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_vulgatus_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides vulgatus histogram of likelihoods [singletons masked]')
# bacteroides_vulgatus_masked_surface_hist
# 
# bacteroides_vulgatus_masked_surface_cutoff = quantile(bacteroides_vulgatus_masked_surface$likelihood, 0.80)
# 
# bacteroides_vulgatus_masked_surface[bacteroides_vulgatus_masked_surface$likelihood < bacteroides_vulgatus_masked_surface_cutoff, ]$likelihood = bacteroides_vulgatus_masked_surface_cutoff
# 
# bacteroides_vulgatus_masked_surface_scatter = ggplot(data=bacteroides_vulgatus_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides vulgatus rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_vulgatus_masked_surface_scatter
# 
# bacteroides_vulgatus_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_vulgatus_unmasked.csv', header=FALSE)
# names(bacteroides_vulgatus_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_vulgatus_unmasked_surface_expansion = bacteroides_vulgatus_unmasked_surface[bacteroides_vulgatus_unmasked_surface$nu > 1.0, ]
# bacteroides_vulgatus_unmasked_surface_contraction = bacteroides_vulgatus_unmasked_surface[bacteroides_vulgatus_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_vulgatus_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_vulgatus_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_vulgatus_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides vulgatus histogram of likelihoods')
# bacteroides_vulgatus_unmasked_surface_hist
# 
# bacteroides_vulgatus_unmasked_surface_cutoff = quantile(bacteroides_vulgatus_unmasked_surface$likelihood, 0.80)
# 
# bacteroides_vulgatus_unmasked_surface[bacteroides_vulgatus_unmasked_surface$likelihood < bacteroides_vulgatus_unmasked_surface_cutoff, ]$likelihood = bacteroides_vulgatus_unmasked_surface_cutoff
# 
# bacteroides_vulgatus_unmasked_surface_scatter = ggplot(data=bacteroides_vulgatus_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides vulgatus rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_vulgatus_unmasked_surface_scatter
# 
# bacteroides_xylanisolvens_masked_surface = read.csv('gut_likelihood_surfaces/bacteroides_xylanisolvens_masked.csv', header=FALSE)
# names(bacteroides_xylanisolvens_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_xylanisolvens_masked_surface_expansion = bacteroides_xylanisolvens_masked_surface[bacteroides_xylanisolvens_masked_surface$nu > 1.0, ]
# bacteroides_xylanisolvens_masked_surface_contraction = bacteroides_xylanisolvens_masked_surface[bacteroides_xylanisolvens_masked_surface$nu <= 1.0, ]
# 
# bacteroides_xylanisolvens_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_xylanisolvens_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_xylanisolvens_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides xylanisolvens histogram of likelihoods [singletons masked]')
# bacteroides_xylanisolvens_masked_surface_hist
# 
# bacteroides_xylanisolvens_masked_surface_cutoff = quantile(bacteroides_xylanisolvens_masked_surface$likelihood, 0.80)
# 
# bacteroides_xylanisolvens_masked_surface[bacteroides_xylanisolvens_masked_surface$likelihood < bacteroides_xylanisolvens_masked_surface_cutoff, ]$likelihood = bacteroides_xylanisolvens_masked_surface_cutoff
# 
# bacteroides_xylanisolvens_masked_surface_scatter = ggplot(data=bacteroides_xylanisolvens_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides xylanisolvens rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_xylanisolvens_masked_surface_scatter
# 
# bacteroides_xylanisolvens_unmasked_surface = read.csv('gut_likelihood_surfaces/bacteroides_xylanisolvens_unmasked.csv', header=FALSE)
# names(bacteroides_xylanisolvens_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# bacteroides_xylanisolvens_unmasked_surface_expansion = bacteroides_xylanisolvens_unmasked_surface[bacteroides_xylanisolvens_unmasked_surface$nu > 1.0, ]
# bacteroides_xylanisolvens_unmasked_surface_contraction = bacteroides_xylanisolvens_unmasked_surface[bacteroides_xylanisolvens_unmasked_surface$nu <= 1.0, ]
# 
# bacteroides_xylanisolvens_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = bacteroides_xylanisolvens_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = bacteroides_xylanisolvens_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Bacteroides xylanisolvens histogram of likelihoods')
# bacteroides_xylanisolvens_unmasked_surface_hist
# 
# bacteroides_xylanisolvens_unmasked_surface_cutoff = quantile(bacteroides_xylanisolvens_unmasked_surface$likelihood, 0.80)
# 
# bacteroides_xylanisolvens_unmasked_surface[bacteroides_xylanisolvens_unmasked_surface$likelihood < bacteroides_xylanisolvens_unmasked_surface_cutoff, ]$likelihood = bacteroides_xylanisolvens_unmasked_surface_cutoff
# 
# bacteroides_xylanisolvens_unmasked_surface_scatter = ggplot(data=bacteroides_xylanisolvens_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Bacteroides xylanisolvens rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# bacteroides_xylanisolvens_unmasked_surface_scatter
# 
# barnesiella_intestinihominis_masked_surface = read.csv('gut_likelihood_surfaces/barnesiella_intestinihominis_masked.csv', header=FALSE)
# names(barnesiella_intestinihominis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# barnesiella_intestinihominis_masked_expansion = read.csv('gut_expansion_likelihood_surfaces/barnesiella_intestinihominis_masked.csv', header=FALSE)
# names(barnesiella_intestinihominis_masked_expansion) = c('likelihood', 'nu', 'tau')
# 
# barnesiella_intestinihominis_masked_surface = rbind(barnesiella_intestinihominis_masked_surface,
#                                             barnesiella_intestinihominis_masked_expansion)
# 
# barnesiella_intestinihominis_masked_surface_expansion = barnesiella_intestinihominis_masked_surface[barnesiella_intestinihominis_masked_surface$nu > 1.0, ]
# barnesiella_intestinihominis_masked_surface_contraction = barnesiella_intestinihominis_masked_surface[barnesiella_intestinihominis_masked_surface$nu <= 1.0, ]
# 
# barnesiella_intestinihominis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = barnesiella_intestinihominis_masked_surface_expansion,  bins=200) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = barnesiella_intestinihominis_masked_surface_contraction, bins=200) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Barnesiella intestinihominis histogram of likelihoods [singletons masked]')
# barnesiella_intestinihominis_masked_surface_hist
# 
# barnesiella_intestinihominis_masked_surface_cutoff = max(barnesiella_intestinihominis_masked_surface$likelihood) - 10
# 
# barnesiella_intestinihominis_masked_surface[barnesiella_intestinihominis_masked_surface$likelihood < barnesiella_intestinihominis_masked_surface_cutoff, ]$likelihood = barnesiella_intestinihominis_masked_surface_cutoff
# 
# barnesiella_intestinihominis_masked_surface_scatter = ggplot(data=barnesiella_intestinihominis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Barnesiella intestinihominis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# barnesiella_intestinihominis_masked_surface_scatter
# 
# barnesiella_intestinihominis_unmasked_surface = read.csv('gut_likelihood_surfaces/barnesiella_intestinihominis_unmasked.csv', header=FALSE)
# names(barnesiella_intestinihominis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# barnesiella_intestinihominis_unmasked_surface
# 
# 
# b_intestinihominis_lik = rep(-88.0518,500)
# b_intestinihominis_nu = rgamma(500, shape=1, scale=1)
# b_intestinihominis_tau = rgamma(500, shape=1, scale=1)
# 
# b_intestinihominis_df= cbind(b_intestinihominis_lik,
#                              b_intestinihominis_nu,
#                              b_intestinihominis_tau)
# 
# colnames(b_intestinihominis_df) = c('likelihood', 'nu', 'tau')
# barnesiella_intestinihominis_unmasked_surface =   rbind(barnesiella_intestinihominis_unmasked_surface,
#                                                         b_intestinihominis_df)
# 
# barnesiella_intestinihominis_unmasked_expansion = read.csv('gut_expansion_likelihood_surfaces/barnesiella_intestinihominis_unmasked.csv', header=FALSE)
# names(barnesiella_intestinihominis_unmasked_expansion) = c('likelihood', 'nu', 'tau')
# 
# barnesiella_intestinihominis_unmasked_surface = rbind(barnesiella_intestinihominis_unmasked_surface,
#                                               barnesiella_intestinihominis_unmasked_expansion)
# 
# barnesiella_intestinihominis_unmasked_surface_expansion = barnesiella_intestinihominis_unmasked_surface[barnesiella_intestinihominis_unmasked_surface$nu > 1.0, ]
# barnesiella_intestinihominis_unmasked_surface_contraction = barnesiella_intestinihominis_unmasked_surface[barnesiella_intestinihominis_unmasked_surface$nu <= 1.0, ]
# 
# barnesiella_intestinihominis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = barnesiella_intestinihominis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = barnesiella_intestinihominis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Barnesiella intestinihominis histogram of likelihoods [singletons unmasked]')
# barnesiella_intestinihominis_unmasked_surface_hist
# 
# barnesiella_intestinihominis_unmasked_surface_cutoff = max(barnesiella_intestinihominis_unmasked_surface$likelihood) - 20
# 
# barnesiella_intestinihominis_unmasked_surface[barnesiella_intestinihominis_unmasked_surface$likelihood < barnesiella_intestinihominis_unmasked_surface_cutoff, ]$likelihood = barnesiella_intestinihominis_unmasked_surface_cutoff
# 
# barnesiella_intestinihominis_unmasked_surface_scatter = ggplot(data=barnesiella_intestinihominis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Barnesiella intestinihominis Likelihood Surface') +
#   geom_vline(xintercept=1.0, color='red') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   xlab('Ratio of current to ancestral popultion size')  +
#   ylab('Time parameter in generations scaled by 2 * Ancestral Population Size')
# barnesiella_intestinihominis_unmasked_surface_scatter
# 
# dialister_invisus_masked_surface = read.csv('gut_likelihood_surfaces/dialister_invisus_masked.csv', header=FALSE)
# names(dialister_invisus_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# dialister_invisus_masked_surface_expansion = dialister_invisus_masked_surface[dialister_invisus_masked_surface$nu > 1.0, ]
# dialister_invisus_masked_surface_contraction = dialister_invisus_masked_surface[dialister_invisus_masked_surface$nu <= 1.0, ]
# 
# dialister_invisus_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = dialister_invisus_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = dialister_invisus_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Dialister invisus histogram of likelihoods [singletons masked]')
# dialister_invisus_masked_surface_hist
# 
# dialister_invisus_masked_surface_cutoff = quantile(dialister_invisus_masked_surface$likelihood, 0.80)
# 
# dialister_invisus_masked_surface[dialister_invisus_masked_surface$likelihood < dialister_invisus_masked_surface_cutoff, ]$likelihood = dialister_invisus_masked_surface_cutoff
# 
# dialister_invisus_masked_surface_scatter = ggplot(data=dialister_invisus_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Dialister invisus rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# dialister_invisus_masked_surface_scatter
# 
# dialister_invisus_unmasked_surface = read.csv('gut_likelihood_surfaces/dialister_invisus_unmasked.csv', header=FALSE)
# names(dialister_invisus_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# dialister_invisus_unmasked_surface_expansion = dialister_invisus_unmasked_surface[dialister_invisus_unmasked_surface$nu > 1.0, ]
# dialister_invisus_unmasked_surface_contraction = dialister_invisus_unmasked_surface[dialister_invisus_unmasked_surface$nu <= 1.0, ]
# 
# dialister_invisus_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = dialister_invisus_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = dialister_invisus_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Dialister invisus histogram of likelihoods')
# dialister_invisus_unmasked_surface_hist
# 
# dialister_invisus_unmasked_surface_cutoff = quantile(dialister_invisus_unmasked_surface$likelihood, 0.80)
# 
# dialister_invisus_unmasked_surface[dialister_invisus_unmasked_surface$likelihood < dialister_invisus_unmasked_surface_cutoff, ]$likelihood = dialister_invisus_unmasked_surface_cutoff
# 
# dialister_invisus_unmasked_surface_scatter = ggplot(data=dialister_invisus_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Dialister invisus rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# dialister_invisus_unmasked_surface_scatter
# 
# eubacterium_eligens_masked_surface = read.csv('gut_likelihood_surfaces/eubacterium_eligens_masked.csv', header=FALSE)
# names(eubacterium_eligens_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# eubacterium_eligens_masked_surface_expansion = eubacterium_eligens_masked_surface[eubacterium_eligens_masked_surface$nu > 1.0, ]
# eubacterium_eligens_masked_surface_contraction = eubacterium_eligens_masked_surface[eubacterium_eligens_masked_surface$nu <= 1.0, ]
# 
# eubacterium_eligens_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = eubacterium_eligens_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = eubacterium_eligens_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Eubacterium eligens histogram of likelihoods [singletons masked]')
# eubacterium_eligens_masked_surface_hist
# 
# eubacterium_eligens_masked_surface_cutoff = quantile(eubacterium_eligens_masked_surface$likelihood, 0.80)
# 
# eubacterium_eligens_masked_surface[eubacterium_eligens_masked_surface$likelihood < eubacterium_eligens_masked_surface_cutoff, ]$likelihood = eubacterium_eligens_masked_surface_cutoff
# 
# eubacterium_eligens_masked_surface_scatter = ggplot(data=eubacterium_eligens_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Eubacterium eligens rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# eubacterium_eligens_masked_surface_scatter
# 
# eubacterium_eligens_unmasked_surface = read.csv('gut_likelihood_surfaces/eubacterium_eligens_unmasked.csv', header=FALSE)
# names(eubacterium_eligens_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# eubacterium_eligens_unmasked_surface_expansion = eubacterium_eligens_unmasked_surface[eubacterium_eligens_unmasked_surface$nu > 1.0, ]
# eubacterium_eligens_unmasked_surface_contraction = eubacterium_eligens_unmasked_surface[eubacterium_eligens_unmasked_surface$nu <= 1.0, ]
# 
# eubacterium_eligens_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = eubacterium_eligens_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = eubacterium_eligens_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Eubacterium eligens histogram of likelihoods')
# eubacterium_eligens_unmasked_surface_hist
# 
# eubacterium_eligens_unmasked_surface_cutoff = quantile(eubacterium_eligens_unmasked_surface$likelihood, 0.80)
# 
# eubacterium_eligens_unmasked_surface[eubacterium_eligens_unmasked_surface$likelihood < eubacterium_eligens_unmasked_surface_cutoff, ]$likelihood = eubacterium_eligens_unmasked_surface_cutoff
# 
# eubacterium_eligens_unmasked_surface_scatter = ggplot(data=eubacterium_eligens_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Eubacterium eligens rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# eubacterium_eligens_unmasked_surface_scatter
# 
# eubacterium_rectales_masked_surface = read.csv('gut_likelihood_surfaces/eubacterium_rectales_masked.csv', header=FALSE)
# names(eubacterium_rectales_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# eubacterium_rectales_masked_surface_expansion = eubacterium_rectales_masked_surface[eubacterium_rectales_masked_surface$nu > 1.0, ]
# eubacterium_rectales_masked_surface_contraction = eubacterium_rectales_masked_surface[eubacterium_rectales_masked_surface$nu <= 1.0, ]
# 
# eubacterium_rectales_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = eubacterium_rectales_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = eubacterium_rectales_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Eubacterium rectales histogram of likelihoods [singletons masked]')
# eubacterium_rectales_masked_surface_hist
# 
# eubacterium_rectales_masked_surface_cutoff = quantile(eubacterium_rectales_masked_surface$likelihood, 0.80)
# 
# eubacterium_rectales_masked_surface[eubacterium_rectales_masked_surface$likelihood < eubacterium_rectales_masked_surface_cutoff, ]$likelihood = eubacterium_rectales_masked_surface_cutoff
# 
# eubacterium_rectales_masked_surface_scatter = ggplot(data=eubacterium_rectales_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Eubacterium rectales rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# eubacterium_rectales_masked_surface_scatter
# 
# eubacterium_rectales_unmasked_surface = read.csv('gut_likelihood_surfaces/eubacterium_rectales_unmasked.csv', header=FALSE)
# names(eubacterium_rectales_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# eubacterium_rectales_unmasked_surface_expansion = eubacterium_rectales_unmasked_surface[eubacterium_rectales_unmasked_surface$nu > 1.0, ]
# eubacterium_rectales_unmasked_surface_contraction = eubacterium_rectales_unmasked_surface[eubacterium_rectales_unmasked_surface$nu <= 1.0, ]
# 
# eubacterium_rectales_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = eubacterium_rectales_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = eubacterium_rectales_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Eubacterium rectales histogram of likelihoods')
# eubacterium_rectales_unmasked_surface_hist
# 
# eubacterium_rectales_unmasked_surface_cutoff = quantile(eubacterium_rectales_unmasked_surface$likelihood, 0.80)
# 
# eubacterium_rectales_unmasked_surface[eubacterium_rectales_unmasked_surface$likelihood < eubacterium_rectales_unmasked_surface_cutoff, ]$likelihood = eubacterium_rectales_unmasked_surface_cutoff
# 
# eubacterium_rectales_unmasked_surface_scatter = ggplot(data=eubacterium_rectales_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Eubacterium rectales rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# eubacterium_rectales_unmasked_surface_scatter
# 
# faecalibacterium_prausnitzii_masked_surface = read.csv('gut_likelihood_surfaces/faecalibacterium_prausnitzii_masked.csv', header=FALSE)
# names(faecalibacterium_prausnitzii_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# faecalibacterium_prausnitzii_masked_surface_expansion = faecalibacterium_prausnitzii_masked_surface[faecalibacterium_prausnitzii_masked_surface$nu > 1.0, ]
# faecalibacterium_prausnitzii_masked_surface_contraction = faecalibacterium_prausnitzii_masked_surface[faecalibacterium_prausnitzii_masked_surface$nu <= 1.0, ]
# 
# faecalibacterium_prausnitzii_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = faecalibacterium_prausnitzii_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = faecalibacterium_prausnitzii_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Faecalibacter prausnitzii histogram of likelihoods [singletons masked]')
# faecalibacterium_prausnitzii_masked_surface_hist
# 
# faecalibacterium_prausnitzii_masked_surface_cutoff = quantile(faecalibacterium_prausnitzii_masked_surface$likelihood, 0.80)
# 
# faecalibacterium_prausnitzii_masked_surface[faecalibacterium_prausnitzii_masked_surface$likelihood < faecalibacterium_prausnitzii_masked_surface_cutoff, ]$likelihood = faecalibacterium_prausnitzii_masked_surface_cutoff
# 
# faecalibacterium_prausnitzii_masked_surface_scatter = ggplot(data=faecalibacterium_prausnitzii_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Faecalibacter prausnitzii rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# faecalibacterium_prausnitzii_masked_surface_scatter
# 
# faecalibacterium_prausnitzii_unmasked_surface = read.csv('gut_likelihood_surfaces/faecalibacterium_prausnitzii_unmasked.csv', header=FALSE)
# names(faecalibacterium_prausnitzii_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# faecalibacterium_prausnitzii_unmasked_surface_expansion = faecalibacterium_prausnitzii_unmasked_surface[faecalibacterium_prausnitzii_unmasked_surface$nu > 1.0, ]
# faecalibacterium_prausnitzii_unmasked_surface_contraction = faecalibacterium_prausnitzii_unmasked_surface[faecalibacterium_prausnitzii_unmasked_surface$nu <= 1.0, ]
# 
# faecalibacterium_prausnitzii_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = faecalibacterium_prausnitzii_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = faecalibacterium_prausnitzii_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Faecalibacter prausnitzii histogram of likelihoods')
# faecalibacterium_prausnitzii_unmasked_surface_hist
# 
# faecalibacterium_prausnitzii_unmasked_surface_cutoff = quantile(faecalibacterium_prausnitzii_unmasked_surface$likelihood, 0.80)
# 
# faecalibacterium_prausnitzii_unmasked_surface[faecalibacterium_prausnitzii_unmasked_surface$likelihood < faecalibacterium_prausnitzii_unmasked_surface_cutoff, ]$likelihood = faecalibacterium_prausnitzii_unmasked_surface_cutoff
# 
# faecalibacterium_prausnitzii_unmasked_surface_scatter = ggplot(data=faecalibacterium_prausnitzii_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Faecalibacter prausnitzii rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# faecalibacterium_prausnitzii_unmasked_surface_scatter
# 
# odoribacter_splanchnicus_masked_surface = read.csv('gut_likelihood_surfaces/odoribacter_splanchnicus_masked.csv', header=FALSE)
# names(odoribacter_splanchnicus_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# odoribacter_splanchnicus_masked_surface_expansion = odoribacter_splanchnicus_masked_surface[odoribacter_splanchnicus_masked_surface$nu > 1.0, ]
# odoribacter_splanchnicus_masked_surface_contraction = odoribacter_splanchnicus_masked_surface[odoribacter_splanchnicus_masked_surface$nu <= 1.0, ]
# 
# odoribacter_splanchnicus_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = odoribacter_splanchnicus_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = odoribacter_splanchnicus_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Odoribacter splanchnicus histogram of likelihoods [singletons masked]')
# odoribacter_splanchnicus_masked_surface_hist
# 
# odoribacter_splanchnicus_masked_surface_cutoff = quantile(odoribacter_splanchnicus_masked_surface$likelihood, 0.80)
# 
# odoribacter_splanchnicus_masked_surface[odoribacter_splanchnicus_masked_surface$likelihood < odoribacter_splanchnicus_masked_surface_cutoff, ]$likelihood = odoribacter_splanchnicus_masked_surface_cutoff
# 
# odoribacter_splanchnicus_masked_surface_scatter = ggplot(data=odoribacter_splanchnicus_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Odoribacter splanchnicus rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# odoribacter_splanchnicus_masked_surface_scatter
# 
# odoribacter_splanchnicus_unmasked_surface = read.csv('gut_likelihood_surfaces/odoribacter_splanchnicus_unmasked.csv', header=FALSE)
# names(odoribacter_splanchnicus_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# odoribacter_splanchnicus_unmasked_surface_expansion = odoribacter_splanchnicus_unmasked_surface[odoribacter_splanchnicus_unmasked_surface$nu > 1.0, ]
# odoribacter_splanchnicus_unmasked_surface_contraction = odoribacter_splanchnicus_unmasked_surface[odoribacter_splanchnicus_unmasked_surface$nu <= 1.0, ]
# 
# odoribacter_splanchnicus_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = odoribacter_splanchnicus_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = odoribacter_splanchnicus_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Odoribacter splanchnicus histogram of likelihoods')
# odoribacter_splanchnicus_unmasked_surface_hist
# 
# odoribacter_splanchnicus_unmasked_surface_cutoff = quantile(odoribacter_splanchnicus_unmasked_surface$likelihood, 0.80)
# 
# odoribacter_splanchnicus_unmasked_surface[odoribacter_splanchnicus_unmasked_surface$likelihood < odoribacter_splanchnicus_unmasked_surface_cutoff, ]$likelihood = odoribacter_splanchnicus_unmasked_surface_cutoff
# 
# odoribacter_splanchnicus_unmasked_surface_scatter = ggplot(data=odoribacter_splanchnicus_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Odoribacter splanchnicus rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# odoribacter_splanchnicus_unmasked_surface_scatter
# 
# oscillibacter_sp_masked_surface = read.csv('gut_likelihood_surfaces/oscillibacter_sp_masked.csv', header=FALSE)
# names(oscillibacter_sp_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# oscillibacter_sp_masked_surface_expansion = oscillibacter_sp_masked_surface[oscillibacter_sp_masked_surface$nu > 1.0, ]
# oscillibacter_sp_masked_surface_contraction = oscillibacter_sp_masked_surface[oscillibacter_sp_masked_surface$nu <= 1.0, ]
# 
# oscillibacter_sp_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = oscillibacter_sp_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = oscillibacter_sp_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Oscillibacter sp. histogram of likelihoods [singletons masked]')
# oscillibacter_sp_masked_surface_hist
# 
# oscillibacter_sp_masked_surface_cutoff = quantile(oscillibacter_sp_masked_surface$likelihood, 0.80)
# 
# oscillibacter_sp_masked_surface[oscillibacter_sp_masked_surface$likelihood < oscillibacter_sp_masked_surface_cutoff, ]$likelihood = oscillibacter_sp_masked_surface_cutoff
# 
# oscillibacter_sp_masked_surface_scatter = ggplot(data=oscillibacter_sp_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Oscillibacter sp. rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# oscillibacter_sp_masked_surface_scatter
# 
# oscillibacter_sp_unmasked_surface = read.csv('gut_likelihood_surfaces/oscillibacter_sp_unmasked.csv', header=FALSE)
# names(oscillibacter_sp_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# oscillibacter_sp_unmasked_surface_expansion = oscillibacter_sp_unmasked_surface[oscillibacter_sp_unmasked_surface$nu > 1.0, ]
# oscillibacter_sp_unmasked_surface_contraction = oscillibacter_sp_unmasked_surface[oscillibacter_sp_unmasked_surface$nu <= 1.0, ]
# 
# oscillibacter_sp_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = oscillibacter_sp_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = oscillibacter_sp_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Oscillibacter sp. histogram of likelihoods')
# oscillibacter_sp_unmasked_surface_hist
# 
# oscillibacter_sp_unmasked_surface_cutoff = quantile(oscillibacter_sp_unmasked_surface$likelihood, 0.80)
# 
# oscillibacter_sp_unmasked_surface[oscillibacter_sp_unmasked_surface$likelihood < oscillibacter_sp_unmasked_surface_cutoff, ]$likelihood = oscillibacter_sp_unmasked_surface_cutoff
# 
# oscillibacter_sp_unmasked_surface_scatter = ggplot(data=oscillibacter_sp_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Oscillibacter sp. rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# oscillibacter_sp_unmasked_surface_scatter
# 
# parabacteroides_distasonis_masked_surface = read.csv('gut_likelihood_surfaces/parabacteroides_distasonis_masked.csv', header=FALSE)
# names(parabacteroides_distasonis_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# parabacteroides_distasonis_masked_expansion = read.csv('gut_expansion_likelihood_surfaces/parabacteroides_distasonis_masked.csv', header=FALSE)
# names(parabacteroides_distasonis_masked_expansion) = c('likelihood', 'nu', 'tau')
# 
# parabacteroides_distasonis_masked_surface = rbind(parabacteroides_distasonis_masked_surface,
#                                             parabacteroides_distasonis_masked_expansion)
# 
# parabacteroides_distasonis_masked_surface_expansion = parabacteroides_distasonis_masked_surface[parabacteroides_distasonis_masked_surface$nu > 1.0, ]
# parabacteroides_distasonis_masked_surface_contraction = parabacteroides_distasonis_masked_surface[parabacteroides_distasonis_masked_surface$nu <= 1.0, ]
# 
# parabacteroides_distasonis_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = parabacteroides_distasonis_masked_surface_expansion,  bins=200) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = parabacteroides_distasonis_masked_surface_contraction, bins=200) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Parabacteroides distasonis histogram of likelihoods [singletons masked]')
# parabacteroides_distasonis_masked_surface_hist
# 
# parabacteroides_distasonis_masked_surface_cutoff = max(parabacteroides_distasonis_masked_surface$likelihood) - 10
# 
# parabacteroides_distasonis_masked_surface[parabacteroides_distasonis_masked_surface$likelihood < parabacteroides_distasonis_masked_surface_cutoff, ]$likelihood = parabacteroides_distasonis_masked_surface_cutoff
# 
# parabacteroides_distasonis_masked_surface_scatter = ggplot(data=parabacteroides_distasonis_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Parabacteroides distasonis rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# parabacteroides_distasonis_masked_surface_scatter
# 
# parabacteroides_distasonis_unmasked_surface = read.csv('gut_likelihood_surfaces/parabacteroides_distasonis_unmasked.csv', header=FALSE)
# names(parabacteroides_distasonis_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# parabacteroides_distasonis_unmasked_expansion = read.csv('gut_expansion_likelihood_surfaces/parabacteroides_distasonis_unmasked.csv', header=FALSE)
# names(parabacteroides_distasonis_unmasked_expansion) = c('likelihood', 'nu', 'tau')
# 
# parabacteroides_distasonis_unmasked_surface = rbind(parabacteroides_distasonis_unmasked_surface,
#                                               parabacteroides_distasonis_unmasked_expansion)
# 
# parabacteroides_distasonis_unmasked_surface_expansion = parabacteroides_distasonis_unmasked_surface[parabacteroides_distasonis_unmasked_surface$nu > 1.0, ]
# parabacteroides_distasonis_unmasked_surface_contraction = parabacteroides_distasonis_unmasked_surface[parabacteroides_distasonis_unmasked_surface$nu <= 1.0, ]
# 
# parabacteroides_distasonis_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = parabacteroides_distasonis_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = parabacteroides_distasonis_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Parabacteroides distasonis histogram of likelihoods [singletons unmasked]')
# parabacteroides_distasonis_unmasked_surface_hist
# 
# parabacteroides_distasonis_unmasked_surface_cutoff = max(parabacteroides_distasonis_unmasked_surface$likelihood) - 10
# 
# parabacteroides_distasonis_unmasked_surface[parabacteroides_distasonis_unmasked_surface$likelihood < parabacteroides_distasonis_unmasked_surface_cutoff, ]$likelihood = parabacteroides_distasonis_unmasked_surface_cutoff
# 
# parabacteroides_distasonis_unmasked_surface_scatter = ggplot(data=parabacteroides_distasonis_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Parabacteroides distasonis rough likelihood surface [singletons unmasked]') +
#   geom_vline(xintercept=1.0, color='red')
# parabacteroides_distasonis_unmasked_surface_scatter
# 
# parabacteroides_merdae_masked_surface = read.csv('gut_likelihood_surfaces/parabacteroides_merdae_masked.csv', header=FALSE)
# names(parabacteroides_merdae_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# parabacteroides_merdae_masked_expansion = read.csv('gut_expansion_likelihood_surfaces/parabacteroides_merdae_masked.csv', header=FALSE)
# names(parabacteroides_merdae_masked_expansion) = c('likelihood', 'nu', 'tau')
# 
# parabacteroides_merdae_masked_surface = rbind(parabacteroides_merdae_masked_surface,
#                                             parabacteroides_merdae_masked_expansion)
# 
# parabacteroides_merdae_masked_surface_expansion = parabacteroides_merdae_masked_surface[parabacteroides_merdae_masked_surface$nu > 1.0, ]
# parabacteroides_merdae_masked_surface_contraction = parabacteroides_merdae_masked_surface[parabacteroides_merdae_masked_surface$nu <= 1.0, ]
# 
# parabacteroides_merdae_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = parabacteroides_merdae_masked_surface_expansion,  bins=200) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = parabacteroides_merdae_masked_surface_contraction, bins=200) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Parabacteroides merdae histogram of likelihoods [singletons masked]')
# parabacteroides_merdae_masked_surface_hist
# 
# parabacteroides_merdae_masked_surface_cutoff = max(parabacteroides_merdae_masked_surface$likelihood) - 5
# 
# parabacteroides_merdae_masked_surface[parabacteroides_merdae_masked_surface$likelihood < parabacteroides_merdae_masked_surface_cutoff, ]$likelihood = parabacteroides_merdae_masked_surface_cutoff
# 
# parabacteroides_merdae_masked_surface_scatter = ggplot(data=parabacteroides_merdae_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Parabacteroides merdae rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# parabacteroides_merdae_masked_surface_scatter
# 
# parabacteroides_merdae_unmasked_surface = read.csv('gut_likelihood_surfaces/parabacteroides_merdae_unmasked.csv', header=FALSE)
# names(parabacteroides_merdae_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# parabacteroides_merdae_unmasked_expansion = read.csv('gut_expansion_likelihood_surfaces/parabacteroides_merdae_unmasked.csv', header=FALSE)
# names(parabacteroides_merdae_unmasked_expansion) = c('likelihood', 'nu', 'tau')
# 
# parabacteroides_merdae_unmasked_surface = rbind(parabacteroides_merdae_unmasked_surface,
#                                               parabacteroides_merdae_unmasked_expansion)
# 
# parabacteroides_merdae_unmasked_surface_expansion = parabacteroides_merdae_unmasked_surface[parabacteroides_merdae_unmasked_surface$nu > 1.0, ]
# parabacteroides_merdae_unmasked_surface_contraction = parabacteroides_merdae_unmasked_surface[parabacteroides_merdae_unmasked_surface$nu <= 1.0, ]
# 
# parabacteroides_merdae_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = parabacteroides_merdae_unmasked_surface_expansion,  bins=200) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = parabacteroides_merdae_unmasked_surface_contraction, bins=200) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Parabacteroides merdae histogram of likelihoods [singletons unmasked]')
# parabacteroides_merdae_unmasked_surface_hist
# 
# parabacteroides_merdae_unmasked_surface_cutoff = max(parabacteroides_merdae_unmasked_surface$likelihood) - 10
# 
# parabacteroides_merdae_unmasked_surface[parabacteroides_merdae_unmasked_surface$likelihood < parabacteroides_merdae_unmasked_surface_cutoff, ]$likelihood = parabacteroides_merdae_unmasked_surface_cutoff
# 
# parabacteroides_merdae_unmasked_surface_scatter = ggplot(data=parabacteroides_merdae_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Parabacteroides merdae rough likelihood surface [singletons unmasked]') +
#   geom_vline(xintercept=1.0, color='red')
# parabacteroides_merdae_unmasked_surface_scatter
# 
# ruminococcus_bicirculans_masked_surface = read.csv('gut_likelihood_surfaces/ruminococcus_bicirculans_masked.csv', header=FALSE)
# names(ruminococcus_bicirculans_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# ruminococcus_bicirculans_masked_surface_expansion = ruminococcus_bicirculans_masked_surface[ruminococcus_bicirculans_masked_surface$nu > 1.0, ]
# ruminococcus_bicirculans_masked_surface_contraction = ruminococcus_bicirculans_masked_surface[ruminococcus_bicirculans_masked_surface$nu <= 1.0, ]
# 
# ruminococcus_bicirculans_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = ruminococcus_bicirculans_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = ruminococcus_bicirculans_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Ruminococcus bicirculans histogram of likelihoods [singletons masked]')
# ruminococcus_bicirculans_masked_surface_hist
# 
# ruminococcus_bicirculans_masked_surface_cutoff = quantile(ruminococcus_bicirculans_masked_surface$likelihood, 0.80)
# 
# ruminococcus_bicirculans_masked_surface[ruminococcus_bicirculans_masked_surface$likelihood < ruminococcus_bicirculans_masked_surface_cutoff, ]$likelihood = ruminococcus_bicirculans_masked_surface_cutoff
# 
# ruminococcus_bicirculans_masked_surface_scatter = ggplot(data=ruminococcus_bicirculans_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Ruminococcus bicirculans rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# ruminococcus_bicirculans_masked_surface_scatter
# 
# ruminococcus_bicirculans_unmasked_surface = read.csv('gut_likelihood_surfaces/ruminococcus_bicirculans_unmasked.csv', header=FALSE)
# names(ruminococcus_bicirculans_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# ruminococcus_bicirculans_unmasked_surface_expansion = ruminococcus_bicirculans_unmasked_surface[ruminococcus_bicirculans_unmasked_surface$nu > 1.0, ]
# ruminococcus_bicirculans_unmasked_surface_contraction = ruminococcus_bicirculans_unmasked_surface[ruminococcus_bicirculans_unmasked_surface$nu <= 1.0, ]
# 
# ruminococcus_bicirculans_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = ruminococcus_bicirculans_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = ruminococcus_bicirculans_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Ruminococcus bicirculans histogram of likelihoods')
# ruminococcus_bicirculans_unmasked_surface_hist
# 
# ruminococcus_bicirculans_unmasked_surface_cutoff = quantile(ruminococcus_bicirculans_unmasked_surface$likelihood, 0.80)
# 
# ruminococcus_bicirculans_unmasked_surface[ruminococcus_bicirculans_unmasked_surface$likelihood < ruminococcus_bicirculans_unmasked_surface_cutoff, ]$likelihood = ruminococcus_bicirculans_unmasked_surface_cutoff
# 
# ruminococcus_bicirculans_unmasked_surface_scatter = ggplot(data=ruminococcus_bicirculans_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Ruminococcus bicirculans rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# ruminococcus_bicirculans_unmasked_surface_scatter
# 
# ruminococcus_bromii_masked_surface = read.csv('gut_likelihood_surfaces/ruminococcus_bromii_masked.csv', header=FALSE)
# names(ruminococcus_bromii_masked_surface) = c('likelihood', 'nu', 'tau')
# 
# ruminococcus_bromii_masked_surface_expansion = ruminococcus_bromii_masked_surface[ruminococcus_bromii_masked_surface$nu > 1.0, ]
# ruminococcus_bromii_masked_surface_contraction = ruminococcus_bromii_masked_surface[ruminococcus_bromii_masked_surface$nu <= 1.0, ]
# 
# ruminococcus_bromii_masked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = ruminococcus_bromii_masked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = ruminococcus_bromii_masked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Ruminococcus bromii histogram of likelihoods [singletons masked]')
# ruminococcus_bromii_masked_surface_hist
# 
# ruminococcus_bromii_masked_surface_cutoff = quantile(ruminococcus_bromii_masked_surface$likelihood, 0.80)
# 
# ruminococcus_bromii_masked_surface[ruminococcus_bromii_masked_surface$likelihood < ruminococcus_bromii_masked_surface_cutoff, ]$likelihood = ruminococcus_bromii_masked_surface_cutoff
# 
# ruminococcus_bromii_masked_surface_scatter = ggplot(data=ruminococcus_bromii_masked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Ruminococcus bromii rough likelihood surface [singletons masked]') +
#   geom_vline(xintercept=1.0, color='red')
# ruminococcus_bromii_masked_surface_scatter
# 
# ruminococcus_bromii_unmasked_surface = read.csv('gut_likelihood_surfaces/ruminococcus_bromii_unmasked.csv', header=FALSE)
# names(ruminococcus_bromii_unmasked_surface) = c('likelihood', 'nu', 'tau')
# 
# ruminococcus_bromii_unmasked_surface_expansion = ruminococcus_bromii_unmasked_surface[ruminococcus_bromii_unmasked_surface$nu > 1.0, ]
# ruminococcus_bromii_unmasked_surface_contraction = ruminococcus_bromii_unmasked_surface[ruminococcus_bromii_unmasked_surface$nu <= 1.0, ]
# 
# ruminococcus_bromii_unmasked_surface_hist = ggplot() +
#   geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = ruminococcus_bromii_unmasked_surface_expansion,  bins=100) +
#   geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = ruminococcus_bromii_unmasked_surface_contraction, bins=100) +
#   scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#   scale_y_log10() +
#   xlab('Likelihood') +
#   ylab('Count') +
#   ggtitle('Ruminococcus bromii histogram of likelihoods')
# ruminococcus_bromii_unmasked_surface_hist
# 
# ruminococcus_bromii_unmasked_surface_cutoff = quantile(ruminococcus_bromii_unmasked_surface$likelihood, 0.80)
# 
# ruminococcus_bromii_unmasked_surface[ruminococcus_bromii_unmasked_surface$likelihood < ruminococcus_bromii_unmasked_surface_cutoff, ]$likelihood = ruminococcus_bromii_unmasked_surface_cutoff
# 
# ruminococcus_bromii_unmasked_surface_scatter = ggplot(data=ruminococcus_bromii_unmasked_surface, aes(x=nu, y=tau)) + 
#   geom_point(aes(color=likelihood)) +
#   scale_fill_brewer(palette = "Accent") +
#   scale_x_continuous(trans='log10') +
#   scale_y_continuous(trans='log10') +
#   ggtitle('Ruminococcus bromii rough likelihood surface') +
#   geom_vline(xintercept=1.0, color='red')
# ruminococcus_bromii_unmasked_surface_scatter
# 
# plot_histogram = function(input) {
#   species_surface = read.csv(input, header=FALSE)
#   names(species_surface) = c('likelihood', 'nu', 'tau')
#   species_surface_expansion = species_surface[species_surface$nu > 1.0, ]
#   species_surface_contraction = species_surface[species_surface$nu <= 1.0, ]
#   
#   species_surface_hist = ggplot(data=species_surface) +
#     geom_histogram(aes(likelihood, fill = "expansion"), alpha = .2, data = species_surface_expansion,  bins=100) +
#     geom_histogram(aes(likelihood, fill = "contraction"), alpha = .2, data = species_surface_contraction, bins=100) +
#     scale_fill_manual(name = "dataset", values = c(expansion = "red", contraction = "green")) +
#     scale_y_log10() +
#     xlab('Likelihood') +
#     ylab('Count')
#   return(species_surface_hist)
# }
# 
# plot_likelihood_surface = function(input) {
#   species_surface = read.csv(input, header=FALSE)
#   names(species_surface) = c('likelihood', 'nu', 'tau')
#   
#   species_surface_cutoff = quantile(species_surface$likelihood, 0.80)
#   
#   species_surface[species_surface$likelihood < species_surface_cutoff, ]$likelihood = species_surface_cutoff
#   
#   species_surface_scatter = ggplot(data=species_surface, aes(x=nu, y=tau)) + 
#     geom_point(aes(color=likelihood)) +
#     scale_fill_brewer(palette = "Accent") +
#     scale_x_continuous(trans='log10') +
#     scale_y_continuous(trans='log10') +
#     geom_vline(xintercept=1.0, color='red')
#   return(species_surface_scatter)
# }
# 
# # Gut Consensus Unmasked
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Akkermansia_muciniphila_55290_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Akkermansia muciniphila 55290 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Akkermansia_muciniphila_55290_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Akkermansia muciniphila 55290 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Alistipes_finegoldii_56071_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Alistipes finegoldii 56071 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Alistipes_finegoldii_56071_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Alistipes finegoldii 56071 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Alistipes_onderdonkii_55464_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Alistipes onderdonkii 55464 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Alistipes_onderdonkii_55464_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Alistipes onderdonkii 55464 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Alistipes_putredinis_61533_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Alistipes_putredinis_61533 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Alistipes_putredinis_61533_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Alistipes_putredinis_61533 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Alistipes_shahii_62199_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Alistipes shahii 62199 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Alistipes_shahii_62199_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Alistipes shahii 62199 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroidales_bacterium_58650_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroidales bacterium 58650 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroidales_bacterium_58650_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroidales bacterium 58650 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_caccae_53434_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides caccae 53434 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_caccae_53434_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides caccae 53434 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_cellulosilyticus_58046_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides cellulosilyticus 58046 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_cellulosilyticus_58046_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides cellulosilyticus 58046 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_fragilis_54507_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides fragilis 54507 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_fragilis_54507_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides fragilis 54507 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_massiliensis_44749_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides massiliensis 44749 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_massiliensis_44749_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides massiliensis 44749 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_ovatus_58035_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides ovatus 58035 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_ovatus_58035_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides ovatus 58035 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_stercoris_56735_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides stercoris 56735 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_stercoris_56735_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides stercoris 56735 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_thetaiotaomicron_56941_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides thetaiotaomicron 56941 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_thetaiotaomicron_56941_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides thetaiotaomicron 56941 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_uniformis_57318_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides uniformis 57318 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_uniformis_57318_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides uniformis 57318 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_vulgatus_57955_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides vulgatus 57955 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_vulgatus_57955_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides vulgatus 57955 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Bacteroides_xylanisolvens_57185_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Bacteroides xylanisolvens 57185 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Bacteroides_xylanisolvens_57185_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Bacteroides xylanisolvens 57185 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Barnesiella_intestinihominis_62208_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Barnesiella intestinihominis 62208 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Barnesiella_intestinihominis_62208_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Barnesiella intestinihominis 62208 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Coprococcus_sp_62244_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Coprococcus sp 62244 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Coprococcus_sp_62244_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Coprococcus sp 62244 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Dialister_invisus_61905_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Dialister invisus 61905 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Dialister_invisus_61905_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Dialister invisus 61905 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Eubacterium_eligens_61678_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Eubacterium eligens 61678 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Eubacterium_eligens_61678_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Eubacterium eligens 61678 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Eubacterium_rectale_56927_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Eubacterium rectale 56927 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Eubacterium_rectale_56927_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Eubacterium rectale 56927 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Faecalibacterium_prausnitzii_57453_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Faecalibacterium prausnitzii 57453 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Faecalibacterium_prausnitzii_57453_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Faecalibacterium prausnitzii 57453 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Oscillibacter_sp_60799_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Oscillibacter sp 60799 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Oscillibacter_sp_60799_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Oscillibacter sp 60799 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Parabacteroides_distasonis_56985_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Parabacteroides distasonis 56985 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Parabacteroides_distasonis_56985_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Parabacteroides distasonis 56985 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Parabacteroides_merdae_56972_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Parabacteroides merdae 56972 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Parabacteroides_merdae_56972_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Parabacteroides merdae 56972 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Phascolarctobacterium_sp_59817_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Phascolarctobacterium sp 59817 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Phascolarctobacterium_sp_59817_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Phascolarctobacterium  sp 59817 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Prevotella_copri_61740_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Prevotella copri 61740 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Prevotella_copri_61740_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Prevotella  copri 61740 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Ruminococcus_bicirculans_59300_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Ruminococcus bicirculans 59300 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Ruminococcus_bicirculans_59300_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Ruminococcus bicirculans 59300 gut consensus likelihood surface')
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Ruminococcus_bromii_62047_unmasked.csv')
# gut_consensus_hist + 
#   ggtitle('Ruminococcus bromii 62047 gut consensus likelihood histogram')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Ruminococcus_bromii_62047_unmasked.csv')
# gut_consensus_likelihood +
#   ggtitle('Ruminococcus bromii 62047 gut consensus likelihood surface')
# 
# a_muciniphila_gut_consensus_empirical = c(7699923, 3000825, 1167628, 463693,
#                                           211570, 126150, 97358, 84953,
#                                           77668, 72333, 68129, 64402,
#                                           61411, 58488, 55759, 53536,
#                                           51265, 49002, 47183, 45447,
#                                           43719, 42139, 40591, 39294,
#                                           38102, 37023, 35967, 34902,
#                                           33938, 33162, 32358, 31692,
#                                           30997, 30325, 29692, 29301,
#                                           28916, 28501, 28179, 27927,
#                                           27628, 27498, 27361, 27206,
#                                           27041, 26982, 26907, 26913,
#                                           13485)
# a_muciniphila_gut_consensus_one_epoch = fold_sfs(c(2804780.988914795,
#                                                    1402391.590278085,
#                                                    934927.7518795277,
#                                                    701195.8193095237,
#                                                    560956.6589321734,
#                                                    467463.8850613571,
#                                                    400683.33216453483,
#                                                    350597.9174184588,
#                                                    311642.5947914722,
#                                                    280478.3366570959,
#                                                    254980.3072496627,
#                                                    233731.9493903648,
#                                                    215752.56964682377,
#                                                    200341.67270970455,
#                                                    186985.5620184747,
#                                                    175298.9651525649,
#                                                    164987.2620255456,
#                                                    155821.30368119033,
#                                                    147620.18304876125,
#                                                    140239.17447162524,
#                                                    133561.11908484463,
#                                                    127490.15963529033,
#                                                    121947.10969643321,
#                                                    116865.98057948503,
#                                                    112191.34178587019,
#                                                    107876.29058601073,
#                                                    103880.87280284682,
#                                                    100170.84199890273,
#                                                    96716.67538324631,
#                                                    93492.78653706444,
#                                                    90476.89051494091,
#                                                    87649.48798963078,
#                                                    84993.44318870867,
#                                                    82493.6363129736,
#                                                    80136.67554027055,
#                                                    77910.65702869574,
#                                                    75804.9638381529,
#                                                    73810.09660120425,
#                                                    71917.53024450107,
#                                                    70119.59220202516,
#                                                    68409.35845079499,
#                                                    66780.56439857648,
#                                                    65227.528205910385,
#                                                    63745.0845641893,
#                                                    62328.52730335468,
#                                                    60973.559485524995,
#                                                    59676.24986966238,
#                                                    58432.99481814265,
#                                                    57240.48486784485,
#                                                    56095.675312696054,
#                                                    54995.76024710481,
#                                                    53938.149604361315,
#                                                    52920.4487944998,
#                                                    51940.44060458105,
#                                                    50996.06907351641,
#                                                    50085.42509458669,
#                                                    49206.733533468156,
#                                                    48358.341678893274,
#                                                    47538.70886782404,
#                                                    46746.397148079195,
#                                                    45980.06285943587,
#                                                    45238.44902941616,
#                                                    44520.37849333091,
#                                                    43824.74765927403,
#                                                    43150.52084868983,
#                                                    42496.72515142186,
#                                                    41862.445741504576,
#                                                    41246.82160625833,
#                                                    40649.04164678274,
#                                                    40068.341112691516,
#                                                    39503.99833812217,
#                                                    38955.33174976168,
#                                                    38421.69712078076,
#                                                    37902.48504742179,
#                                                    37397.118627456504, 
#                                                    36905.05132193872,
#                                                    36425.76498355223,
#                                                    35958.7680366366,
#                                                    35503.59379544257,
#                                                    35059.79890850492,
#                                                    34626.96191825705,
#                                                    34204.68192604247,
#                                                    33792.577353615605,
#                                                    33390.28479313126,
#                                                    32997.45793828596,
#                                                    32613.766590039424,
#                                                    32238.895730930286,
#                                                    31872.544662458513,
#                                                    31514.426200677404,
#                                                    31164.26592535934,
#                                                    30821.801478711943,
#                                                    30486.781909796475,
#                                                    30158.967061270996,
#                                                    29838.126995246683,
#                                                    29524.04145543704,
#                                                    29216.499362897295,
#                                                    28915.298342969614))
# 
# 
# a_muciniphila_gut_consensus_x_axis = 1:length(a_muciniphila_gut_consensus_one_epoch)
# a_muciniphila_gut_consensus_df = data.frame(a_muciniphila_gut_consensus_empirical,
#                                                      a_muciniphila_gut_consensus_one_epoch,
#                                                      a_muciniphila_gut_consensus_x_axis)
# 
# 
# names(a_muciniphila_gut_consensus_df) = c('Empirical',
#                                           'One-epoch',
#                                           'x_axis')
# 
# p_a_muciniphila_gut_consensus_comparison <- ggplot(data = melt(a_muciniphila_gut_consensus_df, id='x_axis'),
#                                                       aes(x=x_axis, 
#                                                           y=value,
#                                                           fill=variable)) +
#   geom_bar(position='dodge2', stat='identity') +
#   labs(x = "", fill = "") +
#   scale_x_continuous(name='Minor Allele Frequency in Sample', breaks=a_muciniphila_gut_consensus_x_axis, limits=c(0.5, length(a_muciniphila_gut_consensus_x_axis) + 0.5)) +
#   ggtitle('A. muciniphila Consensus Site Frequency Spectrum') +
#   ylab('Number of Segregating Sites') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
# 
# p_a_muciniphila_gut_consensus_comparison
# 
# a_muciniphila_gut_consensus_df = data.frame(proportional_sfs(a_muciniphila_gut_consensus_empirical),
#                                             proportional_sfs(a_muciniphila_gut_consensus_one_epoch),
#                                             a_muciniphila_gut_consensus_x_axis)
# 
# names(a_muciniphila_gut_consensus_df) = c('Empirical',
#                                           'One-epoch',
#                                           'x_axis')
# 
# p_a_muciniphila_gut_consensus_comparison <- ggplot(data = melt(a_muciniphila_gut_consensus_df, id='x_axis'),
#                                                    aes(x=x_axis, 
#                                                        y=value,
#                                                        fill=variable)) +
#   geom_bar(position='dodge2', stat='identity') +
#   labs(x = "", fill = "") +
#   scale_x_continuous(name='Minor Allele Frequency in Sample', breaks=a_muciniphila_gut_consensus_x_axis, limits=c(0.5, length(a_muciniphila_gut_consensus_x_axis) + 0.5)) +
#   ggtitle('A. muciniphila Consensus Site Frequency Spectrum') +
#   ylab('Proportion of Segregating Sites') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
# 
# p_a_muciniphila_gut_consensus_comparison
# 
# gut_consensus_hist = 
#   plot_histogram('./gut_consensus/Akkermansia_muciniphila_55290_masked.csv')
# gut_consensus_hist + 
#   ggtitle('Akkermansia muciniphila 55290 gut consensus likelihood histogram (singletons masked)')
# gut_consensus_likelihood =
#   plot_likelihood_surface('./gut_consensus/Akkermansia_muciniphila_55290_masked.csv')
# gut_consensus_likelihood +
#   ggtitle('Akkermansia muciniphila 55290 gut consensus likelihood surface (singletons masked)')
# 
# set.seed(1)
# dnadiff_distribution = read.table('../Data/streptococcus_mutans_isolates/dnadiff_report_summary.txt', header=TRUE, sep=',')
# bases = dnadiff_distribution$alignBases
# seqs = dnadiff_distribution$alignSeq
# bases = c(bases, rnorm(n=100, mean=mean(bases), sd=0.5 * sd(bases)))
# seqs = c(seqs, rnorm(n=100, mean=mean(seqs), sd=0.25 * sd(seqs)))
# ggplot() + aes(bases) + geom_histogram() +
#   ggtitle('Histogram of Base Read Map Coverage for Strep. mutans') +
#   xlab('Base Read Map %')  +
#   ylab('Count') +
#   scale_x_continuous(breaks=seq(0,100,5))
# ggplot() + aes(seqs) + geom_histogram() +
#   ggtitle('Histogram of Sequence Read Map Coverage for Strep. mutans') +
#   xlab('Sequence Read Map %')  +
#   ylab('Count') +
#   scale_x_continuous(breaks=seq(0,100,5))
# 
# b_xylanisolvens_UHGG_sfs = proportional_sfs(fold_sfs(c(265, 90410, 54750, 36211, 27840, 24125, 19913, 
#                              15132, 10876, 10754, 9430, 9737, 7231, 7163, 5925, 
#                              6578, 5693, 5594, 5258, 4865, 4263, 4243, 3755, 3373, 
#                              3451, 3120, 3502, 3193, 2619, 2808, 3418, 3308, 3469, 
#                              3209, 2672, 3068, 3429, 2593, 2443, 2230, 2156, 2063, 
#                              1939, 2272, 1975, 1728, 1788, 1999, 1973, 1790, 1720, 
#                              1989, 1524, 1430, 1529, 1485, 1224, 1251, 1102, 1306, 
#                              1153, 1081, 1160, 1064, 993, 973, 1359, 1119, 1234, 
#                              1117, 1125, 1253, 1000, 1385, 1044, 1101, 1168, 1455, 
#                              1018, 779, 782, 799, 928, 837, 973, 976, 1134, 1163, 
#                              808, 801, 788, 827, 840, 1015, 805, 919, 670, 761, 701, 
#                              649, 659, 675, 764, 829, 641, 821, 667, 658, 696, 742,
#                              792, 716, 628, 648, 611, 619, 647, 594, 640, 688, 746, 
#                              715, 720, 713, 921, 864, 805, 1012, 921, 680, 606, 702,
#                              602, 635, 907, 664, 582, 745, 677, 805, 561, 671, 534, 
#                              590, 508, 452, 547, 516, 503, 456, 436, 551, 501, 542, 546, 
#                              598, 529, 494, 595, 576, 508, 686, 508, 608, 618, 480, 448,
#                              562, 442, 562, 419, 419, 533, 430, 429, 481, 495, 420, 383, 
#                              492, 437, 518, 394, 426, 450, 466, 578, 648, 651, 486, 431, 
#                              484, 381, 361, 402, 361, 378, 396, 308, 320, 302, 358, 311, 
#                              324, 329, 296, 392, 333, 340, 436, 347, 323, 388, 542, 414, 
#                              357, 345, 315, 281, 284, 427, 279, 261, 244, 336, 297, 343, 
#                              373, 282, 277, 302, 305, 306, 335, 281, 392, 277, 296, 295, 
#                              282, 262, 228, 264, 250, 283, 273, 314, 241, 278, 322, 316, 
#                              253, 246, 399, 470, 255, 243, 216, 252, 278, 230, 262, 278, 
#                              248, 259, 251, 275, 277, 244, 235, 248, 237, 240, 409, 284, 
#                              231, 247, 334, 265, 259, 256, 226, 207, 216, 342, 349, 297, 
#                              279, 270, 460, 317, 337, 331, 307, 232, 224, 227, 209, 220, 
#                              215, 259, 170, 178, 167, 172, 222, 188, 240, 234, 195, 201, 
#                              194, 230, 467, 259, 223, 196, 227, 259, 304, 292, 305, 238, 
#                              281, 302, 295, 391, 251, 302, 298, 283, 306, 230, 350, 276, 
#                              332, 309, 315, 325, 300, 274, 212, 227, 227, 212, 231, 266, 
#                              267, 205, 231, 265, 243, 238, 204, 287, 258, 206, 160, 181, 
#                              213, 134, 149, 172, 176, 149, 158, 138, 98, 94, 107, 102, 70, 
#                              116, 96, 83, 88, 84, 73, 58, 94, 90, 14, 4, 1, 0, 0, 0, 0, 0, 
#                              0, 0, 0, 0, 0, 0, 0)))
# 
# b_xylanisolvens_UHGG_x_axis = 1:length(b_xylanisolvens_UHGG_sfs)
# 
# b_xylanisolvens_UHGG_df = data.frame(b_xylanisolvens_UHGG_sfs,
#                                      b_xylanisolvens_UHGG_x_axis)
# 
# 
# names(b_xylanisolvens_UHGG_df) = c('Observed', 'x_axis')
# 
# p_b_xylanisolvens_UHGG_comparison <- ggplot(data = melt(b_xylanisolvens_UHGG_df, id='x_axis'),
#                                                       aes(x=x_axis, 
#                                                           y=value)) +
#   geom_bar(position='dodge2', stat='identity') +
#   labs(x = "", fill = "") +
#   scale_x_continuous(name='Minor Allele Frequency in Sample', breaks=b_xylanisolvens_UHGG_x_axis, limits=c(1.5, length(b_xylanisolvens_UHGG_x_axis) + 0.5)) +
#   ggtitle('B. Xylanisolvens Folded SFS from UHGG Data') +
#   xlim(0, 75) +
#   ylab('Proportion of Segregating Sites') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
# 
# p_b_xylanisolvens_UHGG_comparison
# 
# b_xylanisolvens_UHGG_count_sfs = c(265, 90410, 54750, 36211, 27840, 24125, 19913, 
#                                      15132, 10876, 10754, 9430, 9737, 7231, 7163, 5925, 
#                                      6578, 5693, 5594, 5258, 4865, 4263, 4243, 3755, 3373, 
#                                      3451, 3120, 3502, 3193, 2619, 2808, 3418, 3308, 3469, 
#                                      3209, 2672, 3068, 3429, 2593, 2443, 2230, 2156, 2063, 
#                                      1939, 2272, 1975, 1728, 1788, 1999, 1973, 1790, 1720, 
#                                      1989, 1524, 1430, 1529, 1485, 1224, 1251, 1102, 1306, 
#                                      1153, 1081, 1160, 1064, 993, 973, 1359, 1119, 1234, 
#                                      1117, 1125, 1253, 1000, 1385, 1044, 1101, 1168, 1455, 
#                                      1018, 779, 782, 799, 928, 837, 973, 976, 1134, 1163, 
#                                      808, 801, 788, 827, 840, 1015, 805, 919, 670, 761, 701, 
#                                      649, 659, 675, 764, 829, 641, 821, 667, 658, 696, 742,
#                                      792, 716, 628, 648, 611, 619, 647, 594, 640, 688, 746, 
#                                      715, 720, 713, 921, 864, 805, 1012, 921, 680, 606, 702,
#                                      602, 635, 907, 664, 582, 745, 677, 805, 561, 671, 534, 
#                                      590, 508, 452, 547, 516, 503, 456, 436, 551, 501, 542, 546, 
#                                      598, 529, 494, 595, 576, 508, 686, 508, 608, 618, 480, 448,
#                                      562, 442, 562, 419, 419, 533, 430, 429, 481, 495, 420, 383, 
#                                      492, 437, 518, 394, 426, 450, 466, 578, 648, 651, 486, 431, 
#                                      484, 381, 361, 402, 361, 378, 396, 308, 320, 302, 358, 311, 
#                                      324, 329, 296, 392, 333, 340, 436, 347, 323, 388, 542, 414, 
#                                      357, 345, 315, 281, 284, 427, 279, 261, 244, 336, 297, 343, 
#                                      373, 282, 277, 302, 305, 306, 335, 281, 392, 277, 296, 295, 
#                                      282, 262, 228, 264, 250, 283, 273, 314, 241, 278, 322, 316, 
#                                      253, 246, 399, 470, 255, 243, 216, 252, 278, 230, 262, 278, 
#                                      248, 259, 251, 275, 277, 244, 235, 248, 237, 240, 409, 284, 
#                                      231, 247, 334, 265, 259, 256, 226, 207, 216, 342, 349, 297, 
#                                      279, 270, 460, 317, 337, 331, 307, 232, 224, 227, 209, 220, 
#                                      215, 259, 170, 178, 167, 172, 222, 188, 240, 234, 195, 201, 
#                                      194, 230, 467, 259, 223, 196, 227, 259, 304, 292, 305, 238, 
#                                      281, 302, 295, 391, 251, 302, 298, 283, 306, 230, 350, 276, 
#                                      332, 309, 315, 325, 300, 274, 212, 227, 227, 212, 231, 266, 
#                                      267, 205, 231, 265, 243, 238, 204, 287, 258, 206, 160, 181, 
#                                      213, 134, 149, 172, 176, 149, 158, 138, 98, 94, 107, 102, 70, 
#                                      116, 96, 83, 88, 84, 73, 58, 94, 90, 14, 4, 1, 0, 0, 0, 0, 0, 
#                                      0, 0, 0, 0, 0, 0, 0)
# 
# b_xylanisolvens_UHGG_x_axis = 1:length(b_xylanisolvens_UHGG_count_sfs)
# 
# b_xylanisolvens_UHGG_df = data.frame(b_xylanisolvens_UHGG_count_sfs,
#                                      b_xylanisolvens_UHGG_x_axis)
# 
# 
# names(b_xylanisolvens_UHGG_df) = c('Observed', 'x_axis')
# 
# p_b_xylanisolvens_UHGG_comparison <- ggplot(data = melt(b_xylanisolvens_UHGG_df, id='x_axis'),
#                                             aes(x=x_axis, 
#                                                 y=value)) +
#   geom_bar(position='dodge2', stat='identity') +
#   labs(x = "", fill = "") +
#   ylim(0, 300) +
#   xlim(0, 25) + 
#   scale_x_continuous(name='Minor Allele Frequency in Sample', breaks=b_xylanisolvens_UHGG_x_axis, limits=c(1.5, length(b_xylanisolvens_UHGG_x_axis) + 0.5)) +
#   ggtitle('B. Thetaiotaomicron Site Frequency Spectrum, Downsampled to 20 samples') +
#   ylab('Proportion of Segregating Sites') +
#   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
#                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
#   scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
# 
# p_b_xylanisolvens_UHGG_comparison


# # Downsampled to 10
# 
# ## A. finegoldii
# plot_likelihood_surface('../Analysis/qp_gut_10/a_finegoldii_10.csv')
# a_finegoldii_10_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_10/empirical_sfs.txt'
# )
# a_finegoldii_10_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_10/one_epoch_demography.txt'
# )
# a_finegoldii_10_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_10/two_epoch_demography.txt'
# )
# a_finegoldii_original_empirical = read_input_sfs_original(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_10/original_empirical_sfs.txt'
# )
# 
# compare_sfs(a_finegoldii_10_empirical,
#             a_finegoldii_10_one_epoch,
#             a_finegoldii_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. finegoldii Downsampled to 10')
# 
# compare_sfs(proportional_sfs(a_finegoldii_10_empirical),
#             proportional_sfs(a_finegoldii_10_one_epoch),
#             proportional_sfs(a_finegoldii_10_two_epoch)) +
#   ggtitle('A. finegoldii Downsampled to 10')
# 
# ## A. muciniphila
# plot_likelihood_surface('../Analysis/qp_gut_10/a_muciniphila_10.csv')
# a_muciniphila_10_empirical =  read_input_sfs(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_10/empirical_sfs.txt'
# )
# a_muciniphila_10_one_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_10/one_epoch_demography.txt'
# )
# a_muciniphila_10_two_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_10/two_epoch_demography.txt'
# )
# a_muciniphila_original_empirical = read_input_sfs_original(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(a_muciniphila_10_empirical,
#             a_muciniphila_10_one_epoch,
#             a_muciniphila_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. muciniphila Downsampled to 10')
# 
# compare_sfs(proportional_sfs(a_muciniphila_10_empirical),
#             proportional_sfs(a_muciniphila_10_one_epoch),
#             proportional_sfs(a_muciniphila_10_two_epoch)) +
#   ggtitle('A. muciniphila Downsampled to 10')
# 
# 
# ## A. onderdonkii
# plot_likelihood_surface('../Analysis/qp_gut_10/a_onderdonkii_10.csv')
# a_onderdonkii_10_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_10/empirical_sfs.txt'
# )
# a_onderdonkii_10_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_10/one_epoch_demography.txt'
# )
# a_onderdonkii_10_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_10/two_epoch_demography.txt'
# )
# a_onderdonkii_original_empirical = read_input_sfs_original(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_10/original_empirical_sfs.txt'
# )
# 
# compare_sfs(a_onderdonkii_10_empirical,
#             a_onderdonkii_10_one_epoch,
#             a_onderdonkii_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. onderdonkii Downsampled to 10')
# 
# compare_sfs(proportional_sfs(a_onderdonkii_10_empirical),
#             proportional_sfs(a_onderdonkii_10_one_epoch),
#             proportional_sfs(a_onderdonkii_10_two_epoch)) +
#   ggtitle('A. onderdonkii Downsampled to 10')
# 
# 
# ## A. putredinis
# plot_likelihood_surface('../Analysis/qp_gut_10/a_putredinis_10.csv')
# a_putredinis_10_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_10/empirical_sfs.txt'
# )
# a_putredinis_10_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_10/one_epoch_demography.txt'
# )
# a_putredinis_10_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_10/two_epoch_demography.txt'
# )
# a_putredinis_original_empirical = read_input_sfs_original(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(a_putredinis_10_empirical,
#             a_putredinis_10_one_epoch,
#             a_putredinis_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. putredinis Downsampled to 10')
# 
# compare_sfs(proportional_sfs(a_putredinis_10_empirical),
#             proportional_sfs(a_putredinis_10_one_epoch),
#             proportional_sfs(a_putredinis_10_two_epoch)) +
#   ggtitle('A. putredinis Downsampled to 10')
# 
# 
# 
# ## A. shahii
# plot_likelihood_surface('../Analysis/qp_gut_10/a_shahii_10.csv')
# a_shahii_10_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_shahii_62199_downsampled_10/empirical_sfs.txt'
# )
# a_shahii_10_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_10/one_epoch_demography.txt'
# )
# a_shahii_10_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_10/two_epoch_demography.txt'
# )
# a_shahii_original_empirical = read_input_sfs_original(
#   '../Analysis/Alistipes_shahii_62199_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(a_shahii_10_empirical,
#             a_shahii_10_one_epoch,
#             a_shahii_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. shahii Downsampled to 10')
# 
# compare_sfs(proportional_sfs(a_shahii_10_empirical),
#             proportional_sfs(a_shahii_10_one_epoch),
#             proportional_sfs(a_shahii_10_two_epoch)) +
#   ggtitle('A. shahii Downsampled to 10')
# 
# 
# ## B. bacterium
# plot_likelihood_surface('../Analysis/qp_gut_10/b_bacterium_10.csv')
# b_bacterium_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_10/empirical_sfs.txt'
# )
# b_bacterium_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_10/one_epoch_demography.txt'
# )
# b_bacterium_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_10/two_epoch_demography.txt'
# )
# b_bacterium_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_bacterium_10_empirical,
#             b_bacterium_10_one_epoch,
#             b_bacterium_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. bacterium Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_bacterium_10_empirical),
#             proportional_sfs(b_bacterium_10_one_epoch),
#             proportional_sfs(b_bacterium_10_two_epoch)) +
#   ggtitle('B. bacterium Downsampled to 10')
# 
# ## B. caccae
# plot_likelihood_surface('../Analysis/qp_gut_10/b_caccae_10.csv')
# b_caccae_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_10/empirical_sfs.txt'
# )
# b_caccae_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_10/one_epoch_demography.txt'
# )
# b_caccae_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_10/two_epoch_demography.txt'
# )
# b_caccae_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_caccae_10_empirical,
#             b_caccae_10_one_epoch,
#             b_caccae_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. caccae Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_caccae_10_empirical),
#             proportional_sfs(b_caccae_10_one_epoch),
#             proportional_sfs(b_caccae_10_two_epoch)) +
#   ggtitle('B. caccae Downsampled to 10')
# 
# ## B. cellulosilyticus
# plot_likelihood_surface('../Analysis/qp_gut_10/b_cellulosilyticus_10.csv')
# b_cellulosilyticus_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_10/empirical_sfs.txt'
# )
# b_cellulosilyticus_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_10/one_epoch_demography.txt'
# )
# b_cellulosilyticus_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_10/two_epoch_demography.txt'
# )
# b_cellulosilyticus_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_cellulosilyticus_10_empirical,
#             b_cellulosilyticus_10_one_epoch,
#             b_cellulosilyticus_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. cellulosilyticus Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_cellulosilyticus_10_empirical),
#             proportional_sfs(b_cellulosilyticus_10_one_epoch),
#             proportional_sfs(b_cellulosilyticus_10_two_epoch)) +
#   ggtitle('B. cellulosilyticus Downsampled to 10')
# 
# 
# ##  B. fragilis
# plot_likelihood_surface('../Analysis/qp_gut_10/b_fragilis_10.csv')
# b_fragilis_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_10/empirical_sfs.txt'
# )
# b_fragilis_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_10/one_epoch_demography.txt'
# )
# b_fragilis_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_10/two_epoch_demography.txt'
# )
# b_fragilis_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_fragilis_10_empirical,
#             b_fragilis_10_one_epoch,
#             b_fragilis_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. fragilis Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_fragilis_10_empirical),
#             proportional_sfs(b_fragilis_10_one_epoch),
#             proportional_sfs(b_fragilis_10_two_epoch)) +
#   ggtitle('B. fragilis Downsampled to 10')
# 
# 
# ## B. intestinihominis
# plot_likelihood_surface('../Analysis/qp_gut_10/b_intestinihominis_10.csv')
# b_intestinihominis_10_empirical =  read_input_sfs(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_10/empirical_sfs.txt'
# )
# b_intestinihominis_10_one_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_10/one_epoch_demography.txt'
# )
# b_intestinihominis_10_two_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_10/two_epoch_demography.txt'
# )
# b_intestinihominis_original_empirical = read_input_sfs_original(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_intestinihominis_10_empirical,
#             b_intestinihominis_10_one_epoch,
#             b_intestinihominis_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. intestinihominis Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_intestinihominis_10_empirical),
#             proportional_sfs(b_intestinihominis_10_one_epoch),
#             proportional_sfs(b_intestinihominis_10_two_epoch)) +
#   ggtitle('B. intestinihominis Downsampled to 10')
# 
# 
# 
# ## B. ovatus
# plot_likelihood_surface('../Analysis/qp_gut_10/b_ovatus_10.csv')
# b_ovatus_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_10/empirical_sfs.txt'
# )
# b_ovatus_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_10/one_epoch_demography.txt'
# )
# b_ovatus_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_10/two_epoch_demography.txt'
# )
# b_ovatus_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_ovatus_10_empirical,
#             b_ovatus_10_one_epoch,
#             b_ovatus_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. ovatus Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_ovatus_10_empirical),
#             proportional_sfs(b_ovatus_10_one_epoch),
#             proportional_sfs(b_ovatus_10_two_epoch)) +
#   ggtitle('B. ovatus Downsampled to 10')
# 
# 
# ## B. thetaiotaomicron
# plot_likelihood_surface('../Analysis/qp_gut_10/b_thetaiotaomicron_10.csv')
# b_thetaiotaomicron_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_10/empirical_sfs.txt'
# )
# b_thetaiotaomicron_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_10/one_epoch_demography.txt'
# )
# b_thetaiotaomicron_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_10/two_epoch_demography.txt'
# )
# b_thetaiotaomicron_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_thetaiotaomicron_10_empirical,
#             b_thetaiotaomicron_10_one_epoch,
#             b_thetaiotaomicron_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. thetaiotaomicron Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_thetaiotaomicron_10_empirical),
#             proportional_sfs(b_thetaiotaomicron_10_one_epoch),
#             proportional_sfs(b_thetaiotaomicron_10_two_epoch)) +
#   ggtitle('B. thetaiotaomicron Downsampled to 10')
# 
# 
# ## B. uniformis
# plot_likelihood_surface('../Analysis/qp_gut_10/b_uniformis_10.csv')
# b_uniformis_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_10/empirical_sfs.txt'
# )
# b_uniformis_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_10/one_epoch_demography.txt'
# )
# b_uniformis_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_10/two_epoch_demography.txt'
# )
# b_uniformis_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_uniformis_10_empirical,
#             b_uniformis_10_one_epoch,
#             b_uniformis_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. uniformis Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_uniformis_10_empirical),
#             proportional_sfs(b_uniformis_10_one_epoch),
#             proportional_sfs(b_uniformis_10_two_epoch)) +
#   ggtitle('B. uniformis Downsampled to 10')
# 
# 
# ## B. vulgatus
# plot_likelihood_surface('../Analysis/qp_gut_10/b_vulgatus_10.csv')
# b_vulgatus_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_10/empirical_sfs.txt'
# )
# b_vulgatus_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_10/one_epoch_demography.txt'
# )
# b_vulgatus_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_10/two_epoch_demography.txt'
# )
# b_vulgatus_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_vulgatus_10_empirical,
#             b_vulgatus_10_one_epoch,
#             b_vulgatus_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. vulgatus Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_vulgatus_10_empirical),
#             proportional_sfs(b_vulgatus_10_one_epoch),
#             proportional_sfs(b_vulgatus_10_two_epoch)) +
#   ggtitle('B. vulgatus Downsampled to 10')
# 
# 
# 
# ## B. xylanisolvens
# plot_likelihood_surface('../Analysis/qp_gut_10/b_xylanisolvens_10.csv')
# b_xylanisolvens_10_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_10/empirical_sfs.txt'
# )
# b_xylanisolvens_10_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_10/one_epoch_demography.txt'
# )
# b_xylanisolvens_10_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_10/two_epoch_demography.txt'
# )
# b_xylanisolvens_original_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(b_xylanisolvens_10_empirical,
#             b_xylanisolvens_10_one_epoch,
#             b_xylanisolvens_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. xylanisolvens Downsampled to 10')
# 
# compare_sfs(proportional_sfs(b_xylanisolvens_10_empirical),
#             proportional_sfs(b_xylanisolvens_10_one_epoch),
#             proportional_sfs(b_xylanisolvens_10_two_epoch)) +
#   ggtitle('B. xylanisolvens Downsampled to 10')
# 
# 
# 
# ## D. invisus
# plot_likelihood_surface('../Analysis/qp_gut_10/d_invisus_10.csv')
# d_invisus_10_empirical =  read_input_sfs(
#   '../Analysis/Dialister_invisus_61905_downsampled_10/empirical_sfs.txt'
# )
# d_invisus_10_one_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_10/one_epoch_demography.txt'
# )
# d_invisus_10_two_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_10/two_epoch_demography.txt'
# )
# d_invisus_original_empirical = read_input_sfs_original(
#   '../Analysis/Dialister_invisus_61905_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(d_invisus_10_empirical,
#             d_invisus_10_one_epoch,
#             d_invisus_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('D. invisus Downsampled to 10')
# 
# compare_sfs(proportional_sfs(d_invisus_10_empirical),
#             proportional_sfs(d_invisus_10_one_epoch),
#             proportional_sfs(d_invisus_10_two_epoch)) +
#   ggtitle('D. invisus Downsampled to 10')
# 
# 
# ## E. eligens
# plot_likelihood_surface('../Analysis/qp_gut_10/e_eligens_10.csv')
# e_eligens_10_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_10/empirical_sfs.txt'
# )
# e_eligens_10_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_10/one_epoch_demography.txt'
# )
# e_eligens_10_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_10/two_epoch_demography.txt'
# )
# e_eligens_original_empirical = read_input_sfs_original(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(e_eligens_10_empirical,
#             e_eligens_10_one_epoch,
#             e_eligens_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. eligens Downsampled to 10')
# 
# compare_sfs(proportional_sfs(e_eligens_10_empirical),
#             proportional_sfs(e_eligens_10_one_epoch),
#             proportional_sfs(e_eligens_10_two_epoch)) +
#   ggtitle('E. eligens Downsampled to 10')
# 
# 
# 
# ## E. rectale
# plot_likelihood_surface('../Analysis/qp_gut_10/e_rectale_10.csv')
# e_rectale_10_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_10/empirical_sfs.txt'
# )
# e_rectale_10_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_10/one_epoch_demography.txt'
# )
# e_rectale_10_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_10/two_epoch_demography.txt'
# )
# e_rectale_original_empirical = read_input_sfs_original(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(e_rectale_10_empirical,
#             e_rectale_10_one_epoch,
#             e_rectale_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. rectale Downsampled to 10')
# 
# compare_sfs(proportional_sfs(e_rectale_10_empirical),
#             proportional_sfs(e_rectale_10_one_epoch),
#             proportional_sfs(e_rectale_10_two_epoch)) +
#   ggtitle('E. rectale Downsampled to 10')
# 
# 
# ## F. prausnitzii
# plot_likelihood_surface('../Analysis/qp_gut_10/f_prausnitzii_10.csv')
# f_prausnitzii_10_empirical =  read_input_sfs(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_10/empirical_sfs.txt'
# )
# f_prausnitzii_10_one_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_10/one_epoch_demography.txt'
# )
# f_prausnitzii_10_two_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_10/two_epoch_demography.txt'
# )
# f_prausnitzii_original_empirical = read_input_sfs_original(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(f_prausnitzii_10_empirical,
#             f_prausnitzii_10_one_epoch,
#             f_prausnitzii_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('F. prausnitzii Downsampled to 10')
# 
# compare_sfs(proportional_sfs(f_prausnitzii_10_empirical),
#             proportional_sfs(f_prausnitzii_10_one_epoch),
#             proportional_sfs(f_prausnitzii_10_two_epoch)) +
#   ggtitle('F. prausnitzii Downsampled to 10')
# 
# 
# ## Oscillibacter sp.
# plot_likelihood_surface('../Analysis/qp_gut_10/oscillibacter_sp_10.csv')
# oscillibacter_sp_10_empirical =  read_input_sfs(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_10/empirical_sfs.txt'
# )
# oscillibacter_sp_10_one_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_10/one_epoch_demography.txt'
# )
# oscillibacter_sp_10_two_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_10/two_epoch_demography.txt'
# )
# oscillibacter_sp_original_empirical = read_input_sfs_original(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(oscillibacter_sp_10_empirical,
#             oscillibacter_sp_10_one_epoch,
#             oscillibacter_sp_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Oscillibacter sp. Downsampled to 10')
# 
# compare_sfs(proportional_sfs(oscillibacter_sp_10_empirical),
#             proportional_sfs(oscillibacter_sp_10_one_epoch),
#             proportional_sfs(oscillibacter_sp_10_two_epoch)) +
#   ggtitle('Oscillibacter sp. Downsampled to 10')
# 
# 
# ## o. splanchnicus
# plot_likelihood_surface('../Analysis/qp_gut_10/o_splanchnicus_10.csv')
# o_splanchnicus_10_empirical =  read_input_sfs(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_10/empirical_sfs.txt'
# )
# o_splanchnicus_10_one_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_10/one_epoch_demography.txt'
# )
# o_splanchnicus_10_two_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_10/two_epoch_demography.txt'
# )
# o_splanchnicus_original_empirical = read_input_sfs_original(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(o_splanchnicus_10_empirical,
#             o_splanchnicus_10_one_epoch,
#             o_splanchnicus_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('O. splanchnicus Downsampled to 10')
# 
# compare_sfs(proportional_sfs(o_splanchnicus_10_empirical),
#             proportional_sfs(o_splanchnicus_10_one_epoch),
#             proportional_sfs(o_splanchnicus_10_two_epoch)) +
#   ggtitle('O. splanchnicus Downsampled to 10')
# 
# 
# ## P. copri
# plot_likelihood_surface('../Analysis/qp_gut_10/p_copri_10.csv')
# p_copri_10_empirical =  read_input_sfs(
#   '../Analysis/Prevotella_copri_61740_downsampled_10/empirical_sfs.txt'
# )
# p_copri_10_one_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_10/one_epoch_demography.txt'
# )
# p_copri_10_two_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_10/two_epoch_demography.txt'
# )
# p_copri_original_empirical = read_input_sfs_original(
#   '../Analysis/Prevotella_copri_61740_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(p_copri_10_empirical,
#             p_copri_10_one_epoch,
#             p_copri_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. copri Downsampled to 10')
# 
# compare_sfs(proportional_sfs(p_copri_10_empirical),
#             proportional_sfs(p_copri_10_one_epoch),
#             proportional_sfs(p_copri_10_two_epoch)) +
#   ggtitle('P. copri Downsampled to 10')
# 
# 
# ## P. distasonis
# plot_likelihood_surface('../Analysis/qp_gut_10/p_distasonis_10.csv')
# p_distasonis_10_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_10/empirical_sfs.txt'
# )
# p_distasonis_10_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_10/one_epoch_demography.txt'
# )
# p_distasonis_10_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_10/two_epoch_demography.txt'
# )
# p_distasonis_original_empirical = read_input_sfs_original(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(p_distasonis_10_empirical,
#             p_distasonis_10_one_epoch,
#             p_distasonis_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. distasonis Downsampled to 10')
# 
# compare_sfs(proportional_sfs(p_distasonis_10_empirical),
#             proportional_sfs(p_distasonis_10_one_epoch),
#             proportional_sfs(p_distasonis_10_two_epoch)) +
#   ggtitle('P. distasonis Downsampled to 10')
# 
# 
# ## P. merdae
# plot_likelihood_surface('../Analysis/qp_gut_10/p_merdae_10.csv')
# p_merdae_10_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_10/empirical_sfs.txt'
# )
# p_merdae_10_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_10/one_epoch_demography.txt'
# )
# p_merdae_10_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_10/two_epoch_demography.txt'
# )
# p_merdae_original_empirical = read_input_sfs_original(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(p_merdae_10_empirical,
#             p_merdae_10_one_epoch,
#             p_merdae_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. merdae Downsampled to 10')
# 
# compare_sfs(proportional_sfs(p_merdae_10_empirical),
#             proportional_sfs(p_merdae_10_one_epoch),
#             proportional_sfs(p_merdae_10_two_epoch)) +
#   ggtitle('P. merdae Downsampled to 10')
# 
# 
# ## Phascolarctobacterium sp.
# plot_likelihood_surface('../Analysis/qp_gut_10/phascolarctobacterium_sp_10.csv')
# phascolarctobacterium_sp_10_empirical =  read_input_sfs(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_10/empirical_sfs.txt'
# )
# phascolarctobacterium_sp_10_one_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_10/one_epoch_demography.txt'
# )
# phascolarctobacterium_sp_10_two_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_10/two_epoch_demography.txt'
# )
# phascolarctobacterium_sp_original_empirical = read_input_sfs_original(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(phascolarctobacterium_sp_10_empirical,
#             phascolarctobacterium_sp_10_one_epoch,
#             phascolarctobacterium_sp_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 10')
# 
# compare_sfs(proportional_sfs(phascolarctobacterium_sp_10_empirical),
#             proportional_sfs(phascolarctobacterium_sp_10_one_epoch),
#             proportional_sfs(phascolarctobacterium_sp_10_two_epoch)) +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 10')
# 
# 
# ## R. bicirculans
# plot_likelihood_surface('../Analysis/qp_gut_10/r_bicirculans_10.csv')
# r_bicirculans_10_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_10/empirical_sfs.txt'
# )
# r_bicirculans_10_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_10/one_epoch_demography.txt'
# )
# r_bicirculans_10_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_10/two_epoch_demography.txt'
# )
# r_bicirculans_original_empirical = read_input_sfs_original(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(r_bicirculans_10_empirical,
#             r_bicirculans_10_one_epoch,
#             r_bicirculans_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bicirculans Downsampled to 10')
# 
# compare_sfs(proportional_sfs(r_bicirculans_10_empirical),
#             proportional_sfs(r_bicirculans_10_one_epoch),
#             proportional_sfs(r_bicirculans_10_two_epoch)) +
#   ggtitle('R. bicirculans Downsampled to 10')
# 
# ## R. bromii
# plot_likelihood_surface('../Analysis/qp_gut_10/r_bromii_10.csv')
# r_bromii_10_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_10/empirical_sfs.txt'
# )
# r_bromii_10_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_10/one_epoch_demography.txt'
# )
# r_bromii_10_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_10/two_epoch_demography.txt'
# )
# r_bromii_original_empirical = read_input_sfs_original(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_10/original_empirical_sfs.txt'
# )
# compare_sfs(r_bromii_10_empirical,
#             r_bromii_10_one_epoch,
#             r_bromii_10_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bromii Downsampled to 10')
# 
# compare_sfs(proportional_sfs(r_bromii_10_empirical),
#             proportional_sfs(r_bromii_10_one_epoch),
#             proportional_sfs(r_bromii_10_two_epoch)) +
#   ggtitle('R. bromii Downsampled to 10')
# 
# # Downsampled to 12
# 
# # A. finegoldii
# plot_likelihood_surface('../Analysis/qp_gut_12/a_finegoldii_12.csv')
# a_finegoldii_12_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_12/empirical_sfs.txt'
# )
# a_finegoldii_12_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_12/one_epoch_demography.txt'
# )
# a_finegoldii_12_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_12/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_finegoldii_12_empirical,
#             a_finegoldii_12_one_epoch,
#             a_finegoldii_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. finegoldii Downsampled to 12')
# 
# compare_sfs(proportional_sfs(a_finegoldii_12_empirical),
#             proportional_sfs(a_finegoldii_12_one_epoch),
#             proportional_sfs(a_finegoldii_12_two_epoch)) +
#   ggtitle('A. finegoldii Downsampled to 12')
# 
# # A. muciniphila
# plot_likelihood_surface('../Analysis/qp_gut_12/a_muciniphila_12.csv')
# a_muciniphila_12_empirical =  read_input_sfs(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_12/empirical_sfs.txt'
# )
# a_muciniphila_12_one_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_12/one_epoch_demography.txt'
# )
# a_muciniphila_12_two_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(a_muciniphila_12_empirical,
#             a_muciniphila_12_one_epoch,
#             a_muciniphila_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. muciniphila Downsampled to 12')
# 
# compare_sfs(proportional_sfs(a_muciniphila_12_empirical),
#             proportional_sfs(a_muciniphila_12_one_epoch),
#             proportional_sfs(a_muciniphila_12_two_epoch)) +
#   ggtitle('A. muciniphila Downsampled to 12')
# 
# 
# # A. onderdonkii
# plot_likelihood_surface('../Analysis/qp_gut_12/a_onderdonkii_12.csv')
# a_onderdonkii_12_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_12/empirical_sfs.txt'
# )
# a_onderdonkii_12_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_12/one_epoch_demography.txt'
# )
# a_onderdonkii_12_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_12/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_onderdonkii_12_empirical,
#             a_onderdonkii_12_one_epoch,
#             a_onderdonkii_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. onderdonkii Downsampled to 12')
# 
# compare_sfs(proportional_sfs(a_onderdonkii_12_empirical),
#             proportional_sfs(a_onderdonkii_12_one_epoch),
#             proportional_sfs(a_onderdonkii_12_two_epoch)) +
#   ggtitle('A. onderdonkii Downsampled to 12')
# 
# 
# # A. putredinis
# plot_likelihood_surface('../Analysis/qp_gut_12/a_putredinis_12.csv')
# a_putredinis_12_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_12/empirical_sfs.txt'
# )
# a_putredinis_12_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_12/one_epoch_demography.txt'
# )
# a_putredinis_12_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(a_putredinis_12_empirical,
#             a_putredinis_12_one_epoch,
#             a_putredinis_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. putredinis Downsampled to 12')
# 
# compare_sfs(proportional_sfs(a_putredinis_12_empirical),
#             proportional_sfs(a_putredinis_12_one_epoch),
#             proportional_sfs(a_putredinis_12_two_epoch)) +
#   ggtitle('A. putredinis Downsampled to 12')
# 
# 
# 
# # A. shahii
# plot_likelihood_surface('../Analysis/qp_gut_12/a_shahii_12.csv')
# a_shahii_12_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_shahii_62199_downsampled_12/empirical_sfs.txt'
# )
# a_shahii_12_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_12/one_epoch_demography.txt'
# )
# a_shahii_12_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(a_shahii_12_empirical,
#             a_shahii_12_one_epoch,
#             a_shahii_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. shahii Downsampled to 12')
# 
# compare_sfs(proportional_sfs(a_shahii_12_empirical),
#             proportional_sfs(a_shahii_12_one_epoch),
#             proportional_sfs(a_shahii_12_two_epoch)) +
#   ggtitle('A. shahii Downsampled to 12')
# 
# 
# # B. bacterium
# plot_likelihood_surface('../Analysis/qp_gut_12/b_bacterium_12.csv')
# b_bacterium_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_12/empirical_sfs.txt'
# )
# b_bacterium_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_12/one_epoch_demography.txt'
# )
# b_bacterium_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_bacterium_12_empirical,
#             b_bacterium_12_one_epoch,
#             b_bacterium_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. bacterium Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_bacterium_12_empirical),
#             proportional_sfs(b_bacterium_12_one_epoch),
#             proportional_sfs(b_bacterium_12_two_epoch)) +
#   ggtitle('B. bacterium Downsampled to 12')
# 
# # B. caccae
# plot_likelihood_surface('../Analysis/qp_gut_12/b_caccae_12.csv')
# b_caccae_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_12/empirical_sfs.txt'
# )
# b_caccae_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_12/one_epoch_demography.txt'
# )
# b_caccae_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_caccae_12_empirical,
#             b_caccae_12_one_epoch,
#             b_caccae_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. caccae Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_caccae_12_empirical),
#             proportional_sfs(b_caccae_12_one_epoch),
#             proportional_sfs(b_caccae_12_two_epoch)) +
#   ggtitle('B. caccae Downsampled to 12')
# 
# # B. cellulosilyticus
# plot_likelihood_surface('../Analysis/qp_gut_12/b_cellulosilyticus_12.csv')
# b_cellulosilyticus_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_12/empirical_sfs.txt'
# )
# b_cellulosilyticus_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_12/one_epoch_demography.txt'
# )
# b_cellulosilyticus_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_cellulosilyticus_12_empirical,
#             b_cellulosilyticus_12_one_epoch,
#             b_cellulosilyticus_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. cellulosilyticus Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_cellulosilyticus_12_empirical),
#             proportional_sfs(b_cellulosilyticus_12_one_epoch),
#             proportional_sfs(b_cellulosilyticus_12_two_epoch)) +
#   ggtitle('B. cellulosilyticus Downsampled to 12')
# 
# 
# #  B. fragilis
# plot_likelihood_surface('../Analysis/qp_gut_12/b_fragilis_12.csv')
# b_fragilis_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_12/empirical_sfs.txt'
# )
# b_fragilis_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_12/one_epoch_demography.txt'
# )
# b_fragilis_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_fragilis_12_empirical,
#             b_fragilis_12_one_epoch,
#             b_fragilis_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. fragilis Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_fragilis_12_empirical),
#             proportional_sfs(b_fragilis_12_one_epoch),
#             proportional_sfs(b_fragilis_12_two_epoch)) +
#   ggtitle('B. fragilis Downsampled to 12')
# 
# 
# # B. intestinihominis
# plot_likelihood_surface('../Analysis/qp_gut_12/b_intestinihominis_12.csv')
# b_intestinihominis_12_empirical =  read_input_sfs(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_12/empirical_sfs.txt'
# )
# b_intestinihominis_12_one_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_12/one_epoch_demography.txt'
# )
# b_intestinihominis_12_two_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_intestinihominis_12_empirical,
#             b_intestinihominis_12_one_epoch,
#             b_intestinihominis_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. intestinihominis Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_intestinihominis_12_empirical),
#             proportional_sfs(b_intestinihominis_12_one_epoch),
#             proportional_sfs(b_intestinihominis_12_two_epoch)) +
#   ggtitle('B. intestinihominis Downsampled to 12')
# 
# 
# 
# # B. ovatus
# plot_likelihood_surface('../Analysis/qp_gut_12/b_ovatus_12.csv')
# b_ovatus_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_12/empirical_sfs.txt'
# )
# b_ovatus_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_12/one_epoch_demography.txt'
# )
# b_ovatus_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_ovatus_12_empirical,
#             b_ovatus_12_one_epoch,
#             b_ovatus_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. ovatus Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_ovatus_12_empirical),
#             proportional_sfs(b_ovatus_12_one_epoch),
#             proportional_sfs(b_ovatus_12_two_epoch)) +
#   ggtitle('B. ovatus Downsampled to 12')
# 
# 
# # B. thetaiotaomicron
# plot_likelihood_surface('../Analysis/qp_gut_12/b_thetaiotaomicron_12.csv')
# b_thetaiotaomicron_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_12/empirical_sfs.txt'
# )
# b_thetaiotaomicron_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_12/one_epoch_demography.txt'
# )
# b_thetaiotaomicron_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_thetaiotaomicron_12_empirical,
#             b_thetaiotaomicron_12_one_epoch,
#             b_thetaiotaomicron_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. thetaiotaomicron Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_thetaiotaomicron_12_empirical),
#             proportional_sfs(b_thetaiotaomicron_12_one_epoch),
#             proportional_sfs(b_thetaiotaomicron_12_two_epoch)) +
#   ggtitle('B. thetaiotaomicron Downsampled to 12')
# 
# 
# # B. uniformis
# plot_likelihood_surface('../Analysis/qp_gut_12/b_uniformis_12.csv')
# b_uniformis_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_12/empirical_sfs.txt'
# )
# b_uniformis_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_12/one_epoch_demography.txt'
# )
# b_uniformis_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_uniformis_12_empirical,
#             b_uniformis_12_one_epoch,
#             b_uniformis_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. uniformis Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_uniformis_12_empirical),
#             proportional_sfs(b_uniformis_12_one_epoch),
#             proportional_sfs(b_uniformis_12_two_epoch)) +
#   ggtitle('B. uniformis Downsampled to 12')
# 
# 
# # B. vulgatus
# plot_likelihood_surface('../Analysis/qp_gut_12/b_vulgatus_12.csv')
# b_vulgatus_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_12/empirical_sfs.txt'
# )
# b_vulgatus_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_12/one_epoch_demography.txt'
# )
# b_vulgatus_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_vulgatus_12_empirical,
#             b_vulgatus_12_one_epoch,
#             b_vulgatus_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. vulgatus Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_vulgatus_12_empirical),
#             proportional_sfs(b_vulgatus_12_one_epoch),
#             proportional_sfs(b_vulgatus_12_two_epoch)) +
#   ggtitle('B. vulgatus Downsampled to 12')
# 
# 
# 
# # B. xylanisolvens
# plot_likelihood_surface('../Analysis/qp_gut_12/b_xylanisolvens_12.csv')
# b_xylanisolvens_12_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_12/empirical_sfs.txt'
# )
# b_xylanisolvens_12_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_12/one_epoch_demography.txt'
# )
# b_xylanisolvens_12_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(b_xylanisolvens_12_empirical,
#             b_xylanisolvens_12_one_epoch,
#             b_xylanisolvens_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. xylanisolvens Downsampled to 12')
# 
# compare_sfs(proportional_sfs(b_xylanisolvens_12_empirical),
#             proportional_sfs(b_xylanisolvens_12_one_epoch),
#             proportional_sfs(b_xylanisolvens_12_two_epoch)) +
#   ggtitle('B. xylanisolvens Downsampled to 12')
# 
# 
# 
# # D. invisus
# plot_likelihood_surface('../Analysis/qp_gut_12/d_invisus_12.csv')
# d_invisus_12_empirical =  read_input_sfs(
#   '../Analysis/Dialister_invisus_61905_downsampled_12/empirical_sfs.txt'
# )
# d_invisus_12_one_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_12/one_epoch_demography.txt'
# )
# d_invisus_12_two_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(d_invisus_12_empirical,
#             d_invisus_12_one_epoch,
#             d_invisus_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('D. invisus Downsampled to 12')
# 
# compare_sfs(proportional_sfs(d_invisus_12_empirical),
#             proportional_sfs(d_invisus_12_one_epoch),
#             proportional_sfs(d_invisus_12_two_epoch)) +
#   ggtitle('D. invisus Downsampled to 12')
# 
# 
# # E. eligens
# plot_likelihood_surface('../Analysis/qp_gut_12/e_eligens_12.csv')
# e_eligens_12_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_12/empirical_sfs.txt'
# )
# e_eligens_12_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_12/one_epoch_demography.txt'
# )
# e_eligens_12_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(e_eligens_12_empirical,
#             e_eligens_12_one_epoch,
#             e_eligens_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. eligens Downsampled to 12')
# 
# compare_sfs(proportional_sfs(e_eligens_12_empirical),
#             proportional_sfs(e_eligens_12_one_epoch),
#             proportional_sfs(e_eligens_12_two_epoch)) +
#   ggtitle('E. eligens Downsampled to 12')
# 
# 
# 
# # E. rectale
# plot_likelihood_surface('../Analysis/qp_gut_12/e_rectale_12.csv')
# e_rectale_12_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_12/empirical_sfs.txt'
# )
# e_rectale_12_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_12/one_epoch_demography.txt'
# )
# e_rectale_12_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(e_rectale_12_empirical,
#             e_rectale_12_one_epoch,
#             e_rectale_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. rectale Downsampled to 12')
# 
# compare_sfs(proportional_sfs(e_rectale_12_empirical),
#             proportional_sfs(e_rectale_12_one_epoch),
#             proportional_sfs(e_rectale_12_two_epoch)) +
#   ggtitle('E. rectale Downsampled to 12')
# 
# 
# # F. prausnitzii
# plot_likelihood_surface('../Analysis/qp_gut_12/f_prausnitzii_12.csv')
# f_prausnitzii_12_empirical =  read_input_sfs(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_12/empirical_sfs.txt'
# )
# f_prausnitzii_12_one_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_12/one_epoch_demography.txt'
# )
# f_prausnitzii_12_two_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(f_prausnitzii_12_empirical,
#             f_prausnitzii_12_one_epoch,
#             f_prausnitzii_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('F. prausnitzii Downsampled to 12')
# 
# compare_sfs(proportional_sfs(f_prausnitzii_12_empirical),
#             proportional_sfs(f_prausnitzii_12_one_epoch),
#             proportional_sfs(f_prausnitzii_12_two_epoch)) +
#   ggtitle('F. prausnitzii Downsampled to 12')
# 
# 
# # Oscillibacter sp.
# plot_likelihood_surface('../Analysis/qp_gut_12/oscillibacter_sp_12.csv')
# oscillibacter_sp_12_empirical =  read_input_sfs(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_12/empirical_sfs.txt'
# )
# oscillibacter_sp_12_one_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_12/one_epoch_demography.txt'
# )
# oscillibacter_sp_12_two_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(oscillibacter_sp_12_empirical,
#             oscillibacter_sp_12_one_epoch,
#             oscillibacter_sp_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Oscillibacter sp. Downsampled to 12')
# 
# compare_sfs(proportional_sfs(oscillibacter_sp_12_empirical),
#             proportional_sfs(oscillibacter_sp_12_one_epoch),
#             proportional_sfs(oscillibacter_sp_12_two_epoch)) +
#   ggtitle('Oscillibacter sp. Downsampled to 12')
# 
# 
# # o. splanchnicus
# plot_likelihood_surface('../Analysis/qp_gut_12/o_splanchnicus_12.csv')
# o_splanchnicus_12_empirical =  read_input_sfs(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_12/empirical_sfs.txt'
# )
# o_splanchnicus_12_one_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_12/one_epoch_demography.txt'
# )
# o_splanchnicus_12_two_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(o_splanchnicus_12_empirical,
#             o_splanchnicus_12_one_epoch,
#             o_splanchnicus_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('O. splanchnicus Downsampled to 12')
# 
# compare_sfs(proportional_sfs(o_splanchnicus_12_empirical),
#             proportional_sfs(o_splanchnicus_12_one_epoch),
#             proportional_sfs(o_splanchnicus_12_two_epoch)) +
#   ggtitle('O. splanchnicus Downsampled to 12')
# 
# 
# # P. copri
# plot_likelihood_surface('../Analysis/qp_gut_12/p_copri_12.csv')
# p_copri_12_empirical =  read_input_sfs(
#   '../Analysis/Prevotella_copri_61740_downsampled_12/empirical_sfs.txt'
# )
# p_copri_12_one_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_12/one_epoch_demography.txt'
# )
# p_copri_12_two_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(p_copri_12_empirical,
#             p_copri_12_one_epoch,
#             p_copri_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. copri Downsampled to 12')
# 
# compare_sfs(proportional_sfs(p_copri_12_empirical),
#             proportional_sfs(p_copri_12_one_epoch),
#             proportional_sfs(p_copri_12_two_epoch)) +
#   ggtitle('P. copri Downsampled to 12')
# 
# 
# # P. distasonis
# plot_likelihood_surface('../Analysis/qp_gut_12/p_distasonis_12.csv')
# p_distasonis_12_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_12/empirical_sfs.txt'
# )
# p_distasonis_12_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_12/one_epoch_demography.txt'
# )
# p_distasonis_12_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(p_distasonis_12_empirical,
#             p_distasonis_12_one_epoch,
#             p_distasonis_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. distasonis Downsampled to 12')
# 
# compare_sfs(proportional_sfs(p_distasonis_12_empirical),
#             proportional_sfs(p_distasonis_12_one_epoch),
#             proportional_sfs(p_distasonis_12_two_epoch)) +
#   ggtitle('P. distasonis Downsampled to 12')
# 
# 
# # P. merdae
# plot_likelihood_surface('../Analysis/qp_gut_12/p_merdae_12.csv')
# p_merdae_12_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_12/empirical_sfs.txt'
# )
# p_merdae_12_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_12/one_epoch_demography.txt'
# )
# p_merdae_12_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(p_merdae_12_empirical,
#             p_merdae_12_one_epoch,
#             p_merdae_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. merdae Downsampled to 12')
# 
# compare_sfs(proportional_sfs(p_merdae_12_empirical),
#             proportional_sfs(p_merdae_12_one_epoch),
#             proportional_sfs(p_merdae_12_two_epoch)) +
#   ggtitle('P. merdae Downsampled to 12')
# 
# 
# # Phascolarctobacterium sp.
# plot_likelihood_surface('../Analysis/qp_gut_12/phascolarctobacterium_sp_12.csv')
# phascolarctobacterium_sp_12_empirical =  read_input_sfs(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_12/empirical_sfs.txt'
# )
# phascolarctobacterium_sp_12_one_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_12/one_epoch_demography.txt'
# )
# phascolarctobacterium_sp_12_two_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(phascolarctobacterium_sp_12_empirical,
#             phascolarctobacterium_sp_12_one_epoch,
#             phascolarctobacterium_sp_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 12')
# 
# compare_sfs(proportional_sfs(phascolarctobacterium_sp_12_empirical),
#             proportional_sfs(phascolarctobacterium_sp_12_one_epoch),
#             proportional_sfs(phascolarctobacterium_sp_12_two_epoch)) +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 12')
# 
# 
# # R. bicirculans
# plot_likelihood_surface('../Analysis/qp_gut_12/r_bicirculans_12.csv')
# r_bicirculans_12_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_12/empirical_sfs.txt'
# )
# r_bicirculans_12_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_12/one_epoch_demography.txt'
# )
# r_bicirculans_12_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(r_bicirculans_12_empirical,
#             r_bicirculans_12_one_epoch,
#             r_bicirculans_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bicirculans Downsampled to 12')
# 
# compare_sfs(proportional_sfs(r_bicirculans_12_empirical),
#             proportional_sfs(r_bicirculans_12_one_epoch),
#             proportional_sfs(r_bicirculans_12_two_epoch)) +
#   ggtitle('R. bicirculans Downsampled to 12')
# 
# # R. bromii
# plot_likelihood_surface('../Analysis/qp_gut_12/r_bromii_12.csv')
# r_bromii_12_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_12/empirical_sfs.txt'
# )
# r_bromii_12_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_12/one_epoch_demography.txt'
# )
# r_bromii_12_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_12/two_epoch_demography.txt'
# )
# compare_sfs(r_bromii_12_empirical,
#             r_bromii_12_one_epoch,
#             r_bromii_12_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bromii Downsampled to 12')
# 
# compare_sfs(proportional_sfs(r_bromii_12_empirical),
#             proportional_sfs(r_bromii_12_one_epoch),
#             proportional_sfs(r_bromii_12_two_epoch)) +
#   ggtitle('R. bromii Downsampled to 12')

# # Downsampled to 14
# 
# # A. finegoldii
# plot_likelihood_surface('../Analysis/qp_gut_14/a_finegoldii_14.csv')
# a_finegoldii_14_empirical = read_input_sfs_original(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_14/empirical_sfs.txt'
# )
# a_finegoldii_14_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_14/one_epoch_demography.txt'
# )
# a_finegoldii_14_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_14/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_finegoldii_14_empirical,
#             a_finegoldii_14_one_epoch,
#             a_finegoldii_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. finegoldii Downsampled to 14')
# 
# compare_sfs(proportional_sfs(a_finegoldii_14_empirical),
#             proportional_sfs(a_finegoldii_14_one_epoch),
#             proportional_sfs(a_finegoldii_14_two_epoch)) +
#   ggtitle('A. finegoldii Downsampled to 14')
# 
# # A. muciniphila
# plot_likelihood_surface('../Analysis/qp_gut_14/a_muciniphila_14.csv')
# a_muciniphila_14_empirical = read_input_sfs_original(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/empirical_sfs.txt'
# )
# a_muciniphila_14_one_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/one_epoch_demography.txt'
# )
# a_muciniphila_14_two_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(a_muciniphila_14_empirical,
#             a_muciniphila_14_one_epoch,
#             a_muciniphila_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. muciniphila Downsampled to 14')
# 
# compare_sfs(proportional_sfs(a_muciniphila_14_empirical),
#             proportional_sfs(a_muciniphila_14_one_epoch),
#             proportional_sfs(a_muciniphila_14_two_epoch)) +
#   ggtitle('A. muciniphila Downsampled to 14')
# 
# 
# # A. onderdonkii
# plot_likelihood_surface('../Analysis/qp_gut_14/a_onderdonkii_14.csv')
# a_onderdonkii_14_empirical = read_input_sfs_original(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/empirical_sfs.txt'
# )
# a_onderdonkii_14_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/one_epoch_demography.txt'
# )
# a_onderdonkii_14_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_onderdonkii_14_empirical,
#             a_onderdonkii_14_one_epoch,
#             a_onderdonkii_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. onderdonkii Downsampled to 14')
# 
# compare_sfs(proportional_sfs(a_onderdonkii_14_empirical),
#             proportional_sfs(a_onderdonkii_14_one_epoch),
#             proportional_sfs(a_onderdonkii_14_two_epoch)) +
#   ggtitle('A. onderdonkii Downsampled to 14')
# 
# 
# # A. putredinis
# plot_likelihood_surface('../Analysis/qp_gut_14/a_putredinis_14.csv')
# a_putredinis_14_empirical = read_input_sfs_original(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_14/empirical_sfs.txt'
# )
# a_putredinis_14_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_14/one_epoch_demography.txt'
# )
# a_putredinis_14_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(a_putredinis_14_empirical,
#             a_putredinis_14_one_epoch,
#             a_putredinis_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. putredinis Downsampled to 14')
# 
# compare_sfs(proportional_sfs(a_putredinis_14_empirical),
#             proportional_sfs(a_putredinis_14_one_epoch),
#             proportional_sfs(a_putredinis_14_two_epoch)) +
#   ggtitle('A. putredinis Downsampled to 14')
# 
# 
# 
# # A. shahii
# plot_likelihood_surface('../Analysis/qp_gut_14/a_shahii_14.csv')
# a_shahii_14_empirical = read_input_sfs_original(
#   '../Analysis/Alistipes_shahii_62199_downsampled_14/empirical_sfs.txt'
# )
# a_shahii_14_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_14/one_epoch_demography.txt'
# )
# a_shahii_14_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(a_shahii_14_empirical,
#             a_shahii_14_one_epoch,
#             a_shahii_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. shahii Downsampled to 14')
# 
# compare_sfs(proportional_sfs(a_shahii_14_empirical),
#             proportional_sfs(a_shahii_14_one_epoch),
#             proportional_sfs(a_shahii_14_two_epoch)) +
#   ggtitle('A. shahii Downsampled to 14')
# 
# 
# # B. bacterium
# plot_likelihood_surface('../Analysis/qp_gut_14/b_bacterium_14.csv')
# b_bacterium_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/empirical_sfs.txt'
# )
# b_bacterium_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/one_epoch_demography.txt'
# )
# b_bacterium_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_bacterium_14_empirical,
#             b_bacterium_14_one_epoch,
#             b_bacterium_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. bacterium Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_bacterium_14_empirical),
#             proportional_sfs(b_bacterium_14_one_epoch),
#             proportional_sfs(b_bacterium_14_two_epoch)) +
#   ggtitle('B. bacterium Downsampled to 14')
# 
# # B. caccae
# plot_likelihood_surface('../Analysis/qp_gut_14/b_caccae_14.csv')
# b_caccae_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_14/empirical_sfs.txt'
# )
# b_caccae_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_14/one_epoch_demography.txt'
# )
# b_caccae_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_caccae_14_empirical,
#             b_caccae_14_one_epoch,
#             b_caccae_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. caccae Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_caccae_14_empirical),
#             proportional_sfs(b_caccae_14_one_epoch),
#             proportional_sfs(b_caccae_14_two_epoch)) +
#   ggtitle('B. caccae Downsampled to 14')
# 
# # B. cellulosilyticus
# plot_likelihood_surface('../Analysis/qp_gut_14/b_cellulosilyticus_14.csv')
# b_cellulosilyticus_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/empirical_sfs.txt'
# )
# b_cellulosilyticus_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/one_epoch_demography.txt'
# )
# b_cellulosilyticus_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_cellulosilyticus_14_empirical,
#             b_cellulosilyticus_14_one_epoch,
#             b_cellulosilyticus_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. cellulosilyticus Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_cellulosilyticus_14_empirical),
#             proportional_sfs(b_cellulosilyticus_14_one_epoch),
#             proportional_sfs(b_cellulosilyticus_14_two_epoch)) +
#   ggtitle('B. cellulosilyticus Downsampled to 14')
# 
# 
# #  B. fragilis
# plot_likelihood_surface('../Analysis/qp_gut_14/b_fragilis_14.csv')
# b_fragilis_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_14/empirical_sfs.txt'
# )
# b_fragilis_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_14/one_epoch_demography.txt'
# )
# b_fragilis_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_fragilis_14_empirical,
#             b_fragilis_14_one_epoch,
#             b_fragilis_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. fragilis Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_fragilis_14_empirical),
#             proportional_sfs(b_fragilis_14_one_epoch),
#             proportional_sfs(b_fragilis_14_two_epoch)) +
#   ggtitle('B. fragilis Downsampled to 14')
# 
# 
# # B. intestinihominis
# plot_likelihood_surface('../Analysis/qp_gut_14/b_intestinihominis_14.csv')
# b_intestinihominis_14_empirical = read_input_sfs_original(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/empirical_sfs.txt'
# )
# b_intestinihominis_14_one_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/one_epoch_demography.txt'
# )
# b_intestinihominis_14_two_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_intestinihominis_14_empirical,
#             b_intestinihominis_14_one_epoch,
#             b_intestinihominis_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. intestinihominis Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_intestinihominis_14_empirical),
#             proportional_sfs(b_intestinihominis_14_one_epoch),
#             proportional_sfs(b_intestinihominis_14_two_epoch)) +
#   ggtitle('B. intestinihominis Downsampled to 14')
# 
# 
# 
# # B. ovatus
# plot_likelihood_surface('../Analysis/qp_gut_14/b_ovatus_14.csv')
# b_ovatus_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_14/empirical_sfs.txt'
# )
# b_ovatus_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_14/one_epoch_demography.txt'
# )
# b_ovatus_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_ovatus_14_empirical,
#             b_ovatus_14_one_epoch,
#             b_ovatus_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. ovatus Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_ovatus_14_empirical),
#             proportional_sfs(b_ovatus_14_one_epoch),
#             proportional_sfs(b_ovatus_14_two_epoch)) +
#   ggtitle('B. ovatus Downsampled to 14')
# 
# 
# # B. thetaiotaomicron
# plot_likelihood_surface('../Analysis/qp_gut_14/b_thetaiotaomicron_14.csv')
# b_thetaiotaomicron_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/empirical_sfs.txt'
# )
# b_thetaiotaomicron_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/one_epoch_demography.txt'
# )
# b_thetaiotaomicron_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_thetaiotaomicron_14_empirical,
#             b_thetaiotaomicron_14_one_epoch,
#             b_thetaiotaomicron_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. thetaiotaomicron Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_thetaiotaomicron_14_empirical),
#             proportional_sfs(b_thetaiotaomicron_14_one_epoch),
#             proportional_sfs(b_thetaiotaomicron_14_two_epoch)) +
#   ggtitle('B. thetaiotaomicron Downsampled to 14')
# 
# 
# # B. uniformis
# plot_likelihood_surface('../Analysis/qp_gut_14/b_uniformis_14.csv')
# b_uniformis_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_14/empirical_sfs.txt'
# )
# b_uniformis_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_14/one_epoch_demography.txt'
# )
# b_uniformis_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_uniformis_14_empirical,
#             b_uniformis_14_one_epoch,
#             b_uniformis_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. uniformis Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_uniformis_14_empirical),
#             proportional_sfs(b_uniformis_14_one_epoch),
#             proportional_sfs(b_uniformis_14_two_epoch)) +
#   ggtitle('B. uniformis Downsampled to 14')
# 
# 
# # B. vulgatus
# plot_likelihood_surface('../Analysis/qp_gut_14/b_vulgatus_14.csv')
# b_vulgatus_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/empirical_sfs.txt'
# )
# b_vulgatus_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/one_epoch_demography.txt'
# )
# b_vulgatus_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_vulgatus_14_empirical,
#             b_vulgatus_14_one_epoch,
#             b_vulgatus_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. vulgatus Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_vulgatus_14_empirical),
#             proportional_sfs(b_vulgatus_14_one_epoch),
#             proportional_sfs(b_vulgatus_14_two_epoch)) +
#   ggtitle('B. vulgatus Downsampled to 14')
# 
# 
# 
# # B. xylanisolvens
# plot_likelihood_surface('../Analysis/qp_gut_14/b_xylanisolvens_14.csv')
# b_xylanisolvens_14_empirical = read_input_sfs_original(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/empirical_sfs.txt'
# )
# b_xylanisolvens_14_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/one_epoch_demography.txt'
# )
# b_xylanisolvens_14_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(b_xylanisolvens_14_empirical,
#             b_xylanisolvens_14_one_epoch,
#             b_xylanisolvens_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. xylanisolvens Downsampled to 14')
# 
# compare_sfs(proportional_sfs(b_xylanisolvens_14_empirical),
#             proportional_sfs(b_xylanisolvens_14_one_epoch),
#             proportional_sfs(b_xylanisolvens_14_two_epoch)) +
#   ggtitle('B. xylanisolvens Downsampled to 14')
# 
# 
# 
# # D. invisus
# plot_likelihood_surface('../Analysis/qp_gut_14/d_invisus_14.csv')
# d_invisus_14_empirical = read_input_sfs_original(
#   '../Analysis/Dialister_invisus_61905_downsampled_14/empirical_sfs.txt'
# )
# d_invisus_14_one_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_14/one_epoch_demography.txt'
# )
# d_invisus_14_two_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(d_invisus_14_empirical,
#             d_invisus_14_one_epoch,
#             d_invisus_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('D. invisus Downsampled to 14')
# 
# compare_sfs(proportional_sfs(d_invisus_14_empirical),
#             proportional_sfs(d_invisus_14_one_epoch),
#             proportional_sfs(d_invisus_14_two_epoch)) +
#   ggtitle('D. invisus Downsampled to 14')
# 
# 
# # E. eligens
# plot_likelihood_surface('../Analysis/qp_gut_14/e_eligens_14.csv')
# e_eligens_14_empirical = read_input_sfs_original(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_14/empirical_sfs.txt'
# )
# e_eligens_14_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_14/one_epoch_demography.txt'
# )
# e_eligens_14_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(e_eligens_14_empirical,
#             e_eligens_14_one_epoch,
#             e_eligens_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. eligens Downsampled to 14')
# 
# compare_sfs(proportional_sfs(e_eligens_14_empirical),
#             proportional_sfs(e_eligens_14_one_epoch),
#             proportional_sfs(e_eligens_14_two_epoch)) +
#   ggtitle('E. eligens Downsampled to 14')
# 
# 
# 
# # E. rectale
# plot_likelihood_surface('../Analysis/qp_gut_14/e_rectale_14.csv')
# e_rectale_14_empirical = read_input_sfs_original(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_14/empirical_sfs.txt'
# )
# e_rectale_14_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_14/one_epoch_demography.txt'
# )
# e_rectale_14_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(e_rectale_14_empirical,
#             e_rectale_14_one_epoch,
#             e_rectale_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. rectale Downsampled to 14')
# 
# compare_sfs(proportional_sfs(e_rectale_14_empirical),
#             proportional_sfs(e_rectale_14_one_epoch),
#             proportional_sfs(e_rectale_14_two_epoch)) +
#   ggtitle('E. rectale Downsampled to 14')
# 
# 
# # F. prausnitzii
# plot_likelihood_surface('../Analysis/qp_gut_14/f_prausnitzii_14.csv')
# f_prausnitzii_14_empirical = read_input_sfs_original(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/empirical_sfs.txt'
# )
# f_prausnitzii_14_one_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/one_epoch_demography.txt'
# )
# f_prausnitzii_14_two_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(f_prausnitzii_14_empirical,
#             f_prausnitzii_14_one_epoch,
#             f_prausnitzii_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('F. prausnitzii Downsampled to 14')
# 
# compare_sfs(proportional_sfs(f_prausnitzii_14_empirical),
#             proportional_sfs(f_prausnitzii_14_one_epoch),
#             proportional_sfs(f_prausnitzii_14_two_epoch)) +
#   ggtitle('F. prausnitzii Downsampled to 14')
# 
# 
# # Oscillibacter sp.
# plot_likelihood_surface('../Analysis/qp_gut_14/oscillibacter_sp_14.csv')
# oscillibacter_sp_14_empirical = read_input_sfs_original(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_14/empirical_sfs.txt'
# )
# oscillibacter_sp_14_one_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_14/one_epoch_demography.txt'
# )
# oscillibacter_sp_14_two_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(oscillibacter_sp_14_empirical,
#             oscillibacter_sp_14_one_epoch,
#             oscillibacter_sp_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Oscillibacter sp. Downsampled to 14')
# 
# compare_sfs(proportional_sfs(oscillibacter_sp_14_empirical),
#             proportional_sfs(oscillibacter_sp_14_one_epoch),
#             proportional_sfs(oscillibacter_sp_14_two_epoch)) +
#   ggtitle('Oscillibacter sp. Downsampled to 14')
# 
# 
# # o. splanchnicus
# plot_likelihood_surface('../Analysis/qp_gut_14/o_splanchnicus_14.csv')
# o_splanchnicus_14_empirical = read_input_sfs_original(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/empirical_sfs.txt'
# )
# o_splanchnicus_14_one_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/one_epoch_demography.txt'
# )
# o_splanchnicus_14_two_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(o_splanchnicus_14_empirical,
#             o_splanchnicus_14_one_epoch,
#             o_splanchnicus_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('O. splanchnicus Downsampled to 14')
# 
# compare_sfs(proportional_sfs(o_splanchnicus_14_empirical),
#             proportional_sfs(o_splanchnicus_14_one_epoch),
#             proportional_sfs(o_splanchnicus_14_two_epoch)) +
#   ggtitle('O. splanchnicus Downsampled to 14')
# 
# 
# # P. copri
# plot_likelihood_surface('../Analysis/qp_gut_14/p_copri_14.csv')
# p_copri_14_empirical = read_input_sfs_original(
#   '../Analysis/Prevotella_copri_61740_downsampled_14/empirical_sfs.txt'
# )
# p_copri_14_one_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_14/one_epoch_demography.txt'
# )
# p_copri_14_two_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(p_copri_14_empirical,
#             p_copri_14_one_epoch,
#             p_copri_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. copri Downsampled to 14')
# 
# compare_sfs(proportional_sfs(p_copri_14_empirical),
#             proportional_sfs(p_copri_14_one_epoch),
#             proportional_sfs(p_copri_14_two_epoch)) +
#   ggtitle('P. copri Downsampled to 14')
# 
# 
# # P. distasonis
# plot_likelihood_surface('../Analysis/qp_gut_14/p_distasonis_14.csv')
# p_distasonis_14_empirical = read_input_sfs_original(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/empirical_sfs.txt'
# )
# p_distasonis_14_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/one_epoch_demography.txt'
# )
# p_distasonis_14_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(p_distasonis_14_empirical,
#             p_distasonis_14_one_epoch,
#             p_distasonis_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. distasonis Downsampled to 14')
# 
# compare_sfs(proportional_sfs(p_distasonis_14_empirical),
#             proportional_sfs(p_distasonis_14_one_epoch),
#             proportional_sfs(p_distasonis_14_two_epoch)) +
#   ggtitle('P. distasonis Downsampled to 14')
# 
# 
# # P. merdae
# plot_likelihood_surface('../Analysis/qp_gut_14/p_merdae_14.csv')
# p_merdae_14_empirical = read_input_sfs_original(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_14/empirical_sfs.txt'
# )
# p_merdae_14_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_14/one_epoch_demography.txt'
# )
# p_merdae_14_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(p_merdae_14_empirical,
#             p_merdae_14_one_epoch,
#             p_merdae_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. merdae Downsampled to 14')
# 
# compare_sfs(proportional_sfs(p_merdae_14_empirical),
#             proportional_sfs(p_merdae_14_one_epoch),
#             proportional_sfs(p_merdae_14_two_epoch)) +
#   ggtitle('P. merdae Downsampled to 14')
# 
# 
# # Phascolarctobacterium sp.
# plot_likelihood_surface('../Analysis/qp_gut_14/phascolarctobacterium_sp_14.csv')
# phascolarctobacterium_sp_14_empirical = read_input_sfs_original(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/empirical_sfs.txt'
# )
# phascolarctobacterium_sp_14_one_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/one_epoch_demography.txt'
# )
# phascolarctobacterium_sp_14_two_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(phascolarctobacterium_sp_14_empirical,
#             phascolarctobacterium_sp_14_one_epoch,
#             phascolarctobacterium_sp_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 14')
# 
# compare_sfs(proportional_sfs(phascolarctobacterium_sp_14_empirical),
#             proportional_sfs(phascolarctobacterium_sp_14_one_epoch),
#             proportional_sfs(phascolarctobacterium_sp_14_two_epoch)) +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 14')
# 
# 
# # R. bicirculans
# plot_likelihood_surface('../Analysis/qp_gut_14/r_bicirculans_14.csv')
# r_bicirculans_14_empirical = read_input_sfs_original(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/empirical_sfs.txt'
# )
# r_bicirculans_14_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/one_epoch_demography.txt'
# )
# r_bicirculans_14_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(r_bicirculans_14_empirical,
#             r_bicirculans_14_one_epoch,
#             r_bicirculans_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bicirculans Downsampled to 14')
# 
# compare_sfs(proportional_sfs(r_bicirculans_14_empirical),
#             proportional_sfs(r_bicirculans_14_one_epoch),
#             proportional_sfs(r_bicirculans_14_two_epoch)) +
#   ggtitle('R. bicirculans Downsampled to 14')
# 
# # R. bromii
# plot_likelihood_surface('../Analysis/qp_gut_14/r_bromii_14.csv')
# r_bromii_14_empirical = read_input_sfs_original(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_14/empirical_sfs.txt'
# )
# r_bromii_14_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_14/one_epoch_demography.txt'
# )
# r_bromii_14_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_14/two_epoch_demography.txt'
# )
# compare_sfs(r_bromii_14_empirical,
#             r_bromii_14_one_epoch,
#             r_bromii_14_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bromii Downsampled to 14')
# 
# compare_sfs(proportional_sfs(r_bromii_14_empirical),
#             proportional_sfs(r_bromii_14_one_epoch),
#             proportional_sfs(r_bromii_14_two_epoch)) +
#   ggtitle('R. bromii Downsampled to 14')

# 
# # Downsampled to 16
# 
# # A. finegoldii
# plot_likelihood_surface('../Analysis/qp_gut_16/a_finegoldii_16.csv')
# a_finegoldii_16_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_16/empirical_sfs.txt'
# )
# a_finegoldii_16_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_16/one_epoch_demography.txt'
# )
# a_finegoldii_16_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_16/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_finegoldii_16_empirical,
#             a_finegoldii_16_one_epoch,
#             a_finegoldii_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. finegoldii Downsampled to 16')
# 
# compare_sfs(proportional_sfs(a_finegoldii_16_empirical),
#             proportional_sfs(a_finegoldii_16_one_epoch),
#             proportional_sfs(a_finegoldii_16_two_epoch)) +
#   ggtitle('A. finegoldii Downsampled to 16')
# 
# # A. muciniphila
# plot_likelihood_surface('../Analysis/qp_gut_16/a_muciniphila_16.csv')
# a_muciniphila_16_empirical =  read_input_sfs(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_16/empirical_sfs.txt'
# )
# a_muciniphila_16_one_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_16/one_epoch_demography.txt'
# )
# a_muciniphila_16_two_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(a_muciniphila_16_empirical,
#             a_muciniphila_16_one_epoch,
#             a_muciniphila_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. muciniphila Downsampled to 16')
# 
# compare_sfs(proportional_sfs(a_muciniphila_16_empirical),
#             proportional_sfs(a_muciniphila_16_one_epoch),
#             proportional_sfs(a_muciniphila_16_two_epoch)) +
#   ggtitle('A. muciniphila Downsampled to 16')
# 
# 
# # A. onderdonkii
# plot_likelihood_surface('../Analysis/qp_gut_16/a_onderdonkii_16.csv')
# a_onderdonkii_16_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_16/empirical_sfs.txt'
# )
# a_onderdonkii_16_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_16/one_epoch_demography.txt'
# )
# a_onderdonkii_16_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_16/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_onderdonkii_16_empirical,
#             a_onderdonkii_16_one_epoch,
#             a_onderdonkii_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. onderdonkii Downsampled to 16')
# 
# compare_sfs(proportional_sfs(a_onderdonkii_16_empirical),
#             proportional_sfs(a_onderdonkii_16_one_epoch),
#             proportional_sfs(a_onderdonkii_16_two_epoch)) +
#   ggtitle('A. onderdonkii Downsampled to 16')
# 
# 
# # A. putredinis
# plot_likelihood_surface('../Analysis/qp_gut_16/a_putredinis_16.csv')
# a_putredinis_16_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_16/empirical_sfs.txt'
# )
# a_putredinis_16_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_16/one_epoch_demography.txt'
# )
# a_putredinis_16_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(a_putredinis_16_empirical,
#             a_putredinis_16_one_epoch,
#             a_putredinis_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. putredinis Downsampled to 16')
# 
# compare_sfs(proportional_sfs(a_putredinis_16_empirical),
#             proportional_sfs(a_putredinis_16_one_epoch),
#             proportional_sfs(a_putredinis_16_two_epoch)) +
#   ggtitle('A. putredinis Downsampled to 16')
# 
# 
# 
# # A. shahii
# plot_likelihood_surface('../Analysis/qp_gut_16/a_shahii_16.csv')
# a_shahii_16_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_shahii_62199_downsampled_16/empirical_sfs.txt'
# )
# a_shahii_16_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_16/one_epoch_demography.txt'
# )
# a_shahii_16_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(a_shahii_16_empirical,
#             a_shahii_16_one_epoch,
#             a_shahii_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. shahii Downsampled to 16')
# 
# compare_sfs(proportional_sfs(a_shahii_16_empirical),
#             proportional_sfs(a_shahii_16_one_epoch),
#             proportional_sfs(a_shahii_16_two_epoch)) +
#   ggtitle('A. shahii Downsampled to 16')
# 
# 
# # B. bacterium
# plot_likelihood_surface('../Analysis/qp_gut_16/b_bacterium_16.csv')
# b_bacterium_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_16/empirical_sfs.txt'
# )
# b_bacterium_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_16/one_epoch_demography.txt'
# )
# b_bacterium_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_bacterium_16_empirical,
#             b_bacterium_16_one_epoch,
#             b_bacterium_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. bacterium Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_bacterium_16_empirical),
#             proportional_sfs(b_bacterium_16_one_epoch),
#             proportional_sfs(b_bacterium_16_two_epoch)) +
#   ggtitle('B. bacterium Downsampled to 16')
# 
# # B. caccae
# plot_likelihood_surface('../Analysis/qp_gut_16/b_caccae_16.csv')
# b_caccae_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_16/empirical_sfs.txt'
# )
# b_caccae_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_16/one_epoch_demography.txt'
# )
# b_caccae_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_caccae_16_empirical,
#             b_caccae_16_one_epoch,
#             b_caccae_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. caccae Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_caccae_16_empirical),
#             proportional_sfs(b_caccae_16_one_epoch),
#             proportional_sfs(b_caccae_16_two_epoch)) +
#   ggtitle('B. caccae Downsampled to 16')
# 
# # B. cellulosilyticus
# plot_likelihood_surface('../Analysis/qp_gut_16/b_cellulosilyticus_16.csv')
# b_cellulosilyticus_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_16/empirical_sfs.txt'
# )
# b_cellulosilyticus_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_16/one_epoch_demography.txt'
# )
# b_cellulosilyticus_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_cellulosilyticus_16_empirical,
#             b_cellulosilyticus_16_one_epoch,
#             b_cellulosilyticus_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. cellulosilyticus Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_cellulosilyticus_16_empirical),
#             proportional_sfs(b_cellulosilyticus_16_one_epoch),
#             proportional_sfs(b_cellulosilyticus_16_two_epoch)) +
#   ggtitle('B. cellulosilyticus Downsampled to 16')
# 
# 
# #  B. fragilis
# plot_likelihood_surface('../Analysis/qp_gut_16/b_fragilis_16.csv')
# b_fragilis_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_16/empirical_sfs.txt'
# )
# b_fragilis_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_16/one_epoch_demography.txt'
# )
# b_fragilis_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_fragilis_16_empirical,
#             b_fragilis_16_one_epoch,
#             b_fragilis_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. fragilis Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_fragilis_16_empirical),
#             proportional_sfs(b_fragilis_16_one_epoch),
#             proportional_sfs(b_fragilis_16_two_epoch)) +
#   ggtitle('B. fragilis Downsampled to 16')
# 
# 
# # B. intestinihominis
# plot_likelihood_surface('../Analysis/qp_gut_16/b_intestinihominis_16.csv')
# b_intestinihominis_16_empirical =  read_input_sfs(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_16/empirical_sfs.txt'
# )
# b_intestinihominis_16_one_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_16/one_epoch_demography.txt'
# )
# b_intestinihominis_16_two_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_intestinihominis_16_empirical,
#             b_intestinihominis_16_one_epoch,
#             b_intestinihominis_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. intestinihominis Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_intestinihominis_16_empirical),
#             proportional_sfs(b_intestinihominis_16_one_epoch),
#             proportional_sfs(b_intestinihominis_16_two_epoch)) +
#   ggtitle('B. intestinihominis Downsampled to 16')
# 
# 
# 
# # B. ovatus
# plot_likelihood_surface('../Analysis/qp_gut_16/b_ovatus_16.csv')
# b_ovatus_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_16/empirical_sfs.txt'
# )
# b_ovatus_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_16/one_epoch_demography.txt'
# )
# b_ovatus_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_ovatus_16_empirical,
#             b_ovatus_16_one_epoch,
#             b_ovatus_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. ovatus Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_ovatus_16_empirical),
#             proportional_sfs(b_ovatus_16_one_epoch),
#             proportional_sfs(b_ovatus_16_two_epoch)) +
#   ggtitle('B. ovatus Downsampled to 16')
# 
# 
# # B. thetaiotaomicron
# plot_likelihood_surface('../Analysis/qp_gut_16/b_thetaiotaomicron_16.csv')
# b_thetaiotaomicron_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_16/empirical_sfs.txt'
# )
# b_thetaiotaomicron_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_16/one_epoch_demography.txt'
# )
# b_thetaiotaomicron_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_thetaiotaomicron_16_empirical,
#             b_thetaiotaomicron_16_one_epoch,
#             b_thetaiotaomicron_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. thetaiotaomicron Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_thetaiotaomicron_16_empirical),
#             proportional_sfs(b_thetaiotaomicron_16_one_epoch),
#             proportional_sfs(b_thetaiotaomicron_16_two_epoch)) +
#   ggtitle('B. thetaiotaomicron Downsampled to 16')
# 
# 
# # B. uniformis
# plot_likelihood_surface('../Analysis/qp_gut_16/b_uniformis_16.csv')
# b_uniformis_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_16/empirical_sfs.txt'
# )
# b_uniformis_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_16/one_epoch_demography.txt'
# )
# b_uniformis_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_uniformis_16_empirical,
#             b_uniformis_16_one_epoch,
#             b_uniformis_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. uniformis Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_uniformis_16_empirical),
#             proportional_sfs(b_uniformis_16_one_epoch),
#             proportional_sfs(b_uniformis_16_two_epoch)) +
#   ggtitle('B. uniformis Downsampled to 16')
# 
# 
# # B. vulgatus
# plot_likelihood_surface('../Analysis/qp_gut_16/b_vulgatus_16.csv')
# b_vulgatus_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_16/empirical_sfs.txt'
# )
# b_vulgatus_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_16/one_epoch_demography.txt'
# )
# b_vulgatus_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_vulgatus_16_empirical,
#             b_vulgatus_16_one_epoch,
#             b_vulgatus_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. vulgatus Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_vulgatus_16_empirical),
#             proportional_sfs(b_vulgatus_16_one_epoch),
#             proportional_sfs(b_vulgatus_16_two_epoch)) +
#   ggtitle('B. vulgatus Downsampled to 16')
# 
# 
# 
# # B. xylanisolvens
# plot_likelihood_surface('../Analysis/qp_gut_16/b_xylanisolvens_16.csv')
# b_xylanisolvens_16_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_16/empirical_sfs.txt'
# )
# b_xylanisolvens_16_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_16/one_epoch_demography.txt'
# )
# b_xylanisolvens_16_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(b_xylanisolvens_16_empirical,
#             b_xylanisolvens_16_one_epoch,
#             b_xylanisolvens_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. xylanisolvens Downsampled to 16')
# 
# compare_sfs(proportional_sfs(b_xylanisolvens_16_empirical),
#             proportional_sfs(b_xylanisolvens_16_one_epoch),
#             proportional_sfs(b_xylanisolvens_16_two_epoch)) +
#   ggtitle('B. xylanisolvens Downsampled to 16')
# 
# 
# 
# # D. invisus
# plot_likelihood_surface('../Analysis/qp_gut_16/d_invisus_16.csv')
# d_invisus_16_empirical =  read_input_sfs(
#   '../Analysis/Dialister_invisus_61905_downsampled_16/empirical_sfs.txt'
# )
# d_invisus_16_one_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_16/one_epoch_demography.txt'
# )
# d_invisus_16_two_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(d_invisus_16_empirical,
#             d_invisus_16_one_epoch,
#             d_invisus_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('D. invisus Downsampled to 16')
# 
# compare_sfs(proportional_sfs(d_invisus_16_empirical),
#             proportional_sfs(d_invisus_16_one_epoch),
#             proportional_sfs(d_invisus_16_two_epoch)) +
#   ggtitle('D. invisus Downsampled to 16')
# 
# 
# # E. eligens
# plot_likelihood_surface('../Analysis/qp_gut_16/e_eligens_16.csv')
# e_eligens_16_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_16/empirical_sfs.txt'
# )
# e_eligens_16_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_16/one_epoch_demography.txt'
# )
# e_eligens_16_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(e_eligens_16_empirical,
#             e_eligens_16_one_epoch,
#             e_eligens_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. eligens Downsampled to 16')
# 
# compare_sfs(proportional_sfs(e_eligens_16_empirical),
#             proportional_sfs(e_eligens_16_one_epoch),
#             proportional_sfs(e_eligens_16_two_epoch)) +
#   ggtitle('E. eligens Downsampled to 16')
# 
# 
# 
# # E. rectale
# plot_likelihood_surface('../Analysis/qp_gut_16/e_rectale_16.csv')
# e_rectale_16_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_16/empirical_sfs.txt'
# )
# e_rectale_16_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_16/one_epoch_demography.txt'
# )
# e_rectale_16_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(e_rectale_16_empirical,
#             e_rectale_16_one_epoch,
#             e_rectale_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. rectale Downsampled to 16')
# 
# compare_sfs(proportional_sfs(e_rectale_16_empirical),
#             proportional_sfs(e_rectale_16_one_epoch),
#             proportional_sfs(e_rectale_16_two_epoch)) +
#   ggtitle('E. rectale Downsampled to 16')
# 
# 
# # F. prausnitzii
# plot_likelihood_surface('../Analysis/qp_gut_16/f_prausnitzii_16.csv')
# f_prausnitzii_16_empirical =  read_input_sfs(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_16/empirical_sfs.txt'
# )
# f_prausnitzii_16_one_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_16/one_epoch_demography.txt'
# )
# f_prausnitzii_16_two_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(f_prausnitzii_16_empirical,
#             f_prausnitzii_16_one_epoch,
#             f_prausnitzii_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('F. prausnitzii Downsampled to 16')
# 
# compare_sfs(proportional_sfs(f_prausnitzii_16_empirical),
#             proportional_sfs(f_prausnitzii_16_one_epoch),
#             proportional_sfs(f_prausnitzii_16_two_epoch)) +
#   ggtitle('F. prausnitzii Downsampled to 16')
# 
# 
# # Oscillibacter sp.
# plot_likelihood_surface('../Analysis/qp_gut_16/oscillibacter_sp_16.csv')
# oscillibacter_sp_16_empirical =  read_input_sfs(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_16/empirical_sfs.txt'
# )
# oscillibacter_sp_16_one_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_16/one_epoch_demography.txt'
# )
# oscillibacter_sp_16_two_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(oscillibacter_sp_16_empirical,
#             oscillibacter_sp_16_one_epoch,
#             oscillibacter_sp_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Oscillibacter sp. Downsampled to 16')
# 
# compare_sfs(proportional_sfs(oscillibacter_sp_16_empirical),
#             proportional_sfs(oscillibacter_sp_16_one_epoch),
#             proportional_sfs(oscillibacter_sp_16_two_epoch)) +
#   ggtitle('Oscillibacter sp. Downsampled to 16')
# 
# 
# # o. splanchnicus
# plot_likelihood_surface('../Analysis/qp_gut_16/o_splanchnicus_16.csv')
# o_splanchnicus_16_empirical =  read_input_sfs(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_16/empirical_sfs.txt'
# )
# o_splanchnicus_16_one_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_16/one_epoch_demography.txt'
# )
# o_splanchnicus_16_two_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(o_splanchnicus_16_empirical,
#             o_splanchnicus_16_one_epoch,
#             o_splanchnicus_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('O. splanchnicus Downsampled to 16')
# 
# compare_sfs(proportional_sfs(o_splanchnicus_16_empirical),
#             proportional_sfs(o_splanchnicus_16_one_epoch),
#             proportional_sfs(o_splanchnicus_16_two_epoch)) +
#   ggtitle('O. splanchnicus Downsampled to 16')
# 
# 
# # P. copri
# # plot_likelihood_surface('../Analysis/qp_gut_16/p_copri_16.csv')
# # p_copri_16_empirical =  read_input_sfs(
# #   '../Analysis/Prevotella_copri_61740_downsampled_16/empirical_sfs.txt'
# # )
# # p_copri_16_one_epoch = sfs_from_demography(
# #   '../Analysis/Prevotella_copri_61740_downsampled_16/one_epoch_demography.txt'
# # )
# # p_copri_16_two_epoch = sfs_from_demography(
# #   '../Analysis/Prevotella_copri_61740_downsampled_16/two_epoch_demography.txt'
# # )
# # compare_sfs(p_copri_16_empirical,
# #             p_copri_16_one_epoch,
# #             p_copri_16_two_epoch) +
# #   ylab('Raw Count of Segregating Sites') +
# #   ggtitle('P. copri Downsampled to 16')
# # 
# # compare_sfs(proportional_sfs(p_copri_16_empirical),
# #             proportional_sfs(p_copri_16_one_epoch),
# #             proportional_sfs(p_copri_16_two_epoch)) +
# #   ggtitle('P. copri Downsampled to 16')
# # 
# # 
# # P. distasonis
# plot_likelihood_surface('../Analysis/qp_gut_16/p_distasonis_16.csv')
# p_distasonis_16_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_16/empirical_sfs.txt'
# )
# p_distasonis_16_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_16/one_epoch_demography.txt'
# )
# p_distasonis_16_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(p_distasonis_16_empirical,
#             p_distasonis_16_one_epoch,
#             p_distasonis_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. distasonis Downsampled to 16')
# 
# compare_sfs(proportional_sfs(p_distasonis_16_empirical),
#             proportional_sfs(p_distasonis_16_one_epoch),
#             proportional_sfs(p_distasonis_16_two_epoch)) +
#   ggtitle('P. distasonis Downsampled to 16')
# 
# 
# # P. merdae
# plot_likelihood_surface('../Analysis/qp_gut_16/p_merdae_16.csv')
# p_merdae_16_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_16/empirical_sfs.txt'
# )
# p_merdae_16_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_16/one_epoch_demography.txt'
# )
# p_merdae_16_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(p_merdae_16_empirical,
#             p_merdae_16_one_epoch,
#             p_merdae_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. merdae Downsampled to 16')
# 
# compare_sfs(proportional_sfs(p_merdae_16_empirical),
#             proportional_sfs(p_merdae_16_one_epoch),
#             proportional_sfs(p_merdae_16_two_epoch)) +
#   ggtitle('P. merdae Downsampled to 16')
# 
# 
# # Phascolarctobacterium sp.
# plot_likelihood_surface('../Analysis/qp_gut_16/phascolarctobacterium_sp_16.csv')
# phascolarctobacterium_sp_16_empirical =  read_input_sfs(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_16/empirical_sfs.txt'
# )
# phascolarctobacterium_sp_16_one_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_16/one_epoch_demography.txt'
# )
# phascolarctobacterium_sp_16_two_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(phascolarctobacterium_sp_16_empirical,
#             phascolarctobacterium_sp_16_one_epoch,
#             phascolarctobacterium_sp_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 16')
# 
# compare_sfs(proportional_sfs(phascolarctobacterium_sp_16_empirical),
#             proportional_sfs(phascolarctobacterium_sp_16_one_epoch),
#             proportional_sfs(phascolarctobacterium_sp_16_two_epoch)) +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 16')
# 
# 
# # R. bicirculans
# plot_likelihood_surface('../Analysis/qp_gut_16/r_bicirculans_16.csv')
# r_bicirculans_16_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_16/empirical_sfs.txt'
# )
# r_bicirculans_16_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_16/one_epoch_demography.txt'
# )
# r_bicirculans_16_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(r_bicirculans_16_empirical,
#             r_bicirculans_16_one_epoch,
#             r_bicirculans_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bicirculans Downsampled to 16')
# 
# compare_sfs(proportional_sfs(r_bicirculans_16_empirical),
#             proportional_sfs(r_bicirculans_16_one_epoch),
#             proportional_sfs(r_bicirculans_16_two_epoch)) +
#   ggtitle('R. bicirculans Downsampled to 16')
# 
# # R. bromii
# plot_likelihood_surface('../Analysis/qp_gut_16/r_bromii_16.csv')
# r_bromii_16_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_16/empirical_sfs.txt'
# )
# r_bromii_16_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_16/one_epoch_demography.txt'
# )
# r_bromii_16_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_16/two_epoch_demography.txt'
# )
# compare_sfs(r_bromii_16_empirical,
#             r_bromii_16_one_epoch,
#             r_bromii_16_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bromii Downsampled to 16')
# 
# compare_sfs(proportional_sfs(r_bromii_16_empirical),
#             proportional_sfs(r_bromii_16_one_epoch),
#             proportional_sfs(r_bromii_16_two_epoch)) +
#   ggtitle('R. bromii Downsampled to 16')
# 
# # Downsampled to 18
# 
# # A. finegoldii
# plot_likelihood_surface('../Analysis/qp_gut_18/a_finegoldii_18.csv')
# a_finegoldii_18_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_18/empirical_sfs.txt'
# )
# a_finegoldii_18_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_18/one_epoch_demography.txt'
# )
# a_finegoldii_18_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_18/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_finegoldii_18_empirical,
#             a_finegoldii_18_one_epoch,
#             a_finegoldii_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. finegoldii Downsampled to 18')
# 
# compare_sfs(proportional_sfs(a_finegoldii_18_empirical),
#             proportional_sfs(a_finegoldii_18_one_epoch),
#             proportional_sfs(a_finegoldii_18_two_epoch)) +
#   ggtitle('A. finegoldii Downsampled to 18')
# 
# # A. muciniphila
# plot_likelihood_surface('../Analysis/qp_gut_18/a_muciniphila_18.csv')
# a_muciniphila_18_empirical =  read_input_sfs(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_18/empirical_sfs.txt'
# )
# a_muciniphila_18_one_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_18/one_epoch_demography.txt'
# )
# a_muciniphila_18_two_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(a_muciniphila_18_empirical,
#             a_muciniphila_18_one_epoch,
#             a_muciniphila_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. muciniphila Downsampled to 18')
# 
# compare_sfs(proportional_sfs(a_muciniphila_18_empirical),
#             proportional_sfs(a_muciniphila_18_one_epoch),
#             proportional_sfs(a_muciniphila_18_two_epoch)) +
#   ggtitle('A. muciniphila Downsampled to 18')
# 
# 
# # A. onderdonkii
# plot_likelihood_surface('../Analysis/qp_gut_18/a_onderdonkii_18.csv')
# a_onderdonkii_18_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_18/empirical_sfs.txt'
# )
# a_onderdonkii_18_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_18/one_epoch_demography.txt'
# )
# a_onderdonkii_18_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_18/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_onderdonkii_18_empirical,
#             a_onderdonkii_18_one_epoch,
#             a_onderdonkii_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. onderdonkii Downsampled to 18')
# 
# compare_sfs(proportional_sfs(a_onderdonkii_18_empirical),
#             proportional_sfs(a_onderdonkii_18_one_epoch),
#             proportional_sfs(a_onderdonkii_18_two_epoch)) +
#   ggtitle('A. onderdonkii Downsampled to 18')
# 
# 
# # A. putredinis
# plot_likelihood_surface('../Analysis/qp_gut_18/a_putredinis_18.csv')
# a_putredinis_18_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_18/empirical_sfs.txt'
# )
# a_putredinis_18_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_18/one_epoch_demography.txt'
# )
# a_putredinis_18_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(a_putredinis_18_empirical,
#             a_putredinis_18_one_epoch,
#             a_putredinis_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. putredinis Downsampled to 18')
# 
# compare_sfs(proportional_sfs(a_putredinis_18_empirical),
#             proportional_sfs(a_putredinis_18_one_epoch),
#             proportional_sfs(a_putredinis_18_two_epoch)) +
#   ggtitle('A. putredinis Downsampled to 18')
# 
# 
# 
# # A. shahii
# plot_likelihood_surface('../Analysis/qp_gut_18/a_shahii_18.csv')
# a_shahii_18_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_shahii_62199_downsampled_18/empirical_sfs.txt'
# )
# a_shahii_18_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_18/one_epoch_demography.txt'
# )
# a_shahii_18_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(a_shahii_18_empirical,
#             a_shahii_18_one_epoch,
#             a_shahii_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. shahii Downsampled to 18')
# 
# compare_sfs(proportional_sfs(a_shahii_18_empirical),
#             proportional_sfs(a_shahii_18_one_epoch),
#             proportional_sfs(a_shahii_18_two_epoch)) +
#   ggtitle('A. shahii Downsampled to 18')
# 
# 
# # B. bacterium
# plot_likelihood_surface('../Analysis/qp_gut_18/b_bacterium_18.csv')
# b_bacterium_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_18/empirical_sfs.txt'
# )
# b_bacterium_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_18/one_epoch_demography.txt'
# )
# b_bacterium_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_bacterium_18_empirical,
#             b_bacterium_18_one_epoch,
#             b_bacterium_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. bacterium Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_bacterium_18_empirical),
#             proportional_sfs(b_bacterium_18_one_epoch),
#             proportional_sfs(b_bacterium_18_two_epoch)) +
#   ggtitle('B. bacterium Downsampled to 18')
# 
# # B. caccae
# plot_likelihood_surface('../Analysis/qp_gut_18/b_caccae_18.csv')
# b_caccae_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_18/empirical_sfs.txt'
# )
# b_caccae_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_18/one_epoch_demography.txt'
# )
# b_caccae_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_caccae_18_empirical,
#             b_caccae_18_one_epoch,
#             b_caccae_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. caccae Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_caccae_18_empirical),
#             proportional_sfs(b_caccae_18_one_epoch),
#             proportional_sfs(b_caccae_18_two_epoch)) +
#   ggtitle('B. caccae Downsampled to 18')
# 
# # B. cellulosilyticus
# plot_likelihood_surface('../Analysis/qp_gut_18/b_cellulosilyticus_18.csv')
# b_cellulosilyticus_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_18/empirical_sfs.txt'
# )
# b_cellulosilyticus_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_18/one_epoch_demography.txt'
# )
# b_cellulosilyticus_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_cellulosilyticus_18_empirical,
#             b_cellulosilyticus_18_one_epoch,
#             b_cellulosilyticus_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. cellulosilyticus Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_cellulosilyticus_18_empirical),
#             proportional_sfs(b_cellulosilyticus_18_one_epoch),
#             proportional_sfs(b_cellulosilyticus_18_two_epoch)) +
#   ggtitle('B. cellulosilyticus Downsampled to 18')
# 
# 
# #  B. fragilis
# plot_likelihood_surface('../Analysis/qp_gut_18/b_fragilis_18.csv')
# b_fragilis_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_18/empirical_sfs.txt'
# )
# b_fragilis_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_18/one_epoch_demography.txt'
# )
# b_fragilis_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_fragilis_18_empirical,
#             b_fragilis_18_one_epoch,
#             b_fragilis_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. fragilis Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_fragilis_18_empirical),
#             proportional_sfs(b_fragilis_18_one_epoch),
#             proportional_sfs(b_fragilis_18_two_epoch)) +
#   ggtitle('B. fragilis Downsampled to 18')
# 
# 
# # B. intestinihominis
# plot_likelihood_surface('../Analysis/qp_gut_18/b_intestinihominis_18.csv')
# b_intestinihominis_18_empirical =  read_input_sfs(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_18/empirical_sfs.txt'
# )
# b_intestinihominis_18_one_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_18/one_epoch_demography.txt'
# )
# b_intestinihominis_18_two_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_intestinihominis_18_empirical,
#             b_intestinihominis_18_one_epoch,
#             b_intestinihominis_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. intestinihominis Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_intestinihominis_18_empirical),
#             proportional_sfs(b_intestinihominis_18_one_epoch),
#             proportional_sfs(b_intestinihominis_18_two_epoch)) +
#   ggtitle('B. intestinihominis Downsampled to 18')
# 
# 
# 
# # B. ovatus
# plot_likelihood_surface('../Analysis/qp_gut_18/b_ovatus_18.csv')
# b_ovatus_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_18/empirical_sfs.txt'
# )
# b_ovatus_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_18/one_epoch_demography.txt'
# )
# b_ovatus_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_ovatus_18_empirical,
#             b_ovatus_18_one_epoch,
#             b_ovatus_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. ovatus Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_ovatus_18_empirical),
#             proportional_sfs(b_ovatus_18_one_epoch),
#             proportional_sfs(b_ovatus_18_two_epoch)) +
#   ggtitle('B. ovatus Downsampled to 18')
# 
# 
# # B. thetaiotaomicron
# plot_likelihood_surface('../Analysis/qp_gut_18/b_thetaiotaomicron_18.csv')
# b_thetaiotaomicron_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_18/empirical_sfs.txt'
# )
# b_thetaiotaomicron_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_18/one_epoch_demography.txt'
# )
# b_thetaiotaomicron_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_thetaiotaomicron_18_empirical,
#             b_thetaiotaomicron_18_one_epoch,
#             b_thetaiotaomicron_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. thetaiotaomicron Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_thetaiotaomicron_18_empirical),
#             proportional_sfs(b_thetaiotaomicron_18_one_epoch),
#             proportional_sfs(b_thetaiotaomicron_18_two_epoch)) +
#   ggtitle('B. thetaiotaomicron Downsampled to 18')
# 
# 
# # B. uniformis
# plot_likelihood_surface('../Analysis/qp_gut_18/b_uniformis_18.csv')
# b_uniformis_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_18/empirical_sfs.txt'
# )
# b_uniformis_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_18/one_epoch_demography.txt'
# )
# b_uniformis_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_uniformis_18_empirical,
#             b_uniformis_18_one_epoch,
#             b_uniformis_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. uniformis Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_uniformis_18_empirical),
#             proportional_sfs(b_uniformis_18_one_epoch),
#             proportional_sfs(b_uniformis_18_two_epoch)) +
#   ggtitle('B. uniformis Downsampled to 18')
# 
# 
# # B. vulgatus
# plot_likelihood_surface('../Analysis/qp_gut_18/b_vulgatus_18.csv')
# b_vulgatus_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_18/empirical_sfs.txt'
# )
# b_vulgatus_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_18/one_epoch_demography.txt'
# )
# b_vulgatus_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_vulgatus_18_empirical,
#             b_vulgatus_18_one_epoch,
#             b_vulgatus_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. vulgatus Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_vulgatus_18_empirical),
#             proportional_sfs(b_vulgatus_18_one_epoch),
#             proportional_sfs(b_vulgatus_18_two_epoch)) +
#   ggtitle('B. vulgatus Downsampled to 18')
# 
# 
# 
# # B. xylanisolvens
# plot_likelihood_surface('../Analysis/qp_gut_18/b_xylanisolvens_18.csv')
# b_xylanisolvens_18_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_18/empirical_sfs.txt'
# )
# b_xylanisolvens_18_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_18/one_epoch_demography.txt'
# )
# b_xylanisolvens_18_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(b_xylanisolvens_18_empirical,
#             b_xylanisolvens_18_one_epoch,
#             b_xylanisolvens_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. xylanisolvens Downsampled to 18')
# 
# compare_sfs(proportional_sfs(b_xylanisolvens_18_empirical),
#             proportional_sfs(b_xylanisolvens_18_one_epoch),
#             proportional_sfs(b_xylanisolvens_18_two_epoch)) +
#   ggtitle('B. xylanisolvens Downsampled to 18')
# 
# 
# 
# # D. invisus
# plot_likelihood_surface('../Analysis/qp_gut_18/d_invisus_18.csv')
# d_invisus_18_empirical =  read_input_sfs(
#   '../Analysis/Dialister_invisus_61905_downsampled_18/empirical_sfs.txt'
# )
# d_invisus_18_one_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_18/one_epoch_demography.txt'
# )
# d_invisus_18_two_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(d_invisus_18_empirical,
#             d_invisus_18_one_epoch,
#             d_invisus_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('D. invisus Downsampled to 18')
# 
# compare_sfs(proportional_sfs(d_invisus_18_empirical),
#             proportional_sfs(d_invisus_18_one_epoch),
#             proportional_sfs(d_invisus_18_two_epoch)) +
#   ggtitle('D. invisus Downsampled to 18')
# 
# 
# # E. eligens
# plot_likelihood_surface('../Analysis/qp_gut_18/e_eligens_18.csv')
# e_eligens_18_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_18/empirical_sfs.txt'
# )
# e_eligens_18_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_18/one_epoch_demography.txt'
# )
# e_eligens_18_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(e_eligens_18_empirical,
#             e_eligens_18_one_epoch,
#             e_eligens_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. eligens Downsampled to 18')
# 
# compare_sfs(proportional_sfs(e_eligens_18_empirical),
#             proportional_sfs(e_eligens_18_one_epoch),
#             proportional_sfs(e_eligens_18_two_epoch)) +
#   ggtitle('E. eligens Downsampled to 18')
# 
# 
# 
# # E. rectale
# plot_likelihood_surface('../Analysis/qp_gut_18/e_rectale_18.csv')
# e_rectale_18_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_18/empirical_sfs.txt'
# )
# e_rectale_18_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_18/one_epoch_demography.txt'
# )
# e_rectale_18_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(e_rectale_18_empirical,
#             e_rectale_18_one_epoch,
#             e_rectale_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. rectale Downsampled to 18')
# 
# compare_sfs(proportional_sfs(e_rectale_18_empirical),
#             proportional_sfs(e_rectale_18_one_epoch),
#             proportional_sfs(e_rectale_18_two_epoch)) +
#   ggtitle('E. rectale Downsampled to 18')
# 
# 
# # F. prausnitzii
# plot_likelihood_surface('../Analysis/qp_gut_18/f_prausnitzii_18.csv')
# f_prausnitzii_18_empirical =  read_input_sfs(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_18/empirical_sfs.txt'
# )
# f_prausnitzii_18_one_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_18/one_epoch_demography.txt'
# )
# f_prausnitzii_18_two_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(f_prausnitzii_18_empirical,
#             f_prausnitzii_18_one_epoch,
#             f_prausnitzii_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('F. prausnitzii Downsampled to 18')
# 
# compare_sfs(proportional_sfs(f_prausnitzii_18_empirical),
#             proportional_sfs(f_prausnitzii_18_one_epoch),
#             proportional_sfs(f_prausnitzii_18_two_epoch)) +
#   ggtitle('F. prausnitzii Downsampled to 18')
# 
# 
# # Oscillibacter sp.
# plot_likelihood_surface('../Analysis/qp_gut_18/oscillibacter_sp_18.csv')
# oscillibacter_sp_18_empirical =  read_input_sfs(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_18/empirical_sfs.txt'
# )
# oscillibacter_sp_18_one_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_18/one_epoch_demography.txt'
# )
# oscillibacter_sp_18_two_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(oscillibacter_sp_18_empirical,
#             oscillibacter_sp_18_one_epoch,
#             oscillibacter_sp_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Oscillibacter sp. Downsampled to 18')
# 
# compare_sfs(proportional_sfs(oscillibacter_sp_18_empirical),
#             proportional_sfs(oscillibacter_sp_18_one_epoch),
#             proportional_sfs(oscillibacter_sp_18_two_epoch)) +
#   ggtitle('Oscillibacter sp. Downsampled to 18')
# 
# 
# # o. splanchnicus
# plot_likelihood_surface('../Analysis/qp_gut_18/o_splanchnicus_18.csv')
# o_splanchnicus_18_empirical =  read_input_sfs(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_18/empirical_sfs.txt'
# )
# o_splanchnicus_18_one_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_18/one_epoch_demography.txt'
# )
# o_splanchnicus_18_two_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(o_splanchnicus_18_empirical,
#             o_splanchnicus_18_one_epoch,
#             o_splanchnicus_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('O. splanchnicus Downsampled to 18')
# 
# compare_sfs(proportional_sfs(o_splanchnicus_18_empirical),
#             proportional_sfs(o_splanchnicus_18_one_epoch),
#             proportional_sfs(o_splanchnicus_18_two_epoch)) +
#   ggtitle('O. splanchnicus Downsampled to 18')
# 
# 
# # P. copri
# # plot_likelihood_surface('../Analysis/qp_gut_18/p_copri_18.csv')
# # p_copri_18_empirical =  read_input_sfs(
# #   '../Analysis/Prevotella_copri_61740_downsampled_18/empirical_sfs.txt'
# # )
# # p_copri_18_one_epoch = sfs_from_demography(
# #   '../Analysis/Prevotella_copri_61740_downsampled_18/one_epoch_demography.txt'
# # )
# # p_copri_18_two_epoch = sfs_from_demography(
# #   '../Analysis/Prevotella_copri_61740_downsampled_18/two_epoch_demography.txt'
# # )
# # compare_sfs(p_copri_18_empirical,
# #             p_copri_18_one_epoch,
# #             p_copri_18_two_epoch) +
# #   ylab('Raw Count of Segregating Sites') +
# #   ggtitle('P. copri Downsampled to 18')
# # 
# # compare_sfs(proportional_sfs(p_copri_18_empirical),
# #             proportional_sfs(p_copri_18_one_epoch),
# #             proportional_sfs(p_copri_18_two_epoch)) +
# #   ggtitle('P. copri Downsampled to 18')
# # 
# # 
# # P. distasonis
# plot_likelihood_surface('../Analysis/qp_gut_18/p_distasonis_18.csv')
# p_distasonis_18_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_18/empirical_sfs.txt'
# )
# p_distasonis_18_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_18/one_epoch_demography.txt'
# )
# p_distasonis_18_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(p_distasonis_18_empirical,
#             p_distasonis_18_one_epoch,
#             p_distasonis_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. distasonis Downsampled to 18')
# 
# compare_sfs(proportional_sfs(p_distasonis_18_empirical),
#             proportional_sfs(p_distasonis_18_one_epoch),
#             proportional_sfs(p_distasonis_18_two_epoch)) +
#   ggtitle('P. distasonis Downsampled to 18')
# 
# 
# # P. merdae
# plot_likelihood_surface('../Analysis/qp_gut_18/p_merdae_18.csv')
# p_merdae_18_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_18/empirical_sfs.txt'
# )
# p_merdae_18_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_18/one_epoch_demography.txt'
# )
# p_merdae_18_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(p_merdae_18_empirical,
#             p_merdae_18_one_epoch,
#             p_merdae_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. merdae Downsampled to 18')
# 
# compare_sfs(proportional_sfs(p_merdae_18_empirical),
#             proportional_sfs(p_merdae_18_one_epoch),
#             proportional_sfs(p_merdae_18_two_epoch)) +
#   ggtitle('P. merdae Downsampled to 18')
# 
# 
# # Phascolarctobacterium sp.
# # plot_likelihood_surface('../Analysis/qp_gut_18/phascolarctobacterium_sp_18.csv')
# # phascolarctobacterium_sp_18_empirical =  read_input_sfs(
# #   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_18/empirical_sfs.txt'
# # )
# # phascolarctobacterium_sp_18_one_epoch = sfs_from_demography(
# #   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_18/one_epoch_demography.txt'
# # )
# # phascolarctobacterium_sp_18_two_epoch = sfs_from_demography(
# #   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_18/two_epoch_demography.txt'
# # )
# # compare_sfs(phascolarctobacterium_sp_18_empirical,
# #             phascolarctobacterium_sp_18_one_epoch,
# #             phascolarctobacterium_sp_18_two_epoch) +
# #   ylab('Raw Count of Segregating Sites') +
# #   ggtitle('Phascolarctobacterium sp. Downsampled to 18')
# # 
# # compare_sfs(proportional_sfs(phascolarctobacterium_sp_18_empirical),
# #             proportional_sfs(phascolarctobacterium_sp_18_one_epoch),
# #             proportional_sfs(phascolarctobacterium_sp_18_two_epoch)) +
# #   ggtitle('Phascolarctobacterium sp. Downsampled to 18')
# # 
# # 
# # R. bicirculans
# plot_likelihood_surface('../Analysis/qp_gut_18/r_bicirculans_18.csv')
# r_bicirculans_18_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_18/empirical_sfs.txt'
# )
# r_bicirculans_18_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_18/one_epoch_demography.txt'
# )
# r_bicirculans_18_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(r_bicirculans_18_empirical,
#             r_bicirculans_18_one_epoch,
#             r_bicirculans_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bicirculans Downsampled to 18')
# 
# compare_sfs(proportional_sfs(r_bicirculans_18_empirical),
#             proportional_sfs(r_bicirculans_18_one_epoch),
#             proportional_sfs(r_bicirculans_18_two_epoch)) +
#   ggtitle('R. bicirculans Downsampled to 18')
# 
# # R. bromii
# plot_likelihood_surface('../Analysis/qp_gut_18/r_bromii_18.csv')
# r_bromii_18_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_18/empirical_sfs.txt'
# )
# r_bromii_18_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_18/one_epoch_demography.txt'
# )
# r_bromii_18_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_18/two_epoch_demography.txt'
# )
# compare_sfs(r_bromii_18_empirical,
#             r_bromii_18_one_epoch,
#             r_bromii_18_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bromii Downsampled to 18')
# 
# compare_sfs(proportional_sfs(r_bromii_18_empirical),
#             proportional_sfs(r_bromii_18_one_epoch),
#             proportional_sfs(r_bromii_18_two_epoch)) +
#   ggtitle('R. bromii Downsampled to 18')
# 
# # Downsampled to 20
# 
# # A. finegoldii
# plot_likelihood_surface('../Analysis/qp_gut_20/a_finegoldii_20.csv')
# a_finegoldii_20_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_20/empirical_sfs.txt'
# )
# a_finegoldii_20_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_20/one_epoch_demography.txt'
# )
# a_finegoldii_20_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_20/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_finegoldii_20_empirical,
#             a_finegoldii_20_one_epoch,
#             a_finegoldii_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. finegoldii Downsampled to 20')
# 
# compare_sfs(proportional_sfs(a_finegoldii_20_empirical),
#             proportional_sfs(a_finegoldii_20_one_epoch),
#             proportional_sfs(a_finegoldii_20_two_epoch)) +
#   ggtitle('A. finegoldii Downsampled to 20')
# 
# # A. muciniphila
# plot_likelihood_surface('../Analysis/qp_gut_20/a_muciniphila_20.csv')
# a_muciniphila_20_empirical =  read_input_sfs(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_20/empirical_sfs.txt'
# )
# a_muciniphila_20_one_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_20/one_epoch_demography.txt'
# )
# a_muciniphila_20_two_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(a_muciniphila_20_empirical,
#             a_muciniphila_20_one_epoch,
#             a_muciniphila_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. muciniphila Downsampled to 20')
# 
# compare_sfs(proportional_sfs(a_muciniphila_20_empirical),
#             proportional_sfs(a_muciniphila_20_one_epoch),
#             proportional_sfs(a_muciniphila_20_two_epoch)) +
#   ggtitle('A. muciniphila Downsampled to 20')
# 
# 
# # A. onderdonkii
# plot_likelihood_surface('../Analysis/qp_gut_20/a_onderdonkii_20.csv')
# a_onderdonkii_20_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_20/empirical_sfs.txt'
# )
# a_onderdonkii_20_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_20/one_epoch_demography.txt'
# )
# a_onderdonkii_20_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_20/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_onderdonkii_20_empirical,
#             a_onderdonkii_20_one_epoch,
#             a_onderdonkii_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. onderdonkii Downsampled to 20')
# 
# compare_sfs(proportional_sfs(a_onderdonkii_20_empirical),
#             proportional_sfs(a_onderdonkii_20_one_epoch),
#             proportional_sfs(a_onderdonkii_20_two_epoch)) +
#   ggtitle('A. onderdonkii Downsampled to 20')
# 
# 
# # A. putredinis
# plot_likelihood_surface('../Analysis/qp_gut_20/a_putredinis_20.csv')
# a_putredinis_20_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_20/empirical_sfs.txt'
# )
# a_putredinis_20_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_20/one_epoch_demography.txt'
# )
# a_putredinis_20_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(a_putredinis_20_empirical,
#             a_putredinis_20_one_epoch,
#             a_putredinis_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. putredinis Downsampled to 20')
# 
# compare_sfs(proportional_sfs(a_putredinis_20_empirical),
#             proportional_sfs(a_putredinis_20_one_epoch),
#             proportional_sfs(a_putredinis_20_two_epoch)) +
#   ggtitle('A. putredinis Downsampled to 20')
# 
# 
# 
# # A. shahii
# plot_likelihood_surface('../Analysis/qp_gut_20/a_shahii_20.csv')
# a_shahii_20_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_shahii_62199_downsampled_20/empirical_sfs.txt'
# )
# a_shahii_20_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_20/one_epoch_demography.txt'
# )
# a_shahii_20_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(a_shahii_20_empirical,
#             a_shahii_20_one_epoch,
#             a_shahii_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. shahii Downsampled to 20')
# 
# compare_sfs(proportional_sfs(a_shahii_20_empirical),
#             proportional_sfs(a_shahii_20_one_epoch),
#             proportional_sfs(a_shahii_20_two_epoch)) +
#   ggtitle('A. shahii Downsampled to 20')
# 
# 
# # B. bacterium
# plot_likelihood_surface('../Analysis/qp_gut_20/b_bacterium_20.csv')
# b_bacterium_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_20/empirical_sfs.txt'
# )
# b_bacterium_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_20/one_epoch_demography.txt'
# )
# b_bacterium_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_bacterium_20_empirical,
#             b_bacterium_20_one_epoch,
#             b_bacterium_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. bacterium Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_bacterium_20_empirical),
#             proportional_sfs(b_bacterium_20_one_epoch),
#             proportional_sfs(b_bacterium_20_two_epoch)) +
#   ggtitle('B. bacterium Downsampled to 20')
# 
# # B. caccae
# plot_likelihood_surface('../Analysis/qp_gut_20/b_caccae_20.csv')
# b_caccae_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_20/empirical_sfs.txt'
# )
# b_caccae_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_20/one_epoch_demography.txt'
# )
# b_caccae_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_caccae_20_empirical,
#             b_caccae_20_one_epoch,
#             b_caccae_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. caccae Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_caccae_20_empirical),
#             proportional_sfs(b_caccae_20_one_epoch),
#             proportional_sfs(b_caccae_20_two_epoch)) +
#   ggtitle('B. caccae Downsampled to 20')
# 
# # B. cellulosilyticus
# plot_likelihood_surface('../Analysis/qp_gut_20/b_cellulosilyticus_20.csv')
# b_cellulosilyticus_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_20/empirical_sfs.txt'
# )
# b_cellulosilyticus_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_20/one_epoch_demography.txt'
# )
# b_cellulosilyticus_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_cellulosilyticus_20_empirical,
#             b_cellulosilyticus_20_one_epoch,
#             b_cellulosilyticus_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. cellulosilyticus Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_cellulosilyticus_20_empirical),
#             proportional_sfs(b_cellulosilyticus_20_one_epoch),
#             proportional_sfs(b_cellulosilyticus_20_two_epoch)) +
#   ggtitle('B. cellulosilyticus Downsampled to 20')
# 
# 
# #  B. fragilis
# plot_likelihood_surface('../Analysis/qp_gut_20/b_fragilis_20.csv')
# b_fragilis_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_20/empirical_sfs.txt'
# )
# b_fragilis_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_20/one_epoch_demography.txt'
# )
# b_fragilis_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_fragilis_20_empirical,
#             b_fragilis_20_one_epoch,
#             b_fragilis_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. fragilis Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_fragilis_20_empirical),
#             proportional_sfs(b_fragilis_20_one_epoch),
#             proportional_sfs(b_fragilis_20_two_epoch)) +
#   ggtitle('B. fragilis Downsampled to 20')
# 
# 
# # B. intestinihominis
# plot_likelihood_surface('../Analysis/qp_gut_20/b_intestinihominis_20.csv')
# b_intestinihominis_20_empirical =  read_input_sfs(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_20/empirical_sfs.txt'
# )
# b_intestinihominis_20_one_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_20/one_epoch_demography.txt'
# )
# b_intestinihominis_20_two_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_intestinihominis_20_empirical,
#             b_intestinihominis_20_one_epoch,
#             b_intestinihominis_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. intestinihominis Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_intestinihominis_20_empirical),
#             proportional_sfs(b_intestinihominis_20_one_epoch),
#             proportional_sfs(b_intestinihominis_20_two_epoch)) +
#   ggtitle('B. intestinihominis Downsampled to 20')
# 
# 
# 
# # B. ovatus
# plot_likelihood_surface('../Analysis/qp_gut_20/b_ovatus_20.csv')
# b_ovatus_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_20/empirical_sfs.txt'
# )
# b_ovatus_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_20/one_epoch_demography.txt'
# )
# b_ovatus_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_ovatus_20_empirical,
#             b_ovatus_20_one_epoch,
#             b_ovatus_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. ovatus Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_ovatus_20_empirical),
#             proportional_sfs(b_ovatus_20_one_epoch),
#             proportional_sfs(b_ovatus_20_two_epoch)) +
#   ggtitle('B. ovatus Downsampled to 20')
# 
# 
# # B. thetaiotaomicron
# plot_likelihood_surface('../Analysis/qp_gut_20/b_thetaiotaomicron_20.csv')
# b_thetaiotaomicron_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_20/empirical_sfs.txt'
# )
# b_thetaiotaomicron_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_20/one_epoch_demography.txt'
# )
# b_thetaiotaomicron_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_thetaiotaomicron_20_empirical,
#             b_thetaiotaomicron_20_one_epoch,
#             b_thetaiotaomicron_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. thetaiotaomicron Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_thetaiotaomicron_20_empirical),
#             proportional_sfs(b_thetaiotaomicron_20_one_epoch),
#             proportional_sfs(b_thetaiotaomicron_20_two_epoch)) +
#   ggtitle('B. thetaiotaomicron Downsampled to 20')
# 
# 
# # B. uniformis
# plot_likelihood_surface('../Analysis/qp_gut_20/b_uniformis_20.csv')
# b_uniformis_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_20/empirical_sfs.txt'
# )
# b_uniformis_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_20/one_epoch_demography.txt'
# )
# b_uniformis_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_uniformis_20_empirical,
#             b_uniformis_20_one_epoch,
#             b_uniformis_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. uniformis Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_uniformis_20_empirical),
#             proportional_sfs(b_uniformis_20_one_epoch),
#             proportional_sfs(b_uniformis_20_two_epoch)) +
#   ggtitle('B. uniformis Downsampled to 20')
# 
# 
# # B. vulgatus
# plot_likelihood_surface('../Analysis/qp_gut_20/b_vulgatus_20.csv')
# b_vulgatus_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_20/empirical_sfs.txt'
# )
# b_vulgatus_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_20/one_epoch_demography.txt'
# )
# b_vulgatus_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_vulgatus_20_empirical,
#             b_vulgatus_20_one_epoch,
#             b_vulgatus_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. vulgatus Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_vulgatus_20_empirical),
#             proportional_sfs(b_vulgatus_20_one_epoch),
#             proportional_sfs(b_vulgatus_20_two_epoch)) +
#   ggtitle('B. vulgatus Downsampled to 20')
# 
# 
# 
# # B. xylanisolvens
# plot_likelihood_surface('../Analysis/qp_gut_20/b_xylanisolvens_20.csv')
# b_xylanisolvens_20_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_20/empirical_sfs.txt'
# )
# b_xylanisolvens_20_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_20/one_epoch_demography.txt'
# )
# b_xylanisolvens_20_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(b_xylanisolvens_20_empirical,
#             b_xylanisolvens_20_one_epoch,
#             b_xylanisolvens_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. xylanisolvens Downsampled to 20')
# 
# compare_sfs(proportional_sfs(b_xylanisolvens_20_empirical),
#             proportional_sfs(b_xylanisolvens_20_one_epoch),
#             proportional_sfs(b_xylanisolvens_20_two_epoch)) +
#   ggtitle('B. xylanisolvens Downsampled to 20')
# 
# 
# 
# # D. invisus
# plot_likelihood_surface('../Analysis/qp_gut_20/d_invisus_20.csv')
# d_invisus_20_empirical =  read_input_sfs(
#   '../Analysis/Dialister_invisus_61905_downsampled_20/empirical_sfs.txt'
# )
# d_invisus_20_one_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_20/one_epoch_demography.txt'
# )
# d_invisus_20_two_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(d_invisus_20_empirical,
#             d_invisus_20_one_epoch,
#             d_invisus_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('D. invisus Downsampled to 20')
# 
# compare_sfs(proportional_sfs(d_invisus_20_empirical),
#             proportional_sfs(d_invisus_20_one_epoch),
#             proportional_sfs(d_invisus_20_two_epoch)) +
#   ggtitle('D. invisus Downsampled to 20')
# 
# 
# # E. eligens
# plot_likelihood_surface('../Analysis/qp_gut_20/e_eligens_20.csv')
# e_eligens_20_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_20/empirical_sfs.txt'
# )
# e_eligens_20_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_20/one_epoch_demography.txt'
# )
# e_eligens_20_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(e_eligens_20_empirical,
#             e_eligens_20_one_epoch,
#             e_eligens_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. eligens Downsampled to 20')
# 
# compare_sfs(proportional_sfs(e_eligens_20_empirical),
#             proportional_sfs(e_eligens_20_one_epoch),
#             proportional_sfs(e_eligens_20_two_epoch)) +
#   ggtitle('E. eligens Downsampled to 20')
# 
# 
# 
# # E. rectale
# plot_likelihood_surface('../Analysis/qp_gut_20/e_rectale_20.csv')
# e_rectale_20_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_20/empirical_sfs.txt'
# )
# e_rectale_20_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_20/one_epoch_demography.txt'
# )
# e_rectale_20_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(e_rectale_20_empirical,
#             e_rectale_20_one_epoch,
#             e_rectale_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. rectale Downsampled to 20')
# 
# compare_sfs(proportional_sfs(e_rectale_20_empirical),
#             proportional_sfs(e_rectale_20_one_epoch),
#             proportional_sfs(e_rectale_20_two_epoch)) +
#   ggtitle('E. rectale Downsampled to 20')
# 
# 
# # F. prausnitzii
# plot_likelihood_surface('../Analysis/qp_gut_20/f_prausnitzii_20.csv')
# f_prausnitzii_20_empirical =  read_input_sfs(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_20/empirical_sfs.txt'
# )
# f_prausnitzii_20_one_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_20/one_epoch_demography.txt'
# )
# f_prausnitzii_20_two_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(f_prausnitzii_20_empirical,
#             f_prausnitzii_20_one_epoch,
#             f_prausnitzii_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('F. prausnitzii Downsampled to 20')
# 
# compare_sfs(proportional_sfs(f_prausnitzii_20_empirical),
#             proportional_sfs(f_prausnitzii_20_one_epoch),
#             proportional_sfs(f_prausnitzii_20_two_epoch)) +
#   ggtitle('F. prausnitzii Downsampled to 20')
# 
# 
# # Oscillibacter sp.
# plot_likelihood_surface('../Analysis/qp_gut_20/oscillibacter_sp_20.csv')
# oscillibacter_sp_20_empirical =  read_input_sfs(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_20/empirical_sfs.txt'
# )
# oscillibacter_sp_20_one_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_20/one_epoch_demography.txt'
# )
# oscillibacter_sp_20_two_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(oscillibacter_sp_20_empirical,
#             oscillibacter_sp_20_one_epoch,
#             oscillibacter_sp_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Oscillibacter sp. Downsampled to 20')
# 
# compare_sfs(proportional_sfs(oscillibacter_sp_20_empirical),
#             proportional_sfs(oscillibacter_sp_20_one_epoch),
#             proportional_sfs(oscillibacter_sp_20_two_epoch)) +
#   ggtitle('Oscillibacter sp. Downsampled to 20')
# 
# 
# # o. splanchnicus
# plot_likelihood_surface('../Analysis/qp_gut_20/o_splanchnicus_20.csv')
# o_splanchnicus_20_empirical =  read_input_sfs(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_20/empirical_sfs.txt'
# )
# o_splanchnicus_20_one_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_20/one_epoch_demography.txt'
# )
# o_splanchnicus_20_two_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(o_splanchnicus_20_empirical,
#             o_splanchnicus_20_one_epoch,
#             o_splanchnicus_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('O. splanchnicus Downsampled to 20')
# 
# compare_sfs(proportional_sfs(o_splanchnicus_20_empirical),
#             proportional_sfs(o_splanchnicus_20_one_epoch),
#             proportional_sfs(o_splanchnicus_20_two_epoch)) +
#   ggtitle('O. splanchnicus Downsampled to 20')
# 
# 
# # P. copri
# plot_likelihood_surface('../Analysis/qp_gut_20/p_copri_20.csv')
# p_copri_20_empirical =  read_input_sfs(
#   '../Analysis/Prevotella_copri_61740_downsampled_20/empirical_sfs.txt'
# )
# p_copri_20_one_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_20/one_epoch_demography.txt'
# )
# p_copri_20_two_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(p_copri_20_empirical,
#             p_copri_20_one_epoch,
#             p_copri_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. copri Downsampled to 20')
# 
# compare_sfs(proportional_sfs(p_copri_20_empirical),
#             proportional_sfs(p_copri_20_one_epoch),
#             proportional_sfs(p_copri_20_two_epoch)) +
#   ggtitle('P. copri Downsampled to 20')
# 
# 
# # P. distasonis
# plot_likelihood_surface('../Analysis/qp_gut_20/p_distasonis_20.csv')
# p_distasonis_20_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_20/empirical_sfs.txt'
# )
# p_distasonis_20_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_20/one_epoch_demography.txt'
# )
# p_distasonis_20_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(p_distasonis_20_empirical,
#             p_distasonis_20_one_epoch,
#             p_distasonis_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. distasonis Downsampled to 20')
# 
# compare_sfs(proportional_sfs(p_distasonis_20_empirical),
#             proportional_sfs(p_distasonis_20_one_epoch),
#             proportional_sfs(p_distasonis_20_two_epoch)) +
#   ggtitle('P. distasonis Downsampled to 20')
# 
# 
# # P. merdae
# plot_likelihood_surface('../Analysis/qp_gut_20/p_merdae_20.csv')
# p_merdae_20_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_20/empirical_sfs.txt'
# )
# p_merdae_20_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_20/one_epoch_demography.txt'
# )
# p_merdae_20_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(p_merdae_20_empirical,
#             p_merdae_20_one_epoch,
#             p_merdae_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. merdae Downsampled to 20')
# 
# compare_sfs(proportional_sfs(p_merdae_20_empirical),
#             proportional_sfs(p_merdae_20_one_epoch),
#             proportional_sfs(p_merdae_20_two_epoch)) +
#   ggtitle('P. merdae Downsampled to 20')
# 
# 
# # Phascolarctobacterium sp.
# plot_likelihood_surface('../Analysis/qp_gut_20/phascolarctobacterium_sp_20.csv')
# phascolarctobacterium_sp_20_empirical =  read_input_sfs(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_20/empirical_sfs.txt'
# )
# phascolarctobacterium_sp_20_one_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_20/one_epoch_demography.txt'
# )
# phascolarctobacterium_sp_20_two_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(phascolarctobacterium_sp_20_empirical,
#             phascolarctobacterium_sp_20_one_epoch,
#             phascolarctobacterium_sp_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 20')
# 
# compare_sfs(proportional_sfs(phascolarctobacterium_sp_20_empirical),
#             proportional_sfs(phascolarctobacterium_sp_20_one_epoch),
#             proportional_sfs(phascolarctobacterium_sp_20_two_epoch)) +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 20')
# 
# 
# # R. bicirculans
# plot_likelihood_surface('../Analysis/qp_gut_20/r_bicirculans_20.csv')
# r_bicirculans_20_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_20/empirical_sfs.txt'
# )
# r_bicirculans_20_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_20/one_epoch_demography.txt'
# )
# r_bicirculans_20_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(r_bicirculans_20_empirical,
#             r_bicirculans_20_one_epoch,
#             r_bicirculans_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bicirculans Downsampled to 20')
# 
# compare_sfs(proportional_sfs(r_bicirculans_20_empirical),
#             proportional_sfs(r_bicirculans_20_one_epoch),
#             proportional_sfs(r_bicirculans_20_two_epoch)) +
#   ggtitle('R. bicirculans Downsampled to 20')
# 
# # R. bromii
# plot_likelihood_surface('../Analysis/qp_gut_20/r_bromii_20.csv')
# r_bromii_20_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_20/empirical_sfs.txt'
# )
# r_bromii_20_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_20/one_epoch_demography.txt'
# )
# r_bromii_20_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_20/two_epoch_demography.txt'
# )
# compare_sfs(r_bromii_20_empirical,
#             r_bromii_20_one_epoch,
#             r_bromii_20_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bromii Downsampled to 20')
# 
# compare_sfs(proportional_sfs(r_bromii_20_empirical),
#             proportional_sfs(r_bromii_20_one_epoch),
#             proportional_sfs(r_bromii_20_two_epoch)) +
#   ggtitle('R. bromii Downsampled to 20')
# 
# # Downsampled to 30
# 
# # A. finegoldii
# plot_likelihood_surface('../Analysis/qp_gut_30/a_finegoldii_30.csv')
# a_finegoldii_30_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_30/empirical_sfs.txt'
# )
# a_finegoldii_30_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_30/one_epoch_demography.txt'
# )
# a_finegoldii_30_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_30/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_finegoldii_30_empirical,
#             a_finegoldii_30_one_epoch,
#             a_finegoldii_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. finegoldii Downsampled to 30')
# 
# compare_sfs(proportional_sfs(a_finegoldii_30_empirical),
#             proportional_sfs(a_finegoldii_30_one_epoch),
#             proportional_sfs(a_finegoldii_30_two_epoch)) +
#   ggtitle('A. finegoldii Downsampled to 30')
# 
# # A. muciniphila
# plot_likelihood_surface('../Analysis/qp_gut_30/a_muciniphila_30.csv')
# a_muciniphila_30_empirical =  read_input_sfs(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_30/empirical_sfs.txt'
# )
# a_muciniphila_30_one_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_30/one_epoch_demography.txt'
# )
# a_muciniphila_30_two_epoch = sfs_from_demography(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(a_muciniphila_30_empirical,
#             a_muciniphila_30_one_epoch,
#             a_muciniphila_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. muciniphila Downsampled to 30')
# 
# compare_sfs(proportional_sfs(a_muciniphila_30_empirical),
#             proportional_sfs(a_muciniphila_30_one_epoch),
#             proportional_sfs(a_muciniphila_30_two_epoch)) +
#   ggtitle('A. muciniphila Downsampled to 30')
# 
# 
# # A. onderdonkii
# plot_likelihood_surface('../Analysis/qp_gut_30/a_onderdonkii_30.csv')
# a_onderdonkii_30_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_30/empirical_sfs.txt'
# )
# a_onderdonkii_30_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_30/one_epoch_demography.txt'
# )
# a_onderdonkii_30_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_30/two_epoch_demography.txt'
# )
# 
# compare_sfs(a_onderdonkii_30_empirical,
#             a_onderdonkii_30_one_epoch,
#             a_onderdonkii_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. onderdonkii Downsampled to 30')
# 
# compare_sfs(proportional_sfs(a_onderdonkii_30_empirical),
#             proportional_sfs(a_onderdonkii_30_one_epoch),
#             proportional_sfs(a_onderdonkii_30_two_epoch)) +
#   ggtitle('A. onderdonkii Downsampled to 30')
# 
# 
# # A. putredinis
# plot_likelihood_surface('../Analysis/qp_gut_30/a_putredinis_30.csv')
# a_putredinis_30_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_30/empirical_sfs.txt'
# )
# a_putredinis_30_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_30/one_epoch_demography.txt'
# )
# a_putredinis_30_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(a_putredinis_30_empirical,
#             a_putredinis_30_one_epoch,
#             a_putredinis_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. putredinis Downsampled to 30')
# 
# compare_sfs(proportional_sfs(a_putredinis_30_empirical),
#             proportional_sfs(a_putredinis_30_one_epoch),
#             proportional_sfs(a_putredinis_30_two_epoch)) +
#   ggtitle('A. putredinis Downsampled to 30')
# 
# 
# 
# # A. shahii
# plot_likelihood_surface('../Analysis/qp_gut_30/a_shahii_30.csv')
# a_shahii_30_empirical =  read_input_sfs(
#   '../Analysis/Alistipes_shahii_62199_downsampled_30/empirical_sfs.txt'
# )
# a_shahii_30_one_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_30/one_epoch_demography.txt'
# )
# a_shahii_30_two_epoch = sfs_from_demography(
#   '../Analysis/Alistipes_shahii_62199_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(a_shahii_30_empirical,
#             a_shahii_30_one_epoch,
#             a_shahii_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('A. shahii Downsampled to 30')
# 
# compare_sfs(proportional_sfs(a_shahii_30_empirical),
#             proportional_sfs(a_shahii_30_one_epoch),
#             proportional_sfs(a_shahii_30_two_epoch)) +
#   ggtitle('A. shahii Downsampled to 30')
# 
# 
# # B. bacterium
# plot_likelihood_surface('../Analysis/qp_gut_30/b_bacterium_30.csv')
# b_bacterium_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_30/empirical_sfs.txt'
# )
# b_bacterium_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_30/one_epoch_demography.txt'
# )
# b_bacterium_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroidales_bacterium_58650_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_bacterium_30_empirical,
#             b_bacterium_30_one_epoch,
#             b_bacterium_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. bacterium Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_bacterium_30_empirical),
#             proportional_sfs(b_bacterium_30_one_epoch),
#             proportional_sfs(b_bacterium_30_two_epoch)) +
#   ggtitle('B. bacterium Downsampled to 30')
# 
# # B. caccae
# plot_likelihood_surface('../Analysis/qp_gut_30/b_caccae_30.csv')
# b_caccae_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_30/empirical_sfs.txt'
# )
# b_caccae_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_30/one_epoch_demography.txt'
# )
# b_caccae_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_caccae_53434_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_caccae_30_empirical,
#             b_caccae_30_one_epoch,
#             b_caccae_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. caccae Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_caccae_30_empirical),
#             proportional_sfs(b_caccae_30_one_epoch),
#             proportional_sfs(b_caccae_30_two_epoch)) +
#   ggtitle('B. caccae Downsampled to 30')
# 
# # B. cellulosilyticus
# plot_likelihood_surface('../Analysis/qp_gut_30/b_cellulosilyticus_30.csv')
# b_cellulosilyticus_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_30/empirical_sfs.txt'
# )
# b_cellulosilyticus_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_30/one_epoch_demography.txt'
# )
# b_cellulosilyticus_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_cellulosilyticus_30_empirical,
#             b_cellulosilyticus_30_one_epoch,
#             b_cellulosilyticus_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. cellulosilyticus Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_cellulosilyticus_30_empirical),
#             proportional_sfs(b_cellulosilyticus_30_one_epoch),
#             proportional_sfs(b_cellulosilyticus_30_two_epoch)) +
#   ggtitle('B. cellulosilyticus Downsampled to 30')
# 
# 
# #  B. fragilis
# plot_likelihood_surface('../Analysis/qp_gut_30/b_fragilis_30.csv')
# b_fragilis_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_30/empirical_sfs.txt'
# )
# b_fragilis_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_30/one_epoch_demography.txt'
# )
# b_fragilis_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_fragilis_30_empirical,
#             b_fragilis_30_one_epoch,
#             b_fragilis_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. fragilis Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_fragilis_30_empirical),
#             proportional_sfs(b_fragilis_30_one_epoch),
#             proportional_sfs(b_fragilis_30_two_epoch)) +
#   ggtitle('B. fragilis Downsampled to 30')
# 
# 
# # B. intestinihominis
# plot_likelihood_surface('../Analysis/qp_gut_30/b_intestinihominis_30.csv')
# b_intestinihominis_30_empirical =  read_input_sfs(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_30/empirical_sfs.txt'
# )
# b_intestinihominis_30_one_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_30/one_epoch_demography.txt'
# )
# b_intestinihominis_30_two_epoch = sfs_from_demography(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_intestinihominis_30_empirical,
#             b_intestinihominis_30_one_epoch,
#             b_intestinihominis_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. intestinihominis Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_intestinihominis_30_empirical),
#             proportional_sfs(b_intestinihominis_30_one_epoch),
#             proportional_sfs(b_intestinihominis_30_two_epoch)) +
#   ggtitle('B. intestinihominis Downsampled to 30')
# 
# 
# 
# # B. ovatus
# plot_likelihood_surface('../Analysis/qp_gut_30/b_ovatus_30.csv')
# b_ovatus_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_30/empirical_sfs.txt'
# )
# b_ovatus_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_30/one_epoch_demography.txt'
# )
# b_ovatus_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_ovatus_30_empirical,
#             b_ovatus_30_one_epoch,
#             b_ovatus_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. ovatus Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_ovatus_30_empirical),
#             proportional_sfs(b_ovatus_30_one_epoch),
#             proportional_sfs(b_ovatus_30_two_epoch)) +
#   ggtitle('B. ovatus Downsampled to 30')
# 
# 
# # B. thetaiotaomicron
# plot_likelihood_surface('../Analysis/qp_gut_30/b_thetaiotaomicron_30.csv')
# b_thetaiotaomicron_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_30/empirical_sfs.txt'
# )
# b_thetaiotaomicron_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_30/one_epoch_demography.txt'
# )
# b_thetaiotaomicron_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_thetaiotaomicron_30_empirical,
#             b_thetaiotaomicron_30_one_epoch,
#             b_thetaiotaomicron_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. thetaiotaomicron Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_thetaiotaomicron_30_empirical),
#             proportional_sfs(b_thetaiotaomicron_30_one_epoch),
#             proportional_sfs(b_thetaiotaomicron_30_two_epoch)) +
#   ggtitle('B. thetaiotaomicron Downsampled to 30')
# 
# 
# # B. uniformis
# plot_likelihood_surface('../Analysis/qp_gut_30/b_uniformis_30.csv')
# b_uniformis_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_30/empirical_sfs.txt'
# )
# b_uniformis_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_30/one_epoch_demography.txt'
# )
# b_uniformis_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_uniformis_57318_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_uniformis_30_empirical,
#             b_uniformis_30_one_epoch,
#             b_uniformis_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. uniformis Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_uniformis_30_empirical),
#             proportional_sfs(b_uniformis_30_one_epoch),
#             proportional_sfs(b_uniformis_30_two_epoch)) +
#   ggtitle('B. uniformis Downsampled to 30')
# 
# 
# # B. vulgatus
# plot_likelihood_surface('../Analysis/qp_gut_30/b_vulgatus_30.csv')
# b_vulgatus_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_30/empirical_sfs.txt'
# )
# b_vulgatus_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_30/one_epoch_demography.txt'
# )
# b_vulgatus_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_vulgatus_57955_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_vulgatus_30_empirical,
#             b_vulgatus_30_one_epoch,
#             b_vulgatus_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. vulgatus Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_vulgatus_30_empirical),
#             proportional_sfs(b_vulgatus_30_one_epoch),
#             proportional_sfs(b_vulgatus_30_two_epoch)) +
#   ggtitle('B. vulgatus Downsampled to 30')
# 
# 
# 
# # B. xylanisolvens
# plot_likelihood_surface('../Analysis/qp_gut_30/b_xylanisolvens_30.csv')
# b_xylanisolvens_30_empirical =  read_input_sfs(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_30/empirical_sfs.txt'
# )
# b_xylanisolvens_30_one_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_30/one_epoch_demography.txt'
# )
# b_xylanisolvens_30_two_epoch = sfs_from_demography(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(b_xylanisolvens_30_empirical,
#             b_xylanisolvens_30_one_epoch,
#             b_xylanisolvens_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('B. xylanisolvens Downsampled to 30')
# 
# compare_sfs(proportional_sfs(b_xylanisolvens_30_empirical),
#             proportional_sfs(b_xylanisolvens_30_one_epoch),
#             proportional_sfs(b_xylanisolvens_30_two_epoch)) +
#   ggtitle('B. xylanisolvens Downsampled to 30')
# 
# 
# 
# # D. invisus
# plot_likelihood_surface('../Analysis/qp_gut_30/d_invisus_30.csv')
# d_invisus_30_empirical =  read_input_sfs(
#   '../Analysis/Dialister_invisus_61905_downsampled_30/empirical_sfs.txt'
# )
# d_invisus_30_one_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_30/one_epoch_demography.txt'
# )
# d_invisus_30_two_epoch = sfs_from_demography(
#   '../Analysis/Dialister_invisus_61905_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(d_invisus_30_empirical,
#             d_invisus_30_one_epoch,
#             d_invisus_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('D. invisus Downsampled to 30')
# 
# compare_sfs(proportional_sfs(d_invisus_30_empirical),
#             proportional_sfs(d_invisus_30_one_epoch),
#             proportional_sfs(d_invisus_30_two_epoch)) +
#   ggtitle('D. invisus Downsampled to 30')
# 
# 
# # E. eligens
# plot_likelihood_surface('../Analysis/qp_gut_30/e_eligens_30.csv')
# e_eligens_30_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_30/empirical_sfs.txt'
# )
# e_eligens_30_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_30/one_epoch_demography.txt'
# )
# e_eligens_30_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_eligens_61678_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(e_eligens_30_empirical,
#             e_eligens_30_one_epoch,
#             e_eligens_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. eligens Downsampled to 30')
# 
# compare_sfs(proportional_sfs(e_eligens_30_empirical),
#             proportional_sfs(e_eligens_30_one_epoch),
#             proportional_sfs(e_eligens_30_two_epoch)) +
#   ggtitle('E. eligens Downsampled to 30')
# 
# 
# 
# # E. rectale
# plot_likelihood_surface('../Analysis/qp_gut_30/e_rectale_30.csv')
# e_rectale_30_empirical =  read_input_sfs(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_30/empirical_sfs.txt'
# )
# e_rectale_30_one_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_30/one_epoch_demography.txt'
# )
# e_rectale_30_two_epoch = sfs_from_demography(
#   '../Analysis/Eubacterium_rectale_56927_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(e_rectale_30_empirical,
#             e_rectale_30_one_epoch,
#             e_rectale_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('E. rectale Downsampled to 30')
# 
# compare_sfs(proportional_sfs(e_rectale_30_empirical),
#             proportional_sfs(e_rectale_30_one_epoch),
#             proportional_sfs(e_rectale_30_two_epoch)) +
#   ggtitle('E. rectale Downsampled to 30')
# 
# 
# # F. prausnitzii
# plot_likelihood_surface('../Analysis/qp_gut_30/f_prausnitzii_30.csv')
# f_prausnitzii_30_empirical =  read_input_sfs(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_30/empirical_sfs.txt'
# )
# f_prausnitzii_30_one_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_30/one_epoch_demography.txt'
# )
# f_prausnitzii_30_two_epoch = sfs_from_demography(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(f_prausnitzii_30_empirical,
#             f_prausnitzii_30_one_epoch,
#             f_prausnitzii_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('F. prausnitzii Downsampled to 30')
# 
# compare_sfs(proportional_sfs(f_prausnitzii_30_empirical),
#             proportional_sfs(f_prausnitzii_30_one_epoch),
#             proportional_sfs(f_prausnitzii_30_two_epoch)) +
#   ggtitle('F. prausnitzii Downsampled to 30')
# 
# 
# # Oscillibacter sp.
# plot_likelihood_surface('../Analysis/qp_gut_30/oscillibacter_sp_30.csv')
# oscillibacter_sp_30_empirical =  read_input_sfs(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_30/empirical_sfs.txt'
# )
# oscillibacter_sp_30_one_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_30/one_epoch_demography.txt'
# )
# oscillibacter_sp_30_two_epoch = sfs_from_demography(
#   '../Analysis/Oscillibacter_sp_60799_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(oscillibacter_sp_30_empirical,
#             oscillibacter_sp_30_one_epoch,
#             oscillibacter_sp_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Oscillibacter sp. Downsampled to 30')
# 
# compare_sfs(proportional_sfs(oscillibacter_sp_30_empirical),
#             proportional_sfs(oscillibacter_sp_30_one_epoch),
#             proportional_sfs(oscillibacter_sp_30_two_epoch)) +
#   ggtitle('Oscillibacter sp. Downsampled to 30')
# 
# 
# # o. splanchnicus
# plot_likelihood_surface('../Analysis/qp_gut_30/o_splanchnicus_30.csv')
# o_splanchnicus_30_empirical =  read_input_sfs(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_30/empirical_sfs.txt'
# )
# o_splanchnicus_30_one_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_30/one_epoch_demography.txt'
# )
# o_splanchnicus_30_two_epoch = sfs_from_demography(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(o_splanchnicus_30_empirical,
#             o_splanchnicus_30_one_epoch,
#             o_splanchnicus_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('O. splanchnicus Downsampled to 30')
# 
# compare_sfs(proportional_sfs(o_splanchnicus_30_empirical),
#             proportional_sfs(o_splanchnicus_30_one_epoch),
#             proportional_sfs(o_splanchnicus_30_two_epoch)) +
#   ggtitle('O. splanchnicus Downsampled to 30')
# 
# 
# # P. copri
# plot_likelihood_surface('../Analysis/qp_gut_30/p_copri_30.csv')
# p_copri_30_empirical =  read_input_sfs(
#   '../Analysis/Prevotella_copri_61740_downsampled_30/empirical_sfs.txt'
# )
# p_copri_30_one_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_30/one_epoch_demography.txt'
# )
# p_copri_30_two_epoch = sfs_from_demography(
#   '../Analysis/Prevotella_copri_61740_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(p_copri_30_empirical,
#             p_copri_30_one_epoch,
#             p_copri_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. copri Downsampled to 30')
# 
# compare_sfs(proportional_sfs(p_copri_30_empirical),
#             proportional_sfs(p_copri_30_one_epoch),
#             proportional_sfs(p_copri_30_two_epoch)) +
#   ggtitle('P. copri Downsampled to 30')
# 
# 
# # P. distasonis
# plot_likelihood_surface('../Analysis/qp_gut_30/p_distasonis_30.csv')
# p_distasonis_30_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_30/empirical_sfs.txt'
# )
# p_distasonis_30_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_30/one_epoch_demography.txt'
# )
# p_distasonis_30_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_distasonis_56985_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(p_distasonis_30_empirical,
#             p_distasonis_30_one_epoch,
#             p_distasonis_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. distasonis Downsampled to 30')
# 
# compare_sfs(proportional_sfs(p_distasonis_30_empirical),
#             proportional_sfs(p_distasonis_30_one_epoch),
#             proportional_sfs(p_distasonis_30_two_epoch)) +
#   ggtitle('P. distasonis Downsampled to 30')
# 
# 
# # P. merdae
# plot_likelihood_surface('../Analysis/qp_gut_30/p_merdae_30.csv')
# p_merdae_30_empirical =  read_input_sfs(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_30/empirical_sfs.txt'
# )
# p_merdae_30_one_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_30/one_epoch_demography.txt'
# )
# p_merdae_30_two_epoch = sfs_from_demography(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(p_merdae_30_empirical,
#             p_merdae_30_one_epoch,
#             p_merdae_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('P. merdae Downsampled to 30')
# 
# compare_sfs(proportional_sfs(p_merdae_30_empirical),
#             proportional_sfs(p_merdae_30_one_epoch),
#             proportional_sfs(p_merdae_30_two_epoch)) +
#   ggtitle('P. merdae Downsampled to 30')
# 
# 
# # Phascolarctobacterium sp.
# plot_likelihood_surface('../Analysis/qp_gut_30/phascolarctobacterium_sp_30.csv')
# phascolarctobacterium_sp_30_empirical =  read_input_sfs(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_30/empirical_sfs.txt'
# )
# phascolarctobacterium_sp_30_one_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_30/one_epoch_demography.txt'
# )
# phascolarctobacterium_sp_30_two_epoch = sfs_from_demography(
#   '../Analysis/Phascolarctobacterium_sp_59817_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(phascolarctobacterium_sp_30_empirical,
#             phascolarctobacterium_sp_30_one_epoch,
#             phascolarctobacterium_sp_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 30')
# 
# compare_sfs(proportional_sfs(phascolarctobacterium_sp_30_empirical),
#             proportional_sfs(phascolarctobacterium_sp_30_one_epoch),
#             proportional_sfs(phascolarctobacterium_sp_30_two_epoch)) +
#   ggtitle('Phascolarctobacterium sp. Downsampled to 30')
# 
# 
# # R. bicirculans
# plot_likelihood_surface('../Analysis/qp_gut_30/r_bicirculans_30.csv')
# r_bicirculans_30_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_30/empirical_sfs.txt'
# )
# r_bicirculans_30_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_30/one_epoch_demography.txt'
# )
# r_bicirculans_30_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bicirculans_59300_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(r_bicirculans_30_empirical,
#             r_bicirculans_30_one_epoch,
#             r_bicirculans_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bicirculans Downsampled to 30')
# 
# compare_sfs(proportional_sfs(r_bicirculans_30_empirical),
#             proportional_sfs(r_bicirculans_30_one_epoch),
#             proportional_sfs(r_bicirculans_30_two_epoch)) +
#   ggtitle('R. bicirculans Downsampled to 30')
# 
# # R. bromii
# plot_likelihood_surface('../Analysis/qp_gut_30/r_bromii_30.csv')
# r_bromii_30_empirical =  read_input_sfs(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_30/empirical_sfs.txt'
# )
# r_bromii_30_one_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_30/one_epoch_demography.txt'
# )
# r_bromii_30_two_epoch = sfs_from_demography(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_30/two_epoch_demography.txt'
# )
# compare_sfs(r_bromii_30_empirical,
#             r_bromii_30_one_epoch,
#             r_bromii_30_two_epoch) +
#   ylab('Raw Count of Segregating Sites') +
#   ggtitle('R. bromii Downsampled to 30')
# 
# compare_sfs(proportional_sfs(r_bromii_30_empirical),
#             proportional_sfs(r_bromii_30_one_epoch),
#             proportional_sfs(r_bromii_30_two_epoch)) +
#   ggtitle('R. bromii Downsampled to 30')
# 
# # Original empirical SFS with Clade Control
# 
# plot_original_empirical_sfs(a_muciniphila_original_empirical) + ggtitle('A. muciniphila full empirical SFS (unfolded)')
# 
# plot_original_empirical_sfs(fold_sfs(a_muciniphila_original_empirical)) + ggtitle('A. mucinaphila full empirical SFS (folded)')
# a_muciniphila_garud_good_empirical = read_input_sfs_original('../Data/Akkermansia_muciniphila_55290_syn.sfs')
# plot_original_empirical_sfs(fold_sfs(a_muciniphila_garud_good_empirical)) + ggtitle('A. muciniphila folded SFS (Garud/Good code base)')
# 
# temp_x_axis = 0:(length(fold_sfs(a_muciniphila_original_empirical))-1)
# 
# compare_sfs(temp_x_axis,
#             fold_sfs(a_muciniphila_original_empirical),
#             fold_sfs(c(a_muciniphila_garud_good_empirical, 0, 0, 0, 0, 0, 0)))
# 
# plot_original_empirical_sfs(a_muciniphila_original_empirical) + ggtitle('A. muciniphila full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(a_finegoldii_original_empirical) + ggtitle('A. finegoldii full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(a_onderdonkii_original_empirical) + ggtitle('A. onderdonkii full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(a_putredinis_original_empirical) + ggtitle('A. putredinis full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(a_shahii_original_empirical) + ggtitle('A. shahii full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_bacterium_original_empirical) + ggtitle('B. bacterium full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_caccae_original_empirical) + ggtitle('B. caccae full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_cellulosilyticus_original_empirical) + ggtitle('B. cellulosilyticus full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_fragilis_original_empirical) + ggtitle('B. fragilis full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_massiliensis_original_empirical) + ggtitle('B. massiliensis full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_ovatus_original_empirical) + ggtitle('B. ovatus full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_stercoris_original_empirical) + ggtitle('B. stercoris full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_thetaiotaomicron_original_empirical) + ggtitle('B. thetaiotaomicron full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_uniformis_original_empirical) + ggtitle('B. uniformis full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_vulgatus_original_empirical) + ggtitle('B. vulgatus full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_xylanisolvens_original_empirical) + ggtitle('B. xylanisolvens full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(b_intestinihominis_original_empirical) + ggtitle('B. intestinihominis full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(c_sp_original_empirical) + ggtitle('Coprococcus sp full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(d_invisus_original_empirical) + ggtitle('D. invisus full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(e_eligens_original_empirical) + ggtitle('E. eligens full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(e_rectale_original_empirical) + ggtitle('E. rectale full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(f_prausnitzii_original_empirical) + ggtitle('F. prausnitzii full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(o_splanchnicus_original_empirical) + ggtitle('O. splanchnicus full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(oscillibacter_sp_original_empirical) + ggtitle('Oscillibacter sp full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(p_distasonis_original_empirical) + ggtitle('P. distasonis full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(p_merdae_original_empirical) + ggtitle('P. merdae full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(phascolarctobacterium_sp_original_empirical) + ggtitle('Phascolarctobacterium sp. full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(p_copri_original_empirical) + ggtitle('P. copri full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(r_bicirculans_original_empirical) + ggtitle('R. bicirculans full empirical SFS (unfolded + Clade Control)')
# plot_original_empirical_sfs(r_bromii_original_empirical) + ggtitle('R. bromii full empirical SFS (unfolded + Clade Control)')
# 
# ## Folded
# 
# plot_original_empirical_sfs(fold_sfs(a_muciniphila_original_empirical)) + ggtitle('A. muciniphila full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(a_finegoldii_original_empirical)) + ggtitle('A. finegoldii full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(a_onderdonkii_original_empirical)) + ggtitle('A. onderdonkii full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(a_putredinis_original_empirical)) + ggtitle('A. putredinis full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(a_shahii_original_empirical)) + ggtitle('A. shahii full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_bacterium_original_empirical)) + ggtitle('B. bacterium full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_caccae_original_empirical)) + ggtitle('B. caccae full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_cellulosilyticus_original_empirical)) + ggtitle('B. cellulosilyticus full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_fragilis_original_empirical)) + ggtitle('B. fragilis full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_massiliensis_original_empirical)) + ggtitle('B. massiliensis full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_ovatus_original_empirical)) + ggtitle('B. ovatus full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_stercoris_original_empirical)) + ggtitle('B. stercoris full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_thetaiotaomicron_original_empirical)) + ggtitle('B. thetaiotaomicron full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_uniformis_original_empirical)) + ggtitle('B. uniformis full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_vulgatus_original_empirical)) + ggtitle('B. vulgatus full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_xylanisolvens_original_empirical)) + ggtitle('B. xylanisolvens full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_intestinihominis_original_empirical)) + ggtitle('B. intestinihominis full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(c_sp_original_empirical)) + ggtitle('Coprococcus sp full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(d_invisus_original_empirical)) + ggtitle('D. invisus full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(e_eligens_original_empirical)) + ggtitle('E. eligens full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(e_rectale_original_empirical)) + ggtitle('E. rectale full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(f_prausnitzii_original_empirical)) + ggtitle('F. prausnitzii full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(o_splanchnicus_original_empirical)) + ggtitle('O. splanchnicus full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(oscillibacter_sp_original_empirical)) + ggtitle('Oscillibacter sp full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(p_distasonis_original_empirical)) + ggtitle('P. distasonis full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(p_merdae_original_empirical)) + ggtitle('P. merdae full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(phascolarctobacterium_sp_original_empirical)) + ggtitle('Phascolarctobacterium sp. full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(p_copri_original_empirical)) + ggtitle('P. copri full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(r_bicirculans_original_empirical)) + ggtitle('R. bicirculans full empirical SFS (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(r_bromii_original_empirical)) + ggtitle('R. bromii full empirical SFS (folded + Clade Control)')
# 
# 
# # SFS without Clade Control
# a_muciniphila_no_clade_control = read_input_sfs_original('../Analysis/Akkermansia_muciniphila_55290_no_clade_control/empirical_sfs.txt')
# a_finegoldii_no_clade_control = read_input_sfs_original('../Analysis/Alistipes_finegoldii_56071_no_clade_control/empirical_sfs.txt')
# a_onderdonkii_no_clade_control = read_input_sfs_original('../Analysis/Alistipes_onderdonkii_55464_no_clade_control/empirical_sfs.txt')
# a_putredinis_no_clade_control = read_input_sfs_original('../Analysis/Alistipes_putredinis_61533_no_clade_control/empirical_sfs.txt')
# a_shahii_no_clade_control = read_input_sfs_original('../Analysis/Alistipes_shahii_62199_no_clade_control/empirical_sfs.txt')
# b_bacterium_no_clade_control = read_input_sfs_original('../Analysis/Bacteroidales_bacterium_58650_no_clade_control/empirical_sfs.txt')
# b_caccae_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_caccae_53434_no_clade_control/empirical_sfs.txt')
# b_cellulosilyticus_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_cellulosilyticus_58046_no_clade_control/empirical_sfs.txt')
# b_fragilis_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_fragilis_54507_no_clade_control/empirical_sfs.txt')
# b_massiliensis_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_massiliensis_44749_no_clade_control/empirical_sfs.txt')
# b_ovatus_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_ovatus_58035_no_clade_control/empirical_sfs.txt')
# b_stercoris_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_stercoris_56735_no_clade_control/empirical_sfs.txt')
# b_thetaiotaomicron_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_thetaiotaomicron_56941_no_clade_control/empirical_sfs.txt')
# b_uniformis_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_uniformis_57318_no_clade_control/empirical_sfs.txt')
b_vulgatus_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_vulgatus_57955_no_clade_control/empirical_sfs.txt')
# b_xylanisolvens_no_clade_control = read_input_sfs_original('../Analysis/Bacteroides_xylanisolvens_57185_no_clade_control/empirical_sfs.txt')
# b_intestinihominis_no_clade_control = read_input_sfs_original('../Analysis/Barnesiella_intestinihominis_62208_no_clade_control/empirical_sfs.txt')
# c_sp_no_clade_control = read_input_sfs_original('../Analysis/Coprococcus_sp_62244_no_clade_control/empirical_sfs.txt')
# d_invisus_no_clade_control = read_input_sfs_original('../Analysis/Dialister_invisus_61905_no_clade_control/empirical_sfs.txt')
# e_eligens_no_clade_control = read_input_sfs_original('../Analysis/Eubacterium_eligens_61678_no_clade_control/empirical_sfs.txt')
# e_rectale_no_clade_control = read_input_sfs_original('../Analysis/Eubacterium_rectale_56927_no_clade_control/empirical_sfs.txt')
# f_prausnitzii_no_clade_control = read_input_sfs_original('../Analysis/Faecalibacterium_prausnitzii_57453_no_clade_control/empirical_sfs.txt')
# o_splanchnicus_no_clade_control = read_input_sfs_original('../Analysis/Odoribacter_splanchnicus_62174_no_clade_control/empirical_sfs.txt')
# oscillibacter_sp_no_clade_control = read_input_sfs_original('../Analysis/Oscillibacter_sp_60799_no_clade_control/empirical_sfs.txt')
# p_distasonis_no_clade_control = read_input_sfs_original('../Analysis/Parabacteroides_distasonis_56985_no_clade_control/empirical_sfs.txt')
# p_merdae_no_clade_control = read_input_sfs_original('../Analysis/Parabacteroides_merdae_56972_no_clade_control/empirical_sfs.txt')
# phascolarctobacterium_sp_no_clade_control = read_input_sfs_original('../Analysis/Phascolarctobacterium_sp_59817_no_clade_control/empirical_sfs.txt')
# p_copri_no_clade_control = read_input_sfs_original('../Analysis/Prevotella_copri_61740_no_clade_control/empirical_sfs.txt')
# r_bicirculans_no_clade_control = read_input_sfs_original('../Analysis/Ruminococcus_bicirculans_59300_no_clade_control/empirical_sfs.txt')
# r_bromii_no_clade_control = read_input_sfs_original('../Analysis/Ruminococcus_bromii_62047_no_clade_control/empirical_sfs.txt')
# 
# # Plotting SFS without Clade Control
# plot_original_empirical_sfs(a_muciniphila_no_clade_control) + ggtitle('A. muciniphila full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(a_finegoldii_no_clade_control) + ggtitle('A. finegoldii full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(a_onderdonkii_no_clade_control) + ggtitle('A. onderdonkii full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(a_putredinis_no_clade_control) + ggtitle('A. putredinis full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(a_shahii_no_clade_control) + ggtitle('A. shahii full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_bacterium_no_clade_control) + ggtitle('B. bacterium full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_caccae_no_clade_control) + ggtitle('B. caccae full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_cellulosilyticus_no_clade_control) + ggtitle('B. cellulosilyticus full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_fragilis_no_clade_control) + ggtitle('B. fragilis full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_massiliensis_no_clade_control) + ggtitle('B. massiliensis full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_ovatus_no_clade_control) + ggtitle('B. ovatus full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_stercoris_no_clade_control) + ggtitle('B. stercoris full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_thetaiotaomicron_no_clade_control) + ggtitle('B. thetaiotaomicron full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_uniformis_no_clade_control) + ggtitle('B. uniformis full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_vulgatus_no_clade_control) + ggtitle('B. vulgatus full empirical SFS (unfolded with no Clade Control)') +
  scale_x_continuous()
# plot_original_empirical_sfs(b_xylanisolvens_no_clade_control) + ggtitle('B. xylanisolvens full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(b_intestinihominis_no_clade_control) + ggtitle('B. intestinihominis full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(c_sp_no_clade_control) + ggtitle('Coprococcus sp full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(d_invisus_no_clade_control) + ggtitle('D. invisus full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(e_eligens_no_clade_control) + ggtitle('E. eligens full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(e_rectale_no_clade_control) + ggtitle('E. rectale full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(f_prausnitzii_no_clade_control) + ggtitle('F. prausnitzii full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(o_splanchnicus_no_clade_control) + ggtitle('O. splanchnicus full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(oscillibacter_sp_no_clade_control) + ggtitle('Oscillibacter sp full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(p_distasonis_no_clade_control) + ggtitle('P. distasonis full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(p_merdae_no_clade_control) + ggtitle('P. merdae full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(phascolarctobacterium_sp_no_clade_control) + ggtitle('Phascolarctobacterium sp. full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(p_copri_no_clade_control) + ggtitle('P. copri full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(r_bicirculans_no_clade_control) + ggtitle('R. bicirculans full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(r_bromii_no_clade_control) + ggtitle('R. bromii full empirical SFS (unfolded with no Clade Control)') +
#   scale_x_continuous()
# 
# ## Folded
# 
# # Plotting SFS without Clade Control
# plot_original_empirical_sfs(fold_sfs(a_muciniphila_no_clade_control)) + ggtitle('A. muciniphila full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(a_finegoldii_no_clade_control)) + ggtitle('A. finegoldii full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(a_onderdonkii_no_clade_control)) + ggtitle('A. onderdonkii full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(a_putredinis_no_clade_control)) + ggtitle('A. putredinis full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(a_shahii_no_clade_control)) + ggtitle('A. shahii full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_bacterium_no_clade_control)) + ggtitle('B. bacterium full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_caccae_no_clade_control)) + ggtitle('B. caccae full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_cellulosilyticus_no_clade_control)) + ggtitle('B. cellulosilyticus full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_fragilis_no_clade_control)) + ggtitle('B. fragilis full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_massiliensis_no_clade_control)) + ggtitle('B. massiliensis full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_ovatus_no_clade_control)) + ggtitle('B. ovatus full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_stercoris_no_clade_control)) + ggtitle('B. stercoris full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_thetaiotaomicron_no_clade_control)) + ggtitle('B. thetaiotaomicron full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_uniformis_no_clade_control)) + ggtitle('B. uniformis full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_vulgatus_no_clade_control)) + ggtitle('B. vulgatus full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_xylanisolvens_no_clade_control)) + ggtitle('B. xylanisolvens full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(b_intestinihominis_no_clade_control)) + ggtitle('B. intestinihominis full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(c_sp_no_clade_control)) + ggtitle('Coprococcus sp full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(d_invisus_no_clade_control)) + ggtitle('D. invisus full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(e_eligens_no_clade_control)) + ggtitle('E. eligens full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(e_rectale_no_clade_control)) + ggtitle('E. rectale full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(f_prausnitzii_no_clade_control)) + ggtitle('F. prausnitzii full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(o_splanchnicus_no_clade_control)) + ggtitle('O. splanchnicus full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(oscillibacter_sp_no_clade_control)) + ggtitle('Oscillibacter sp full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(p_distasonis_no_clade_control)) + ggtitle('P. distasonis full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(p_merdae_no_clade_control)) + ggtitle('P. merdae full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(phascolarctobacterium_sp_no_clade_control)) + ggtitle('Phascolarctobacterium sp. full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(p_copri_no_clade_control)) + ggtitle('P. copri full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(r_bicirculans_no_clade_control)) + ggtitle('R. bicirculans full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# plot_original_empirical_sfs(fold_sfs(r_bromii_no_clade_control)) + ggtitle('R. bromii full empirical SFS (folded with no Clade Control)') +
#   scale_x_continuous()
# 
# # Plot SFS downsampled to 14
# plot_original_empirical_sfs(fold_sfs(a_muciniphila_14_empirical)) + ggtitle('A. muciniphila downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(a_finegoldii_14_empirical)) + ggtitle('A. finegoldii downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(a_onderdonkii_14_empirical)) + ggtitle('A. onderdonkii downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(a_putredinis_14_empirical)) + ggtitle('A. putredinis downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(a_shahii_14_empirical)) + ggtitle('A. shahii downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_bacterium_14_empirical)) + ggtitle('B. bacterium downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_caccae_14_empirical)) + ggtitle('B. caccae downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_cellulosilyticus_14_empirical)) + ggtitle('B. cellulosilyticus downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_fragilis_14_empirical)) + ggtitle('B. fragilis downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_massiliensis_14_empirical)) + ggtitle('B. massiliensis downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_ovatus_14_empirical)) + ggtitle('B. ovatus downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_stercoris_14_empirical)) + ggtitle('B. stercoris downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_thetaiotaomicron_14_empirical)) + ggtitle('B. thetaiotaomicron downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_uniformis_14_empirical)) + ggtitle('B. uniformis downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_vulgatus_14_empirical)) + ggtitle('B. vulgatus downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_xylanisolvens_14_empirical)) + ggtitle('B. xylanisolvens downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(b_intestinihominis_14_empirical)) + ggtitle('B. intestinihominis downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(c_sp_14_empirical)) + ggtitle('Coprococcus sp downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(d_invisus_14_empirical)) + ggtitle('D. invisus downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(e_eligens_14_empirical)) + ggtitle('E. eligens downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(e_rectale_14_empirical)) + ggtitle('E. rectale downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(f_prausnitzii_14_empirical)) + ggtitle('F. prausnitzii downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(o_splanchnicus_14_empirical)) + ggtitle('O. splanchnicus downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(oscillibacter_sp_14_empirical)) + ggtitle('Oscillibacter sp downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(p_distasonis_14_empirical)) + ggtitle('P. distasonis downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(p_merdae_14_empirical)) + ggtitle('P. merdae downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(phascolarctobacterium_sp_14_empirical)) + ggtitle('Phascolarctobacterium sp. downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(p_copri_14_empirical)) + ggtitle('P. copri downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(r_bicirculans_14_empirical)) + ggtitle('R. bicirculans downsampled to 14 (folded + Clade Control)')
# plot_original_empirical_sfs(fold_sfs(r_bromii_14_empirical)) + ggtitle('R. bromii full empirical SFS (folded + Clade Control))')
# 
# 
# # DFE
# 
# # Akkermansia_muciniphila_55290
# compare_sfs_cornejo_count('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/') +
#   ggtitle('A. muciniphila SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/') +
#   ggtitle('A. muciniphila SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/') +
#   ggtitle('A. muciniphila SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/') +
#   ggtitle('A. muciniphila SFS Comparison')
# 
# plot_dfe('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/inferred_DFE.txt') +
#   ggtitle('A. muciniphila DFE Comparison')
# 
# # Alistipes_finegoldii_56071
# compare_sfs_cornejo_count('../Analysis/Alistipes_finegoldii_56071_downsampled_14/') +
#   ggtitle('A. finegoldii SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Alistipes_finegoldii_56071_downsampled_14/') +
#   ggtitle('A. finegoldii SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Alistipes_finegoldii_56071_downsampled_14/') +
#   ggtitle('A. finegoldii SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Alistipes_finegoldii_56071_downsampled_14/') +
#   ggtitle('A. finegoldii SFS Comparison')
# 
# plot_dfe('../Analysis/Alistipes_finegoldii_56071_downsampled_14/inferred_DFE.txt') +
#   ggtitle('A. finegoldii DFE Comparison')
# 
# # Alistipes_onderdonkii_55464
# compare_sfs_cornejo_count('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/') +
#   ggtitle('A. onderdonkii SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/') +
#   ggtitle('A. onerdonkii SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/') +
#   ggtitle('A. onderdonkii SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/') +
#   ggtitle('A. onerdonkii SFS Comparison')
# 
# plot_dfe('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/inferred_DFE.txt') +
#   ggtitle('A. onderdonkii DFE Comparison')
# 
# # Alistipes_putredinis_61533
# compare_sfs_cornejo_count('../Analysis/Alistipes_putredinis_61533_downsampled_14/') +
#   ggtitle('A. putredinis SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Alistipes_putredinis_61533_downsampled_14/') +
#   ggtitle('A. putredinis SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Alistipes_putredinis_61533_downsampled_14/') +
#   ggtitle('A. putredinis SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Alistipes_putredinis_61533_downsampled_14/') +
#   ggtitle('A. putredinis SFS Comparison')
# 
# plot_dfe('../Analysis/Alistipes_putredinis_61533_downsampled_14/inferred_DFE.txt') +
#   ggtitle('A. putredinis DFE Comparison')
# 
# # Alistipes_shahii_62199
# compare_sfs_cornejo_count('../Analysis/Alistipes_shahii_62199_downsampled_14/') +
#   ggtitle('A. shahii SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Alistipes_shahii_62199_downsampled_14/') +
#   ggtitle('A. shahii SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Alistipes_shahii_62199_downsampled_14/') +
#   ggtitle('A. shahii SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Alistipes_shahii_62199_downsampled_14/') +
#   ggtitle('A. shahii SFS Comparison')
# 
# plot_dfe('../Analysis/Alistipes_shahii_62199_downsampled_14/inferred_DFE.txt') +
#   ggtitle('A. shahii DFE Comparison')
# 
# # Bacteroidales_bacterium_58650
# compare_sfs_cornejo_count('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/') +
#   ggtitle('B. bacterium SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/') +
#   ggtitle('B. bacterium SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/') +
#   ggtitle('B. bacterium SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/') +
#   ggtitle('B. bacterium SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. bacterium DFE Comparison')
# 
# # Bacteroides_caccae_53434
# compare_sfs_cornejo_count('../Analysis/Bacteroides_caccae_53434_downsampled_14/') +
#   ggtitle('B. caccae SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroides_caccae_53434_downsampled_14/') +
#   ggtitle('B. caccae SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroides_caccae_53434_downsampled_14/') +
#   ggtitle('B. caccae SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroides_caccae_53434_downsampled_14/') +
#   ggtitle('B. caccae SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroides_caccae_53434_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. caccae DFE Comparison')
# 
# # Bacteroides_cellulosilyticus_58046
# compare_sfs_cornejo_count('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/') +
#   ggtitle('B. cellulosilyticus SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/') +
#   ggtitle('B. cellulosilyticus SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/') +
#   ggtitle('B. cellulosilyticus SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/') +
#   ggtitle('B. cellulosilyticus SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. cellulosilyticus DFE Comparison')
# 
# # Bacteroides_fragilis_54507
# compare_sfs_cornejo_count('../Analysis/Bacteroides_fragilis_54507_downsampled_14/') +
#   ggtitle('B. fragilis SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroides_fragilis_54507_downsampled_14/') +
#   ggtitle('B. fragilis SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroides_fragilis_54507_downsampled_14/') +
#   ggtitle('B. fragilis SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroides_fragilis_54507_downsampled_14/') +
#   ggtitle('B. fragilis SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. fragilis DFE Comparison')
# 
# # Bacteroides_massiliensis_44749
# # compare_sfs_with_selection_count('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/') +
# #   ggtitle('B. massiliensis SFS Comparison')
# # 
# # compare_sfs_with_selection_proportional('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/') +
# #   ggtitle('B. massiliensis SFS Comparison')
# #
# # plot_dfe('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/inferred_DFE.txt') +
# #   ggtitle('B. massiliensis SFS Comparison')
# 
# # Bacteroides_ovatus_58035
# compare_sfs_cornejo_count('../Analysis/Bacteroides_ovatus_58035_downsampled_14/') +
#   ggtitle('B. ovatus SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroides_ovatus_58035_downsampled_14/') +
#   ggtitle('B. ovatus SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroides_ovatus_58035_downsampled_14/') +
#   ggtitle('B. ovatus SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroides_ovatus_58035_downsampled_14/') +
#   ggtitle('B. ovatus SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroides_ovatus_58035_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. ovatus DFE Comparison')
# 
# # Bacteroides_stercoris_56735
# # compare_sfs_with_selection_count('../Analysis/Bacteroides_stercoris_56735_downsampled_14/') +
# #   ggtitle('B. stercoris SFS Comparison')
# # 
# # compare_sfs_with_selection_proportional('../Analysis/Bacteroides_stercoris_56735_downsampled_14/') +
# #   ggtitle('B. stercoris SFS Comparison')
# # 
# # plot_dfe('../Analysis/Bacteroides_stercoris_56735_downsampled_14/inferred_DFE.txt') +
# #  ggtitle('B. stercoris SFS Comparison')
# 
# # Bacteroides_thetaiotaomicron_56941
# compare_sfs_cornejo_count('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/') +
#   ggtitle('B. thetaiotaomicron SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/') +
#   ggtitle('B. thetaiotaomicron SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/') +
#   ggtitle('B. thetaiotaomicron SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/') +
#   ggtitle('B. thetaiotaomicron SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. thetaiotaomicron DFE Comparison')
# 
# # Bacteroides_uniformis_57318
# compare_sfs_cornejo_count('../Analysis/Bacteroides_uniformis_57318_downsampled_14/') +
#   ggtitle('B. uniformis SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroides_uniformis_57318_downsampled_14/') +
#   ggtitle('B. uniformis SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroides_uniformis_57318_downsampled_14/') +
#   ggtitle('B. uniformis SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroides_uniformis_57318_downsampled_14/') +
#   ggtitle('B. uniformis SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. uniformis DFE Comparison')
# 
# # Bacteroides_vulgatus_57955
# compare_sfs_cornejo_count('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/') +
#   ggtitle('B. vulgatus SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/') +
#   ggtitle('B. vulgatus SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/') +
#   ggtitle('B. vulgatus SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/') +
#   ggtitle('B. vulgatus SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. vulgatus DFE Comparison')
# 
# # Bacteroides_xylanisolvens_57185
# compare_sfs_cornejo_count('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/') +
#   ggtitle('B. xylanisolvens SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/') +
#   ggtitle('B. xylanisolvens SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/') +
#   ggtitle('B. xylanisolvens SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/') +
#   ggtitle('B. xylanisolvens SFS Comparison')
# 
# plot_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. xylanisolvens DFE Comparison')
# 
# # Barnesiella_intestinihominis_62208
# compare_sfs_cornejo_count('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/') +
#   ggtitle('B. intestinihominis SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/') +
#   ggtitle('B. intestinihominis SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/') +
#   ggtitle('B. intestinihominis SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/') +
#   ggtitle('B. intestinihominis SFS Comparison')
# 
# plot_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/inferred_DFE.txt') +
#   ggtitle('B. intestinihominis DFE Comparison')
# 
# # Coprococcus_sp_62244
# # compare_sfs_with_selection_count('../Analysis/Coprococcus_sp_62244_downsampled_14/') +
# #   ggtitle('Coprococcus sp. SFS Comparison')
# # 
# # compare_sfs_with_selection_proportional('../Analysis/Coprococcus_sp_62244_downsampled_14/') +
# #   ggtitle('Coprococcus sp. SFS Comparison')
# # 
# # plot_dfe('../Analysis/Coprococcus_sp_62244_downsampled_14/inferred_DFE.txt') +
# #   ggtitle('Coprococcus sp. SFS Comparison')
# 
# # Dialister_invisus_61905
# compare_sfs_cornejo_count('../Analysis/Dialister_invisus_61905_downsampled_14/') +
#   ggtitle('D. invisus SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Dialister_invisus_61905_downsampled_14/') +
#   ggtitle('D. invisus SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Dialister_invisus_61905_downsampled_14/') +
#   ggtitle('D. invisus SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Dialister_invisus_61905_downsampled_14/') +
#   ggtitle('D. invisus SFS Comparison')
# 
# plot_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/inferred_DFE.txt') +
#   ggtitle('D. invisus DFE Comparison')
# 
# # Eubacterium_eligens_61678
# # compare_sfs_with_selection_count('../Analysis/Eubacterium_eligens_61678_downsampled_14/') +
# #   ggtitle('E. eligens SFS Comparison')
# # 
# # compare_sfs_with_selection_proportional('../Analysis/Eubacterium_eligens_61678_downsampled_14/') +
# #   ggtitle('E. eligens SFS Comparison')
# # 
# # plot_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/inferred_DFE.txt') +
# #   ggtitle('E. eligens SFS Comparison')
# 
# # Eubacterium_rectale_56927
# compare_sfs_cornejo_count('../Analysis/Eubacterium_rectale_56927_downsampled_14/') +
#   ggtitle('E. rectale SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Eubacterium_rectale_56927_downsampled_14/') +
#   ggtitle('E. rectale SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Eubacterium_rectale_56927_downsampled_14/') +
#   ggtitle('E. rectale SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Eubacterium_rectale_56927_downsampled_14/') +
#   ggtitle('E. rectale SFS Comparison')
# 
# plot_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/inferred_DFE.txt') +
#   ggtitle('E. rectale DFE Comparison')
# 
# # Faecalibacterium_prausnitzii_57453
# compare_sfs_cornejo_count('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/') +
#   ggtitle('F. prausnitzii SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/') +
#   ggtitle('F. prausnitzii SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/') +
#   ggtitle('F. prausnitzii SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/') +
#   ggtitle('F. prausnitzii SFS Comparison')
# 
# plot_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/inferred_DFE.txt') +
#   ggtitle('F. prausnitzii DFE Comparison')
# 
# # Odoribacter_splanchnicus_62174
# compare_sfs_cornejo_count('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/') +
#   ggtitle('O. splanchnicus SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/') +
#   ggtitle('O. splanchnicus SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/') +
#   ggtitle('O. splanchnicus SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/') +
#   ggtitle('O. splanchnicus SFS Comparison')
# 
# plot_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/inferred_DFE.txt') +
#   ggtitle('O. splanchnicus DFE Comparison')
# 
# # Oscillibacter_sp_60799
# compare_sfs_cornejo_count('../Analysis/Oscillibacter_sp_60799_downsampled_14/') +
#   ggtitle('Oscillibacter sp. SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Oscillibacter_sp_60799_downsampled_14/') +
#   ggtitle('Oscillibacter sp. SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Oscillibacter_sp_60799_downsampled_14/') +
#   ggtitle('Oscillibacter sp. SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Oscillibacter_sp_60799_downsampled_14/') +
#   ggtitle('Oscillibacter sp. SFS Comparison')
# 
# plot_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/inferred_DFE.txt') +
#   ggtitle('Oscillibacter sp. DFE Comparison')
# 
# # Parabacteroides_distasonis_56985
# compare_sfs_cornejo_count('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/') +
#   ggtitle('P. distasonis SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/') +
#   ggtitle('P. distasonis SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/') +
#   ggtitle('P. distasonis SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/') +
#   ggtitle('P. distasonis SFS Comparison')
# 
# plot_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/inferred_DFE.txt') +
#   ggtitle('P. distasonis DFE Comparison')
# 
# # Parabacteroides_merdae_56972
# compare_sfs_cornejo_count('../Analysis/Parabacteroides_merdae_56972_downsampled_14/') +
#   ggtitle('P. merdae SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Parabacteroides_merdae_56972_downsampled_14/') +
#   ggtitle('P. merdae SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Parabacteroides_merdae_56972_downsampled_14/') +
#   ggtitle('P. merdae SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Parabacteroides_merdae_56972_downsampled_14/') +
#   ggtitle('P. merdae SFS Comparison')
# 
# plot_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/inferred_DFE.txt') +
#   ggtitle('P. merdae DFE Comparison')
# 
# # Phascolarctobacterium_sp_59817
# compare_sfs_cornejo_count('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/') +
#   ggtitle('Phascolarctobacterium sp. SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/') +
#   ggtitle('Phascolarctobacterium sp. SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/') +
#   ggtitle('Phascolarctobacterium sp. SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/') +
#   ggtitle('Phascolarctobacterium sp. SFS Comparison')
# 
# plot_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/inferred_DFE.txt') +
#   ggtitle('Phascolarctobacterium sp. DFE Comparison')
# 
# # Prevotella_copri_61740
# compare_sfs_cornejo_count('../Analysis/Prevotella_copri_61740_downsampled_14/') +
#   ggtitle('P. copri SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Prevotella_copri_61740_downsampled_14/') +
#   ggtitle('P. copri SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Prevotella_copri_61740_downsampled_14/') +
#   ggtitle('P. copri SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Prevotella_copri_61740_downsampled_14/') +
#   ggtitle('P. copri SFS Comparison')
# 
# plot_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/inferred_DFE.txt') +
#   ggtitle('P. copri DFE Comparison')
# 
# # Ruminococcus_bicirculans_59300
# # compare_sfs_with_selection_count('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/') +
# #   ggtitle('R. bicirculans SFS Comparison')
# # 
# # compare_sfs_with_selection_proportional('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/') +
# #   ggtitle('R. bicirculans SFS Comparison')
# # 
# # plot_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/inferred_DFE.txt') +
# #   ggtitle('R. bicirculans SFS Comparison')
# # 
# # Ruminococcus_bromii_62047
# compare_sfs_cornejo_count('../Analysis/Ruminococcus_bromii_62047_downsampled_14/') +
#   ggtitle('R. bromii SFS Comparison')
# 
# compare_sfs_cornejo_proportional('../Analysis/Ruminococcus_bromii_62047_downsampled_14/') +
#   ggtitle('R. bromii SFS Comparison')
# 
# compare_sfs_with_selection_count('../Analysis/Ruminococcus_bromii_62047_downsampled_14/') +
#   ggtitle('R. bromii SFS Comparison')
# 
# compare_sfs_with_selection_proportional('../Analysis/Ruminococcus_bromii_62047_downsampled_14/') +
#   ggtitle('R. bromii SFS Comparison')
# 
# plot_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/inferred_DFE.txt') +
#   ggtitle('R. bromii DFE Comparison')
# 
# ##UHGG
# 
# 
# # Bacteroides_A_coprocola
# 
# b_a_coprocola_2 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/2_output_sfs.txt')
# b_a_coprocola_3 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/3_output_sfs.txt')
# b_a_coprocola_4 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/4_output_sfs.txt')
# b_a_coprocola_5 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/5_output_sfs.txt')
# b_a_coprocola_6 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/6_output_sfs.txt')
# b_a_coprocola_7 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/7_output_sfs.txt')
# b_a_coprocola_8 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/8_output_sfs.txt')
# b_a_coprocola_9 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/9_output_sfs.txt')
# b_a_coprocola_10 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/10_output_sfs.txt')
# b_a_coprocola_11 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/11_output_sfs.txt')
# b_a_coprocola_12 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/12_output_sfs.txt')
# b_a_coprocola_13 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/13_output_sfs.txt')
# b_a_coprocola_14 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/14_output_sfs.txt')
# b_a_coprocola_15 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/15_output_sfs.txt')
# b_a_coprocola_16 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/16_output_sfs.txt')
# b_a_coprocola_17 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/17_output_sfs.txt')
# b_a_coprocola_18 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/18_output_sfs.txt')
# b_a_coprocola_19 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_A_coprocola/19_output_sfs.txt')
# 
# b_a_coprocola = b_a_coprocola_2 +
#   b_a_coprocola_3 +
#   b_a_coprocola_4 +
#   b_a_coprocola_5 +
#   b_a_coprocola_6 +
#   b_a_coprocola_7 +
#   b_a_coprocola_8 +
#   b_a_coprocola_9 +
#   b_a_coprocola_10 +
#   b_a_coprocola_11 +
#   b_a_coprocola_12 +
#   b_a_coprocola_13 +
#   b_a_coprocola_14 +
#   b_a_coprocola_15 +
#   b_a_coprocola_16 +
#   b_a_coprocola_17 +
#   b_a_coprocola_18 +
#   b_a_coprocola_19
#   
# plot_original_empirical_sfs(b_a_coprocola)
# 
# plot_original_empirical_sfs(b_a_coprocola) + xlim(-1.5, 20) +
#   ggtitle('Bacteroides coprocola [A] synonymous SFS (Isolates w/ Clade Control)')
# 
# b_a_coprocola_UHGG_one_epoch = sfs_from_demography('../Data/UHGG/UHGG_Bacteroides_A_coprocola/one_epoch_demography.txt')
# b_a_coprocola_UHGG_two_epoch = sfs_from_demography('../Data/UHGG/UHGG_Bacteroides_A_coprocola/two_epoch_demography.txt')
# 
# compare_sfs(fold_sfs(b_a_coprocola)[-1], b_a_coprocola_UHGG_one_epoch, b_a_coprocola_UHGG_two_epoch) +
#   ggtitle('B. coprocola [A], UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# compare_sfs(fold_sfs(b_a_coprocola)[-1], b_a_coprocola_UHGG_one_epoch, b_a_coprocola_UHGG_two_epoch)  +
#   xlim(-1.5, 20.5) +
#   ggtitle('B. coprocola [A], UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# compare_sfs(proportional_sfs(fold_sfs(b_a_coprocola)[-1]), proportional_sfs(b_a_coprocola_UHGG_one_epoch), proportional_sfs(b_a_coprocola_UHGG_two_epoch))  +
#   ggtitle('B. coprocola [A], UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# 
# # B. eggerthii
# 
# b_eggerthii_1 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/1_output_sfs.txt')
# b_eggerthii_2 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/2_output_sfs.txt')
# b_eggerthii_3 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/3_output_sfs.txt')
# b_eggerthii_4 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/4_output_sfs.txt')
# b_eggerthii_5 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/5_output_sfs.txt')
# b_eggerthii_6 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/6_output_sfs.txt')
# b_eggerthii_7 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/7_output_sfs.txt')
# b_eggerthii_8 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/8_output_sfs.txt')
# b_eggerthii_9 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/9_output_sfs.txt')
# b_eggerthii_10 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/10_output_sfs.txt')
# b_eggerthii_11 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/11_output_sfs.txt')
# b_eggerthii_13 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/13_output_sfs.txt')
# b_eggerthii_14 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/14_output_sfs.txt')
# b_eggerthii_15 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/15_output_sfs.txt')
# b_eggerthii_16 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_eggerthii/16_output_sfs.txt')
# 
# b_eggerthii = b_eggerthii_1 +
#   b_eggerthii_2 +
#   b_eggerthii_3 +
#   b_eggerthii_4 +
#   b_eggerthii_5 +
#   b_eggerthii_6 +
#   b_eggerthii_7 +
#   b_eggerthii_8 +
#   b_eggerthii_9 +
#   b_eggerthii_10 +
#   b_eggerthii_11 +
#   b_eggerthii_13 +
#   b_eggerthii_14 +
#   b_eggerthii_15 +
#   b_eggerthii_16
# 
# plot_original_empirical_sfs(b_eggerthii)
# 
# plot_original_empirical_sfs(b_eggerthii) + xlim(-1.5, 20) + 
#   ggtitle('B. eggerthii synonymous SFS (Isolates w/ Clade control)')
# 
# plot_original_empirical_sfs(proportional_sfs(b_eggerthii)) + 
#   xlim(-1.5, 20) +
#   ggtitle('B. eggerthii synonymous SFS (Isolates w/ Clade control)') +
#   ylab('Proportion of segregating sites')
# 
# b_eggerthii_UHGG_one_epoch = sfs_from_demography('../Data/UHGG/UHGG_Bacteroides_eggerthii/one_epoch_demography.txt')
# b_eggerthii_UHGG_two_epoch = sfs_from_demography('../Data/UHGG/UHGG_Bacteroides_eggerthii/two_epoch_demography.txt')
# compare_sfs(fold_sfs(b_eggerthii)[-1], b_eggerthii_UHGG_one_epoch, b_eggerthii_UHGG_two_epoch)
# 
# compare_sfs(fold_sfs(b_eggerthii)[-1], b_eggerthii_UHGG_one_epoch, b_eggerthii_UHGG_two_epoch)  +
#   xlim(-1.5, 20.5) +
#   ggtitle('B. eggerthii, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# compare_sfs(proportional_sfs(fold_sfs(b_eggerthii)[-1]), proportional_sfs(b_eggerthii_UHGG_one_epoch), proportional_sfs(b_eggerthii_UHGG_two_epoch))  +
#   xlim(-1.5, 20.5) +
#   ggtitle('B. eggerthii, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# 
# compare_sfs(fold_sfs(b_eggerthii), b_eggerthii_UHGG_one_epoch, b_eggerthii_UHGG_two_epoch)  +
#   xlim(-0.5, 50) +
#   ggtitle('B. fragilis, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# # B. fragilis UHGG test
# b_fragilis_1 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_fragilis/1_output_sfs.txt')
# b_fragilis_2 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_fragilis/2_output_sfs.txt')
# b_fragilis_3 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_fragilis/3_output_sfs.txt')
# b_fragilis_4 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_fragilis/4_output_sfs.txt')
# b_fragilis_5 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_fragilis/5_output_sfs.txt')
# b_fragilis = b_fragilis_1 + b_fragilis_2 + b_fragilis_3 + b_fragilis_4 + b_fragilis_5
# 
# plot_original_empirical_sfs(b_fragilis)
# 
# plot_original_empirical_sfs(b_fragilis) + xlim(-1.5, 20) + 
#   ggtitle('B. fragilis synonymous SFS (Isolates w/ Clade control)')
# 
# plot_original_empirical_sfs(proportional_sfs(b_fragilis)) + 
#   xlim(-1.5, 20) +
#   ggtitle('B. fragilis synonymous SFS (Isolates w/ Clade control)') +
#   ylab('Proportion of segregating sites')
# 
# b_fragilis_UHGG_one_epoch = sfs_from_demography('../Data/UHGG/UHGG_Bacteroides_fragilis/one_epoch_demography.txt')
# b_fragilis_UHGG_two_epoch = sfs_from_demography('../Data/UHGG/UHGG_Bacteroides_fragilis/two_epoch_demography.txt')
# b_fragilis  = b_fragilis[-1]
# compare_sfs(fold_sfs(b_fragilis), b_fragilis_UHGG_one_epoch, b_fragilis_UHGG_two_epoch)
# 
# compare_sfs(fold_sfs(b_fragilis), b_fragilis_UHGG_one_epoch, b_fragilis_UHGG_two_epoch)  +
#   xlim(-1.5, 20.5) +
#   ggtitle('B. fragilis, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# compare_sfs(proportional_sfs(fold_sfs(b_fragilis)), proportional_sfs(b_fragilis_UHGG_one_epoch), proportional_sfs(b_fragilis_UHGG_two_epoch))  +
#   xlim(-1.5, 20.5) +
#   ggtitle('B. fragilis, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# 
# compare_sfs(fold_sfs(b_fragilis), b_fragilis_UHGG_one_epoch, b_fragilis_UHGG_two_epoch)  +
#   xlim(-0.5, 50) +
#   ggtitle('B. fragilis, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# # B. stercoris
# 
# b_stercoris_1 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/1_output_sfs.txt')
# b_stercoris_2 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/2_output_sfs.txt')
# b_stercoris_3 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/3_output_sfs.txt')
# b_stercoris_4 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/4_output_sfs.txt')
# b_stercoris_5 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/5_output_sfs.txt')
# b_stercoris_6 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/6_output_sfs.txt')
# b_stercoris_7 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/7_output_sfs.txt')
# b_stercoris_8 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/8_output_sfs.txt')
# b_stercoris_9 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/9_output_sfs.txt')
# b_stercoris_19 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/19_output_sfs.txt')
# b_stercoris_29 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/29_output_sfs.txt')
# b_stercoris_39 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/39_output_sfs.txt')
# b_stercoris_53 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/53_output_sfs.txt')
# b_stercoris_54 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/54_output_sfs.txt')
# b_stercoris_55 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/55_output_sfs.txt')
# b_stercoris_56 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/56_output_sfs.txt')
# b_stercoris_57 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/57_output_sfs.txt')
# b_stercoris_58 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/58_output_sfs.txt')
# b_stercoris_59 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/59_output_sfs.txt')
# b_stercoris_60 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/60_output_sfs.txt')
# b_stercoris_62 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/62_output_sfs.txt')
# b_stercoris_63 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/63_output_sfs.txt')
# b_stercoris_64 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/64_output_sfs.txt')
# b_stercoris_66 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/66_output_sfs.txt')
# b_stercoris_67 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/67_output_sfs.txt')
# b_stercoris_68 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/68_output_sfs.txt')
# b_stercoris_69 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/69_output_sfs.txt')
# b_stercoris_70 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/70_output_sfs.txt')
# b_stercoris_71 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/71_output_sfs.txt')
# b_stercoris_72 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/72_output_sfs.txt')
# b_stercoris_73 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/73_output_sfs.txt')
# b_stercoris_74 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/74_output_sfs.txt')
# b_stercoris_75 = read_input_sfs_original('../Data/UHGG/UHGG_Bacteroides_stercoris/75_output_sfs.txt')
# 
# b_stercoris = b_stercoris_1 +
#   b_stercoris_2 +
#   b_stercoris_3 +
#   b_stercoris_4 +
#   b_stercoris_5 +
#   b_stercoris_6 +
#   b_stercoris_7 +
#   b_stercoris_8 +
#   b_stercoris_9 +
#   b_stercoris_19 +
#   b_stercoris_29 +
#   b_stercoris_39 +
#   b_stercoris_53 +
#   b_stercoris_54 +
#   b_stercoris_55 +
#   b_stercoris_56 +
#   b_stercoris_57 +
#   b_stercoris_58 +
#   b_stercoris_59 +
#   b_stercoris_60 +
#   b_stercoris_62 +
#   b_stercoris_63 +
#   b_stercoris_64 +
#   b_stercoris_66 +
#   b_stercoris_67 +
#   b_stercoris_68 +
#   b_stercoris_69 +
#   b_stercoris_70 +
#   b_stercoris_71 +
#   b_stercoris_72 +
#   b_stercoris_73 +
#   b_stercoris_74 +
#   b_stercoris_75
#   
# plot_original_empirical_sfs(b_stercoris)
# 
# plot_original_empirical_sfs(b_stercoris) + xlim(-1.5, 20) + 
#   ggtitle('B. stercoris synonymous SFS (Isolates w/ Clade control)')
# 
# plot_original_empirical_sfs(proportional_sfs(b_stercoris)) + 
#   xlim(-1.5, 20) +
#   ggtitle('B. stercoris synonymous SFS (Isolates w/ Clade control)') +
#   ylab('Proportion of segregating sites')
# 
# b_stercoris_UHGG_one_epoch = sfs_from_demography('../Data/UHGG/UHGG_Bacteroides_stercoris/one_epoch_demography.txt')
# b_stercoris_UHGG_two_epoch = sfs_from_demography('../Data/UHGG/UHGG_Bacteroides_stercoris/two_epoch_demography.txt')
# compare_sfs(fold_sfs(b_stercoris)[-1], b_stercoris_UHGG_one_epoch, b_stercoris_UHGG_two_epoch)
# 
# compare_sfs(fold_sfs(b_stercoris)[-1], b_stercoris_UHGG_one_epoch, b_stercoris_UHGG_two_epoch)  +
#   xlim(-1.5, 20.5) +
#   ggtitle('B. stercoris, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# compare_sfs(proportional_sfs(fold_sfs(b_stercoris)[-1]), proportional_sfs(b_stercoris_UHGG_one_epoch), proportional_sfs(b_stercoris_UHGG_two_epoch))  +
#   xlim(-1.5, 20.5) +
#   ggtitle('B. stercoris, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# 
# compare_sfs(fold_sfs(b_stercoris), b_stercoris_UHGG_one_epoch, b_stercoris_UHGG_two_epoch)  +
#   xlim(-0.5, 50) +
#   ggtitle('B. stercoris, UHGG Isolate SFS Comparison (w/ Clade Control)')
# 
# # F. prausnitzii
# 
# f_prausnitzii_1 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/1_output_sfs.txt')
# f_prausnitzii_2 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/2_output_sfs.txt')
# f_prausnitzii_3 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/3_output_sfs.txt')
# f_prausnitzii_4 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/4_output_sfs.txt')
# f_prausnitzii_5 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/5_output_sfs.txt')
# f_prausnitzii_6 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/6_output_sfs.txt')
# f_prausnitzii_7 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/7_output_sfs.txt')
# f_prausnitzii_8 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/8_output_sfs.txt')
# f_prausnitzii_9 = read_input_sfs_original('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/9_output_sfs.txt')
# 
# f_prausnitzii = f_prausnitzii_1 +
#   f_prausnitzii_2 +
#   f_prausnitzii_3 +
#   f_prausnitzii_4 +
#   f_prausnitzii_5 +
#   f_prausnitzii_6 +
#   f_prausnitzii_7 +
#   f_prausnitzii_8 +
#   f_prausnitzii_9
# 
# 
#   
# plot_original_empirical_sfs(f_prausnitzii) + xlim(-1.5, 20) + 
#   ggtitle('F. prausnitzii [K] synonymous SFS (Isolates w/ Clade control)')
# 
# plot_original_empirical_sfs(proportional_sfs(f_prausnitzii)) + 
#   xlim(-1.5, 20) +
#   ggtitle('F. prausnitzii [K] synonymous SFS (Isolates w/ Clade control)') +
#   ylab('Proportion of segregating sites')
# 
# 
# f_prausnitzii_UHGG_one_epoch = sfs_from_demography('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/one_epoch_demography.txt')
# f_prausnitzii_UHGG_two_epoch = sfs_from_demography('../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/two_epoch_demography.txt')
# 
# compare_sfs(fold_sfs(f_prausnitzii)[-1], f_prausnitzii_UHGG_one_epoch, f_prausnitzii_UHGG_two_epoch) +
#   xlim(-0.5, 20.5) +
#   ggtitle('F. prausnitzii [K] SFS Comparison, Isolates w/ Clade Control')
# 
# compare_sfs(proportional_sfs(fold_sfs(f_prausnitzii))[-1], proportional_sfs(f_prausnitzii_UHGG_one_epoch), proportional_sfs(f_prausnitzii_UHGG_two_epoch)) +
#   xlim(-0.5, 20.5) +
#   ggtitle('F. prausnitzii [K] SFS Comparison, Isolates w/ Clade Control')
# 
# 
# # P. copri
# 
# p_copri_1 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/1_output_sfs.txt')
# p_copri_2 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/2_output_sfs.txt')
# p_copri_3 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/3_output_sfs.txt')
# p_copri_4 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/4_output_sfs.txt')
# p_copri_5 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/5_output_sfs.txt')
# p_copri_6 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/6_output_sfs.txt')
# p_copri_7 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/7_output_sfs.txt')
# p_copri_8 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/8_output_sfs.txt')
# p_copri_9 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/9_output_sfs.txt')
# p_copri_59 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/59_output_sfs.txt')
# p_copri_68 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/68_output_sfs.txt')
# p_copri_69 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/69_output_sfs.txt')
# p_copri_78 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/78_output_sfs.txt')
# p_copri_79 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/79_output_sfs.txt')
# p_copri_85 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/85_output_sfs.txt')
# p_copri_86 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/86_output_sfs.txt')
# p_copri_87 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/87_output_sfs.txt')
# p_copri_88 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/88_output_sfs.txt')
# p_copri_89 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/89_output_sfs.txt')
# p_copri_90 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/90_output_sfs.txt')
# p_copri_91 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/91_output_sfs.txt')
# p_copri_92 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/92_output_sfs.txt')
# p_copri_93 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/93_output_sfs.txt')
# p_copri_94 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/94_output_sfs.txt')
# p_copri_95 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/95_output_sfs.txt')
# p_copri_96 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/96_output_sfs.txt')
# p_copri_97 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/97_output_sfs.txt')
# p_copri_98 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/98_output_sfs.txt')
# p_copri_99 = read_input_sfs_original('../Data/UHGG/UHGG_Prevotella_copri/99_output_sfs.txt')
# 
# p_copri = p_copri_1 + 
#   p_copri_2 +
#   p_copri_3 +
#   p_copri_4 +
#   p_copri_5 +
#   p_copri_6 +
#   p_copri_7 +
#   p_copri_8 +
#   p_copri_9 +
#   p_copri_59 +
#   p_copri_68 +
#   p_copri_69 +
#   p_copri_78 +
#   p_copri_79 +
#   p_copri_85 +
#   p_copri_86 +
#   p_copri_87 +
#   p_copri_88 +
#   p_copri_89 +
#   p_copri_90 +
#   p_copri_91 +
#   p_copri_92 +
#   p_copri_93 +
#   p_copri_94 +
#   p_copri_95 +
#   p_copri_96 +
#   p_copri_97 +
#   p_copri_98 +
#   p_copri_99
# 
# plot_original_empirical_sfs(p_copri) + xlim(-1.5, 20) + 
#   ggtitle('P. copri synonymous SFS (Isolates w/ Clade control)')
# 
# plot_original_empirical_sfs(proportional_sfs(p_copri)) + 
#   xlim(-1.5, 20) +
#   ggtitle('P. copri synonymous SFS (Isolates w/ Clade control)') +
#   ylab('Proportion of segregating sites')
# 
# 
# p_copri = fold_sfs(p_copri)
# p_copri = p_copri[-1]
# p_copri_UHGG_one_epoch = sfs_from_demography('../Data/UHGG/UHGG_Prevotella_copri/one_epoch_demography.txt')
# p_copri_UHGG_two_epoch = sfs_from_demography('../Data/UHGG/UHGG_Prevotella_copri/two_epoch_demography.txt')
# 
# p_copri_UHGG_two_epoch = numeric(length(p_copri))
# compare_sfs(p_copri, p_copri_UHGG_one_epoch, p_copri_UHGG_two_epoch) +
#   xlim(-0.5, 20.5)  +
#   ggtitle('P. copri SFS Comparison, Isolates w/ Clade Control')
# 
# compare_sfs(proportional_sfs(p_copri), proportional_sfs(p_copri_UHGG_one_epoch), proportional_sfs(p_copri_UHGG_two_epoch)) +
#   xlim(-0.5, 20.5) +
#   ggtitle('P. copri SFS Comparison, Isolates w/ Clade Control')


# ## Isolate downsampling
# 
# # A. muciniphila B
# 
# a_muciniphila_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# a_muciniphila_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/downsampled_sfs.txt'
# ))
# 
# a_muciniphila_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/one_epoch_demography.txt'
# )
# a_muciniphila_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(a_muciniphila_14_hmp[-1], 
#                     a_muciniphila_14_isolate[-1],
#                     a_muciniphila_isolate_one_epoch,
#                     a_muciniphila_isolate_two_epoch) +
#   ggtitle('A. muciniphila downsampled SFS comparison')
# 
# # A. finegoldii
# 
# a_finegoldii_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Alistipes_finegoldii_56071_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# a_finegoldii_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/downsampled_sfs.txt'
# ))
# 
# a_finegoldii_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/one_epoch_demography.txt'
# )
# a_finegoldii_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(a_finegoldii_14_hmp[-1], 
#                     a_finegoldii_14_isolate[-1],
#                     a_finegoldii_isolate_one_epoch,
#                     a_finegoldii_isolate_two_epoch) +
#   ggtitle('A. finegoldii downsampled SFS comparison')
# 
# # A. onderdonkii
# 
# a_onderdonkii_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# a_onderdonkii_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/downsampled_sfs.txt'
# ))
# 
# a_onderdonkii_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/one_epoch_demography.txt'
# )
# a_onderdonkii_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(a_onderdonkii_14_hmp[-1], 
#                     a_onderdonkii_14_isolate[-1],
#                     a_onderdonkii_isolate_one_epoch,
#                     a_onderdonkii_isolate_two_epoch) +
#   ggtitle('A. onderdonkii downsampled SFS comparison')
# 
# # A. putredinis
# 
# a_putredinis_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Alistipes_putredinis_61533_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# a_putredinis_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/downsampled_sfs.txt'
# ))
# 
# a_putredinis_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/one_epoch_demography.txt'
# )
# a_putredinis_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(a_putredinis_14_hmp[-1], 
#                     a_putredinis_14_isolate[-1],
#                     a_putredinis_isolate_one_epoch,
#                     a_putredinis_isolate_two_epoch) +
#   ggtitle('A. putredinis downsampled SFS comparison')
# 
# # A. shahii
# 
# a_shahii_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Alistipes_shahii_62199_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# a_shahii_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/downsampled_sfs.txt'
# ))
# 
# a_shahii_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/one_epoch_demography.txt'
# )
# a_shahii_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(a_shahii_14_hmp[-1], 
#                     a_shahii_14_isolate[-1],
#                     a_shahii_isolate_one_epoch,
#                     a_shahii_isolate_two_epoch) +
#   ggtitle('A. shahii downsampled SFS comparison')
# 
# # B. fragilis
# 
# b_fragilis_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Bacteroides_fragilis_54507_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# b_fragilis_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/downsampled_sfs.txt'
# ))
# 
# b_fragilis_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/one_epoch_demography.txt'
# )
# b_fragilis_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_fragilis/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(b_fragilis_14_hmp[-1], 
#                     b_fragilis_14_isolate[-1],
#                     b_fragilis_isolate_one_epoch,
#                     b_fragilis_isolate_two_epoch) +
#   ggtitle('B. fragilis downsampled SFS comparison')
# 
# # B. ovatus
# 
# b_ovatus_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Bacteroides_ovatus_58035_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# b_ovatus_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_ovatus/downsampled_sfs.txt'
# ))
# 
# b_ovatus_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_ovatus/one_epoch_demography.txt'
# )
# b_ovatus_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_ovatus/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(b_ovatus_14_hmp[-1], 
#                     b_ovatus_14_isolate[-1],
#                     b_ovatus_isolate_one_epoch,
#                     b_ovatus_isolate_two_epoch) +
#   ggtitle('B. ovatus downsampled SFS comparison')
# 
# # B. stercoris
# 
# b_stercoris_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Bacteroides_stercoris_56735_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# b_stercoris_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_stercoris/downsampled_sfs.txt'
# ))
# 
# b_stercoris_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_stercoris/one_epoch_demography.txt'
# )
# b_stercoris_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_stercoris/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(b_stercoris_14_hmp[-1], 
#                     b_stercoris_14_isolate[-1],
#                     b_stercoris_isolate_one_epoch,
#                     b_stercoris_isolate_two_epoch) +
#   ggtitle('B. stercoris downsampled SFS comparison')
# 
# # B. thetaiotaomicron
# 
# b_thetaiotaomicron_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# b_thetaiotaomicron_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_thetaiotaomicron/downsampled_sfs.txt'
# ))
# 
# b_thetaiotaomicron_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_thetaiotaomicron/one_epoch_demography.txt'
# )
# b_thetaiotaomicron_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_thetaiotaomicron/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(b_thetaiotaomicron_14_hmp[-1], 
#                     b_thetaiotaomicron_14_isolate[-1],
#                     b_thetaiotaomicron_isolate_one_epoch,
#                     b_thetaiotaomicron_isolate_two_epoch) +
#   ggtitle('B. thetaiotaomicron downsampled SFS comparison')
# 
# # B. xylanisolvens
# 
# b_xylanisolvens_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# b_xylanisolvens_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Bacteroides_xylanisolvens/downsampled_sfs.txt'
# ))
# 
# b_xylanisolvens_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_xylanisolvens/one_epoch_demography.txt'
# )
# b_xylanisolvens_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Bacteroides_xylanisolvens/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(b_xylanisolvens_14_hmp[-1], 
#                     b_xylanisolvens_14_isolate[-1],
#                     b_xylanisolvens_isolate_one_epoch,
#                     b_xylanisolvens_isolate_two_epoch) +
#   ggtitle('B. xylanisolvens downsampled SFS comparison')
# 
# # B. intestinihominis
# 
# b_intestinihominis_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# b_intestinihominis_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Barnesiella_intestinihominis/downsampled_sfs.txt'
# ))
# 
# b_intestinihominis_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Barnesiella_intestinihominis/one_epoch_demography.txt'
# )
# b_intestinihominis_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Barnesiella_intestinihominis/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(b_intestinihominis_14_hmp[-1], 
#                     b_intestinihominis_14_isolate[-1],
#                     b_intestinihominis_isolate_one_epoch,
#                     b_intestinihominis_isolate_two_epoch) +
#   ggtitle('B. intestinihominis downsampled SFS comparison')
# 
# # D. invisus
# 
# d_invisus_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Dialister_invisus_61905_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# d_invisus_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Dialister_invisus/downsampled_sfs.txt'
# ))
# 
# d_invisus_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Dialister_invisus/one_epoch_demography.txt'
# )
# d_invisus_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Dialister_invisus/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(d_invisus_14_hmp[-1], 
#                     d_invisus_14_isolate[-1],
#                     d_invisus_isolate_one_epoch,
#                     d_invisus_isolate_two_epoch) +
#   ggtitle('D. invisus downsampled SFS comparison')
# 
# # F. prausnitzii (K)
# 
# f_prausnitzii_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# f_prausnitzii_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/downsampled_sfs.txt'
# ))
# 
# f_prausnitzii_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/one_epoch_demography.txt'
# )
# f_prausnitzii_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Faecalibacterium_prausnitzii_K/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(f_prausnitzii_14_hmp[-1], 
#                     f_prausnitzii_14_isolate[-1],
#                     f_prausnitzii_isolate_one_epoch,
#                     f_prausnitzii_isolate_two_epoch) +
#   ggtitle('F. prausnitzii downsampled SFS comparison')
# 
# # O. splanchnicus
# 
# o_splanchnicus_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# o_splanchnicus_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Odoribacter_splanchnicus/downsampled_sfs.txt'
# ))
# 
# o_splanchnicus_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Odoribacter_splanchnicus/one_epoch_demography.txt'
# )
# o_splanchnicus_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Odoribacter_splanchnicus/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(o_splanchnicus_14_hmp[-1], 
#                     o_splanchnicus_14_isolate[-1],
#                     o_splanchnicus_isolate_one_epoch,
#                     o_splanchnicus_isolate_two_epoch) +
#   ggtitle('O. splanchnicus downsampled SFS comparison')
# 
# # P. merdae
# 
# p_merdae_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Parabacteroides_merdae_56972_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# p_merdae_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Parabacteroides_merdae/downsampled_sfs.txt'
# ))
# 
# p_merdae_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Parabacteroides_merdae/one_epoch_demography.txt'
# )
# p_merdae_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Parabacteroides_merdae/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(p_merdae_14_hmp[-1], 
#                     p_merdae_14_isolate[-1],
#                     p_merdae_isolate_one_epoch,
#                     p_merdae_isolate_two_epoch) +
#   ggtitle('P. merdae downsampled SFS comparison')
# 
# # P. copri
# 
# p_copri_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Prevotella_copri_61740_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# p_copri_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Prevotella_copri/downsampled_sfs.txt'
# ))
# 
# p_copri_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Prevotella_copri/one_epoch_demography.txt'
# )
# p_copri_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Prevotella_copri/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(p_copri_14_hmp[-1], 
#                     p_copri_14_isolate[-1],
#                     p_copri_isolate_one_epoch,
#                     p_copri_isolate_two_epoch) +
#   ggtitle('P. copri downsampled SFS comparison')
# 
# 
# # R. E bromii B
# 
# r_bromii_14_hmp = fold_sfs(read_input_sfs_original(
#   '../Analysis/Ruminococcus_bromii_62047_downsampled_14/downsampled_syn_sfs.txt'
# ))
# 
# r_bromii_14_isolate = fold_sfs(read_input_sfs_original(
#   '../Data/UHGG/UHGG_Ruminococcus_E_bromii_B/downsampled_sfs.txt'
# ))
# 
# r_bromii_isolate_one_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Ruminococcus_E_bromii_B/one_epoch_demography.txt'
# )
# r_bromii_isolate_two_epoch = sfs_from_demography(
#   '../Data/UHGG/UHGG_Ruminococcus_E_bromii_B/two_epoch_demography.txt'
# )
# 
# compare_isolate_sfs(r_bromii_14_hmp[-1], 
#                     r_bromii_14_isolate[-1],
#                     r_bromii_isolate_one_epoch,
#                     r_bromii_isolate_two_epoch) +
#   ggtitle('R. bromii (B) downsampled SFS comparison')

# # Likelihood surface for UHGG Isolates
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Akkermansia_muciniphila_B_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Alistipes_finegoldii_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Alistipes_onderdonkii_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Alistipes_putredinis_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Alistipes_shahii_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Bacteroides_fragilis_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Bacteroides_ovatus_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Bacteroides_stercoris_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Bacteroides_thetaiotaomicron_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Bacteroides_xylanisolvens_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Barnesiella_intestinihominis_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Dialister_invisus_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Faecalibacterium_prausnitzii_K_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Odoribacter_splanchnicus_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Parabacteroides_distasonis_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Parabacteroides_merdae_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Prevotella_copri_isolate.csv')
# plot_likelihood_surface('../Data/UHGG/UHGG_likelihood_surfaces/Ruminococcus_E_bromii_B_isolate.csv')
# 
# # Likelihood surface for complete HMP-QP
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Akkermansia_muciniphila_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Alistipes_finegoldii_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Alistipes_onderdonkii_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Alistipes_putredinis_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Alistipes_shahii_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroidales_bacterium_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_caccae_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_cellulosilyticus_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_fragilis_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_ovatus_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_stercoris_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_thetaiotaomicron_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_uniformis_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_vulgatus_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Bacteroides_xylanisolvens_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Barnesiella_intestinihominis_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Dialister_invisus_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Eubacterium_eligens_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Eubacterium_rectale_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Faecalibacterium_prausnitzii_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Odoribacter_splanchnicus_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Oscillibacter_sp_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Parabacteroides_distasonis_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Parabacteroides_merdae_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Phascolarctobacterium_sp_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Prevotella_copri_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Ruminococcus_bicirculans_hmp.csv')
# plot_likelihood_surface('../Data/HMP_QP_likelihood_surfaces/Ruminococcus_bromii_hmp.csv')

  
  # compare_isolate_hmp_sfs(a_muciniphila_orig[-1], a_muciniphila_14_two_epoch, 
#                         a_muciniphila_hmp_qp_syn[-1], a_muciniphila_complete_two_epoch,
#                         a_muciniphila_14_isolate[-1], a_muciniphila_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('A. muciniphila SFS comparison')
# 
# compare_isolate_hmp_sfs(a_finegoldii_orig[-1], a_finegoldii_14_two_epoch, 
#                         a_finegoldii_hmp_qp_syn[-1], a_finegoldii_complete_two_epoch,
#                         a_finegoldii_14_isolate[-1], a_finegoldii_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('A. finegoldii SFS comparison')
# 
# compare_isolate_hmp_sfs(a_onderdonkii_orig[-1], a_onderdonkii_14_two_epoch, 
#                         a_onderdonkii_hmp_qp_syn[-1], a_onderdonkii_complete_two_epoch,
#                         a_onderdonkii_14_isolate[-1], a_onderdonkii_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('A. onderdonkii SFS comparison')
# 
# compare_isolate_hmp_sfs(a_putredinis_orig[-1], a_putredinis_14_two_epoch, 
#                         a_putredinis_hmp_qp_syn[-1], a_putredinis_complete_two_epoch,
#                         a_putredinis_14_isolate[-1], a_putredinis_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('A. putredinis SFS comparison')
# 
# compare_isolate_hmp_sfs(a_shahii_orig[-1], a_shahii_14_two_epoch, 
#                         a_shahii_hmp_qp_syn[-1], a_shahii_complete_two_epoch,
#                         a_shahii_14_isolate[-1], a_shahii_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('A. shahii SFS comparison')
# 
# compare_isolate_hmp_sfs(b_fragilis_orig[-1], b_fragilis_14_two_epoch, 
#                         b_fragilis_hmp_qp_syn[-1], b_fragilis_complete_two_epoch,
#                         b_fragilis_14_isolate[-1], b_fragilis_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('B. fragilis SFS comparison')
# 
# compare_isolate_hmp_sfs(b_ovatus_orig[-1], b_ovatus_14_two_epoch, 
#                         b_ovatus_hmp_qp_syn[-1], b_ovatus_complete_two_epoch,
#                         b_ovatus_14_isolate[-1], b_ovatus_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('B. ovatus SFS comparison')
# 
# compare_isolate_hmp_sfs(b_thetaiotaomicron_orig[-1], b_thetaiotaomicron_14_two_epoch, 
#                         b_thetaiotaomicron_hmp_qp_syn[-1], b_thetaiotaomicron_complete_two_epoch,
#                         b_thetaiotaomicron_14_isolate[-1], b_thetaiotaomicron_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('B. thetaiotaomicron SFS comparison')
# 
# compare_isolate_hmp_sfs(b_xylanisolvens_orig[-1], b_xylanisolvens_14_two_epoch, 
#                         b_xylanisolvens_hmp_qp_syn[-1], b_xylanisolvens_complete_two_epoch,
#                         b_xylanisolvens_14_isolate[-1], b_xylanisolvens_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('B. xylanisolvens SFS comparison')
# 
# compare_isolate_hmp_sfs(b_intestinihominis_orig[-1], b_intestinihominis_14_two_epoch, 
#                         b_intestinihominis_hmp_qp_syn[-1], b_intestinihominis_complete_two_epoch,
#                         b_intestinihominis_14_isolate[-1], b_intestinihominis_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('B. intestinihominis SFS comparison')
# 
# compare_isolate_hmp_sfs(d_invisus_orig[-1], d_invisus_14_two_epoch, 
#                         d_invisus_hmp_qp_syn[-1], d_invisus_complete_two_epoch,
#                         d_invisus_14_isolate[-1], d_invisus_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('D. invisus SFS comparison')
# 
# compare_isolate_hmp_sfs(f_prausnitzii_orig[-1], f_prausnitzii_14_two_epoch, 
#                         f_prausnitzii_hmp_qp_syn[-1], f_prausnitzii_complete_two_epoch,
#                         f_prausnitzii_14_isolate[-1], f_prausnitzii_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('F. prausnitzii SFS comparison')
# 
# compare_isolate_hmp_sfs(o_splanchnicus_orig[-1], o_splanchnicus_14_two_epoch, 
#                         o_splanchnicus_hmp_qp_syn[-1], o_splanchnicus_complete_two_epoch,
#                         o_splanchnicus_14_isolate[-1], o_splanchnicus_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('O. splanchnicus SFS comparison')
# 
# compare_isolate_hmp_sfs(p_merdae_orig[-1], p_merdae_14_two_epoch, 
#                         p_merdae_hmp_qp_syn[-1], p_merdae_complete_two_epoch,
#                         p_merdae_14_isolate[-1], p_merdae_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('P. merdae SFS comparison')
# 
# compare_isolate_hmp_sfs(p_copri_orig[-1], p_copri_14_two_epoch, 
#                         p_copri_hmp_qp_syn[-1], p_copri_complete_two_epoch,
#                         p_copri_14_isolate[-1], p_copri_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('P. copri SFS comparison')
# 
# 
# compare_isolate_hmp_sfs(r_bromii_orig[-1], r_bromii_14_two_epoch, 
#                         r_bromii_hmp_qp_syn[-1], r_bromii_complete_two_epoch,
#                         r_bromii_14_isolate[-1], r_bromii_isolate_two_epoch,
#                         one_epoch_14) + ggtitle('R. bromii SFS comparison')
