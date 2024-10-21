setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

b_caccae_core = read_input_sfs('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_empirical_syn_downsampled_sfs.txt') 
b_caccae_core_ns = read_input_sfs('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_empirical_nonsyn_downsampled_sfs.txt') 
b_caccae_accessory = read_input_sfs('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_empirical_syn_downsampled_sfs.txt') 
b_caccae_accessory_ns = read_input_sfs('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_empirical_nonsyn_downsampled_sfs.txt') 

p_distasonis_core = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_empirical_syn_downsampled_sfs.txt') 
p_distasonis_core_ns = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_empirical_nonsyn_downsampled_sfs.txt') 
p_distasonis_accessory = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_empirical_syn_downsampled_sfs.txt') 
p_distasonis_accessory_ns = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_empirical_nonsyn_downsampled_sfs.txt') 

fig_5A = compare_core_accessory_sfs_syn_ns_5A(b_caccae_core,
  b_caccae_core_ns,
  b_caccae_accessory,
  b_caccae_accessory_ns) + ggtitle('B. caccae') +
  theme(plot.title=element_text(size=22), axis.title=element_text(size=18), axis.text=element_text(size=16))

fig_5B = compare_core_accessory_sfs_syn_ns_5B(p_distasonis_core,
  p_distasonis_core_ns,
  p_distasonis_accessory,
  p_distasonis_accessory_ns) + ggtitle('P. distasonis') +
  theme(plot.title=element_text(size=22), axis.title=element_text(size=18), axis.text=element_text(size=16))

b_caccae_core_dfe = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt') + ggtitle('Core Genes') +
  theme(plot.title=element_text(size=22), axis.title=element_text(size=18), axis.text=element_text(size=16))
p_distasonis_core_dfe = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt') + ggtitle('Core Genes') +
  theme(plot.title=element_text(size=22), axis.title=element_text(size=18), axis.text=element_text(size=16))
b_caccae_acc_dfe = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes') +
  theme(plot.title=element_text(size=22), axis.title=element_text(size=18), axis.text=element_text(size=16))
p_distasonis_acc_dfe = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes') +
  theme(plot.title=element_text(size=22), axis.title=element_text(size=18), axis.text=element_text(size=16))

design = "
ABB
ACC
DEE
DFF
"

### Figure 5
# 1000 x 800

# png("../Summary/figure_5_output.png", width = 1000, height = 800)
figure_5 = fig_5A + b_caccae_core_dfe + b_caccae_acc_dfe +
  fig_5B + p_distasonis_core_dfe + p_distasonis_acc_dfe +
  plot_layout(design=design)
# dev.off()
ggsave('../Summary/figure_5_output.svg', figure_5, width=15, height=12, units='in', dpi=600)
