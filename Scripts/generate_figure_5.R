setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

b_thetaiotaomicron_core = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_thetaiotaomicron_core_ns = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_thetaiotaomicron_accessory = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 
b_thetaiotaomicron_accessory_ns = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

e_rectale_core = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
e_rectale_core_ns = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
e_rectale_accessory = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 
e_rectale_accessory_ns = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

fig_5A = compare_core_accessory_sfs_syn_ns_5A(b_thetaiotaomicron_core,
  b_thetaiotaomicron_core_ns,
  b_thetaiotaomicron_accessory,
  b_thetaiotaomicron_accessory_ns) + ggtitle('B. thetaiotaomicron')

fig_5B = compare_core_accessory_sfs_syn_ns_5B(e_rectale_core,
  e_rectale_core_ns,
  e_rectale_accessory,
  e_rectale_accessory_ns) + ggtitle('E. rectale')

p13_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p21_core_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p13_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')
p21_acc_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')


design = "
ABB
ACC
DEE
DFF
"

### Figure 5
# 1000 x 800

png("../Summary/figure_5_output.png", width = 1000, height = 800)
fig_5A + p13_core_dfe + p13_acc_dfe +
  fig_5B + p21_core_dfe + p21_acc_dfe +
  plot_layout(design=design)
dev.off()
