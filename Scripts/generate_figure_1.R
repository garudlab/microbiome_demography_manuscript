setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# Nucleotide diversity

pi_summary_df = data.frame(read.csv('../Analysis/summarized_pi.csv', header=TRUE))
names(pi_summary_df) = c('species', 'Cohort', 'average_pi', 'num_sites', 
                         'num_samples', 'aggregate_across_pi', 'pairwise_across_pi')

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

position_jitterdodge(
  jitter.width = NULL,
  jitter.height = 0,
  dodge.width = 0.5,
  seed = NA
)

# pairwise_pi_comparison_10 + stat_compare_means(label = "p.signif", method = "t.test")

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
  theme(axis.text.x = element_text(size=rel(1.5), angle=40, vjust=1.0, hjust=1)) +
  theme(axis.text.y = element_text(size=rel(1.5))) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_text(size=rel(1.5))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x,)),
                limits = c(0.0001, 0.2)) +
  scale_fill_manual(values=c('dodgerblue3', 'goldenrod1')) +
  scale_color_manual(values=c('dodgerblue3', 'goldenrod1')) +
  theme(axis.text.x=element_text(face="italic")) +
  theme(legend.position = "none") +
  xlab('Species') + 
  ylab('Nucleotide diversity') +
  # ggtitle('Distribution of within and between-host nucleotide diversity across cohorts') +
  stat_compare_means(method='wilcox.test', label='p.signif', size=6)
  #  stat_compare_means(method='wilcox.test', size=2)
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

over_5_species_df[over_5_species_df$Cohort==' African', ]$Cohort='African'
over_5_species_df[over_5_species_df$Cohort==' HMP', ]$Cohort='North American'

compare_iid_over_5_means <- ggplot(data=over_5_species_df, aes(x=Cohort, y=pairwise_across_pi, fill=Cohort)) +
  geom_boxplot(aes(fill=Cohort), outlier.shape=NA) +
  geom_point(pch = 21, position = position_jitterdodge(), size=1.5) +
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(axis.text.x = element_text(size=rel(1.5), angle=40, vjust=1.0, hjust=1)) +
  theme(axis.text.y = element_text(size=rel(1.5))) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(legend.text = element_text(size=rel(1.5))) +
  theme(legend.title = element_text(size=rel(1.5))) +
  scale_fill_manual(values=c('dodgerblue3', 'goldenrod1')) +
  scale_color_manual(values=c('dodgerblue3', 'goldenrod1')) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x,)),
                limits = c(0.0001, 0.2)) +
  ylab('Mean Nucleotide diversity per Species') +
  # ylim(0, 0.03) +
  stat_compare_means(method='wilcox.test', label='p.signif', size=6)
  # ggtitle('Mean Nucleotide diversity per Species between Cohorts')
compare_iid_over_5_means

### Figure 1
png("../Summary/figure_1_output.png", width = 1600, height = 900)
# 1600 x 900 dimensions for saved image
better_pi_comparison_iid + compare_iid_over_5_means + plot_layout(widths = c(3, 1))
dev.off()

