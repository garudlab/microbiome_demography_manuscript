setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('useful_functions.R')

# FD phylogenetic_tree

# Read the input TSV file
input_table <- read.table("../Data/midas_tree/midas_db_v1.2/species_info.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Extract the midas_number from the species_id column
input_table$midas_number <- sub(".+_(\\d+)$", "\\1", input_table$species_id)

# Create a new data frame with species_id and midas_number columns
output_table <- data.frame(species_id = input_table$species_id, midas_number = input_table$midas_number)

# Save the output as a CSV file
# write.csv(output_table, file = "../Data/midas_tree/midas_db_v1.2/species_code_reference.txt", row.names = FALSE)

# Print the output data frame
print(output_table)

# Load the ape package
# library(ape)

# Read the Newick file
input_tree <- read.tree("../Data/midas_tree/midas_db_v1.2/species_tree.newick")

# Specify the tip labels for the subtree you want to extract
FD_species_subtree = c(
  'Akkermansia_muciniphila_55290',
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_putredinis_61533',
  'Alistipes_shahii_62199',
  'Alistipes_sp_60764',
  'Bacteroidales_bacterium_58650',
  'Bacteroides_caccae_53434',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_coprocola_61586',
  'Bacteroides_eggerthii_54457',
  'Bacteroides_fragilis_54507',
  'Bacteroides_massiliensis_44749',
  'Bacteroides_plebeius_61623',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_uniformis_57318',
  'Bacteroides_vulgatus_57955',
  'Bacteroides_xylanisolvens_57185',
  'Barnesiella_intestinihominis_62208',
  'Coprococcus_sp_62244',
  'Dialister_invisus_61905',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Eubacterium_siraeum_57634',
  'Faecalibacterium_prausnitzii_57453',
  'Faecalibacterium_prausnitzii_61481',
  'Faecalibacterium_prausnitzii_62201',
  'Lachnospiraceae_bacterium_51870',
  'Odoribacter_splanchnicus_62174',
  'Oscillibacter_sp_60799',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Phascolarctobacterium_sp_59817',
  'Prevotella_copri_61740',
  'Roseburia_intestinalis_56239',
  'Roseburia_inulinivorans_61943',
  'Ruminococcus_bicirculans_59300',
  'Ruminococcus_bromii_62047'
)

FD_midas_code_subtree = c()

for (species in FD_species_subtree) {
  FD_midas_code_subtree = c(FD_midas_code_subtree, get_species_code_reference(species, output_table))
}

print(FD_midas_code_subtree)

FD_subtree_tips = FD_midas_code_subtree

# Extract the subtree
FD_subtree <- keep.tip(input_tree, FD_subtree_tips)

# Print the extracted subtree
print(FD_subtree)

for (i in 1:length(FD_subtree$tip.label)) {
  print(FD_subtree$tip.label[i])
  new_tip = get_species_code_reference(FD_subtree$tip.label[i], output_table)
  # new_tip = str_sub(new_tip, 1, str_length(new_tip)-6)
  FD_subtree$tip.label[i] = new_tip
  print(FD_subtree$tip.label[i])
}

# plot(FD_subtree)
write.tree(FD_subtree, file='../Summary/FD_species.newick')

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
  'Faecalibacterium_prausnitzii_62201',
  'Faecalibacterium_prausnitzii_61481'
)

# write.tree(subtree, file='../Summary/core_accessory.newick')

# FD accessory tree

# Specify the tip labels for the subtree you want to extract
FD_accessory_species_subtree = c(
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_putredinis_61533',
  'Alistipes_shahii_62199',
  'Bacteroidales_bacterium_58650',
  'Bacteroides_caccae_53434',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_massiliensis_44749',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_vulgatus_57955',
  'Dialister_invisus_61905',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Eubacterium_siraeum_57634',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Ruminococcus_bromii_62047'
)

FD_accessory_midas_code_subtree = c()

for (species in FD_accessory_species_subtree) {
  FD_accessory_midas_code_subtree = c(FD_accessory_midas_code_subtree, get_species_code_reference(species, output_table))
}

print(FD_accessory_midas_code_subtree)

FD_accessory_subtree_tips = FD_accessory_midas_code_subtree

# Extract the subtree
FD_accessory_subtree <- keep.tip(input_tree, FD_accessory_subtree_tips)

# Print the extracted subtree
print(FD_accessory_subtree)

for (i in 1:length(FD_accessory_subtree$tip.label)) {
  print(FD_accessory_subtree$tip.label[i])
  new_tip = get_species_code_reference(FD_accessory_subtree$tip.label[i], output_table)
  # new_tip = str_sub(new_tip, 1, str_length(new_tip)-6)
  FD_accessory_subtree$tip.label[i] = new_tip
  print(FD_accessory_subtree$tip.label[i])
}

write.tree(FD_accessory_subtree, file='../Summary/FD_accessory_species.newick')

FD_accessory_phylogenetic_levels = c(
  'Alistipes putredinis',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Bacteroidales bacterium',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Bacteroides cellulosilyticus',
  'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides caccae',
  'Bacteroides massiliensis',
  'Bacteroides vulgatus',
  'Dialister invisus',
  'Eubacterium eligens',
  'Eubacterium rectale',
  'Eubacterium siraeum',
  'Ruminococcus bromii'
)

FD_accessory_phylogenetic_levels_MIDAS = c(
  'Alistipes_putredinis_61533',
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_shahii_62199',
  'Bacteroidales_bacterium_58650',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_caccae_53434',
  'Bacteroides_massiliensis_44749',
  'Bacteroides_vulgatus_57955',
  'Dialister_invisus_61905',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Eubacterium_siraeum_57634',
  'Ruminococcus_bromii_62047'
)


# HR phylogenetic_tree

# Specify the tip labels for the subtree you want to extract
HR_species_subtree = c(
  'Akkermansia_muciniphila_55290',
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_shahii_62199',
  'Bacteroides_caccae_53434',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_fragilis_54507',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_vulgatus_57955',
  'Barnesiella_intestinihominis_62208',
  'Dialister_invisus_61905',
  'Eubacterium_rectale_56927',
  'Oscillibacter_sp_60799',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Ruminococcus_bicirculans_59300',
  'Ruminococcus_bromii_62047'
)

HR_midas_code_subtree = c()

for (species in HR_species_subtree) {
  HR_midas_code_subtree = c(HR_midas_code_subtree, get_species_code_reference(species, output_table))
}

print(HR_midas_code_subtree)

HR_subtree_tips = HR_midas_code_subtree

# Extract the subtree
HR_subtree <- keep.tip(input_tree, HR_subtree_tips)

# Print the extracted subtree
print(HR_subtree)

for (i in 1:length(HR_subtree$tip.label)) {
  print(HR_subtree$tip.label[i])
  new_tip = get_species_code_reference(HR_subtree$tip.label[i], output_table)
  # new_tip = str_sub(new_tip, 1, str_length(new_tip)-6)
  HR_subtree$tip.label[i] = new_tip
  print(HR_subtree$tip.label[i])
}

# plot(HR_subtree)
write.tree(HR_subtree, file='../Summary/HR_species.newick')

HR_phylogenetic_levels = c(
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Bacteroides fragilis',
  'Bacteroides cellulosilyticus',
  'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides caccae',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Akkermansia muciniphila',
  'Dialister invisus',
  'Eubacterium rectale',
  'Oscillibacter sp.',
  'Ruminococcus bromii',
  'Ruminococcus bicirculans'
)

HR_phylogenetic_levels_MIDAS = c(
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_shahii_62199',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Bacteroides_fragilis_54507',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_caccae_53434',
  'Bacteroides_vulgatus_57955',
  'Barnesiella_intestinihominis_62208',
  'Akkermansia_muciniphila_55290',
  'Dialister_invisus_61905',
  'Eubacterium_rectale_56927',
  'Oscillibacter_sp_60799',
  'Ruminococcus_bromii_62047',
  'Ruminococcus_bicirculans_59300'
)

# engraftment phylogenetic_tree

# Specify the tip labels for the subtree you want to extract
engraftment_species_subtree = c(
  'Akkermansia_muciniphila_55290',
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_putredinis_61533',
  'Alistipes_shahii_62199',
  'Alistipes_sp_60764',
  'Bacteroides_caccae_53434',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_coprocola_61586',
  'Bacteroides_eggerthii_54457',
  'Bacteroides_fragilis_54507',
  'Bacteroides_massiliensis_44749',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_uniformis_57318',
  'Bacteroides_vulgatus_57955',
  'Barnesiella_intestinihominis_62208',
  'Coprococcus_sp_62244',
  'Dialister_invisus_61905',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Eubacterium_siraeum_57634',
  'Faecalibacterium_prausnitzii_57453',
  'Faecalibacterium_prausnitzii_61481',
  'Faecalibacterium_prausnitzii_62201',
  'Lachnospiraceae_bacterium_51870',
  'Odoribacter_splanchnicus_62174',
  'Oscillibacter_sp_60799',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Phascolarctobacterium_sp_59817',
  'Prevotella_copri_61740',
  'Roseburia_intestinalis_56239',
  'Roseburia_inulinivorans_61943',
  'Ruminococcus_bicirculans_59300',
  'Ruminococcus_bromii_62047'
)

engraftment_midas_code_subtree = c()

for (species in engraftment_species_subtree) {
  engraftment_midas_code_subtree = c(engraftment_midas_code_subtree, get_species_code_reference(species, output_table))
}

print(engraftment_midas_code_subtree)

engraftment_subtree_tips = engraftment_midas_code_subtree

# Extract the subtree
engraftment_subtree <- keep.tip(input_tree, engraftment_subtree_tips)

# Print the extracted subtree
print(engraftment_subtree)

for (i in 1:length(engraftment_subtree$tip.label)) {
  print(engraftment_subtree$tip.label[i])
  new_tip = get_species_code_reference(engraftment_subtree$tip.label[i], output_table)
  # new_tip = str_sub(new_tip, 1, str_length(new_tip)-6)
  engraftment_subtree$tip.label[i] = new_tip
  print(engraftment_subtree$tip.label[i])
}

# plot(engraftment_subtree)
write.tree(engraftment_subtree, file='../Summary/engraftment_species.newick')

# sporulation phylogenetic_tree

# Specify the tip labels for the subtree you want to extract
sporulation_species_subtree = c(
  'Akkermansia_muciniphila_55290',
  'Alistipes_finegoldii_56071',
  'Bacteroides_caccae_53434',
  'Bacteroides_coprocola_61586',
  'Bacteroides_fragilis_54507',
  'Bacteroides_ovatus_58035',
  'Bacteroides_plebeius_61623',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_uniformis_57318',
  'Bacteroides_vulgatus_57955',
  'Bacteroides_xylanisolvens_57185',
  'Coprococcus_sp_62244',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Eubacterium_siraeum_57634',
  'Faecalibacterium_prausnitzii_57453',
  'Faecalibacterium_prausnitzii_62201',
  'Faecalibacterium_prausnitzii_61481',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Prevotella_copri_61740',
  'Roseburia_intestinalis_56239',
  'Roseburia_inulinivorans_61943',
  'Ruminococcus_bromii_62047'
)



sporulation_midas_code_subtree = c()

for (species in sporulation_species_subtree) {
  sporulation_midas_code_subtree = c(sporulation_midas_code_subtree, get_species_code_reference(species, output_table))
}

print(sporulation_midas_code_subtree)

sporulation_subtree_tips = sporulation_midas_code_subtree

# Extract the subtree
sporulation_subtree <- keep.tip(input_tree, sporulation_subtree_tips)

# Print the extracted subtree
print(sporulation_subtree)

for (i in 1:length(sporulation_subtree$tip.label)) {
  print(sporulation_subtree$tip.label[i])
  new_tip = get_species_code_reference(sporulation_subtree$tip.label[i], output_table)
  # new_tip = str_sub(new_tip, 1, str_length(new_tip)-6)
  sporulation_subtree$tip.label[i] = new_tip
  print(sporulation_subtree$tip.label[i])
}

write.tree(sporulation_subtree, file='../Summary/sporulation_species.newick')

# # FD subtree without `DFE shape` outliers
# 
# # Specify the tip labels for the subtree you want to extract
# FD_no_outlier_species_subtree = c(
#   'Akkermansia_muciniphila_55290',
#   'Alistipes_finegoldii_56071',
#   'Alistipes_onderdonkii_55464',
#   'Alistipes_putredinis_61533',
#   'Alistipes_shahii_62199',
#   'Alistipes_sp_60764',
#   'Bacteroidales_bacterium_58650',
#   'Bacteroides_caccae_53434',
#   'Bacteroides_cellulosilyticus_58046',
#   'Bacteroides_coprocola_61586',
#   'Bacteroides_eggerthii_54457',
#   'Bacteroides_fragilis_54507',
#   'Bacteroides_massiliensis_44749',
#   'Bacteroides_plebeius_61623',
#   'Bacteroides_stercoris_56735',
#   'Bacteroides_thetaiotaomicron_56941',
#   'Bacteroides_uniformis_57318',
#   'Bacteroides_vulgatus_57955',
#   'Bacteroides_xylanisolvens_57185',
#   'Barnesiella_intestinihominis_62208',
#   'Coprococcus_sp_62244',
#   'Dialister_invisus_61905',
#   'Eubacterium_eligens_61678',
#   'Eubacterium_rectale_56927',
#   'Eubacterium_siraeum_57634',
#   'Faecalibacterium_prausnitzii_57453',
#   'Faecalibacterium_prausnitzii_61481',
#   'Lachnospiraceae_bacterium_51870',
#   'Odoribacter_splanchnicus_62174',
#   'Oscillibacter_sp_60799',
#   'Parabacteroides_distasonis_56985',
#   'Parabacteroides_merdae_56972',
#   'Phascolarctobacterium_sp_59817',
#   'Prevotella_copri_61740',
#   'Roseburia_inulinivorans_61943',
#   'Ruminococcus_bicirculans_59300',
#   'Ruminococcus_bromii_62047'
# )
# 
# FD_no_outlier_midas_code_subtree = c()
# 
# for (species in FD_no_outlier_species_subtree) {
#   FD_no_outlier_midas_code_subtree = c(FD_no_outlier_midas_code_subtree, get_species_code_reference(species, output_table))
# }
# 
# print(FD_no_outlier_midas_code_subtree)
# 
# FD_no_outlier_subtree_tips = FD_no_outlier_midas_code_subtree
# 
# # Extract the subtree
# FD_no_outlier_subtree <- keep.tip(input_tree, FD_no_outlier_subtree_tips)
# 
# # Print the extracted subtree
# print(FD_no_outlier_subtree)
# 
# for (i in 1:length(FD_no_outlier_subtree$tip.label)) {
#   print(FD_no_outlier_subtree$tip.label[i])
#   new_tip = get_species_code_reference(FD_no_outlier_subtree$tip.label[i], output_table)
#   # new_tip = str_sub(new_tip, 1, str_length(new_tip)-6)
#   FD_no_outlier_subtree$tip.label[i] = new_tip
#   print(FD_no_outlier_subtree$tip.label[i])
# }
# 
# write.tree(FD_no_outlier_subtree, file='../Summary/FD_no_outlier_species.newick')

# SFS comparison

## Read in empirical downsampled SFS (folded)

a_muciniphila_original_folded = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_finegoldii_original_folded = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_onderdonkii_original_folded = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_shahii_original_folded = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_caccae_original_folded = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_cellulosilyticus_original_folded = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
# read_input_sfs('../Analysis/Bacteroides_coprocola_61586_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
# read_input_sfs('../Analysis/Bacteroides_eggerthii_54457_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_fragilis_original_folded = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_ovatus_original_folded = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_stercoris_original_folded = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_thetaiotaomicron_original_folded = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_vulgatus_original_folded = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
d_invisus_original_folded = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_intestinihominis_original_folded = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
e_rectale_original_folded = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
# read_input_sfs('../Analysis/Eubacterium_siraeum_57634_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
oscillibacter_sp_original_folded = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
p_distasonis_original_folded = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
p_merdae_original_folded = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
r_bicirculans_original_folded = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
r_bromii_original_folded = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_syn_downsampled_sfs.txt')

## Read in high recombination SFS (folded)

a_muciniphila_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_empirical_syn_14_downsampled_sfs.txt')
a_finegoldii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_empirical_syn_14_downsampled_sfs.txt')
a_onderdonkii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_empirical_syn_14_downsampled_sfs.txt')
a_shahii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_caccae_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_cellulosilyticus_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_coprocola_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_eggerthii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_fragilis_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_ovatus_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_stercoris_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_thetaiotaomicron_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_vulgatus_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_empirical_syn_14_downsampled_sfs.txt')
d_invisus_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_empirical_syn_14_downsampled_sfs.txt')
b_intestinihominis_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_empirical_syn_14_downsampled_sfs.txt')
e_rectale_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_empirical_syn_14_downsampled_sfs.txt')
e_siraeum_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_empirical_syn_14_downsampled_sfs.txt')
oscillibacter_sp_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_empirical_syn_14_downsampled_sfs.txt')
p_distasonis_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_empirical_syn_14_downsampled_sfs.txt')
p_merdae_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_empirical_syn_14_downsampled_sfs.txt')
r_bicirculans_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_empirical_syn_14_downsampled_sfs.txt')
r_bromii_HR_folded = read_input_sfs('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_empirical_syn_14_downsampled_sfs.txt')

## Read in demographic model fit for high recombination

### One-epoch
a_muciniphila_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_one_epoch_demography.txt')
a_finegoldii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_one_epoch_demography.txt')
a_onderdonkii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_one_epoch_demography.txt')
a_shahii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_one_epoch_demography.txt')
b_caccae_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_one_epoch_demography.txt')
b_cellulosilyticus_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_one_epoch_demography.txt')
b_coprocola_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_one_epoch_demography.txt')
b_eggerthii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_one_epoch_demography.txt')
b_fragilis_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_one_epoch_demography.txt')
b_ovatus_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_one_epoch_demography.txt')
b_stercoris_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_one_epoch_demography.txt')
b_thetaiotaomicron_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_one_epoch_demography.txt')
b_vulgatus_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_one_epoch_demography.txt')
d_invisus_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_one_epoch_demography.txt')
b_intestinihominis_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_one_epoch_demography.txt')
e_rectale_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_one_epoch_demography.txt')
e_siraeum_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_one_epoch_demography.txt')
oscillibacter_sp_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_one_epoch_demography.txt')
p_distasonis_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_one_epoch_demography.txt')
p_merdae_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_one_epoch_demography.txt')
r_bicirculans_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_one_epoch_demography.txt')
r_bromii_HR_one_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_one_epoch_demography.txt')

### Two-epoch
a_muciniphila_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_two_epoch_demography.txt')
a_finegoldii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_two_epoch_demography.txt')
a_onderdonkii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_two_epoch_demography.txt')
a_shahii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_two_epoch_demography.txt')
b_caccae_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_two_epoch_demography.txt')
b_cellulosilyticus_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_two_epoch_demography.txt')
b_coprocola_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_two_epoch_demography.txt')
b_eggerthii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_two_epoch_demography.txt')
b_fragilis_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_two_epoch_demography.txt')
b_ovatus_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_two_epoch_demography.txt')
b_stercoris_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_two_epoch_demography.txt')
b_thetaiotaomicron_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_two_epoch_demography.txt')
b_vulgatus_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_two_epoch_demography.txt')
d_invisus_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_two_epoch_demography.txt')
b_intestinihominis_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_two_epoch_demography.txt')
e_rectale_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_two_epoch_demography.txt')
e_siraeum_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_two_epoch_demography.txt')
oscillibacter_sp_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_two_epoch_demography.txt')
p_distasonis_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_two_epoch_demography.txt')
p_merdae_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_two_epoch_demography.txt')
r_bicirculans_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_two_epoch_demography.txt')
r_bromii_HR_two_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_two_epoch_demography.txt')

### Three-epoch
a_muciniphila_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_three_epoch_demography.txt')
a_finegoldii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_three_epoch_demography.txt')
a_onderdonkii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_three_epoch_demography.txt')
a_shahii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_three_epoch_demography.txt')
b_caccae_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_three_epoch_demography.txt')
b_cellulosilyticus_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_three_epoch_demography.txt')
b_coprocola_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_three_epoch_demography.txt')
b_eggerthii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_three_epoch_demography.txt')
b_fragilis_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_three_epoch_demography.txt')
b_ovatus_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_three_epoch_demography.txt')
b_stercoris_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_three_epoch_demography.txt')
b_thetaiotaomicron_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_three_epoch_demography.txt')
b_vulgatus_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_three_epoch_demography.txt')
d_invisus_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_three_epoch_demography.txt')
b_intestinihominis_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_three_epoch_demography.txt')
e_rectale_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_three_epoch_demography.txt')
e_siraeum_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_three_epoch_demography.txt')
oscillibacter_sp_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_three_epoch_demography.txt')
p_distasonis_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_three_epoch_demography.txt')
p_merdae_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_three_epoch_demography.txt')
r_bicirculans_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_three_epoch_demography.txt')
r_bromii_HR_three_epoch = sfs_from_demography('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_three_epoch_demography.txt')

## HR nonsynonoymous
a_muciniphila_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt')
a_finegoldii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt')
a_onderdonkii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt')
a_shahii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt')
b_caccae_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt')
b_cellulosilyticus_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt')
b_coprocola_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_inferred_DFE.txt')
b_eggerthii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_inferred_DFE.txt')
b_fragilis_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt')
b_ovatus_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_inferred_DFE.txt')
b_stercoris_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt')
b_thetaiotaomicron_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt')
b_vulgatus_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt')
d_invisus_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt')
b_intestinihominis_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt')
e_rectale_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt')
e_siraeum_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_inferred_DFE.txt')
oscillibacter_sp_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt')
p_distasonis_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt')
p_merdae_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt')
r_bicirculans_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt')
r_bromii_HR_nonsyn = empirical_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt')

# HR gamma
a_muciniphila_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt')
a_finegoldii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt')
a_onderdonkii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt')
a_shahii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt')
b_caccae_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt')
b_cellulosilyticus_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt')
b_coprocola_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_inferred_DFE.txt')
b_eggerthii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_inferred_DFE.txt')
b_fragilis_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt')
b_ovatus_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_inferred_DFE.txt')
b_stercoris_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt')
b_thetaiotaomicron_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt')
b_vulgatus_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt')
d_invisus_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt')
b_intestinihominis_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt')
e_rectale_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt')
e_siraeum_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_inferred_DFE.txt')
oscillibacter_sp_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt')
p_distasonis_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt')
p_merdae_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt')
r_bicirculans_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt')
r_bromii_HR_gamma = gamma_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt')

# HR neugamma
a_muciniphila_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt')
a_finegoldii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt')
a_onderdonkii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt')
a_shahii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt')
b_caccae_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt')
b_cellulosilyticus_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt')
b_coprocola_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_inferred_DFE.txt')
b_eggerthii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_inferred_DFE.txt')
b_fragilis_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt')
b_ovatus_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_inferred_DFE.txt')
b_stercoris_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt')
b_thetaiotaomicron_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt')
b_vulgatus_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt')
d_invisus_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt')
b_intestinihominis_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt')
e_rectale_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt')
e_siraeum_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_inferred_DFE.txt')
oscillibacter_sp_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt')
p_distasonis_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt')
p_merdae_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt')
r_bicirculans_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt')
r_bromii_HR_neugamma = neugamma_sfs_from_dfe('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt')

## Compare sfs high recombination (proportional)
# compare_sfs_high_recombination(proportional_sfs(a_muciniphila_original_folded), 
#   proportional_sfs(a_muciniphila_HR_folded)) +
#   ggtitle('Akkermansia muciniphila SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(a_finegoldii_original_folded), 
#   proportional_sfs(a_finegoldii_HR_folded)) +
#   ggtitle('Alistipes finegoldii SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(a_onderdonkii_original_folded), 
#   proportional_sfs(a_onderdonkii_HR_folded)) +
#   ggtitle('Alistipes onderdonkii SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(a_shahii_original_folded), 
#   proportional_sfs(a_shahii_HR_folded)) +
#   ggtitle('Alistipes shahii SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(b_caccae_original_folded), 
#   proportional_sfs(b_caccae_HR_folded)) +
#   ggtitle('Bacteroides caccae SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(b_cellulosilyticus_original_folded), 
#   proportional_sfs(b_cellulosilyticus_HR_folded)) +
#   ggtitle('Bacteroides cellulosilyticus SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(b_fragilis_original_folded), 
#   proportional_sfs(b_fragilis_HR_folded)) +
#   ggtitle('Bacteroides fragilis SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(b_ovatus_original_folded), 
#   proportional_sfs(b_ovatus_HR_folded)) +
#   ggtitle('Bacteroides ovatus SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(b_stercoris_original_folded), 
#   proportional_sfs(b_stercoris_HR_folded)) +
#   ggtitle('Bacteroides stercoris SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(b_thetaiotaomicron_original_folded), 
#   proportional_sfs(b_thetaiotaomicron_HR_folded)) +
#   ggtitle('Bacteroides thetaiotaomicron SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(b_vulgatus_original_folded), 
#   proportional_sfs(b_vulgatus_HR_folded)) +
#   ggtitle('Bacteroides vulgatus SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(d_invisus_original_folded), 
#   proportional_sfs(d_invisus_HR_folded)) +
#   ggtitle('Dialister invisus SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(b_intestinihominis_original_folded), 
#   proportional_sfs(b_intestinihominis_HR_folded)) +
#   ggtitle('Barnesiella intestinihominis SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(e_rectale_original_folded), 
#   proportional_sfs(e_rectale_HR_folded)) +
#   ggtitle('Eubacterium rectale SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(oscillibacter_sp_original_folded), 
#   proportional_sfs(oscillibacter_sp_HR_folded)) +
#   ggtitle('Oscillibacter sp. SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(p_distasonis_original_folded), 
#   proportional_sfs(p_distasonis_HR_folded)) +
#   ggtitle('Parabacteroides distasonis SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(p_merdae_original_folded), 
#   proportional_sfs(p_merdae_HR_folded)) +
#   ggtitle('Parabacteroides merdae SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(r_bicirculans_original_folded), 
#   proportional_sfs(r_bicirculans_HR_folded)) +
#   ggtitle('Ruminococcus bicirculans SFS comparison (proportional)')
# compare_sfs_high_recombination(proportional_sfs(r_bromii_original_folded), 
#   proportional_sfs(r_bromii_HR_folded)) +
#   ggtitle('Ruminococcus bromii SFS comparison (proportional)')

## Compare sfs high recombination (count)
# compare_sfs_high_recombination((a_muciniphila_original_folded), 
#   (a_muciniphila_HR_folded)) +
#   ggtitle('Akkermansia muciniphila SFS comparison (count)')
# compare_sfs_high_recombination((a_finegoldii_original_folded), 
#   (a_finegoldii_HR_folded)) +
#   ggtitle('Alistipes finegoldii SFS comparison (count)')
# compare_sfs_high_recombination((a_onderdonkii_original_folded), 
#   (a_onderdonkii_HR_folded)) +
#   ggtitle('Alistipes onderdonkii SFS comparison (count)')
# compare_sfs_high_recombination((a_shahii_original_folded), 
#   (a_shahii_HR_folded)) +
#   ggtitle('Alistipes shahii SFS comparison (count)')
# compare_sfs_high_recombination((b_caccae_original_folded), 
#   (b_caccae_HR_folded)) +
#   ggtitle('Bacteroides caccae SFS comparison (count)')
# compare_sfs_high_recombination((b_cellulosilyticus_original_folded), 
#   (b_cellulosilyticus_HR_folded)) +
#   ggtitle('Bacteroides cellulosilyticus SFS comparison (count)')
# compare_sfs_high_recombination((b_fragilis_original_folded), 
#   (b_fragilis_HR_folded)) +
#   ggtitle('Bacteroides fragilis SFS comparison (count)')
# compare_sfs_high_recombination((b_ovatus_original_folded), 
#   (b_ovatus_HR_folded)) +
#   ggtitle('Bacteroides ovatus SFS comparison (count)')
# compare_sfs_high_recombination((b_stercoris_original_folded), 
#   (b_stercoris_HR_folded)) +
#   ggtitle('Bacteroides stercoris SFS comparison (count)')
# compare_sfs_high_recombination((b_thetaiotaomicron_original_folded), 
#   (b_thetaiotaomicron_HR_folded)) +
#   ggtitle('Bacteroides thetaiotaomicron SFS comparison (count)')
# compare_sfs_high_recombination((b_vulgatus_original_folded), 
#   (b_vulgatus_HR_folded)) +
#   ggtitle('Bacteroides vulgatus SFS comparison (count)')
# compare_sfs_high_recombination((d_invisus_original_folded), 
#   (d_invisus_HR_folded)) +
#   ggtitle('Dialister invisus SFS comparison (count)')
# compare_sfs_high_recombination((b_intestinihominis_original_folded), 
#   (b_intestinihominis_HR_folded)) +
#   ggtitle('Barnesiella intestinihominis SFS comparison (count)')
# compare_sfs_high_recombination((e_rectale_original_folded), 
#   (e_rectale_HR_folded)) +
#   ggtitle('Eubacterium rectale SFS comparison (count)')
# compare_sfs_high_recombination((oscillibacter_sp_original_folded), 
#   (oscillibacter_sp_HR_folded)) +
#   ggtitle('Oscillibacter sp. SFS comparison (count)')
# compare_sfs_high_recombination((p_distasonis_original_folded), 
#   (p_distasonis_HR_folded)) +
#   ggtitle('Parabacteroides distasonis SFS comparison (count)')
# compare_sfs_high_recombination((p_merdae_original_folded), 
#   (p_merdae_HR_folded)) +
#   ggtitle('Parabacteroides merdae SFS comparison (count)')
# compare_sfs_high_recombination((r_bicirculans_original_folded), 
#   (r_bicirculans_HR_folded)) +
#   ggtitle('Ruminococcus bicirculans SFS comparison (count)')
# compare_sfs_high_recombination((r_bromii_original_folded), 
#   (r_bromii_HR_folded)) +
#   ggtitle('Ruminococcus bromii SFS comparison (count)')

## High recombination model fit
a_muciniphila_HR_demography_sfs = compare_sfs(proportional_sfs(a_muciniphila_HR_folded), 
  proportional_sfs(a_muciniphila_HR_one_epoch), 
  proportional_sfs(a_muciniphila_HR_two_epoch), 
  proportional_sfs(a_muciniphila_HR_three_epoch)) +
  ggtitle('Akkermansia muciniphila (HR) model fit')

a_finegoldii_HR_demography_sfs = compare_sfs(proportional_sfs(a_finegoldii_HR_folded), 
  proportional_sfs(a_finegoldii_HR_one_epoch), 
  proportional_sfs(a_finegoldii_HR_two_epoch), 
  proportional_sfs(a_finegoldii_HR_three_epoch)) +
  ggtitle('Alistipes finegoldii (HR) model fit')

a_onderdonkii_HR_demography_sfs = compare_sfs(proportional_sfs(a_onderdonkii_HR_folded), 
  proportional_sfs(a_onderdonkii_HR_one_epoch), 
  proportional_sfs(a_onderdonkii_HR_two_epoch), 
  proportional_sfs(a_onderdonkii_HR_three_epoch)) +
  ggtitle('Alistipes onderdonkii (HR) model fit')

a_shahii_HR_demography_sfs = compare_sfs(proportional_sfs(a_shahii_HR_folded), 
  proportional_sfs(a_shahii_HR_one_epoch), 
  proportional_sfs(a_shahii_HR_two_epoch), 
  proportional_sfs(a_shahii_HR_three_epoch)) +
  ggtitle('Alistipes shahii (HR) model fit')

b_caccae_HR_demography_sfs = compare_sfs(proportional_sfs(b_caccae_HR_folded), 
  proportional_sfs(b_caccae_HR_one_epoch), 
  proportional_sfs(b_caccae_HR_two_epoch), 
  proportional_sfs(b_caccae_HR_three_epoch)) +
  ggtitle('Bacteroides caccae (HR) model fit')

b_cellulosilyticus_HR_demography_sfs = compare_sfs(proportional_sfs(b_cellulosilyticus_HR_folded), 
  proportional_sfs(b_cellulosilyticus_HR_one_epoch), 
  proportional_sfs(b_cellulosilyticus_HR_two_epoch), 
  proportional_sfs(b_cellulosilyticus_HR_three_epoch)) +
  ggtitle('Bacteroides cellulosilyticus (HR) model fit')

b_coprocola_HR_demography_sfs = compare_sfs(proportional_sfs(b_coprocola_HR_folded), 
  proportional_sfs(b_coprocola_HR_one_epoch), 
  proportional_sfs(b_coprocola_HR_two_epoch), 
  proportional_sfs(b_coprocola_HR_three_epoch)) +
  ggtitle('Bacteroides copracola (HR) model fit')

b_eggerthii_HR_demography_sfs = compare_sfs(proportional_sfs(b_eggerthii_HR_folded), 
  proportional_sfs(b_eggerthii_HR_one_epoch), 
  proportional_sfs(b_eggerthii_HR_two_epoch), 
  proportional_sfs(b_eggerthii_HR_three_epoch)) +
  ggtitle('Bacteroides eggerthii (HR) model fit')

b_fragilis_HR_demography_sfs = compare_sfs(proportional_sfs(b_fragilis_HR_folded), 
  proportional_sfs(b_fragilis_HR_one_epoch), 
  proportional_sfs(b_fragilis_HR_two_epoch), 
  proportional_sfs(b_fragilis_HR_three_epoch)) +
  ggtitle('Bacteroides fragilis (HR) model fit')

b_ovatus_HR_demography_sfs = compare_sfs(proportional_sfs(b_ovatus_HR_folded), 
  proportional_sfs(b_ovatus_HR_one_epoch), 
  proportional_sfs(b_ovatus_HR_two_epoch), 
  proportional_sfs(b_ovatus_HR_three_epoch)) +
  ggtitle('Bacteroides ovatus (HR) model fit')

b_stercoris_HR_demography_sfs = compare_sfs(proportional_sfs(b_stercoris_HR_folded), 
  proportional_sfs(b_stercoris_HR_one_epoch), 
  proportional_sfs(b_stercoris_HR_two_epoch), 
  proportional_sfs(b_stercoris_HR_three_epoch)) +
  ggtitle('Bacteroides stercoris (HR) model fit')

b_thetaiotaomicron_HR_demography_sfs = compare_sfs(proportional_sfs(b_thetaiotaomicron_HR_folded), 
  proportional_sfs(b_thetaiotaomicron_HR_one_epoch), 
  proportional_sfs(b_thetaiotaomicron_HR_two_epoch), 
  proportional_sfs(b_thetaiotaomicron_HR_three_epoch)) +
  ggtitle('Bacteroides thetaiotaomicron (HR) model fit')

b_vulgatus_HR_demography_sfs = compare_sfs(proportional_sfs(b_vulgatus_HR_folded), 
  proportional_sfs(b_vulgatus_HR_one_epoch), 
  proportional_sfs(b_vulgatus_HR_two_epoch), 
  proportional_sfs(b_vulgatus_HR_three_epoch)) +
  ggtitle('Bacteroides vulgatus (HR) model fit')

d_invisus_HR_demography_sfs = compare_sfs(proportional_sfs(d_invisus_HR_folded), 
  proportional_sfs(d_invisus_HR_one_epoch), 
  proportional_sfs(d_invisus_HR_two_epoch), 
  proportional_sfs(d_invisus_HR_three_epoch)) +
  ggtitle('Dialister invisus (HR) model fit')

b_intestinihominis_HR_demography_sfs = compare_sfs(proportional_sfs(b_intestinihominis_HR_folded), 
  proportional_sfs(b_intestinihominis_HR_one_epoch), 
  proportional_sfs(b_intestinihominis_HR_two_epoch), 
  proportional_sfs(b_intestinihominis_HR_three_epoch)) +
  ggtitle('Barnesiella intestinihominis (HR) model fit')

e_rectale_HR_demography_sfs = compare_sfs(proportional_sfs(e_rectale_HR_folded), 
  proportional_sfs(e_rectale_HR_one_epoch), 
  proportional_sfs(e_rectale_HR_two_epoch), 
  proportional_sfs(e_rectale_HR_three_epoch)) +
  ggtitle('Eubacterium rectale (HR) model fit')

e_siraeum_HR_demography_sfs = compare_sfs(proportional_sfs(e_siraeum_HR_folded), 
  proportional_sfs(e_siraeum_HR_one_epoch), 
  proportional_sfs(e_siraeum_HR_two_epoch), 
  proportional_sfs(e_siraeum_HR_three_epoch)) +
  ggtitle('Eubacterium siraeum (HR) model fit')

oscillibacter_sp_HR_demography_sfs = compare_sfs(proportional_sfs(oscillibacter_sp_HR_folded), 
  proportional_sfs(oscillibacter_sp_HR_one_epoch), 
  proportional_sfs(oscillibacter_sp_HR_two_epoch), 
  proportional_sfs(oscillibacter_sp_HR_three_epoch)) +
  ggtitle('Oscillibacter sp. (HR) model fit')

p_distasonis_HR_demography_sfs = compare_sfs(proportional_sfs(p_distasonis_HR_folded), 
  proportional_sfs(p_distasonis_HR_one_epoch), 
  proportional_sfs(p_distasonis_HR_two_epoch), 
  proportional_sfs(p_distasonis_HR_three_epoch)) +
  ggtitle('Parabacteroides distasonis (HR) model fit')

p_merdae_HR_demography_sfs = compare_sfs(proportional_sfs(p_merdae_HR_folded), 
  proportional_sfs(p_merdae_HR_one_epoch), 
  proportional_sfs(p_merdae_HR_two_epoch), 
  proportional_sfs(p_merdae_HR_three_epoch)) +
  ggtitle('Parabacteroides merdae (HR) model fit')

r_bicirculans_HR_demography_sfs = compare_sfs(proportional_sfs(r_bicirculans_HR_folded), 
  proportional_sfs(r_bicirculans_HR_one_epoch), 
  proportional_sfs(r_bicirculans_HR_two_epoch), 
  proportional_sfs(r_bicirculans_HR_three_epoch)) +
  ggtitle('Ruminococcus bicirculans (HR) model fit')

r_bromii_HR_demography_sfs = compare_sfs(proportional_sfs(r_bromii_HR_folded), 
  proportional_sfs(r_bromii_HR_one_epoch), 
  proportional_sfs(r_bromii_HR_two_epoch), 
  proportional_sfs(r_bromii_HR_three_epoch)) +
  ggtitle('Ruminococcus bromii (HR) model fit')

a_muciniphila_HR_demography_sfs +
  a_finegoldii_HR_demography_sfs +
  a_onderdonkii_HR_demography_sfs +
  a_shahii_HR_demography_sfs +
  plot_layout(ncol=1)


## Likelihood surfaces
a_muciniphila_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv') + 
  ggtitle('A. muciniphila (High recombination)')

a_finegoldii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv') + 
  ggtitle('A. finegoldii (High recombination)')

a_onderdonkii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv') + 
  ggtitle('A. onderdonkii (High recombination)')

a_shahii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Alistipes_shahii_62199/likelihood_surface.csv') + 
  ggtitle('A. shahii (High recombination)')

b_caccae_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv') + 
  ggtitle('B. caccae (High recombination)')

b_cellulosilyticus_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv') + 
  ggtitle('B. cellulosilyticus (High recombination)')

b_coprocola_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/likelihood_surface.csv') + 
  ggtitle('B. coprocola (High recombination)')

b_eggerthii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/likelihood_surface.csv') + 
  ggtitle('B. eggerthii (High recombination)')

b_fragilis_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv') + 
  ggtitle('B. fragilis (High recombination)')

b_ovatus_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/likelihood_surface.csv') + 
  ggtitle('B. ovatus (High recombination)')

b_stercoris_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv') + 
  ggtitle('B. stercoris (High recombination)')

b_thetaiotaomicron_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv') + 
  ggtitle('B. thetaiotaomicron (High recombination)')

b_vulgatus_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv') + 
  ggtitle('B. vulgatus (High recombination)')

b_intestinihominis_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv') + 
  ggtitle('B. intestinihominis (High recombination)')

d_invisus_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Dialister_invisus_61905/likelihood_surface.csv') + 
  ggtitle('D. invisus (High recombination)')

e_rectale_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv') + 
  ggtitle('E. rectale (High recombination)')

e_siraeum_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/likelihood_surface.csv') + 
  ggtitle('E. siraeum (High recombination)')

oscillibacter_sp_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv') + 
  ggtitle('Oscillibacter sp. (High recombination)')

p_distasonis_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv') + 
  ggtitle('P. distasonis (High recombination)')

p_merdae_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv') + 
  ggtitle('P. merdae (High recombination)')

r_bicirculans_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv') + 
  ggtitle('R. bicirculans (High recombination)')

r_bromii_HR_likelihood_surface = plot_likelihood_surface_contour('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv') + 
  ggtitle('R. bromii (High recombination)')

## HR demography_fit

HR_demography_fit = a_finegoldii_HR_demography_sfs + a_finegoldii_HR_likelihood_surface +
  a_onderdonkii_HR_demography_sfs + a_onderdonkii_HR_likelihood_surface +
  a_shahii_HR_demography_sfs + a_shahii_HR_likelihood_surface +
  p_distasonis_HR_demography_sfs + p_distasonis_HR_likelihood_surface +
  p_merdae_HR_demography_sfs + p_merdae_HR_likelihood_surface +
  b_fragilis_HR_demography_sfs + b_fragilis_HR_likelihood_surface +
  b_cellulosilyticus_HR_demography_sfs + b_cellulosilyticus_HR_likelihood_surface +
  b_stercoris_HR_demography_sfs + b_stercoris_HR_likelihood_surface +
  b_thetaiotaomicron_HR_demography_sfs + b_thetaiotaomicron_HR_likelihood_surface +
  b_caccae_HR_demography_sfs + b_caccae_HR_likelihood_surface +
  b_vulgatus_HR_demography_sfs + b_vulgatus_HR_likelihood_surface +
  b_intestinihominis_HR_demography_sfs + b_intestinihominis_HR_likelihood_surface +
  a_muciniphila_HR_demography_sfs + a_muciniphila_HR_likelihood_surface +
  d_invisus_HR_demography_sfs + d_invisus_HR_likelihood_surface +
  e_rectale_HR_demography_sfs + e_rectale_HR_likelihood_surface +
  oscillibacter_sp_HR_demography_sfs + oscillibacter_sp_HR_likelihood_surface +
  r_bromii_HR_demography_sfs + r_bromii_HR_likelihood_surface +
  r_bicirculans_HR_demography_sfs + r_bicirculans_HR_likelihood_surface +
  plot_layout(ncol=2)
  
# ggsave(filename='./HR_demography_fit.png', plot=HR_demography_fit, width=20, height=150, units='in', limitsize=FALSE)

## Survival curve
# a_muciniphila_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/survival_curve.csv')
# plot_survival_curve(a_muciniphila_HR_survival_curve) + 
#   ggtitle('A. muciniphila survival curve')
# 
# a_finegoldii_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/survival_curve.csv')
# plot_survival_curve(a_finegoldii_HR_survival_curve) +
#   ggtitle('A. finegoldii survival curve')
# 
# a_onderdonkii_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/survival_curve.csv')
# plot_survival_curve(a_onderdonkii_HR_survival_curve) +
#   ggtitle('A. onderdonkii survival curve')
# 
# a_shahii_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Alistipes_shahii_62199/survival_curve.csv')
# plot_survival_curve(a_shahii_HR_survival_curve) +
#   ggtitle('A. shahii survival curve')
# 
# b_caccae_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_caccae_53434/survival_curve.csv')
# plot_survival_curve(b_caccae_HR_survival_curve) +
#   ggtitle('B. caccae survival curve')
# 
# b_cellulosilyticus_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/survival_curve.csv')
# plot_survival_curve(b_cellulosilyticus_HR_survival_curve) +
#   ggtitle('B. cellulosilyticus survival curve')
# 
# b_coprocola_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/survival_curve.csv')
# plot_survival_curve(b_coprocola_HR_survival_curve) +
#   ggtitle('B. coprocola survival curve')
# 
# b_eggerthii_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/survival_curve.csv')
# plot_survival_curve(b_eggerthii_HR_survival_curve) +
#   ggtitle('B. eggerthii survival curve')
# 
# b_fragilis_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/survival_curve.csv')
# plot_survival_curve(b_fragilis_HR_survival_curve) +
#   ggtitle('B. fragilis survival curve')
# 
# b_ovatus_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/survival_curve.csv')
# plot_survival_curve(b_ovatus_HR_survival_curve) +
#   ggtitle('B. ovatus survival curve')
# 
# b_stercoris_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/survival_curve.csv')
# plot_survival_curve(b_stercoris_HR_survival_curve) +
#   ggtitle('B. stercoris survival curve')
# 
# b_thetaiotaomicron_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/survival_curve.csv')
# plot_survival_curve(b_thetaiotaomicron_HR_survival_curve) +
#   ggtitle('B. thetaiotaomicron survival curve')
# 
# b_vulgatus_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/survival_curve.csv')
# plot_survival_curve(b_vulgatus_HR_survival_curve) +
#   ggtitle('B. vulgatus survival curve')
# 
# d_invisus_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Dialister_invisus_61905/survival_curve.csv')
# plot_survival_curve(d_invisus_HR_survival_curve) +
#   ggtitle('D. invisus survival curve')
# 
# b_intestinihominis_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/survival_curve.csv')
# plot_survival_curve(b_intestinihominis_HR_survival_curve) +
#   ggtitle('B. intestinihominis survival curve')
# 
# # e_rectale_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Eubacterium_rectale_56927/survival_curve.csv')
# # plot_survival_curve(e_rectale_HR_survival_curve) +
# #   ggtitle('A. onderdonkii survival curve')
# 
# e_siraeum_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/survival_curve.csv')
# plot_survival_curve(e_siraeum_HR_survival_curve) +
#   ggtitle('E. siraeum survival curve')
# 
# oscillibacter_sp_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Oscillibacter_sp_60799/survival_curve.csv')
# plot_survival_curve(oscillibacter_sp_HR_survival_curve) +
#   ggtitle('Oscillibacter sp. survival curve')
# 
# p_distasonis_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/survival_curve.csv')
# plot_survival_curve(p_distasonis_HR_survival_curve) +
#   ggtitle('P. distasonis survival curve')
# 
# p_merdae_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/survival_curve.csv')
# plot_survival_curve(p_merdae_HR_survival_curve) +
#   ggtitle('P. merdae survival curve')
# 
# r_bicirculans_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/survival_curve.csv')
# plot_survival_curve(r_bicirculans_HR_survival_curve) +
#   ggtitle('R. bicirculans survival curve')
# 
# r_bromii_HR_survival_curve = read.csv('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/survival_curve.csv')
# plot_survival_curve(r_bromii_HR_survival_curve) +
#   ggtitle('R. bromii survival curve')

## Demography comparison
shared_species_list = c(
  'Akkermansia muciniphila',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Bacteroides caccae',
  'Bacteroides cellulosilyticus',
  'Bacteroides fragilis',
  'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Dialister invisus',
  'Eubacterium rectale',
  'Oscillibacter sp.',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Ruminococcus bicirculans',
  'Ruminococcus bromii'
)

original_demography_file_list = c(
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_two_epoch_demography.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_two_epoch_demography.txt'
)

original_sfs_list = c(
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_syn_downsampled_sfs.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_syn_downsampled_sfs.txt'
)

original_likelihood_surface_list = c(
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_likelihood_surface.csv',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_likelihood_surface.csv'
)

hr_demography_file_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_two_epoch_demography.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_two_epoch_demography.txt'
)

hr_sfs_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_empirical_syn_sfs.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_empirical_syn_sfs.txt'
)

hr_downsampled_sfs_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_empirical_syn_14_downsampled_sfs.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_empirical_syn_14_downsampled_sfs.txt'
)

hr_likelihood_surface_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv'
)

hr_dfe_file_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt'
)

fd_shared_demography_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt'
)

fd_shared_sfs_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_syn_downsampled_sfs.txt'
)

fd_shared_likelihood_surface_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv',
  '../SupplementaryAnalysis/Dialister_invisus_61905/likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv'
)

fd_shared_dfe_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt'
)

fd_core_demography_file_list = c(
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

fd_core_sfs_list = c(
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


fd_core_likelihood_surface_list = c(
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

fd_core_dfe_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt'
)

fd_accessory_demography_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt'
)

fd_accessory_sfs_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_empirical_syn_downsampled_sfs.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_empirical_syn_downsampled_sfs.txt'
)

fd_accessory_likelihood_surface_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Alistipes_sp_60764/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Prevotella_copri_61740/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_likelihood_surface.csv',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_likelihood_surface.csv'
)

fd_accessory_dfe_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt'
)


original_demography_df = data.frame(species=shared_species_list,
  nu_mle = numeric(18),
  time_mle = numeric(18)
)

for (i in 1:length(shared_species_list)) {
  # nu_mle
  original_demography_df[i, 2] = return_nu_mle(original_likelihood_surface_list[i])
  # tau_mle
  original_demography_df[i, 3] = return_time_mle(original_likelihood_surface_list[i],
    original_sfs_list[i],
    original_demography_file_list[i])
}

original_demography_df

hr_demography_df = data.frame(species=shared_species_list,
  sample_size = numeric(18))

for (i in 1:length(shared_species_list)) {
  hr_demography_df[i, 2] = get_species_prevalence(hr_sfs_list[i])
}

hr_demography_df

ggplot(hr_demography_df, aes(x = reorder(species, sample_size), y = sample_size)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Sample Size by Species (HR Data)",
       x = "Species",
       y = "Sample Size") +
  theme_minimal()

hr_demography_df = data.frame(species=shared_species_list,
  nu_mle = numeric(18),
  time_mle = numeric(18)
)

for (i in 1:length(shared_species_list)) {
  # nu_mle
  hr_demography_df[i, 2] = return_nu_mle(hr_likelihood_surface_list[i])
  # tau_mle
  hr_demography_df[i, 3] = return_time_mle(hr_likelihood_surface_list[i],
    hr_downsampled_sfs_list[i],
    hr_demography_file_list[i])
}

hr_demography_df

x_label_text = expression(nu == frac(N[current], N[ancestral]))

original_demography_scatter = ggscatter(original_demography_df, x="nu_mle", y="time_mle", color='species', size=3) +
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

original_demography_scatter

plot_build <- ggplot_build(original_demography_scatter)
color_mapping <- plot_build$data[[1]]$colour
print(color_mapping)

difference_plot =
  original_demography_scatter +
  geom_segment(aes(x=original_demography_df$nu_mle, y=original_demography_df$time_mle,
    xend=hr_demography_df$nu_mle, yend=hr_demography_df$time_mle),
    linejoin='round',
    lineend='round',
    linetype=1,
    color=color_mapping,
    arrow = arrow(length=unit(0.2, 'cm'))) +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  ggtitle('Change in demography before and after removing low-recombination sites')

difference_plot

## Supplemental SFSs

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

ggplot(supplementary_demography_df, aes(x = reorder(species, new_sample_size), y = new_sample_size)) +
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

ggplot(melt(supplementary_demography_df), aes(x=species, y=value, fill=variable)) +
  geom_bar(stat='identity', position = "identity") +
  coord_flip() +
  labs(title = "Sample Size by Species (Augmented Data)",
       x = "Species",
       y = "Sample Size",
  fill = "Data") +
  scale_fill_manual(labels = c("Augmented data", "Original submission"), values = c("blue", "red")) +
  theme_minimal() +
  theme(axis.text.y = element_text(face = 'italic'))



options(ggrepel.max.overlaps = Inf)

## Read in full data SFS (folded, core)

a_muciniphila_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_empirical_syn_downsampled_sfs.txt')
a_finegoldii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_empirical_syn_downsampled_sfs.txt')
a_onderdonkii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_empirical_syn_downsampled_sfs.txt')
a_putredinis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_empirical_syn_downsampled_sfs.txt')
a_shahii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_shahii_62199/core_empirical_syn_downsampled_sfs.txt')
alistipes_sp_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_sp_60764/core_empirical_syn_downsampled_sfs.txt')
b_bacterium_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_empirical_syn_downsampled_sfs.txt')
b_caccae_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_empirical_syn_downsampled_sfs.txt')
b_cellulosilyticus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_empirical_syn_downsampled_sfs.txt')
b_coprocola_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_empirical_syn_downsampled_sfs.txt')
b_eggerthii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_empirical_syn_downsampled_sfs.txt')
b_fragilis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_empirical_syn_downsampled_sfs.txt')
b_massiliensis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_empirical_syn_downsampled_sfs.txt')
b_ovatus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_empirical_syn_downsampled_sfs.txt')
b_plebeius_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_empirical_syn_downsampled_sfs.txt')
b_stercoris_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_empirical_syn_downsampled_sfs.txt')
b_thetaiotaomicron_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_empirical_syn_downsampled_sfs.txt')
b_uniformis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_empirical_syn_downsampled_sfs.txt')
b_vulgatus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_empirical_syn_downsampled_sfs.txt')
b_xylanisolvens_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_empirical_syn_downsampled_sfs.txt')
b_intestinihominis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_empirical_syn_downsampled_sfs.txt')
coprococcus_sp_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Coprococcus_sp_62244/core_empirical_syn_downsampled_sfs.txt')
d_invisus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Dialister_invisus_61905/core_empirical_syn_downsampled_sfs.txt')
e_eligens_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_empirical_syn_downsampled_sfs.txt')
e_rectale_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_empirical_syn_downsampled_sfs.txt')
e_siraeum_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_57453_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_61481_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_62201_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_empirical_syn_downsampled_sfs.txt')
l_bacterium_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_empirical_syn_downsampled_sfs.txt')
o_splanchnicus_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_empirical_syn_downsampled_sfs.txt')
oscillibacter_sp_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_empirical_syn_downsampled_sfs.txt')
p_distasonis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_empirical_syn_downsampled_sfs.txt')
p_merdae_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_empirical_syn_downsampled_sfs.txt')
phascolarctobacterium_sp_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_empirical_syn_downsampled_sfs.txt')
p_copri_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Prevotella_copri_61740/core_empirical_syn_downsampled_sfs.txt')
r_intestinalis_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_empirical_syn_downsampled_sfs.txt')
r_inulinivorans_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_empirical_syn_downsampled_sfs.txt')
r_bicirculans_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_empirical_syn_downsampled_sfs.txt')
r_bromii_FD_core_folded = read_input_sfs('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_empirical_syn_downsampled_sfs.txt')

## Read in demographic model fit for high recombination

### One-epoch (core)
a_muciniphila_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/one_epoch_demography.txt')
a_finegoldii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/one_epoch_demography.txt')
a_onderdonkii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/one_epoch_demography.txt')
a_putredinis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/one_epoch_demography.txt')
a_shahii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/one_epoch_demography.txt')
alistipes_sp_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/one_epoch_demography.txt')
b_bacterium_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/one_epoch_demography.txt')
b_caccae_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/one_epoch_demography.txt')
b_cellulosilyticus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/one_epoch_demography.txt')
b_coprocola_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/one_epoch_demography.txt')
b_eggerthii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/one_epoch_demography.txt')
b_fragilis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/one_epoch_demography.txt')
b_massiliensis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/one_epoch_demography.txt')
b_ovatus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/one_epoch_demography.txt')
b_plebeius_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/one_epoch_demography.txt')
b_stercoris_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/one_epoch_demography.txt')
b_thetaiotaomicron_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/one_epoch_demography.txt')
b_uniformis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/one_epoch_demography.txt')
b_vulgatus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/one_epoch_demography.txt')
b_xylanisolvens_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/one_epoch_demography.txt')
b_intestinihominis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/one_epoch_demography.txt')
coprococcus_sp_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/one_epoch_demography.txt')
d_invisus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/one_epoch_demography.txt')
e_eligens_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/one_epoch_demography.txt')
e_rectale_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/one_epoch_demography.txt')
e_siraeum_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/one_epoch_demography.txt')
f_prausnitzii_57453_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/one_epoch_demography.txt')
f_prausnitzii_61481_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/one_epoch_demography.txt')
f_prausnitzii_62201_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/one_epoch_demography.txt')
l_bacterium_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/one_epoch_demography.txt')
o_splanchnicus_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/one_epoch_demography.txt')
oscillibacter_sp_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/one_epoch_demography.txt')
p_distasonis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/one_epoch_demography.txt')
p_merdae_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/one_epoch_demography.txt')
phascolarctobacterium_sp_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/one_epoch_demography.txt')
p_copri_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/one_epoch_demography.txt')
r_intestinalis_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/one_epoch_demography.txt')
r_inulinivorans_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/one_epoch_demography.txt')
r_bicirculans_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/one_epoch_demography.txt')
r_bromii_FD_core_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/one_epoch_demography.txt')

### Two-epoch (core)
a_muciniphila_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt')
a_finegoldii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt')
a_onderdonkii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt')
a_putredinis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt')
a_shahii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt')
alistipes_sp_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt')
b_bacterium_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt')
b_caccae_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt')
b_cellulosilyticus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt')
b_coprocola_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt')
b_eggerthii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt')
b_fragilis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt')
b_massiliensis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt')
b_ovatus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/two_epoch_demography.txt')
b_plebeius_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt')
b_stercoris_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt')
b_thetaiotaomicron_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt')
b_uniformis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt')
b_vulgatus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt')
b_xylanisolvens_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt')
b_intestinihominis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt')
coprococcus_sp_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt')
d_invisus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt')
e_eligens_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt')
e_rectale_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt')
e_siraeum_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt')
f_prausnitzii_57453_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt')
f_prausnitzii_61481_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt')
f_prausnitzii_62201_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt')
l_bacterium_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt')
o_splanchnicus_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt')
oscillibacter_sp_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt')
p_distasonis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt')
p_merdae_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt')
phascolarctobacterium_sp_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt')
p_copri_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt')
r_intestinalis_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt')
r_inulinivorans_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt')
r_bicirculans_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt')
r_bromii_FD_core_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt')

### Three-epoch (core)
a_muciniphila_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/three_epoch_demography.txt')
a_finegoldii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/three_epoch_demography.txt')
a_onderdonkii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/three_epoch_demography.txt')
a_putredinis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/three_epoch_demography.txt')
a_shahii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/three_epoch_demography.txt')
alistipes_sp_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/three_epoch_demography.txt')
b_bacterium_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/three_epoch_demography.txt')
b_caccae_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/three_epoch_demography.txt')
b_cellulosilyticus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/three_epoch_demography.txt')
b_coprocola_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/three_epoch_demography.txt')
b_eggerthii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/three_epoch_demography.txt')
b_fragilis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/three_epoch_demography.txt')
b_massiliensis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/three_epoch_demography.txt')
b_ovatus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/three_epoch_demography.txt')
b_plebeius_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/three_epoch_demography.txt')
b_stercoris_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/three_epoch_demography.txt')
b_thetaiotaomicron_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/three_epoch_demography.txt')
b_uniformis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/three_epoch_demography.txt')
b_vulgatus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/three_epoch_demography.txt')
b_xylanisolvens_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/three_epoch_demography.txt')
b_intestinihominis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/three_epoch_demography.txt')
coprococcus_sp_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/three_epoch_demography.txt')
d_invisus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/three_epoch_demography.txt')
e_eligens_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/three_epoch_demography.txt')
e_rectale_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/three_epoch_demography.txt')
e_siraeum_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/three_epoch_demography.txt')
f_prausnitzii_57453_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/three_epoch_demography.txt')
f_prausnitzii_61481_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/three_epoch_demography.txt')
f_prausnitzii_62201_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/three_epoch_demography.txt')
l_bacterium_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/three_epoch_demography.txt')
o_splanchnicus_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/three_epoch_demography.txt')
oscillibacter_sp_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/three_epoch_demography.txt')
p_distasonis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/three_epoch_demography.txt')
p_merdae_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/three_epoch_demography.txt')
phascolarctobacterium_sp_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/three_epoch_demography.txt')
p_copri_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/three_epoch_demography.txt')
r_intestinalis_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/three_epoch_demography.txt')
r_inulinivorans_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/three_epoch_demography.txt')
r_bicirculans_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/three_epoch_demography.txt')
r_bromii_FD_core_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/three_epoch_demography.txt')

# Nonsyn empirical (core)

a_muciniphila_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt')
a_finegoldii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt')
a_onderdonkii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt')
a_putredinis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt')
a_shahii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt')
alistipes_sp_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt')
b_bacterium_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt')
b_caccae_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt')
b_cellulosilyticus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt')
b_coprocola_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt')
b_eggerthii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt')
b_fragilis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt')
b_massiliensis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt')
b_ovatus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_DFE.txt')
b_plebeius_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt')
b_stercoris_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt')
b_thetaiotaomicron_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt')
b_uniformis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt')
b_vulgatus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt')
b_xylanisolvens_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt')
b_intestinihominis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt')
coprococcus_sp_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt')
d_invisus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt')
e_eligens_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt')
e_rectale_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt')
e_siraeum_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt')
f_prausnitzii_57453_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt')
f_prausnitzii_61481_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt')
f_prausnitzii_62201_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt')
l_bacterium_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt')
o_splanchnicus_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt')
oscillibacter_sp_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt')
p_distasonis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt')
p_merdae_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt')
phascolarctobacterium_sp_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt')
p_copri_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt')
r_intestinalis_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt')
r_inulinivorans_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt')
r_bicirculans_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt')
r_bromii_FD_core_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt')

# Gamma (core)

a_muciniphila_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt')
a_finegoldii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt')
a_onderdonkii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt')
a_putredinis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt')
a_shahii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt')
alistipes_sp_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt')
b_bacterium_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt')
b_caccae_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt')
b_cellulosilyticus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt')
b_coprocola_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt')
b_eggerthii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt')
b_fragilis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt')
b_massiliensis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt')
b_ovatus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_DFE.txt')
b_plebeius_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt')
b_stercoris_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt')
b_thetaiotaomicron_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt')
b_uniformis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt')
b_vulgatus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt')
b_xylanisolvens_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt')
b_intestinihominis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt')
coprococcus_sp_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt')
d_invisus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt')
e_eligens_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt')
e_rectale_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt')
e_siraeum_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt')
f_prausnitzii_57453_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt')
f_prausnitzii_61481_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt')
f_prausnitzii_62201_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt')
l_bacterium_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt')
o_splanchnicus_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt')
oscillibacter_sp_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt')
p_distasonis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt')
p_merdae_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt')
phascolarctobacterium_sp_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt')
p_copri_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt')
r_intestinalis_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt')
r_inulinivorans_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt')
r_bicirculans_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt')
r_bromii_FD_gamma_core = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt')

# Neugamma

a_muciniphila_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt')
a_finegoldii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt')
a_onderdonkii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt')
a_putredinis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt')
a_shahii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt')
alistipes_sp_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt')
b_bacterium_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt')
b_caccae_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt')
b_cellulosilyticus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt')
b_coprocola_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt')
b_eggerthii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt')
b_fragilis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt')
b_massiliensis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt')
b_ovatus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_DFE.txt')
b_plebeius_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt')
b_stercoris_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt')
b_thetaiotaomicron_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt')
b_uniformis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt')
b_vulgatus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt')
b_xylanisolvens_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt')
b_intestinihominis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt')
coprococcus_sp_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt')
d_invisus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt')
e_eligens_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt')
e_rectale_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt')
e_siraeum_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt')
f_prausnitzii_57453_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt')
f_prausnitzii_61481_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt')
f_prausnitzii_62201_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt')
l_bacterium_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt')
o_splanchnicus_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt')
oscillibacter_sp_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt')
p_distasonis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt')
p_merdae_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt')
phascolarctobacterium_sp_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt')
p_copri_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt')
r_intestinalis_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt')
r_inulinivorans_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt')
r_bicirculans_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt')
r_bromii_FD_neugamma_core = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt')


# SFS comparison
a_muciniphila_FD_core_demography = compare_sfs(proportional_sfs(a_muciniphila_FD_core_folded), 
  proportional_sfs(a_muciniphila_FD_core_one_epoch), 
  proportional_sfs(a_muciniphila_FD_core_two_epoch), 
  proportional_sfs(a_muciniphila_FD_core_three_epoch)) +
  ggtitle('Akkermansia muciniphila (FD, core) model fit')

a_finegoldii_FD_core_demography = compare_sfs(proportional_sfs(a_finegoldii_FD_core_folded), 
  proportional_sfs(a_finegoldii_FD_core_one_epoch), 
  proportional_sfs(a_finegoldii_FD_core_two_epoch), 
  proportional_sfs(a_finegoldii_FD_core_three_epoch)) +
  ggtitle('Alistipes finegoldii (FD, core) model fit')

a_onderdonkii_FD_core_demography = compare_sfs(proportional_sfs(a_onderdonkii_FD_core_folded), 
  proportional_sfs(a_onderdonkii_FD_core_one_epoch), 
  proportional_sfs(a_onderdonkii_FD_core_two_epoch), 
  proportional_sfs(a_onderdonkii_FD_core_three_epoch)) +
  ggtitle('Alistipes onderdonkii (FD, core) model fit')

a_putredinis_FD_core_demography = compare_sfs(proportional_sfs(a_putredinis_FD_core_folded), 
  proportional_sfs(a_putredinis_FD_core_one_epoch), 
  proportional_sfs(a_putredinis_FD_core_two_epoch), 
  proportional_sfs(a_putredinis_FD_core_three_epoch)) +
  ggtitle('Alistipes putredinis (FD, core) model fit')

a_shahii_FD_core_demography = compare_sfs(proportional_sfs(a_shahii_FD_core_folded), 
  proportional_sfs(a_shahii_FD_core_one_epoch), 
  proportional_sfs(a_shahii_FD_core_two_epoch), 
  proportional_sfs(a_shahii_FD_core_three_epoch)) +
  ggtitle('Alistipes shahii (FD, core) model fit')

alistipes_sp_FD_core_demography = compare_sfs(proportional_sfs(alistipes_sp_FD_core_folded), 
  proportional_sfs(alistipes_sp_FD_core_one_epoch), 
  proportional_sfs(alistipes_sp_FD_core_two_epoch), 
  proportional_sfs(alistipes_sp_FD_core_three_epoch)) +
  ggtitle('Alistipes sp. (FD, core) model fit')

b_bacterium_FD_core_demography = compare_sfs(proportional_sfs(b_bacterium_FD_core_folded), 
  proportional_sfs(b_bacterium_FD_core_one_epoch), 
  proportional_sfs(b_bacterium_FD_core_two_epoch), 
  proportional_sfs(b_bacterium_FD_core_three_epoch)) +
  ggtitle('Bacteroidales bacterium (FD, core) model fit')

b_caccae_FD_core_demography = compare_sfs(proportional_sfs(b_caccae_FD_core_folded), 
  proportional_sfs(b_caccae_FD_core_one_epoch), 
  proportional_sfs(b_caccae_FD_core_two_epoch), 
  proportional_sfs(b_caccae_FD_core_three_epoch)) +
  ggtitle('Bacteroides caccae (FD, core) model fit')

b_cellulosilyticus_FD_core_demography = compare_sfs(proportional_sfs(b_cellulosilyticus_FD_core_folded), 
  proportional_sfs(b_cellulosilyticus_FD_core_one_epoch), 
  proportional_sfs(b_cellulosilyticus_FD_core_two_epoch), 
  proportional_sfs(b_cellulosilyticus_FD_core_three_epoch)) +
  ggtitle('Bacteroides cellulosilyticus (FD, core) model fit')

b_coprocola_FD_core_demography = compare_sfs(proportional_sfs(b_coprocola_FD_core_folded), 
  proportional_sfs(b_coprocola_FD_core_one_epoch), 
  proportional_sfs(b_coprocola_FD_core_two_epoch), 
  proportional_sfs(b_coprocola_FD_core_three_epoch)) +
  ggtitle('Bacteroides coprocola (FD, core) model fit')

b_eggerthii_FD_core_demography = compare_sfs(proportional_sfs(b_eggerthii_FD_core_folded), 
  proportional_sfs(b_eggerthii_FD_core_one_epoch), 
  proportional_sfs(b_eggerthii_FD_core_two_epoch), 
  proportional_sfs(b_eggerthii_FD_core_three_epoch)) +
  ggtitle('Bacteroides eggerthii (FD, core) model fit')

b_fragilis_FD_core_demography = compare_sfs(proportional_sfs(b_fragilis_FD_core_folded), 
  proportional_sfs(b_fragilis_FD_core_one_epoch), 
  proportional_sfs(b_fragilis_FD_core_two_epoch), 
  proportional_sfs(b_fragilis_FD_core_three_epoch)) +
  ggtitle('Bacteroides fragilis (FD, core) model fit')

b_massiliensis_FD_core_demography = compare_sfs(proportional_sfs(b_massiliensis_FD_core_folded), 
  proportional_sfs(b_massiliensis_FD_core_one_epoch), 
  proportional_sfs(b_massiliensis_FD_core_two_epoch), 
  proportional_sfs(b_massiliensis_FD_core_three_epoch)) +
  ggtitle('Bacteroides massiliensis (FD, core) model fit')

b_ovatus_FD_core_demography = compare_sfs(proportional_sfs(b_ovatus_FD_core_folded), 
  proportional_sfs(b_ovatus_FD_core_one_epoch), 
  proportional_sfs(b_ovatus_FD_core_two_epoch), 
  proportional_sfs(b_ovatus_FD_core_three_epoch)) +
  ggtitle('Bacteroides ovatus (FD, core) model fit')

b_plebeius_FD_core_demography = compare_sfs(proportional_sfs(b_plebeius_FD_core_folded), 
  proportional_sfs(b_plebeius_FD_core_one_epoch), 
  proportional_sfs(b_plebeius_FD_core_two_epoch), 
  proportional_sfs(b_plebeius_FD_core_three_epoch)) +
  ggtitle('Bacteroides plebeius (FD, core) model fit')

b_stercoris_FD_core_demography = compare_sfs(proportional_sfs(b_stercoris_FD_core_folded), 
  proportional_sfs(b_stercoris_FD_core_one_epoch), 
  proportional_sfs(b_stercoris_FD_core_two_epoch), 
  proportional_sfs(b_stercoris_FD_core_three_epoch)) +
  ggtitle('Bacteroides stercoris (FD, core) model fit')

b_thetaiotaomicron_FD_core_demography = compare_sfs(proportional_sfs(b_thetaiotaomicron_FD_core_folded), 
  proportional_sfs(b_thetaiotaomicron_FD_core_one_epoch), 
  proportional_sfs(b_thetaiotaomicron_FD_core_two_epoch), 
  proportional_sfs(b_thetaiotaomicron_FD_core_three_epoch)) +
  ggtitle('Bacteroides thetaiotaomicron (FD, core) model fit')

b_uniformis_FD_core_demography = compare_sfs(proportional_sfs(b_uniformis_FD_core_folded), 
  proportional_sfs(b_uniformis_FD_core_one_epoch), 
  proportional_sfs(b_uniformis_FD_core_two_epoch), 
  proportional_sfs(b_uniformis_FD_core_three_epoch)) +
  ggtitle('Bacteroides uniformis (FD, core) model fit')

b_vulgatus_FD_core_demography = compare_sfs(proportional_sfs(b_vulgatus_FD_core_folded), 
  proportional_sfs(b_vulgatus_FD_core_one_epoch), 
  proportional_sfs(b_vulgatus_FD_core_two_epoch), 
  proportional_sfs(b_vulgatus_FD_core_three_epoch)) +
  ggtitle('Bacteroides vulgatus (FD, core) model fit')

b_xylanisolvens_FD_core_demography = compare_sfs(proportional_sfs(b_xylanisolvens_FD_core_folded), 
  proportional_sfs(b_xylanisolvens_FD_core_one_epoch), 
  proportional_sfs(b_xylanisolvens_FD_core_two_epoch), 
  proportional_sfs(b_xylanisolvens_FD_core_three_epoch)) +
  ggtitle('Bacteroides xylanisolvens (FD, core) model fit')

b_intestinihominis_FD_core_demography = compare_sfs(proportional_sfs(b_intestinihominis_FD_core_folded), 
  proportional_sfs(b_intestinihominis_FD_core_one_epoch), 
  proportional_sfs(b_intestinihominis_FD_core_two_epoch), 
  proportional_sfs(b_intestinihominis_FD_core_three_epoch)) +
  ggtitle('Barnesiella intestinihominis (FD, core) model fit')

coprococcus_sp_FD_core_demography = compare_sfs(proportional_sfs(coprococcus_sp_FD_core_folded), 
  proportional_sfs(coprococcus_sp_FD_core_one_epoch), 
  proportional_sfs(coprococcus_sp_FD_core_two_epoch), 
  proportional_sfs(coprococcus_sp_FD_core_three_epoch)) +
  ggtitle('Coprococcus sp. (FD, core) model fit')

d_invisus_FD_core_demography = compare_sfs(proportional_sfs(d_invisus_FD_core_folded), 
  proportional_sfs(d_invisus_FD_core_one_epoch), 
  proportional_sfs(d_invisus_FD_core_two_epoch), 
  proportional_sfs(d_invisus_FD_core_three_epoch)) +
  ggtitle('Dialister invisus (FD, core) model fit')

e_eligens_FD_core_demography = compare_sfs(proportional_sfs(e_eligens_FD_core_folded), 
  proportional_sfs(e_eligens_FD_core_one_epoch), 
  proportional_sfs(e_eligens_FD_core_two_epoch), 
  proportional_sfs(e_eligens_FD_core_three_epoch)) +
  ggtitle('Eubacterium eligens (FD, core) model fit')

e_rectale_FD_core_demography = compare_sfs(proportional_sfs(e_rectale_FD_core_folded), 
  proportional_sfs(e_rectale_FD_core_one_epoch), 
  proportional_sfs(e_rectale_FD_core_two_epoch), 
  proportional_sfs(e_rectale_FD_core_three_epoch)) +
  ggtitle('Eubacterium rectale (FD, core) model fit')

e_siraeum_FD_core_demography = compare_sfs(proportional_sfs(e_siraeum_FD_core_folded), 
  proportional_sfs(e_siraeum_FD_core_one_epoch), 
  proportional_sfs(e_siraeum_FD_core_two_epoch), 
  proportional_sfs(e_siraeum_FD_core_three_epoch)) +
  ggtitle('Eubacterium siraeum (FD, core) model fit')

f_prausnitzii_57453_FD_core_demography = compare_sfs(proportional_sfs(f_prausnitzii_57453_FD_core_folded), 
  proportional_sfs(f_prausnitzii_57453_FD_core_one_epoch), 
  proportional_sfs(f_prausnitzii_57453_FD_core_two_epoch), 
  proportional_sfs(f_prausnitzii_57453_FD_core_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 57453 (FD, core) model fit')

f_prausnitzii_61481_FD_core_demography = compare_sfs(proportional_sfs(f_prausnitzii_61481_FD_core_folded), 
  proportional_sfs(f_prausnitzii_61481_FD_core_one_epoch), 
  proportional_sfs(f_prausnitzii_61481_FD_core_two_epoch), 
  proportional_sfs(f_prausnitzii_61481_FD_core_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 61481 (FD, core) model fit')

f_prausnitzii_62201_FD_core_demography = compare_sfs(proportional_sfs(f_prausnitzii_62201_FD_core_folded), 
  proportional_sfs(f_prausnitzii_62201_FD_core_one_epoch), 
  proportional_sfs(f_prausnitzii_62201_FD_core_two_epoch), 
  proportional_sfs(f_prausnitzii_62201_FD_core_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 62201 (FD, core) model fit')

l_bacterium_FD_core_demography = compare_sfs(proportional_sfs(l_bacterium_FD_core_folded), 
  proportional_sfs(l_bacterium_FD_core_one_epoch), 
  proportional_sfs(l_bacterium_FD_core_two_epoch), 
  proportional_sfs(l_bacterium_FD_core_three_epoch)) +
  ggtitle('Lachnospiraceae bacterium (FD, core) model fit')

o_splanchnicus_FD_core_demography = compare_sfs(proportional_sfs(o_splanchnicus_FD_core_folded), 
  proportional_sfs(o_splanchnicus_FD_core_one_epoch), 
  proportional_sfs(o_splanchnicus_FD_core_two_epoch), 
  proportional_sfs(o_splanchnicus_FD_core_three_epoch)) +
  ggtitle('Odoribacter splanchnicus (FD, core) model fit')

oscillibacter_sp_FD_core_demography = compare_sfs(proportional_sfs(oscillibacter_sp_FD_core_folded), 
  proportional_sfs(oscillibacter_sp_FD_core_one_epoch), 
  proportional_sfs(oscillibacter_sp_FD_core_two_epoch), 
  proportional_sfs(oscillibacter_sp_FD_core_three_epoch)) +
  ggtitle('Oscillibacter sp. (FD, core) model fit')

p_distasonis_FD_core_demography = compare_sfs(proportional_sfs(p_distasonis_FD_core_folded), 
  proportional_sfs(p_distasonis_FD_core_one_epoch), 
  proportional_sfs(p_distasonis_FD_core_two_epoch), 
  proportional_sfs(p_distasonis_FD_core_three_epoch)) +
  ggtitle('Parabacteroides distasonis (FD, core) model fit')

p_merdae_FD_core_demography = compare_sfs(proportional_sfs(p_merdae_FD_core_folded), 
  proportional_sfs(p_merdae_FD_core_one_epoch), 
  proportional_sfs(p_merdae_FD_core_two_epoch), 
  proportional_sfs(p_merdae_FD_core_three_epoch)) +
  ggtitle('Parabacteroides merdae (FD, core) model fit')

phascolarctobacterium_sp_FD_core_demography = compare_sfs(proportional_sfs(phascolarctobacterium_sp_FD_core_folded), 
  proportional_sfs(phascolarctobacterium_sp_FD_core_one_epoch), 
  proportional_sfs(phascolarctobacterium_sp_FD_core_two_epoch), 
  proportional_sfs(phascolarctobacterium_sp_FD_core_three_epoch)) +
  ggtitle('Phascolarctobacterium sp. (FD, core) model fit')

p_copri_FD_core_demography = compare_sfs(proportional_sfs(p_copri_FD_core_folded), 
  proportional_sfs(p_copri_FD_core_one_epoch), 
  proportional_sfs(p_copri_FD_core_two_epoch), 
  proportional_sfs(p_copri_FD_core_three_epoch)) +
  ggtitle('Prevotella copri (FD, core) model fit')

r_intestinalis_FD_core_demography = compare_sfs(proportional_sfs(r_intestinalis_FD_core_folded), 
  proportional_sfs(r_intestinalis_FD_core_one_epoch), 
  proportional_sfs(r_intestinalis_FD_core_two_epoch), 
  proportional_sfs(r_intestinalis_FD_core_three_epoch)) +
  ggtitle('Roseburia intestinalis (FD, core) model fit')

r_inulinivorans_FD_core_demography = compare_sfs(proportional_sfs(r_inulinivorans_FD_core_folded), 
  proportional_sfs(r_inulinivorans_FD_core_one_epoch), 
  proportional_sfs(r_inulinivorans_FD_core_two_epoch), 
  proportional_sfs(r_inulinivorans_FD_core_three_epoch)) +
  ggtitle('Roseburia inulinivorans (FD, core) model fit')

r_bicirculans_FD_core_demography = compare_sfs(proportional_sfs(r_bicirculans_FD_core_folded), 
  proportional_sfs(r_bicirculans_FD_core_one_epoch), 
  proportional_sfs(r_bicirculans_FD_core_two_epoch), 
  proportional_sfs(r_bicirculans_FD_core_three_epoch)) +
  ggtitle('Ruminococcus bicirculans (FD, core) model fit')

r_bromii_FD_core_demography = compare_sfs(proportional_sfs(r_bromii_FD_core_folded), 
  proportional_sfs(r_bromii_FD_core_one_epoch), 
  proportional_sfs(r_bromii_FD_core_two_epoch), 
  proportional_sfs(r_bromii_FD_core_three_epoch)) +
  ggtitle('Ruminococcus bromii (FD, core) model fit')

a_muciniphila_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/likelihood_surface.csv')
# a_muciniphila_FD_core_likelihood_surface + ggtitle('Akkermansia muciniphila (FD) likelihood surface')

a_finegoldii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_finegoldii_56071/likelihood_surface.csv')
# a_finegoldii_FD_core_likelihood_surface + ggtitle('Alistipes finegoldi (FD) likelihood surface')

a_onderdonkii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/likelihood_surface.csv')
# a_onderdonkii_FD_core_likelihood_surface + ggtitle('Alistipes onderdonkii (FD) likelihood surface')

a_putredinis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_putredinis_61533/likelihood_surface.csv')
# a_putredinis_FD_core_likelihood_surface + ggtitle('Alistipes putredinis (FD) likelihood surface')

a_shahii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_shahii_62199/likelihood_surface.csv')
# a_shahii_FD_core_likelihood_surface + ggtitle('Alistipes shahii (FD) likelihood surface')

alistipes_sp_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_sp_60764/likelihood_surface.csv')
# alistipes_sp_FD_core_likelihood_surface + ggtitle('Alistipes sp. (FD) likelihood surface')

b_bacterium_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/likelihood_surface.csv')
# b_bacterium_FD_core_likelihood_surface + ggtitle('Bacteroides bacterium (FD) likelihood surface')

b_caccae_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_caccae_53434/likelihood_surface.csv')
# b_caccae_FD_core_likelihood_surface + ggtitle('Bacteroides caccae (FD) likelihood surface')

b_cellulosilyticus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/likelihood_surface.csv')
# b_cellulosilyticus_FD_core_likelihood_surface + ggtitle('Bacteroides cellulosilyticus (FD) likelihood surface')

b_coprocola_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_coprocola_61586/likelihood_surface.csv')
# b_coprocola_FD_core_likelihood_surface + ggtitle('Bacteroides coprocola (FD) likelihood surface')

b_eggerthii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/likelihood_surface.csv')
# b_eggerthii_FD_core_likelihood_surface + ggtitle('Bacteroides eggerthii (FD) likelihood surface')

b_fragilis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_fragilis_54507/likelihood_surface.csv')
# b_fragilis_FD_core_likelihood_surface + ggtitle('Bacteroides fragilis (FD) likelihood surface')

b_massiliensis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/likelihood_surface.csv')
# b_massiliensis_FD_core_likelihood_surface + ggtitle('Bacteroides massiliensis (FD) likelihood surface')

b_ovatus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_ovatus_58035/likelihood_surface.csv')
# b_ovatus_FD_core_likelihood_surface + ggtitle('Bacteroides ovatus (FD) likelihood surface')

b_plebeius_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_plebeius_61623/likelihood_surface.csv')
# b_plebeius_FD_core_likelihood_surface + ggtitle('Bacteroides plebeius (FD) likelihood surface')

b_stercoris_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_stercoris_56735/likelihood_surface.csv')
# b_stercoris_FD_core_likelihood_surface + ggtitle('Bacteroides stercoris (FD) likelihood surface')

b_thetaiotaomicron_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/likelihood_surface.csv')
# b_thetaiotaomicron_FD_core_likelihood_surface + ggtitle('Bacteroides thetaiotaomicron (FD) likelihood surface')

b_uniformis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_uniformis_57318/likelihood_surface.csv')
# b_uniformis_FD_core_likelihood_surface + ggtitle('Bacteroides uniformis (FD) likelihood surface')

b_vulgatus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/likelihood_surface.csv')
# b_vulgatus_FD_core_likelihood_surface + ggtitle('Bacteroides vulgatus (FD) likelihood surface')

b_xylanisolvens_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/likelihood_surface.csv')
# b_xylanisolvens_FD_core_likelihood_surface + ggtitle('Bacteroides xylanisolvens (FD) likelihood surface')

b_intestinihominis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/likelihood_surface.csv')
# b_intestinihominis_FD_core_likelihood_surface + ggtitle('Barnesiella intestinihominis (FD) likelihood surface')

coprococcus_sp_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Coprococcus_sp_62244/likelihood_surface.csv')
# coprococcus_sp_FD_core_likelihood_surface + ggtitle('Coprococcus sp. (FD) likelihood surface')

d_invisus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Dialister_invisus_61905/likelihood_surface.csv')
# d_invisus_FD_core_likelihood_surface + ggtitle('Dialister invisus (FD) likelihood surface')

e_eligens_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_eligens_61678/likelihood_surface.csv')
# e_eligens_FD_core_likelihood_surface + ggtitle('Eubacterium eligens (FD) likelihood surface')

e_rectale_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_rectale_56927/likelihood_surface.csv')
# e_rectale_FD_core_likelihood_surface + ggtitle('Eubacterium rectale (FD) likelihood surface')

e_siraeum_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_siraeum_57634/likelihood_surface.csv')
# e_siraeum_FD_core_likelihood_surface + ggtitle('Eubacterium siraeum (FD) likelihood surface')

f_prausnitzii_57453_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/likelihood_surface.csv')
# f_prausnitzii_57453_FD_core_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 57453 (FD) likelihood surface')

f_prausnitzii_61481_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/likelihood_surface.csv')
# f_prausnitzii_61481_FD_core_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 61481 (FD) likelihood surface')

f_prausnitzii_62201_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/likelihood_surface.csv')
# f_prausnitzii_62201_FD_core_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 62201 (FD) likelihood surface')

l_bacterium_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/likelihood_surface.csv')
# l_bacterium_FD_core_likelihood_surface + ggtitle('Lachnospiraceae bacterium (FD) likelihood surface')

o_splanchnicus_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/likelihood_surface.csv')
# o_splanchnicus_FD_core_likelihood_surface + ggtitle('Odoribacter splanchnicus (FD) likelihood surface')

oscillibacter_sp_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Oscillibacter_sp_60799/likelihood_surface.csv')
# oscillibacter_sp_FD_core_likelihood_surface + ggtitle('Oscillibacter sp. (FD) likelihood surface')

p_distasonis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/likelihood_surface.csv')
# p_distasonis_FD_core_likelihood_surface + ggtitle('Parabacteroides distasonis (FD) likelihood surface')

p_merdae_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Parabacteroides_merdae_56972/likelihood_surface.csv')
# p_merdae_FD_core_likelihood_surface + ggtitle('Parabacteroides merdae (FD) likelihood surface')

phascolarctobacterium_sp_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/likelihood_surface.csv')
# phascolarctobacterium_sp_FD_core_likelihood_surface + ggtitle('Phascolarctobacterium sp. (FD) likelihood surface')

p_copri_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Prevotella_copri_61740/likelihood_surface.csv')
# p_copri_FD_core_likelihood_surface + ggtitle('Prevotella copri (FD) likelihood surface')

r_intestinalis_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Roseburia_intestinalis_56239/likelihood_surface.csv')
# r_intestinalis_FD_core_likelihood_surface + ggtitle('Roseburia intestinalis (FD) likelihood surface')

r_inulinivorans_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/likelihood_surface.csv')
# r_inulinivorans_FD_core_likelihood_surface + ggtitle('Roseburia inulinovrans (FD) likelihood surface')

r_bicirculans_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/likelihood_surface.csv')
# r_bicirculans_FD_core_likelihood_surface + ggtitle('Ruminococcus bicirculans (FD) likelihood surface')

r_bromii_FD_core_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Ruminococcus_bromii_62047/likelihood_surface.csv')
# r_bromii_FD_core_likelihood_surface + ggtitle('Ruminococcus bromii (FD) likelihood surface')

FD_core_demography = alistipes_sp_FD_core_demography + alistipes_sp_FD_core_likelihood_surface +
  a_putredinis_FD_core_demography + a_putredinis_FD_core_likelihood_surface +
  a_finegoldii_FD_core_demography + a_finegoldii_FD_core_likelihood_surface +
  a_onderdonkii_FD_core_demography + a_onderdonkii_FD_core_likelihood_surface +
  a_shahii_FD_core_demography + a_shahii_FD_core_likelihood_surface +
  b_bacterium_FD_core_demography + b_bacterium_FD_core_likelihood_surface +
  o_splanchnicus_FD_core_demography + o_splanchnicus_FD_core_likelihood_surface +
  p_distasonis_FD_core_demography + p_distasonis_FD_core_likelihood_surface +
  p_merdae_FD_core_demography + p_merdae_FD_core_likelihood_surface +
  p_copri_FD_core_demography + p_copri_FD_core_likelihood_surface +
  b_fragilis_FD_core_demography + b_fragilis_FD_core_likelihood_surface +
  b_cellulosilyticus_FD_core_demography + b_cellulosilyticus_FD_core_likelihood_surface +
  b_eggerthii_FD_core_demography + b_eggerthii_FD_core_likelihood_surface +
  b_stercoris_FD_core_demography + b_stercoris_FD_core_likelihood_surface +
  b_uniformis_FD_core_demography + b_uniformis_FD_core_likelihood_surface +
  b_thetaiotaomicron_FD_core_demography + b_thetaiotaomicron_FD_core_likelihood_surface +
  b_xylanisolvens_FD_core_demography + b_xylanisolvens_FD_core_likelihood_surface +
  b_caccae_FD_core_demography + b_caccae_FD_core_likelihood_surface +
  b_massiliensis_FD_core_demography + b_massiliensis_FD_core_likelihood_surface +
  b_vulgatus_FD_core_demography + b_vulgatus_FD_core_likelihood_surface +
  b_plebeius_FD_core_demography + b_plebeius_FD_core_likelihood_surface +
  b_coprocola_FD_core_demography + b_coprocola_FD_core_likelihood_surface +
  b_intestinihominis_FD_core_demography + b_intestinihominis_FD_core_likelihood_surface +
  a_muciniphila_FD_core_demography + a_muciniphila_FD_core_likelihood_surface +
  d_invisus_FD_core_demography + d_invisus_FD_core_likelihood_surface +
  phascolarctobacterium_sp_FD_core_demography + phascolarctobacterium_sp_FD_core_likelihood_surface +
  e_eligens_FD_core_demography + e_eligens_FD_core_likelihood_surface +
  e_rectale_FD_core_demography + e_rectale_FD_core_likelihood_surface +
  r_intestinalis_FD_core_demography + r_intestinalis_FD_core_likelihood_surface +
  r_inulinivorans_FD_core_demography + r_inulinivorans_FD_core_likelihood_surface +
  l_bacterium_FD_core_demography + l_bacterium_FD_core_likelihood_surface +
  coprococcus_sp_FD_core_demography + coprococcus_sp_FD_core_likelihood_surface +
  oscillibacter_sp_FD_core_demography + oscillibacter_sp_FD_core_likelihood_surface +
  r_bromii_FD_core_demography + r_bromii_FD_core_likelihood_surface +
  r_bicirculans_FD_core_demography + r_bicirculans_FD_core_likelihood_surface +
  e_siraeum_FD_core_demography + e_siraeum_FD_core_likelihood_surface +
  f_prausnitzii_57453_FD_core_demography + f_prausnitzii_57453_FD_core_likelihood_surface +
  f_prausnitzii_62201_FD_core_demography + f_prausnitzii_62201_FD_core_likelihood_surface +
  f_prausnitzii_61481_FD_core_demography + f_prausnitzii_61481_FD_core_likelihood_surface +
  plot_layout(ncol=2)
  
  
# ggsave(filename='./FD_core_demography_fit.png', plot=FD_core_demography, width=20, height=225, units="in", limitsize=FALSE)
## Accessory genes

## Read in full data SFS (folded, accessory)

a_muciniphila_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_empirical_syn_downsampled_sfs.txt')
a_finegoldii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_empirical_syn_downsampled_sfs.txt')
a_onderdonkii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_empirical_syn_downsampled_sfs.txt')
a_putredinis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_empirical_syn_downsampled_sfs.txt')
a_shahii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_empirical_syn_downsampled_sfs.txt')
alistipes_sp_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_empirical_syn_downsampled_sfs.txt')
b_bacterium_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_empirical_syn_downsampled_sfs.txt')
b_caccae_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_empirical_syn_downsampled_sfs.txt')
b_cellulosilyticus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_empirical_syn_downsampled_sfs.txt')
b_coprocola_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_empirical_syn_downsampled_sfs.txt')
b_eggerthii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_empirical_syn_downsampled_sfs.txt')
b_fragilis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_empirical_syn_downsampled_sfs.txt')
b_massiliensis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_empirical_syn_downsampled_sfs.txt')
b_ovatus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_empirical_syn_downsampled_sfs.txt')
b_plebeius_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_empirical_syn_downsampled_sfs.txt')
b_stercoris_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_empirical_syn_downsampled_sfs.txt')
b_thetaiotaomicron_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_empirical_syn_downsampled_sfs.txt')
b_uniformis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_empirical_syn_downsampled_sfs.txt')
b_vulgatus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_empirical_syn_downsampled_sfs.txt')
b_xylanisolvens_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_empirical_syn_downsampled_sfs.txt')
b_intestinihominis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_empirical_syn_downsampled_sfs.txt')
coprococcus_sp_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_empirical_syn_downsampled_sfs.txt')
d_invisus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_empirical_syn_downsampled_sfs.txt')
e_eligens_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_empirical_syn_downsampled_sfs.txt')
e_rectale_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_empirical_syn_downsampled_sfs.txt')
e_siraeum_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_57453_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_61481_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_62201_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_empirical_syn_downsampled_sfs.txt')
l_bacterium_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_empirical_syn_downsampled_sfs.txt')
o_splanchnicus_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_empirical_syn_downsampled_sfs.txt')
oscillibacter_sp_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_empirical_syn_downsampled_sfs.txt')
p_distasonis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_empirical_syn_downsampled_sfs.txt')
p_merdae_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_empirical_syn_downsampled_sfs.txt')
phascolarctobacterium_sp_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_empirical_syn_downsampled_sfs.txt')
p_copri_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_empirical_syn_downsampled_sfs.txt')
r_intestinalis_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_empirical_syn_downsampled_sfs.txt')
r_inulinivorans_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_empirical_syn_downsampled_sfs.txt')
r_bicirculans_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_empirical_syn_downsampled_sfs.txt')
r_bromii_FD_accessory_folded = read_input_sfs('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_empirical_syn_downsampled_sfs.txt')

## Read in demographic model fit for high recombination

### One-epoch (accessory)
a_muciniphila_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_one_epoch_demography.txt')
a_finegoldii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_one_epoch_demography.txt')
a_onderdonkii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_one_epoch_demography.txt')
a_putredinis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_one_epoch_demography.txt')
a_shahii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_one_epoch_demography.txt')
alistipes_sp_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_one_epoch_demography.txt')
b_bacterium_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_one_epoch_demography.txt')
b_caccae_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_one_epoch_demography.txt')
b_cellulosilyticus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_one_epoch_demography.txt')
b_coprocola_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_one_epoch_demography.txt')
b_eggerthii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_one_epoch_demography.txt')
b_fragilis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_one_epoch_demography.txt')
b_massiliensis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_one_epoch_demography.txt')
b_ovatus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_one_epoch_demography.txt')
b_plebeius_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_one_epoch_demography.txt')
b_stercoris_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_one_epoch_demography.txt')
b_thetaiotaomicron_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_one_epoch_demography.txt')
b_uniformis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_one_epoch_demography.txt')
b_vulgatus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_one_epoch_demography.txt')
b_xylanisolvens_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_one_epoch_demography.txt')
b_intestinihominis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_one_epoch_demography.txt')
coprococcus_sp_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_one_epoch_demography.txt')
d_invisus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_one_epoch_demography.txt')
e_eligens_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_one_epoch_demography.txt')
e_rectale_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_one_epoch_demography.txt')
e_siraeum_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_one_epoch_demography.txt')
f_prausnitzii_57453_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_one_epoch_demography.txt')
f_prausnitzii_61481_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_one_epoch_demography.txt')
f_prausnitzii_62201_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_one_epoch_demography.txt')
l_bacterium_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_one_epoch_demography.txt')
o_splanchnicus_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_one_epoch_demography.txt')
oscillibacter_sp_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_one_epoch_demography.txt')
p_distasonis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_one_epoch_demography.txt')
p_merdae_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_one_epoch_demography.txt')
phascolarctobacterium_sp_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_one_epoch_demography.txt')
p_copri_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_one_epoch_demography.txt')
r_intestinalis_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_one_epoch_demography.txt')
r_inulinivorans_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_one_epoch_demography.txt')
r_bicirculans_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_one_epoch_demography.txt')
r_bromii_FD_accessory_one_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_one_epoch_demography.txt')

### Two-epoch (accessory)
a_muciniphila_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_two_epoch_demography.txt')
a_finegoldii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_two_epoch_demography.txt')
a_onderdonkii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_two_epoch_demography.txt')
a_putredinis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_two_epoch_demography.txt')
a_shahii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_two_epoch_demography.txt')
alistipes_sp_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_two_epoch_demography.txt')
b_bacterium_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt')
b_caccae_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt')
b_cellulosilyticus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt')
b_coprocola_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_two_epoch_demography.txt')
b_eggerthii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_two_epoch_demography.txt')
b_fragilis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_two_epoch_demography.txt')
b_massiliensis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_two_epoch_demography.txt')
b_ovatus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_two_epoch_demography.txt')
b_plebeius_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_two_epoch_demography.txt')
b_stercoris_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt')
b_thetaiotaomicron_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt')
b_uniformis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_two_epoch_demography.txt')
b_vulgatus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt')
b_xylanisolvens_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_two_epoch_demography.txt')
b_intestinihominis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_two_epoch_demography.txt')
coprococcus_sp_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_two_epoch_demography.txt')
d_invisus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt')
e_eligens_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_two_epoch_demography.txt')
e_rectale_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_two_epoch_demography.txt')
e_siraeum_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_two_epoch_demography.txt')
f_prausnitzii_57453_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_two_epoch_demography.txt')
f_prausnitzii_61481_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_two_epoch_demography.txt')
f_prausnitzii_62201_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_two_epoch_demography.txt')
l_bacterium_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_two_epoch_demography.txt')
o_splanchnicus_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_two_epoch_demography.txt')
oscillibacter_sp_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_two_epoch_demography.txt')
p_distasonis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt')
p_merdae_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt')
phascolarctobacterium_sp_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_two_epoch_demography.txt')
p_copri_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_two_epoch_demography.txt')
r_intestinalis_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_two_epoch_demography.txt')
r_inulinivorans_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_two_epoch_demography.txt')
r_bicirculans_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_two_epoch_demography.txt')
r_bromii_FD_accessory_two_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt')

### Three-epoch (accessory)
a_muciniphila_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_three_epoch_demography.txt')
a_finegoldii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_three_epoch_demography.txt')
a_onderdonkii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_three_epoch_demography.txt')
a_putredinis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_three_epoch_demography.txt')
a_shahii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_three_epoch_demography.txt')
alistipes_sp_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_three_epoch_demography.txt')
b_bacterium_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_three_epoch_demography.txt')
b_caccae_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_three_epoch_demography.txt')
b_cellulosilyticus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_three_epoch_demography.txt')
b_coprocola_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_three_epoch_demography.txt')
b_eggerthii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_three_epoch_demography.txt')
b_fragilis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_three_epoch_demography.txt')
b_massiliensis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_three_epoch_demography.txt')
b_ovatus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_three_epoch_demography.txt')
b_plebeius_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_three_epoch_demography.txt')
b_stercoris_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_three_epoch_demography.txt')
b_thetaiotaomicron_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_three_epoch_demography.txt')
b_uniformis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_three_epoch_demography.txt')
b_vulgatus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_three_epoch_demography.txt')
b_xylanisolvens_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_three_epoch_demography.txt')
b_intestinihominis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_three_epoch_demography.txt')
coprococcus_sp_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_three_epoch_demography.txt')
d_invisus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_three_epoch_demography.txt')
e_eligens_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_three_epoch_demography.txt')
e_rectale_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_three_epoch_demography.txt')
e_siraeum_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_three_epoch_demography.txt')
f_prausnitzii_57453_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_three_epoch_demography.txt')
f_prausnitzii_61481_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_three_epoch_demography.txt')
f_prausnitzii_62201_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_three_epoch_demography.txt')
l_bacterium_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_three_epoch_demography.txt')
o_splanchnicus_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_three_epoch_demography.txt')
oscillibacter_sp_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_three_epoch_demography.txt')
p_distasonis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_three_epoch_demography.txt')
p_merdae_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_three_epoch_demography.txt')
phascolarctobacterium_sp_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_three_epoch_demography.txt')
p_copri_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_three_epoch_demography.txt')
r_intestinalis_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_three_epoch_demography.txt')
r_inulinivorans_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_three_epoch_demography.txt')
r_bicirculans_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_three_epoch_demography.txt')
r_bromii_FD_accessory_three_epoch = sfs_from_demography('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_three_epoch_demography.txt')

# Nonsyn empirical (accessory)

a_muciniphila_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt')
a_finegoldii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt')
a_onderdonkii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt')
a_putredinis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt')
a_shahii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt')
alistipes_sp_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt')
b_bacterium_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt')
b_caccae_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt')
b_cellulosilyticus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt')
b_coprocola_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt')
b_eggerthii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt')
b_fragilis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt')
b_massiliensis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt')
b_ovatus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_inferred_DFE.txt')
b_plebeius_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt')
b_stercoris_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt')
b_thetaiotaomicron_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt')
b_uniformis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt')
b_vulgatus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt')
b_xylanisolvens_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt')
b_intestinihominis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt')
coprococcus_sp_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt')
d_invisus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt')
e_eligens_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt')
e_rectale_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt')
e_siraeum_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt')
f_prausnitzii_57453_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt')
f_prausnitzii_61481_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt')
f_prausnitzii_62201_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt')
l_bacterium_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt')
o_splanchnicus_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt')
oscillibacter_sp_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt')
p_distasonis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt')
p_merdae_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt')
phascolarctobacterium_sp_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt')
p_copri_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt')
r_intestinalis_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt')
r_inulinivorans_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt')
r_bicirculans_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt')
r_bromii_FD_accessory_nonsyn = empirical_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt')

# Gamma (accessory)

a_muciniphila_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt')
a_finegoldii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt')
a_onderdonkii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt')
a_putredinis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt')
a_shahii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt')
alistipes_sp_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt')
b_bacterium_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt')
b_caccae_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt')
b_cellulosilyticus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt')
b_coprocola_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt')
b_eggerthii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt')
b_fragilis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt')
b_massiliensis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt')
b_ovatus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_inferred_DFE.txt')
b_plebeius_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt')
b_stercoris_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt')
b_thetaiotaomicron_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt')
b_uniformis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt')
b_vulgatus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt')
b_xylanisolvens_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt')
b_intestinihominis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt')
coprococcus_sp_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt')
d_invisus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt')
e_eligens_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt')
e_rectale_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt')
e_siraeum_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt')
f_prausnitzii_57453_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt')
f_prausnitzii_61481_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt')
f_prausnitzii_62201_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt')
l_bacterium_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt')
o_splanchnicus_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt')
oscillibacter_sp_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt')
p_distasonis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt')
p_merdae_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt')
phascolarctobacterium_sp_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt')
p_copri_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt')
r_intestinalis_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt')
r_inulinivorans_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt')
r_bicirculans_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt')
r_bromii_FD_gamma_accessory = gamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt')

# Neugamma

a_muciniphila_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt')
a_finegoldii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt')
a_onderdonkii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt')
a_putredinis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt')
a_shahii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt')
alistipes_sp_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt')
b_bacterium_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt')
b_caccae_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt')
b_cellulosilyticus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt')
b_coprocola_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt')
b_eggerthii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt')
b_fragilis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt')
b_massiliensis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt')
b_ovatus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_inferred_DFE.txt')
b_plebeius_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt')
b_stercoris_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt')
b_thetaiotaomicron_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt')
b_uniformis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt')
b_vulgatus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt')
b_xylanisolvens_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt')
b_intestinihominis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt')
coprococcus_sp_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt')
d_invisus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt')
e_eligens_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt')
e_rectale_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt')
e_siraeum_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt')
f_prausnitzii_57453_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt')
f_prausnitzii_61481_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt')
f_prausnitzii_62201_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt')
l_bacterium_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt')
o_splanchnicus_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt')
oscillibacter_sp_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt')
p_distasonis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt')
p_merdae_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt')
phascolarctobacterium_sp_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt')
p_copri_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt')
r_intestinalis_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt')
r_inulinivorans_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt')
r_bicirculans_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt')
r_bromii_FD_neugamma_accessory = neugamma_sfs_from_dfe('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt')


# SFS comparison
a_muciniphila_FD_accessory_demography = compare_sfs(proportional_sfs(a_muciniphila_FD_accessory_folded), 
  proportional_sfs(a_muciniphila_FD_accessory_one_epoch), 
  proportional_sfs(a_muciniphila_FD_accessory_two_epoch), 
  proportional_sfs(a_muciniphila_FD_accessory_three_epoch)) +
  ggtitle('Akkermansia muciniphila (FD, accessory) model fit')

a_finegoldii_FD_accessory_demography = compare_sfs(proportional_sfs(a_finegoldii_FD_accessory_folded), 
  proportional_sfs(a_finegoldii_FD_accessory_one_epoch), 
  proportional_sfs(a_finegoldii_FD_accessory_two_epoch), 
  proportional_sfs(a_finegoldii_FD_accessory_three_epoch)) +
  ggtitle('Alistipes finegoldii (FD, accessory) model fit')

a_onderdonkii_FD_accessory_demography = compare_sfs(proportional_sfs(a_onderdonkii_FD_accessory_folded), 
  proportional_sfs(a_onderdonkii_FD_accessory_one_epoch), 
  proportional_sfs(a_onderdonkii_FD_accessory_two_epoch), 
  proportional_sfs(a_onderdonkii_FD_accessory_three_epoch)) +
  ggtitle('Alistipes onderdonkii (FD, accessory) model fit')

a_putredinis_FD_accessory_demography = compare_sfs(proportional_sfs(a_putredinis_FD_accessory_folded), 
  proportional_sfs(a_putredinis_FD_accessory_one_epoch), 
  proportional_sfs(a_putredinis_FD_accessory_two_epoch), 
  proportional_sfs(a_putredinis_FD_accessory_three_epoch)) +
  ggtitle('Alistipes putredinis (FD, accessory) model fit')

a_shahii_FD_accessory_demography = compare_sfs(proportional_sfs(a_shahii_FD_accessory_folded), 
  proportional_sfs(a_shahii_FD_accessory_one_epoch), 
  proportional_sfs(a_shahii_FD_accessory_two_epoch), 
  proportional_sfs(a_shahii_FD_accessory_three_epoch)) +
  ggtitle('Alistipes shahii (FD, accessory) model fit')

alistipes_sp_FD_accessory_demography = compare_sfs(proportional_sfs(alistipes_sp_FD_accessory_folded), 
  proportional_sfs(alistipes_sp_FD_accessory_one_epoch), 
  proportional_sfs(alistipes_sp_FD_accessory_two_epoch), 
  proportional_sfs(alistipes_sp_FD_accessory_three_epoch)) +
  ggtitle('Alistipes sp. (FD, accessory) model fit')

b_bacterium_FD_accessory_demography = compare_sfs(proportional_sfs(b_bacterium_FD_accessory_folded), 
  proportional_sfs(b_bacterium_FD_accessory_one_epoch), 
  proportional_sfs(b_bacterium_FD_accessory_two_epoch), 
  proportional_sfs(b_bacterium_FD_accessory_three_epoch)) +
  ggtitle('Bacteroidales bacterium (FD, accessory) model fit')

b_caccae_FD_accessory_demography = compare_sfs(proportional_sfs(b_caccae_FD_accessory_folded), 
  proportional_sfs(b_caccae_FD_accessory_one_epoch), 
  proportional_sfs(b_caccae_FD_accessory_two_epoch), 
  proportional_sfs(b_caccae_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides caccae (FD, accessory) model fit')

b_cellulosilyticus_FD_accessory_demography = compare_sfs(proportional_sfs(b_cellulosilyticus_FD_accessory_folded), 
  proportional_sfs(b_cellulosilyticus_FD_accessory_one_epoch), 
  proportional_sfs(b_cellulosilyticus_FD_accessory_two_epoch), 
  proportional_sfs(b_cellulosilyticus_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides cellulosilyticus (FD, accessory) model fit')

b_coprocola_FD_accessory_demography = compare_sfs(proportional_sfs(b_coprocola_FD_accessory_folded), 
  proportional_sfs(b_coprocola_FD_accessory_one_epoch), 
  proportional_sfs(b_coprocola_FD_accessory_two_epoch), 
  proportional_sfs(b_coprocola_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides coprocola (FD, accessory) model fit')

b_eggerthii_FD_accessory_demography = compare_sfs(proportional_sfs(b_eggerthii_FD_accessory_folded), 
  proportional_sfs(b_eggerthii_FD_accessory_one_epoch), 
  proportional_sfs(b_eggerthii_FD_accessory_two_epoch), 
  proportional_sfs(b_eggerthii_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides eggerthii (FD, accessory) model fit')

b_fragilis_FD_accessory_demography = compare_sfs(proportional_sfs(b_fragilis_FD_accessory_folded), 
  proportional_sfs(b_fragilis_FD_accessory_one_epoch), 
  proportional_sfs(b_fragilis_FD_accessory_two_epoch), 
  proportional_sfs(b_fragilis_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides fragilis (FD, accessory) model fit')

b_massiliensis_FD_accessory_demography = compare_sfs(proportional_sfs(b_massiliensis_FD_accessory_folded), 
  proportional_sfs(b_massiliensis_FD_accessory_one_epoch), 
  proportional_sfs(b_massiliensis_FD_accessory_two_epoch), 
  proportional_sfs(b_massiliensis_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides massiliensis (FD, accessory) model fit')

b_ovatus_FD_accessory_demography = compare_sfs(proportional_sfs(b_ovatus_FD_accessory_folded), 
  proportional_sfs(b_ovatus_FD_accessory_one_epoch), 
  proportional_sfs(b_ovatus_FD_accessory_two_epoch), 
  proportional_sfs(b_ovatus_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides ovatus (FD, accessory) model fit')

b_plebeius_FD_accessory_demography = compare_sfs(proportional_sfs(b_plebeius_FD_accessory_folded), 
  proportional_sfs(b_plebeius_FD_accessory_one_epoch), 
  proportional_sfs(b_plebeius_FD_accessory_two_epoch), 
  proportional_sfs(b_plebeius_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides plebeius (FD, accessory) model fit')

b_stercoris_FD_accessory_demography = compare_sfs(proportional_sfs(b_stercoris_FD_accessory_folded), 
  proportional_sfs(b_stercoris_FD_accessory_one_epoch), 
  proportional_sfs(b_stercoris_FD_accessory_two_epoch), 
  proportional_sfs(b_stercoris_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides stercoris (FD, accessory) model fit')

b_thetaiotaomicron_FD_accessory_demography = compare_sfs(proportional_sfs(b_thetaiotaomicron_FD_accessory_folded), 
  proportional_sfs(b_thetaiotaomicron_FD_accessory_one_epoch), 
  proportional_sfs(b_thetaiotaomicron_FD_accessory_two_epoch), 
  proportional_sfs(b_thetaiotaomicron_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides thetaiotaomicron (FD, accessory) model fit')

b_uniformis_FD_accessory_demography = compare_sfs(proportional_sfs(b_uniformis_FD_accessory_folded), 
  proportional_sfs(b_uniformis_FD_accessory_one_epoch), 
  proportional_sfs(b_uniformis_FD_accessory_two_epoch), 
  proportional_sfs(b_uniformis_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides uniformis (FD, accessory) model fit')

b_vulgatus_FD_accessory_demography = compare_sfs(proportional_sfs(b_vulgatus_FD_accessory_folded), 
  proportional_sfs(b_vulgatus_FD_accessory_one_epoch), 
  proportional_sfs(b_vulgatus_FD_accessory_two_epoch), 
  proportional_sfs(b_vulgatus_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides vulgatus (FD, accessory) model fit')

b_xylanisolvens_FD_accessory_demography = compare_sfs(proportional_sfs(b_xylanisolvens_FD_accessory_folded), 
  proportional_sfs(b_xylanisolvens_FD_accessory_one_epoch), 
  proportional_sfs(b_xylanisolvens_FD_accessory_two_epoch), 
  proportional_sfs(b_xylanisolvens_FD_accessory_three_epoch)) +
  ggtitle('Bacteroides xylanisolvens (FD, accessory) model fit')

b_intestinihominis_FD_accessory_demography = compare_sfs(proportional_sfs(b_intestinihominis_FD_accessory_folded), 
  proportional_sfs(b_intestinihominis_FD_accessory_one_epoch), 
  proportional_sfs(b_intestinihominis_FD_accessory_two_epoch), 
  proportional_sfs(b_intestinihominis_FD_accessory_three_epoch)) +
  ggtitle('Barnesiella intestinihominis (FD, accessory) model fit')

coprococcus_sp_FD_accessory_demography = compare_sfs(proportional_sfs(coprococcus_sp_FD_accessory_folded), 
  proportional_sfs(coprococcus_sp_FD_accessory_one_epoch), 
  proportional_sfs(coprococcus_sp_FD_accessory_two_epoch), 
  proportional_sfs(coprococcus_sp_FD_accessory_three_epoch)) +
  ggtitle('Coprococcus sp. (FD, accessory) model fit')

d_invisus_FD_accessory_demography = compare_sfs(proportional_sfs(d_invisus_FD_accessory_folded), 
  proportional_sfs(d_invisus_FD_accessory_one_epoch), 
  proportional_sfs(d_invisus_FD_accessory_two_epoch), 
  proportional_sfs(d_invisus_FD_accessory_three_epoch)) +
  ggtitle('Dialister invisus (FD, accessory) model fit')

e_eligens_FD_accessory_demography = compare_sfs(proportional_sfs(e_eligens_FD_accessory_folded), 
  proportional_sfs(e_eligens_FD_accessory_one_epoch), 
  proportional_sfs(e_eligens_FD_accessory_two_epoch), 
  proportional_sfs(e_eligens_FD_accessory_three_epoch)) +
  ggtitle('Eubacterium eligens (FD, accessory) model fit')

e_rectale_FD_accessory_demography = compare_sfs(proportional_sfs(e_rectale_FD_accessory_folded), 
  proportional_sfs(e_rectale_FD_accessory_one_epoch), 
  proportional_sfs(e_rectale_FD_accessory_two_epoch), 
  proportional_sfs(e_rectale_FD_accessory_three_epoch)) +
  ggtitle('Eubacterium rectale (FD, accessory) model fit')

e_siraeum_FD_accessory_demography = compare_sfs(proportional_sfs(e_siraeum_FD_accessory_folded), 
  proportional_sfs(e_siraeum_FD_accessory_one_epoch), 
  proportional_sfs(e_siraeum_FD_accessory_two_epoch), 
  proportional_sfs(e_siraeum_FD_accessory_three_epoch)) +
  ggtitle('Eubacterium siraeum (FD, accessory) model fit')

f_prausnitzii_57453_FD_accessory_demography = compare_sfs(proportional_sfs(f_prausnitzii_57453_FD_accessory_folded), 
  proportional_sfs(f_prausnitzii_57453_FD_accessory_one_epoch), 
  proportional_sfs(f_prausnitzii_57453_FD_accessory_two_epoch), 
  proportional_sfs(f_prausnitzii_57453_FD_accessory_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 57453 (FD, accessory) model fit')

f_prausnitzii_61481_FD_accessory_demography = compare_sfs(proportional_sfs(f_prausnitzii_61481_FD_accessory_folded), 
  proportional_sfs(f_prausnitzii_61481_FD_accessory_one_epoch), 
  proportional_sfs(f_prausnitzii_61481_FD_accessory_two_epoch), 
  proportional_sfs(f_prausnitzii_61481_FD_accessory_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 61481 (FD, accessory) model fit')

f_prausnitzii_62201_FD_accessory_demography = compare_sfs(proportional_sfs(f_prausnitzii_62201_FD_accessory_folded), 
  proportional_sfs(f_prausnitzii_62201_FD_accessory_one_epoch), 
  proportional_sfs(f_prausnitzii_62201_FD_accessory_two_epoch), 
  proportional_sfs(f_prausnitzii_62201_FD_accessory_three_epoch)) +
  ggtitle('Faecalibacterium prausnitzii 62201 (FD, accessory) model fit')

l_bacterium_FD_accessory_demography = compare_sfs(proportional_sfs(l_bacterium_FD_accessory_folded), 
  proportional_sfs(l_bacterium_FD_accessory_one_epoch), 
  proportional_sfs(l_bacterium_FD_accessory_two_epoch), 
  proportional_sfs(l_bacterium_FD_accessory_three_epoch)) +
  ggtitle('Lachnospiraceae bacterium (FD, accessory) model fit')

o_splanchnicus_FD_accessory_demography = compare_sfs(proportional_sfs(o_splanchnicus_FD_accessory_folded), 
  proportional_sfs(o_splanchnicus_FD_accessory_one_epoch), 
  proportional_sfs(o_splanchnicus_FD_accessory_two_epoch), 
  proportional_sfs(o_splanchnicus_FD_accessory_three_epoch)) +
  ggtitle('Odoribacter splanchnicus (FD, accessory) model fit')

oscillibacter_sp_FD_accessory_demography = compare_sfs(proportional_sfs(oscillibacter_sp_FD_accessory_folded), 
  proportional_sfs(oscillibacter_sp_FD_accessory_one_epoch), 
  proportional_sfs(oscillibacter_sp_FD_accessory_two_epoch), 
  proportional_sfs(oscillibacter_sp_FD_accessory_three_epoch)) +
  ggtitle('Oscillibacter sp. (FD, accessory) model fit')

p_distasonis_FD_accessory_demography = compare_sfs(proportional_sfs(p_distasonis_FD_accessory_folded), 
  proportional_sfs(p_distasonis_FD_accessory_one_epoch), 
  proportional_sfs(p_distasonis_FD_accessory_two_epoch), 
  proportional_sfs(p_distasonis_FD_accessory_three_epoch)) +
  ggtitle('Parabacteroides distasonis (FD, accessory) model fit')

p_merdae_FD_accessory_demography = compare_sfs(proportional_sfs(p_merdae_FD_accessory_folded), 
  proportional_sfs(p_merdae_FD_accessory_one_epoch), 
  proportional_sfs(p_merdae_FD_accessory_two_epoch), 
  proportional_sfs(p_merdae_FD_accessory_three_epoch)) +
  ggtitle('Parabacteroides merdae (FD, accessory) model fit')

phascolarctobacterium_sp_FD_accessory_demography = compare_sfs(proportional_sfs(phascolarctobacterium_sp_FD_accessory_folded), 
  proportional_sfs(phascolarctobacterium_sp_FD_accessory_one_epoch), 
  proportional_sfs(phascolarctobacterium_sp_FD_accessory_two_epoch), 
  proportional_sfs(phascolarctobacterium_sp_FD_accessory_three_epoch)) +
  ggtitle('Phascolarctobacterium sp. (FD, accessory) model fit')

p_copri_FD_accessory_demography = compare_sfs(proportional_sfs(p_copri_FD_accessory_folded), 
  proportional_sfs(p_copri_FD_accessory_one_epoch), 
  proportional_sfs(p_copri_FD_accessory_two_epoch), 
  proportional_sfs(p_copri_FD_accessory_three_epoch)) +
  ggtitle('Prevotella copri (FD, accessory) model fit')

r_intestinalis_FD_accessory_demography = compare_sfs(proportional_sfs(r_intestinalis_FD_accessory_folded), 
  proportional_sfs(r_intestinalis_FD_accessory_one_epoch), 
  proportional_sfs(r_intestinalis_FD_accessory_two_epoch), 
  proportional_sfs(r_intestinalis_FD_accessory_three_epoch)) +
  ggtitle('Roseburia intestinalis (FD, accessory) model fit')

r_inulinivorans_FD_accessory_demography = compare_sfs(proportional_sfs(r_inulinivorans_FD_accessory_folded), 
  proportional_sfs(r_inulinivorans_FD_accessory_one_epoch), 
  proportional_sfs(r_inulinivorans_FD_accessory_two_epoch), 
  proportional_sfs(r_inulinivorans_FD_accessory_three_epoch)) +
  ggtitle('Roseburia inulinivorans (FD, accessory) model fit')

r_bicirculans_FD_accessory_demography = compare_sfs(proportional_sfs(r_bicirculans_FD_accessory_folded), 
  proportional_sfs(r_bicirculans_FD_accessory_one_epoch), 
  proportional_sfs(r_bicirculans_FD_accessory_two_epoch), 
  proportional_sfs(r_bicirculans_FD_accessory_three_epoch)) +
  ggtitle('Ruminococcus bicirculans (FD, accessory) model fit')

r_bromii_FD_accessory_demography = compare_sfs(proportional_sfs(r_bromii_FD_accessory_folded), 
  proportional_sfs(r_bromii_FD_accessory_one_epoch), 
  proportional_sfs(r_bromii_FD_accessory_two_epoch), 
  proportional_sfs(r_bromii_FD_accessory_three_epoch)) +
  ggtitle('Ruminococcus bromii (FD, accessory) model fit')

a_muciniphila_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_likelihood_surface.csv')
# a_muciniphila_FD_accessory_likelihood_surface + ggtitle('Akkermansia muciniphila (FD) likelihood surface')

a_finegoldii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_likelihood_surface.csv')
# a_finegoldii_FD_accessory_likelihood_surface + ggtitle('Alistipes finegoldi (FD) likelihood surface')

a_onderdonkii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_likelihood_surface.csv')
# a_onderdonkii_FD_accessory_likelihood_surface + ggtitle('Alistipes onderdonkii (FD) likelihood surface')

a_putredinis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_likelihood_surface.csv')
# a_putredinis_FD_accessory_likelihood_surface + ggtitle('Alistipes putredinis (FD) likelihood surface')

a_shahii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_likelihood_surface.csv')
# a_shahii_FD_accessory_likelihood_surface + ggtitle('Alistipes shahii (FD) likelihood surface')

alistipes_sp_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_likelihood_surface.csv')
# alistipes_sp_FD_accessory_likelihood_surface + ggtitle('Alistipes sp. (FD) likelihood surface')

b_bacterium_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_likelihood_surface.csv')
# b_bacterium_FD_accessory_likelihood_surface + ggtitle('Bacteroides bacterium (FD) likelihood surface')

b_caccae_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_likelihood_surface.csv')
# b_caccae_FD_accessory_likelihood_surface + ggtitle('Bacteroides caccae (FD) likelihood surface')

b_cellulosilyticus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_likelihood_surface.csv')
# b_cellulosilyticus_FD_accessory_likelihood_surface + ggtitle('Bacteroides cellulosilyticus (FD) likelihood surface')

b_coprocola_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_likelihood_surface.csv')
# b_coprocola_FD_accessory_likelihood_surface + ggtitle('Bacteroides coprocola (FD) likelihood surface')

b_eggerthii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_likelihood_surface.csv')
# b_eggerthii_FD_accessory_likelihood_surface + ggtitle('Bacteroides eggerthii (FD) likelihood surface')

b_fragilis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_likelihood_surface.csv')
# b_fragilis_FD_accessory_likelihood_surface + ggtitle('Bacteroides fragilis (FD) likelihood surface')

b_massiliensis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_likelihood_surface.csv')
# b_massiliensis_FD_accessory_likelihood_surface + ggtitle('Bacteroides massiliensis (FD) likelihood surface')

b_ovatus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_likelihood_surface.csv')
# b_ovatus_FD_accessory_likelihood_surface + ggtitle('Bacteroides ovatus (FD) likelihood surface')

b_plebeius_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_likelihood_surface.csv')
# b_plebeius_FD_accessory_likelihood_surface + ggtitle('Bacteroides plebeius (FD) likelihood surface')

b_stercoris_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_likelihood_surface.csv')
# b_stercoris_FD_accessory_likelihood_surface + ggtitle('Bacteroides stercoris (FD) likelihood surface')

b_thetaiotaomicron_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_likelihood_surface.csv')
# b_thetaiotaomicron_FD_accessory_likelihood_surface + ggtitle('Bacteroides thetaiotaomicron (FD) likelihood surface')

b_uniformis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_likelihood_surface.csv')
# b_uniformis_FD_accessory_likelihood_surface + ggtitle('Bacteroides uniformis (FD) likelihood surface')

b_vulgatus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_likelihood_surface.csv')
# b_vulgatus_FD_accessory_likelihood_surface + ggtitle('Bacteroides vulgatus (FD) likelihood surface')

b_xylanisolvens_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_likelihood_surface.csv')
# b_xylanisolvens_FD_accessory_likelihood_surface + ggtitle('Bacteroides xylanisolvens (FD) likelihood surface')

b_intestinihominis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_likelihood_surface.csv')
# b_intestinihominis_FD_accessory_likelihood_surface + ggtitle('Barnesiella intestinihominis (FD) likelihood surface')

coprococcus_sp_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_likelihood_surface.csv')
# coprococcus_sp_FD_accessory_likelihood_surface + ggtitle('Coprococcus sp. (FD) likelihood surface')

d_invisus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_likelihood_surface.csv')
# d_invisus_FD_accessory_likelihood_surface + ggtitle('Dialister invisus (FD) likelihood surface')

e_eligens_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_likelihood_surface.csv')
# e_eligens_FD_accessory_likelihood_surface + ggtitle('Eubacterium eligens (FD) likelihood surface')

e_rectale_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_likelihood_surface.csv')
# e_rectale_FD_accessory_likelihood_surface + ggtitle('Eubacterium rectale (FD) likelihood surface')

e_siraeum_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_likelihood_surface.csv')
# e_siraeum_FD_accessory_likelihood_surface + ggtitle('Eubacterium siraeum (FD) likelihood surface')

f_prausnitzii_57453_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_likelihood_surface.csv')
# f_prausnitzii_57453_FD_accessory_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 57453 (FD) likelihood surface')

f_prausnitzii_61481_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_likelihood_surface.csv')
# f_prausnitzii_61481_FD_accessory_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 61481 (FD) likelihood surface')

f_prausnitzii_62201_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_likelihood_surface.csv')
# f_prausnitzii_62201_FD_accessory_likelihood_surface + ggtitle('Faecalibacterium prausnitzii 62201 (FD) likelihood surface')

l_bacterium_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_likelihood_surface.csv')
# l_bacterium_FD_accessory_likelihood_surface + ggtitle('Lachnospiraceae bacterium (FD) likelihood surface')

o_splanchnicus_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_likelihood_surface.csv')
# o_splanchnicus_FD_accessory_likelihood_surface + ggtitle('Odoribacter splanchnicus (FD) likelihood surface')

oscillibacter_sp_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_likelihood_surface.csv')
# oscillibacter_sp_FD_accessory_likelihood_surface + ggtitle('Oscillibacter sp. (FD) likelihood surface')

p_distasonis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_likelihood_surface.csv')
# p_distasonis_FD_accessory_likelihood_surface + ggtitle('Parabacteroides distasonis (FD) likelihood surface')

p_merdae_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_likelihood_surface.csv')
# p_merdae_FD_accessory_likelihood_surface + ggtitle('Parabacteroides merdae (FD) likelihood surface')

phascolarctobacterium_sp_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_likelihood_surface.csv')
# phascolarctobacterium_sp_FD_accessory_likelihood_surface + ggtitle('Phascolarctobacterium sp. (FD) likelihood surface')

p_copri_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_likelihood_surface.csv')
# p_copri_FD_accessory_likelihood_surface + ggtitle('Prevotella copri (FD) likelihood surface')

r_intestinalis_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_likelihood_surface.csv')
# r_intestinalis_FD_accessory_likelihood_surface + ggtitle('Roseburia intestinalis (FD) likelihood surface')

r_inulinivorans_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_likelihood_surface.csv')
# r_inulinivorans_FD_accessory_likelihood_surface + ggtitle('Roseburia inulinovrans (FD) likelihood surface')

r_bicirculans_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_likelihood_surface.csv')
# r_bicirculans_FD_accessory_likelihood_surface + ggtitle('Ruminococcus bicirculans (FD) likelihood surface')

r_bromii_FD_accessory_likelihood_surface = plot_likelihood_surface_contour('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_likelihood_surface.csv')
# r_bromii_FD_accessory_likelihood_surface + ggtitle('Ruminococcus bromii (FD) likelihood surface')

FD_accessory_demography = alistipes_sp_FD_accessory_demography + alistipes_sp_FD_accessory_likelihood_surface +
  a_putredinis_FD_accessory_demography + a_putredinis_FD_accessory_likelihood_surface +
  a_finegoldii_FD_accessory_demography + a_finegoldii_FD_accessory_likelihood_surface +
  a_onderdonkii_FD_accessory_demography + a_onderdonkii_FD_accessory_likelihood_surface +
  a_shahii_FD_accessory_demography + a_shahii_FD_accessory_likelihood_surface +
  b_bacterium_FD_accessory_demography + b_bacterium_FD_accessory_likelihood_surface +
  o_splanchnicus_FD_accessory_demography + o_splanchnicus_FD_accessory_likelihood_surface +
  p_distasonis_FD_accessory_demography + p_distasonis_FD_accessory_likelihood_surface +
  p_merdae_FD_accessory_demography + p_merdae_FD_accessory_likelihood_surface +
  p_copri_FD_accessory_demography + p_copri_FD_accessory_likelihood_surface +
  b_fragilis_FD_accessory_demography + b_fragilis_FD_accessory_likelihood_surface +
  b_cellulosilyticus_FD_accessory_demography + b_cellulosilyticus_FD_accessory_likelihood_surface +
  b_eggerthii_FD_accessory_demography + b_eggerthii_FD_accessory_likelihood_surface +
  b_stercoris_FD_accessory_demography + b_stercoris_FD_accessory_likelihood_surface +
  b_uniformis_FD_accessory_demography + b_uniformis_FD_accessory_likelihood_surface +
  b_thetaiotaomicron_FD_accessory_demography + b_thetaiotaomicron_FD_accessory_likelihood_surface +
  b_xylanisolvens_FD_accessory_demography + b_xylanisolvens_FD_accessory_likelihood_surface +
  b_caccae_FD_accessory_demography + b_caccae_FD_accessory_likelihood_surface +
  b_massiliensis_FD_accessory_demography + b_massiliensis_FD_accessory_likelihood_surface +
  b_vulgatus_FD_accessory_demography + b_vulgatus_FD_accessory_likelihood_surface +
  b_plebeius_FD_accessory_demography + b_plebeius_FD_accessory_likelihood_surface +
  b_coprocola_FD_accessory_demography + b_coprocola_FD_accessory_likelihood_surface +
  b_intestinihominis_FD_accessory_demography + b_intestinihominis_FD_accessory_likelihood_surface +
  a_muciniphila_FD_accessory_demography + a_muciniphila_FD_accessory_likelihood_surface +
  d_invisus_FD_accessory_demography + d_invisus_FD_accessory_likelihood_surface +
  phascolarctobacterium_sp_FD_accessory_demography + phascolarctobacterium_sp_FD_accessory_likelihood_surface +
  e_eligens_FD_accessory_demography + e_eligens_FD_accessory_likelihood_surface +
  e_rectale_FD_accessory_demography + e_rectale_FD_accessory_likelihood_surface +
  r_intestinalis_FD_accessory_demography + r_intestinalis_FD_accessory_likelihood_surface +
  r_inulinivorans_FD_accessory_demography + r_inulinivorans_FD_accessory_likelihood_surface +
  l_bacterium_FD_accessory_demography + l_bacterium_FD_accessory_likelihood_surface +
  coprococcus_sp_FD_accessory_demography + coprococcus_sp_FD_accessory_likelihood_surface +
  oscillibacter_sp_FD_accessory_demography + oscillibacter_sp_FD_accessory_likelihood_surface +
  r_bromii_FD_accessory_demography + r_bromii_FD_accessory_likelihood_surface +
  r_bicirculans_FD_accessory_demography + r_bicirculans_FD_accessory_likelihood_surface +
  e_siraeum_FD_accessory_demography + e_siraeum_FD_accessory_likelihood_surface +
  f_prausnitzii_57453_FD_accessory_demography + f_prausnitzii_57453_FD_accessory_likelihood_surface +
  f_prausnitzii_62201_FD_accessory_demography + f_prausnitzii_62201_FD_accessory_likelihood_surface +
  f_prausnitzii_61481_FD_accessory_demography + f_prausnitzii_61481_FD_accessory_likelihood_surface +
  plot_layout(ncol=2)

# ggsave(filename='./FD_accessory_demography_fit.png', plot=FD_accessory_demography, width=20, height=225, units="in", limitsize=FALSE)


# HR DFE Comparison (core)
a_muciniphila_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_DFE.txt')
a_muciniphila_HR_dfe_params$species = 'Akkermansia muciniphila'

a_finegoldii_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_DFE.txt')
a_finegoldii_HR_dfe_params$species = 'Alistipes finegoldii'

a_onderdonkii_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_DFE.txt')
a_onderdonkii_HR_dfe_params$species = 'Alistipes onderdonkii'

a_shahii_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_DFE.txt')
a_shahii_HR_dfe_params$species = 'Alistipes shahii'

b_caccae_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_DFE.txt')
b_caccae_HR_dfe_params$species = 'Bacteroides caccae'

b_cellulosilyticus_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_DFE.txt')
b_cellulosilyticus_HR_dfe_params$species = 'Bacteroides cellulosilyticus'

# b_coprocola_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_inferred_DFE.txt')
# b_coprocola_HR_dfe_params$species = 'Bacteroides coprocola'

# b_eggerthii_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_inferred_DFE.txt')
# b_eggerthii_HR_dfe_params$species = 'Bacteroides eggerthii'

b_fragilis_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_DFE.txt')
b_fragilis_HR_dfe_params$species = 'Bacteroides fragilis'

b_ovatus_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_inferred_DFE.txt')
b_ovatus_HR_dfe_params$species = 'Bacteroides ovatus'

b_stercoris_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_DFE.txt')
b_stercoris_HR_dfe_params$species = 'Bacteroides stercoris'

b_thetaiotaomicron_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_DFE.txt')
b_thetaiotaomicron_HR_dfe_params$species = 'Bacteroides thetaiotaomicron'

b_vulgatus_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_DFE.txt')
b_vulgatus_HR_dfe_params$species = 'Bacteroides vulgatus'

b_intestinihominis_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_DFE.txt')
b_intestinihominis_HR_dfe_params$species = 'Barnesiella intestinihominis'

d_invisus_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_DFE.txt')
d_invisus_HR_dfe_params$species = 'Dialister invisus'

e_rectale_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_DFE.txt')
e_rectale_HR_dfe_params$species = 'Eubacterium rectale'

e_siraeum_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_inferred_DFE.txt')
e_siraeum_HR_dfe_params$species = 'Eubacterium siraeum'

oscillibacter_sp_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_DFE.txt')
oscillibacter_sp_HR_dfe_params$species = 'Oscillibacter sp.'

p_distasonis_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_DFE.txt')
p_distasonis_HR_dfe_params$species = 'Parabacteroides distasonis'

p_merdae_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_DFE.txt')
p_merdae_HR_dfe_params$species = 'Parabacteroides merdae'

r_bicirculans_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_DFE.txt')
r_bicirculans_HR_dfe_params$species = 'Ruminococcus bicirculans'

r_bromii_HR_dfe_params = read_dfe_params('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_DFE.txt')
r_bromii_HR_dfe_params$species = 'Ruminococcus bromii'

HR_dfe_df = rbind(
  melt(a_finegoldii_HR_dfe_params),
  melt(a_onderdonkii_HR_dfe_params),
  melt(a_shahii_HR_dfe_params),
  melt(p_distasonis_HR_dfe_params),
  melt(p_merdae_HR_dfe_params),
  melt(b_fragilis_HR_dfe_params),
  melt(b_cellulosilyticus_HR_dfe_params),
  melt(b_stercoris_HR_dfe_params),
  melt(b_thetaiotaomicron_HR_dfe_params),
  melt(b_caccae_HR_dfe_params),
  melt(b_vulgatus_HR_dfe_params),
  melt(b_intestinihominis_HR_dfe_params),
  melt(a_muciniphila_HR_dfe_params),
  melt(d_invisus_HR_dfe_params),
  melt(e_rectale_HR_dfe_params),
  melt(oscillibacter_sp_HR_dfe_params),
  melt(r_bromii_HR_dfe_params),
  melt(r_bicirculans_HR_dfe_params)
)

HR_dfe_df$species = factor(HR_dfe_df$species, levels=HR_phylogenetic_levels)
HR_dfe_df <- HR_dfe_df[order(HR_dfe_df$species), ]

# dfe_df

## Due to Dadi internal scaling which considers genotype
## fitness as (1, 1 + 2sh, 1 + 2s), and the fact that
## we are working with a haploid sample, we
## wish to multiply the _inferred_ s by 2 to get the true
## selective coefficient of the haploid bacteria.
## However, s is for the heterozygote case.

# dfe_df$value = dfe_df$value * 2
HR_dfe_df$value[HR_dfe_df$value <= 1e-11] = 1e-11
HR_dfe_df$value[HR_dfe_df$value >= 0.5] = 0.5

# DFE Comparison
# 900 x 1500
ggplot(HR_dfe_df[HR_dfe_df$variable == 'gamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
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
  xlab('Selection Coefficient') +
  ggtitle('Gamma-distributed DFE, Low recombination sites and selective sweeps removed')

ggplot(HR_dfe_df[HR_dfe_df$variable == 'neugamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
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
  xlab('Selection Coefficient') +
  ggtitle('Neutral+Gamma-distributed DFE, Low recombination sites and selective sweeps removed')

# ggsave(filename='../HighRecombinationAnalysis/HR_gamma_dfe.png', plot=HR_gamma_dfe, width=800, height=1500, units="px", limitsize=TRUE)

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

# b_ovatus_fd_core_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_DFE.txt')
# b_ovatus_fd_core_dfe_params$species = 'Bacteroides ovatus'

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
  melt(b_bacterium_fd_core_dfe_params),
  melt(b_caccae_fd_core_dfe_params),
  melt(b_cellulosilyticus_fd_core_dfe_params),
  melt(b_coprocola_fd_core_dfe_params),
  melt(b_eggerthii_fd_core_dfe_params),
  melt(b_fragilis_fd_core_dfe_params),
  melt(b_massiliensis_fd_core_dfe_params),
  # melt(b_ovatus_fd_core_dfe_params),
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

fd_core_dfe_df$species = factor(fd_core_dfe_df$species, levels=FD_phylogenetic_levels)
fd_core_dfe_df <- fd_core_dfe_df[order(fd_core_dfe_df$species), ]


# dfe_df

## Due to Dadi internal scaling which considers genotype
## fitness as (1, 1 + 2sh, 1 + 2s), and the fact that
## we are working with a haploid sample, we
## wish to multiply the _inferred_ s by 2 to get the true
## selective coefficient of the haploid bacteria.
## However, s is for the heterozygote case.

# dfe_df$value = dfe_df$value * 2
fd_core_dfe_df$value[fd_core_dfe_df$value <= 1e-11] = 1e-11
fd_core_dfe_df$value[fd_core_dfe_df$value >= 0.5] = 0.5

# DFE Comparison
# 900 x 2000
ggplot(fd_core_dfe_df[fd_core_dfe_df$variable == 'gamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
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
  xlab('Selection Coefficient') +
  ggtitle('Gamma-distributed DFE, core genes')

ggplot(fd_core_dfe_df[fd_core_dfe_df$variable == 'neugamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
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
  xlab('Selection Coefficient') +
  ggtitle('Neutral+Gamma-distributed DFE, core genes')

# FD DFE comparison

a_muciniphila_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_DFE.txt')
a_muciniphila_FD_accessory_dfe_params$species = 'Akkermansia muciniphila'

a_finegoldii_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt')
a_finegoldii_FD_accessory_dfe_params$species = 'Alistipes finegoldii'

a_onderdonkii_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt')
a_onderdonkii_FD_accessory_dfe_params$species = 'Alistipes onderdonkii'

a_putredinis_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt')
a_putredinis_FD_accessory_dfe_params$species = 'Alistipes putredinis'

a_shahii_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt')
a_shahii_FD_accessory_dfe_params$species = 'Alistipes shahii'

alistipes_sp_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_DFE.txt')
alistipes_sp_FD_accessory_dfe_params$species = 'Alistipes sp.'

b_bacterium_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt')
b_bacterium_FD_accessory_dfe_params$species = 'Bacteroidales bacterium'

b_caccae_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt')
b_caccae_FD_accessory_dfe_params$species = 'Bacteroides caccae'

b_cellulosilyticus_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt')
b_cellulosilyticus_FD_accessory_dfe_params$species = 'Bacteroides cellulosilyticus'

b_coprocola_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt')
b_coprocola_FD_accessory_dfe_params$species = 'Bacteroides coprocola'

b_eggerthii_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt')
b_eggerthii_FD_accessory_dfe_params$species = 'Bacteroides eggerthii'

b_fragilis_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt')
b_fragilis_FD_accessory_dfe_params$species = 'Bacteroides fragilis'

b_massiliensis_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt')
b_massiliensis_FD_accessory_dfe_params$species = 'Bacteroides massiliensis'

# b_ovatus_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_inferred_DFE.txt')
# b_ovatus_FD_accessory_dfe_params$species = 'Bacteroides ovatus'

b_plebeius_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt')
b_plebeius_FD_accessory_dfe_params$species = 'Bacteroides plebeius'

b_stercoris_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt')
b_stercoris_FD_accessory_dfe_params$species = 'Bacteroides stercoris'

b_thetaiotaomicron_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt')
b_thetaiotaomicron_FD_accessory_dfe_params$species = 'Bacteroides thetaiotaomicron'

b_uniformis_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt')
b_uniformis_FD_accessory_dfe_params$species = 'Bacteroides uniformis'

b_vulgatus_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt')
b_vulgatus_FD_accessory_dfe_params$species = 'Bacteroides vulgatus'

b_xylanisolvens_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt')
b_xylanisolvens_FD_accessory_dfe_params$species = 'Bacteroides xylanisolvens'

b_intestinihominis_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt')
b_intestinihominis_FD_accessory_dfe_params$species = 'Barnesiella intestinihominis'

coprococcus_sp_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt')
coprococcus_sp_FD_accessory_dfe_params$species = 'Coprococcus sp.'

d_invisus_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt')
d_invisus_FD_accessory_dfe_params$species = 'Dialister invisus'

e_eligens_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt')
e_eligens_FD_accessory_dfe_params$species = 'Eubacterium eligens'

e_rectale_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt')
e_rectale_FD_accessory_dfe_params$species = 'Eubacterium rectale'

e_siraeum_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt')
e_siraeum_FD_accessory_dfe_params$species = 'Eubacterium siraeum'

f_prausnitzii_57453_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_DFE.txt')
f_prausnitzii_57453_FD_accessory_dfe_params$species = 'Faecalibacterium prausnitzii (57453)'

f_prausnitzii_61481_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_DFE.txt')
f_prausnitzii_61481_FD_accessory_dfe_params$species = 'Faecalibacterium prausnitzii (61481)'

f_prausnitzii_62201_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_DFE.txt')
f_prausnitzii_62201_FD_accessory_dfe_params$species = 'Faecalibacterium prausnitzii (62201)'

l_bacterium_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_DFE.txt')
l_bacterium_FD_accessory_dfe_params$species = 'Lachnospiraceae bacterium'

o_splanchnicus_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt')
o_splanchnicus_FD_accessory_dfe_params$species = 'Odoribacter splanchnicus'

oscillibacter_sp_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt')
oscillibacter_sp_FD_accessory_dfe_params$species = 'Oscillibacter sp.'

p_distasonis_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt')
p_distasonis_FD_accessory_dfe_params$species = 'Parabacteroides distasonis'

p_merdae_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt')
p_merdae_FD_accessory_dfe_params$species = 'Parabacteroides merdae'

phascolarctobacterium_sp_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt')
phascolarctobacterium_sp_FD_accessory_dfe_params$species = 'Phascolarctobacterium sp.'

p_copri_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt')
p_copri_FD_accessory_dfe_params$species = 'Prevotella copri'

r_intestinalis_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt')
r_intestinalis_FD_accessory_dfe_params$species = 'Roseburia intestinalis'

r_inulinivorans_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt')
r_inulinivorans_FD_accessory_dfe_params$species = 'Roseburia inulinivorans'

r_bicirculans_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_DFE.txt')
r_bicirculans_FD_accessory_dfe_params$species = 'Ruminococcus bicirculans'

r_bromii_FD_accessory_dfe_params = read_dfe_params('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt')
r_bromii_FD_accessory_dfe_params$species = 'Ruminococcus bromii'

FD_accessory_dfe_df = rbind(
  melt(a_putredinis_FD_accessory_dfe_params),
  melt(a_finegoldii_FD_accessory_dfe_params),
  melt(a_onderdonkii_FD_accessory_dfe_params),
  melt(a_shahii_FD_accessory_dfe_params),
  melt(b_bacterium_FD_accessory_dfe_params),
  melt(p_distasonis_FD_accessory_dfe_params),
  melt(p_merdae_FD_accessory_dfe_params),
  melt(b_cellulosilyticus_FD_accessory_dfe_params),
  melt(b_stercoris_FD_accessory_dfe_params),
  melt(b_thetaiotaomicron_FD_accessory_dfe_params),
  melt(b_caccae_FD_accessory_dfe_params),
  melt(b_massiliensis_FD_accessory_dfe_params),
  melt(b_vulgatus_FD_accessory_dfe_params),
  melt(d_invisus_FD_accessory_dfe_params),
  melt(e_eligens_FD_accessory_dfe_params),
  melt(e_rectale_FD_accessory_dfe_params),
  melt(e_siraeum_FD_accessory_dfe_params),
  melt(r_bromii_FD_accessory_dfe_params)
)


FD_accessory_dfe_df$species = factor(FD_accessory_dfe_df$species, levels=FD_accessory_phylogenetic_levels)
FD_accessory_dfe_df <- FD_accessory_dfe_df[order(FD_accessory_dfe_df$species), ]


# dfe_df

## Due to Dadi internal scaling which considers genotype
## fitness as (1, 1 + 2sh, 1 + 2s), and the fact that
## we are working with a haploid sample, we
## wish to multiply the _inferred_ s by 2 to get the true
## selective coefficient of the haploid bacteria.
## However, s is for the heterozygote case.

# dfe_df$value = dfe_df$value * 2
FD_accessory_dfe_df$value[FD_accessory_dfe_df$value <= 1e-11] = 1e-11
FD_accessory_dfe_df$value[FD_accessory_dfe_df$value >= 0.5] = 0.5

# 900 x 1400
ggplot(FD_accessory_dfe_df[FD_accessory_dfe_df$variable == 'gamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
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
  xlab('Selection Coefficient') +
  ggtitle('Gamma-distributed DFE, accessory genes')

ggplot(FD_accessory_dfe_df[FD_accessory_dfe_df$variable == 'neugamma_dfe_dist_low', ], aes(x=value, y=fct_rev(species), fill=species)) +
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
  xlab('Selection Coefficient') +
  ggtitle('Neutral+Gamma-distributed DFE, accessory genes')


# HR DFE Comparison (core, 2ns)
a_muciniphila_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/core_0.5_inferred_dfe.txt')
a_muciniphila_HR_dfe_dadi_params$species = 'Akkermansia muciniphila'

a_finegoldii_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Alistipes_finegoldii_56071/core_0.5_inferred_dfe.txt')
a_finegoldii_HR_dfe_dadi_params$species = 'Alistipes finegoldii'

a_onderdonkii_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/core_0.5_inferred_dfe.txt')
a_onderdonkii_HR_dfe_dadi_params$species = 'Alistipes onderdonkii'

a_shahii_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Alistipes_shahii_62199/core_0.5_inferred_dfe.txt')
a_shahii_HR_dfe_dadi_params$species = 'Alistipes shahii'

b_caccae_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_caccae_53434/core_0.5_inferred_dfe.txt')
b_caccae_HR_dfe_dadi_params$species = 'Bacteroides caccae'

b_cellulosilyticus_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/core_0.5_inferred_dfe.txt')
b_cellulosilyticus_HR_dfe_dadi_params$species = 'Bacteroides cellulosilyticus'

b_coprocola_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_coprocola_61586/core_0.5_inferred_dfe.txt')
b_coprocola_HR_dfe_dadi_params$species = 'Bacteroides coprocola'

b_eggerthii_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_eggerthii_54457/core_0.5_inferred_dfe.txt')
b_eggerthii_HR_dfe_dadi_params$species = 'Bacteroides eggerthii'

b_fragilis_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_fragilis_54507/core_0.5_inferred_dfe.txt')
b_fragilis_HR_dfe_dadi_params$species = 'Bacteroides fragilis'

b_ovatus_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_ovatus_58035/core_0.5_inferred_dfe.txt')
b_ovatus_HR_dfe_dadi_params$species = 'Bacteroides ovatus'

b_stercoris_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_stercoris_56735/core_0.5_inferred_dfe.txt')
b_stercoris_HR_dfe_dadi_params$species = 'Bacteroides stercoris'

b_thetaiotaomicron_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/core_0.5_inferred_dfe.txt')
b_thetaiotaomicron_HR_dfe_dadi_params$species = 'Bacteroides thetaiotaomicron'

b_vulgatus_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/core_0.5_inferred_dfe.txt')
b_vulgatus_HR_dfe_dadi_params$species = 'Bacteroides vulgatus'

b_intestinihominis_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/core_0.5_inferred_dfe.txt')
b_intestinihominis_HR_dfe_dadi_params$species = 'Barnesiella intestinihominis'

d_invisus_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Dialister_invisus_61905/core_0.5_inferred_dfe.txt')
d_invisus_HR_dfe_dadi_params$species = 'Dialister invisus'

e_rectale_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Eubacterium_rectale_56927/core_0.5_inferred_dfe.txt')
e_rectale_HR_dfe_dadi_params$species = 'Eubacterium rectale'

e_siraeum_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Eubacterium_siraeum_57634/core_0.5_inferred_dfe.txt')
e_siraeum_HR_dfe_dadi_params$species = 'Eubacterium siraeum'

oscillibacter_sp_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Oscillibacter_sp_60799/core_0.5_inferred_dfe.txt')
oscillibacter_sp_HR_dfe_dadi_params$species = 'Oscillibacter sp.'

p_distasonis_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/core_0.5_inferred_dfe.txt')
p_distasonis_HR_dfe_dadi_params$species = 'Parabacteroides distasonis'

p_merdae_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Parabacteroides_merdae_56972/core_0.5_inferred_dfe.txt')
p_merdae_HR_dfe_dadi_params$species = 'Parabacteroides merdae'

r_bicirculans_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/core_0.5_inferred_dfe.txt')
r_bicirculans_HR_dfe_dadi_params$species = 'Ruminococcus bicirculans'

r_bromii_HR_dfe_dadi_params = read_dfe_dadi_params('../HighRecombinationAnalysis/Ruminococcus_bromii_62047/core_0.5_inferred_dfe.txt')
r_bromii_HR_dfe_dadi_params$species = 'Ruminococcus bromii'

HR_dfe_dadi_df = rbind(
  melt(a_finegoldii_HR_dfe_dadi_params),
  melt(a_onderdonkii_HR_dfe_dadi_params),
  melt(a_shahii_HR_dfe_dadi_params),
  melt(p_distasonis_HR_dfe_dadi_params),
  melt(p_merdae_HR_dfe_dadi_params),
  melt(b_fragilis_HR_dfe_dadi_params),
  melt(b_cellulosilyticus_HR_dfe_dadi_params),
  melt(b_stercoris_HR_dfe_dadi_params),
  melt(b_thetaiotaomicron_HR_dfe_dadi_params),
  melt(b_caccae_HR_dfe_dadi_params),
  melt(b_vulgatus_HR_dfe_dadi_params),
  melt(b_intestinihominis_HR_dfe_dadi_params),
  melt(a_muciniphila_HR_dfe_dadi_params),
  melt(d_invisus_HR_dfe_dadi_params),
  melt(e_rectale_HR_dfe_dadi_params),
  melt(oscillibacter_sp_HR_dfe_dadi_params),
  melt(r_bromii_HR_dfe_dadi_params),
  melt(r_bicirculans_HR_dfe_dadi_params)
)

HR_dfe_dadi_df$species = factor(HR_dfe_dadi_df$species, levels=HR_phylogenetic_levels)
HR_dfe_dadi_df <- HR_dfe_dadi_df[order(HR_dfe_dadi_df$species), ]

# dfe_df

## Due to Dadi internal scaling which considers genotype
## fitness as (1, 1 + 2sh, 1 + 2s), and the fact that
## we are working with a haploid sample, we
## wish to multiply the _inferred_ s by 2 to get the true
## selective coefficient of the haploid bacteria.
## However, s is for the heterozygote case.

# dfe_df$value = dfe_df$value * 2
HR_dfe_dadi_df$value[HR_dfe_dadi_df$value <= 1e-11] = 1e-11
HR_dfe_dadi_df$value[HR_dfe_dadi_df$value >= 1E10] = 1E10

# DFE Comparison

ggplot(HR_dfe_dadi_df[HR_dfe_dadi_df$variable == 'gamma_dfe_dist', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e10)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") +
  xlab('Selection Coefficient') +
  ggtitle('Gamma-distributed DFE * 2Ns, Low recombination sites and selective sweeps removed')

ggplot(HR_dfe_dadi_df[HR_dfe_dadi_df$variable == 'neugamma_dfe_dist', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e10)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") +
  xlab('Selection Coefficient') +
  ggtitle('Neutral+Gamma-distributed DFE * 2Ns, Low recombination sites and selective sweeps removed')

# FD DFE comparison (core)

a_muciniphila_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_dfe.txt')
a_muciniphila_fd_core_dfe_dadi_params$species = 'Akkermansia muciniphila'

a_finegoldii_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_dfe.txt')
a_finegoldii_fd_core_dfe_dadi_params$species = 'Alistipes finegoldii'

a_onderdonkii_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_dfe.txt')
a_onderdonkii_fd_core_dfe_dadi_params$species = 'Alistipes onderdonkii'

a_putredinis_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_dfe.txt')
a_putredinis_fd_core_dfe_dadi_params$species = 'Alistipes putredinis'

a_shahii_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_dfe.txt')
a_shahii_fd_core_dfe_dadi_params$species = 'Alistipes shahii'

alistipes_sp_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_dfe.txt')
alistipes_sp_fd_core_dfe_dadi_params$species = 'Alistipes sp.'

b_bacterium_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_dfe.txt')
b_bacterium_fd_core_dfe_dadi_params$species = 'Bacteroidales bacterium'

b_caccae_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_dfe.txt')
b_caccae_fd_core_dfe_dadi_params$species = 'Bacteroides caccae'

b_cellulosilyticus_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_dfe.txt')
b_cellulosilyticus_fd_core_dfe_dadi_params$species = 'Bacteroides cellulosilyticus'

b_coprocola_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_dfe.txt')
b_coprocola_fd_core_dfe_dadi_params$species = 'Bacteroides coprocola'

b_eggerthii_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_dfe.txt')
b_eggerthii_fd_core_dfe_dadi_params$species = 'Bacteroides eggerthii'

b_fragilis_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_dfe.txt')
b_fragilis_fd_core_dfe_dadi_params$species = 'Bacteroides fragilis'

b_massiliensis_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_dfe.txt')
b_massiliensis_fd_core_dfe_dadi_params$species = 'Bacteroides massiliensis'

b_ovatus_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_dfe.txt')
b_ovatus_fd_core_dfe_dadi_params$species = 'Bacteroides ovatus'

b_plebeius_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_dfe.txt')
b_plebeius_fd_core_dfe_dadi_params$species = 'Bacteroides plebeius'

b_stercoris_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_dfe.txt')
b_stercoris_fd_core_dfe_dadi_params$species = 'Bacteroides stercoris'

b_thetaiotaomicron_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_dfe.txt')
b_thetaiotaomicron_fd_core_dfe_dadi_params$species = 'Bacteroides thetaiotaomicron'

b_uniformis_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_dfe.txt')
b_uniformis_fd_core_dfe_dadi_params$species = 'Bacteroides uniformis'

b_vulgatus_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_dfe.txt')
b_vulgatus_fd_core_dfe_dadi_params$species = 'Bacteroides vulgatus'

b_xylanisolvens_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_dfe.txt')
b_xylanisolvens_fd_core_dfe_dadi_params$species = 'Bacteroides xylanisolvens'

b_intestinihominis_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_dfe.txt')
b_intestinihominis_fd_core_dfe_dadi_params$species = 'Barnesiella intestinihominis'

coprococcus_sp_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_dfe.txt')
coprococcus_sp_fd_core_dfe_dadi_params$species = 'Coprococcus sp.'

d_invisus_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_dfe.txt')
d_invisus_fd_core_dfe_dadi_params$species = 'Dialister invisus'

e_eligens_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_dfe.txt')
e_eligens_fd_core_dfe_dadi_params$species = 'Eubacterium eligens'

e_rectale_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_dfe.txt')
e_rectale_fd_core_dfe_dadi_params$species = 'Eubacterium rectale'

e_siraeum_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_dfe.txt')
e_siraeum_fd_core_dfe_dadi_params$species = 'Eubacterium siraeum'

f_prausnitzii_57453_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_dfe.txt')
f_prausnitzii_57453_fd_core_dfe_dadi_params$species = 'Faecalibacterium prausnitzii (57453)'

f_prausnitzii_61481_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_dfe.txt')
f_prausnitzii_61481_fd_core_dfe_dadi_params$species = 'Faecalibacterium prausnitzii (61481)'

f_prausnitzii_62201_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_dfe.txt')
f_prausnitzii_62201_fd_core_dfe_dadi_params$species = 'Faecalibacterium prausnitzii (62201)'

l_bacterium_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_dfe.txt')
l_bacterium_fd_core_dfe_dadi_params$species = 'Lachnospiraceae bacterium'

o_splanchnicus_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_dfe.txt')
o_splanchnicus_fd_core_dfe_dadi_params$species = 'Odoribacter splanchnicus'

oscillibacter_sp_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_dfe.txt')
oscillibacter_sp_fd_core_dfe_dadi_params$species = 'Oscillibacter sp.'

p_distasonis_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_dfe.txt')
p_distasonis_fd_core_dfe_dadi_params$species = 'Parabacteroides distasonis'

p_merdae_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_dfe.txt')
p_merdae_fd_core_dfe_dadi_params$species = 'Parabacteroides merdae'

phascolarctobacterium_sp_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_dfe.txt')
phascolarctobacterium_sp_fd_core_dfe_dadi_params$species = 'Phascolarctobacterium sp.'

p_copri_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_dfe.txt')
p_copri_fd_core_dfe_dadi_params$species = 'Prevotella copri'

r_intestinalis_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_dfe.txt')
r_intestinalis_fd_core_dfe_dadi_params$species = 'Roseburia intestinalis'

r_inulinivorans_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_dfe.txt')
r_inulinivorans_fd_core_dfe_dadi_params$species = 'Roseburia inulinivorans'

r_bicirculans_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_dfe.txt')
r_bicirculans_fd_core_dfe_dadi_params$species = 'Ruminococcus bicirculans'

r_bromii_fd_core_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_dfe.txt')
r_bromii_fd_core_dfe_dadi_params$species = 'Ruminococcus bromii'

fd_core_dfe_dadi_df = rbind(
  melt(a_muciniphila_fd_core_dfe_dadi_params),
  melt(a_finegoldii_fd_core_dfe_dadi_params),
  melt(a_onderdonkii_fd_core_dfe_dadi_params),
  melt(a_putredinis_fd_core_dfe_dadi_params),
  melt(a_shahii_fd_core_dfe_dadi_params),
  melt(alistipes_sp_fd_core_dfe_dadi_params),
  melt(b_bacterium_fd_core_dfe_dadi_params),
  melt(b_bacterium_fd_core_dfe_dadi_params),
  melt(b_caccae_fd_core_dfe_dadi_params),
  melt(b_cellulosilyticus_fd_core_dfe_dadi_params),
  melt(b_coprocola_fd_core_dfe_dadi_params),
  melt(b_eggerthii_fd_core_dfe_dadi_params),
  melt(b_fragilis_fd_core_dfe_dadi_params),
  melt(b_massiliensis_fd_core_dfe_dadi_params),
  # melt(b_ovatus_fd_core_dfe_dadi_params),
  melt(b_plebeius_fd_core_dfe_dadi_params),
  melt(b_stercoris_fd_core_dfe_dadi_params),
  melt(b_thetaiotaomicron_fd_core_dfe_dadi_params),
  melt(b_uniformis_fd_core_dfe_dadi_params),
  melt(b_vulgatus_fd_core_dfe_dadi_params),
  melt(b_xylanisolvens_fd_core_dfe_dadi_params),
  melt(b_intestinihominis_fd_core_dfe_dadi_params),
  melt(coprococcus_sp_fd_core_dfe_dadi_params),
  melt(d_invisus_fd_core_dfe_dadi_params),
  melt(e_eligens_fd_core_dfe_dadi_params),
  melt(e_rectale_fd_core_dfe_dadi_params),
  melt(e_siraeum_fd_core_dfe_dadi_params),
  melt(f_prausnitzii_57453_fd_core_dfe_dadi_params),
  melt(f_prausnitzii_61481_fd_core_dfe_dadi_params),
  melt(f_prausnitzii_62201_fd_core_dfe_dadi_params),
  melt(l_bacterium_fd_core_dfe_dadi_params),
  melt(o_splanchnicus_fd_core_dfe_dadi_params),
  melt(oscillibacter_sp_fd_core_dfe_dadi_params),
  melt(p_distasonis_fd_core_dfe_dadi_params),
  melt(p_merdae_fd_core_dfe_dadi_params),
  melt(phascolarctobacterium_sp_fd_core_dfe_dadi_params),
  melt(p_copri_fd_core_dfe_dadi_params),
  melt(r_intestinalis_fd_core_dfe_dadi_params),
  melt(r_inulinivorans_fd_core_dfe_dadi_params),
  melt(r_bicirculans_fd_core_dfe_dadi_params),
  melt(r_bromii_fd_core_dfe_dadi_params)
)

fd_core_dfe_dadi_df$species = factor(fd_core_dfe_dadi_df$species, levels=FD_phylogenetic_levels)
fd_core_dfe_dadi_df <- fd_core_dfe_dadi_df[order(fd_core_dfe_dadi_df$species), ]


# dfe_df

## Due to Dadi internal scaling which considers genotype
## fitness as (1, 1 + 2sh, 1 + 2s), and the fact that
## we are working with a haploid sample, we
## wish to multiply the _inferred_ s by 2 to get the true
## selective coefficient of the haploid bacteria.
## However, s is for the heterozygote case.

# dfe_df$value = dfe_df$value * 2
fd_core_dfe_dadi_df$value[fd_core_dfe_dadi_df$value <= 1e-11] = 1e-11
fd_core_dfe_dadi_df$value[fd_core_dfe_dadi_df$value >= 1E10] = 1E10

# DFE Comparison

# 900 x 2000
ggplot(fd_core_dfe_dadi_df[fd_core_dfe_dadi_df$variable == 'gamma_dfe_dist', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e10)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") +
  xlab('Selection Coefficient') +
  ggtitle('Gamma-distributed DFE * 2Ns, core genes')

ggplot(fd_core_dfe_dadi_df[fd_core_dfe_dadi_df$variable == 'neugamma_dfe_dist', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e10)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") +
  xlab('Selection Coefficient') +
  ggtitle('Neutral+Gamma-distributed DFE * 2Ns, core genes')

# FD DFE comparison

a_muciniphila_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/accessory_inferred_dfe.txt')
a_muciniphila_FD_accessory_dfe_dadi_params$species = 'Akkermansia muciniphila'

a_finegoldii_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_dfe.txt')
a_finegoldii_FD_accessory_dfe_dadi_params$species = 'Alistipes finegoldii'

a_onderdonkii_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_dfe.txt')
a_onderdonkii_FD_accessory_dfe_dadi_params$species = 'Alistipes onderdonkii'

a_putredinis_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_dfe.txt')
a_putredinis_FD_accessory_dfe_dadi_params$species = 'Alistipes putredinis'

a_shahii_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_dfe.txt')
a_shahii_FD_accessory_dfe_dadi_params$species = 'Alistipes shahii'

alistipes_sp_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Alistipes_sp_60764/accessory_inferred_dfe.txt')
alistipes_sp_FD_accessory_dfe_dadi_params$species = 'Alistipes sp.'

b_bacterium_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_dfe.txt')
b_bacterium_FD_accessory_dfe_dadi_params$species = 'Bacteroidales bacterium'

b_caccae_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_dfe.txt')
b_caccae_FD_accessory_dfe_dadi_params$species = 'Bacteroides caccae'

b_cellulosilyticus_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_dfe.txt')
b_cellulosilyticus_FD_accessory_dfe_dadi_params$species = 'Bacteroides cellulosilyticus'

b_coprocola_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_dfe.txt')
b_coprocola_FD_accessory_dfe_dadi_params$species = 'Bacteroides coprocola'

b_eggerthii_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_dfe.txt')
b_eggerthii_FD_accessory_dfe_dadi_params$species = 'Bacteroides eggerthii'

b_fragilis_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_dfe.txt')
b_fragilis_FD_accessory_dfe_dadi_params$species = 'Bacteroides fragilis'

b_massiliensis_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_dfe.txt')
b_massiliensis_FD_accessory_dfe_dadi_params$species = 'Bacteroides massiliensis'

b_ovatus_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_ovatus_58035/accessory_inferred_dfe.txt')
b_ovatus_FD_accessory_dfe_dadi_params$species = 'Bacteroides ovatus'

b_plebeius_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_dfe.txt')
b_plebeius_FD_accessory_dfe_dadi_params$species = 'Bacteroides plebeius'

b_stercoris_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_dfe.txt')
b_stercoris_FD_accessory_dfe_dadi_params$species = 'Bacteroides stercoris'

b_thetaiotaomicron_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_dfe.txt')
b_thetaiotaomicron_FD_accessory_dfe_dadi_params$species = 'Bacteroides thetaiotaomicron'

b_uniformis_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_dfe.txt')
b_uniformis_FD_accessory_dfe_dadi_params$species = 'Bacteroides uniformis'

b_vulgatus_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_dfe.txt')
b_vulgatus_FD_accessory_dfe_dadi_params$species = 'Bacteroides vulgatus'

b_xylanisolvens_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_dfe.txt')
b_xylanisolvens_FD_accessory_dfe_dadi_params$species = 'Bacteroides xylanisolvens'

b_intestinihominis_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_dfe.txt')
b_intestinihominis_FD_accessory_dfe_dadi_params$species = 'Barnesiella intestinihominis'

coprococcus_sp_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_dfe.txt')
coprococcus_sp_FD_accessory_dfe_dadi_params$species = 'Coprococcus sp.'

d_invisus_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_dfe.txt')
d_invisus_FD_accessory_dfe_dadi_params$species = 'Dialister invisus'

e_eligens_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_dfe.txt')
e_eligens_FD_accessory_dfe_dadi_params$species = 'Eubacterium eligens'

e_rectale_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_dfe.txt')
e_rectale_FD_accessory_dfe_dadi_params$species = 'Eubacterium rectale'

e_siraeum_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_dfe.txt')
e_siraeum_FD_accessory_dfe_dadi_params$species = 'Eubacterium siraeum'

f_prausnitzii_57453_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/accessory_inferred_dfe.txt')
f_prausnitzii_57453_FD_accessory_dfe_dadi_params$species = 'Faecalibacterium prausnitzii (57453)'

f_prausnitzii_61481_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/accessory_inferred_dfe.txt')
f_prausnitzii_61481_FD_accessory_dfe_dadi_params$species = 'Faecalibacterium prausnitzii (61481)'

f_prausnitzii_62201_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/accessory_inferred_dfe.txt')
f_prausnitzii_62201_FD_accessory_dfe_dadi_params$species = 'Faecalibacterium prausnitzii (62201)'

l_bacterium_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/accessory_inferred_dfe.txt')
l_bacterium_FD_accessory_dfe_dadi_params$species = 'Lachnospiraceae bacterium'

o_splanchnicus_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_dfe.txt')
o_splanchnicus_FD_accessory_dfe_dadi_params$species = 'Odoribacter splanchnicus'

oscillibacter_sp_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_dfe.txt')
oscillibacter_sp_FD_accessory_dfe_dadi_params$species = 'Oscillibacter sp.'

p_distasonis_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_dfe.txt')
p_distasonis_FD_accessory_dfe_dadi_params$species = 'Parabacteroides distasonis'

p_merdae_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_dfe.txt')
p_merdae_FD_accessory_dfe_dadi_params$species = 'Parabacteroides merdae'

phascolarctobacterium_sp_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_dfe.txt')
phascolarctobacterium_sp_FD_accessory_dfe_dadi_params$species = 'Phascolarctobacterium sp.'

p_copri_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_dfe.txt')
p_copri_FD_accessory_dfe_dadi_params$species = 'Prevotella copri'

r_intestinalis_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_dfe.txt')
r_intestinalis_FD_accessory_dfe_dadi_params$species = 'Roseburia intestinalis'

r_inulinivorans_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_dfe.txt')
r_inulinivorans_FD_accessory_dfe_dadi_params$species = 'Roseburia inulinivorans'

r_bicirculans_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/accessory_inferred_dfe.txt')
r_bicirculans_FD_accessory_dfe_dadi_params$species = 'Ruminococcus bicirculans'

r_bromii_FD_accessory_dfe_dadi_params = read_dfe_dadi_params('../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_dfe.txt')
r_bromii_FD_accessory_dfe_dadi_params$species = 'Ruminococcus bromii'

FD_accessory_dfe_dadi_df = rbind(
  melt(a_putredinis_FD_accessory_dfe_dadi_params),
  melt(a_finegoldii_FD_accessory_dfe_dadi_params),
  melt(a_onderdonkii_FD_accessory_dfe_dadi_params),
  melt(a_shahii_FD_accessory_dfe_dadi_params),
  melt(b_bacterium_FD_accessory_dfe_dadi_params),
  melt(p_distasonis_FD_accessory_dfe_dadi_params),
  melt(p_merdae_FD_accessory_dfe_dadi_params),
  melt(b_cellulosilyticus_FD_accessory_dfe_dadi_params),
  melt(b_stercoris_FD_accessory_dfe_dadi_params),
  melt(b_thetaiotaomicron_FD_accessory_dfe_dadi_params),
  melt(b_caccae_FD_accessory_dfe_dadi_params),
  melt(b_massiliensis_FD_accessory_dfe_dadi_params),
  melt(b_vulgatus_FD_accessory_dfe_dadi_params),
  melt(d_invisus_FD_accessory_dfe_dadi_params),
  melt(e_eligens_FD_accessory_dfe_dadi_params),
  melt(e_rectale_FD_accessory_dfe_dadi_params),
  melt(e_siraeum_FD_accessory_dfe_dadi_params),
  melt(r_bromii_FD_accessory_dfe_dadi_params)
)

FD_accessory_dfe_dadi_df$species = factor(FD_accessory_dfe_dadi_df$species, levels=FD_accessory_phylogenetic_levels)
FD_accessory_dfe_dadi_df <- FD_accessory_dfe_dadi_df[order(FD_accessory_dfe_dadi_df$species), ]


# dfe_df

## Due to Dadi internal scaling which considers genotype
## fitness as (1, 1 + 2sh, 1 + 2s), and the fact that
## we are working with a haploid sample, we
## wish to multiply the _inferred_ s by 2 to get the true
## selective coefficient of the haploid bacteria.
## However, s is for the heterozygote case.

# dfe_df$value = dfe_df$value * 2
FD_accessory_dfe_dadi_df$value[FD_accessory_dfe_dadi_df$value <= 1e-11] = 1e-11
FD_accessory_dfe_dadi_df$value[FD_accessory_dfe_dadi_df$value >= 1E10] = 1E10

ggplot(FD_accessory_dfe_dadi_df[FD_accessory_dfe_dadi_df$variable == 'gamma_dfe_dist', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e10)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") +
  xlab('Selection Coefficient') +
  ggtitle('Gamma-distributed DFE * 2Ns, accessory genes')

ggplot(FD_accessory_dfe_dadi_df[FD_accessory_dfe_dadi_df$variable == 'neugamma_dfe_dist', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e10)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") +
  xlab('Selection Coefficient') +
  ggtitle('Neutral+Gamma-distributed DFE * 2Ns, accessory genes')
# Accessory vs. core DFE comparison

# # FD DFE comparison (core)

a_muciniphila_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt') + ggtitle('A. muciniphila, core genes')
a_finegoldii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt') + ggtitle('A. finegoldii, core genes')
a_onderdonkii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt') + ggtitle('A. onderdonkii, core genes')
a_putredinis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt') + ggtitle('A. putredinis, core genes')
a_shahii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt') + ggtitle('A. shahii, core genes')
alistipes_sp_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt') + ggtitle('Alistipes sp., core genes')
b_bacterium_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt') + ggtitle('B. bacterium, core genes') + theme(plot.title = element_text(colour = "red"))
b_caccae_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt') + ggtitle('B. caccae, core genes') + theme(plot.title = element_text(colour = "red"))
b_cellulosilyticus_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt') + ggtitle('B. cellulosilyticus, core genes') + theme(plot.title = element_text(colour = "red"))
b_coprocola_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt') + ggtitle('B. coprocola, core genes')
b_eggerthii_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt') + ggtitle('B. eggerthii, core genes')
b_fragilis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt') + ggtitle('B. fragilis, core genes')
b_massiliensis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt') + ggtitle('B. massiliensis, core genes')
b_plebeius_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt') + ggtitle('B. plebeius, core genes')
b_stercoris_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt') + ggtitle('B. stercoris, core genes')
b_thetaiotaomicron_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt') + ggtitle('B. thetaiotaomicron, core genes') + theme(plot.title = element_text(colour = "red"))
b_uniformis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt') + ggtitle('B. uniformis, core genes')
b_vulgatus_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt') + ggtitle('B. vulgatus, core genes') + theme(plot.title = element_text(colour = "red"))
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
p_distasonis_fd_core_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt') + ggtitle('P. distasonis, core genes') + theme(plot.title = element_text(colour = "red"))
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
b_bacterium_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt') + ggtitle('B. bacterium, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_caccae_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt') + ggtitle('B. caccae, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_cellulosilyticus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt') + ggtitle('B. cellulosilyticus, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_coprocola_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_coprocola_61586/accessory_inferred_DFE.txt') + ggtitle('B. coprocola, accessory genes')
b_eggerthii_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_eggerthii_54457/accessory_inferred_DFE.txt') + ggtitle('B. eggerthii, accessory genes')
b_fragilis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_fragilis_54507/accessory_inferred_DFE.txt') + ggtitle('B. fragilis, accessory genes')
b_massiliensis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt') + ggtitle('B. massiliensis, accessory genes')
b_plebeius_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_plebeius_61623/accessory_inferred_DFE.txt') + ggtitle('B. plebeius, accessory genes')
b_stercoris_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt') + ggtitle('B. stercoris, accessory genes')
b_thetaiotaomicron_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt') + ggtitle('B. thetaiotaomicron, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_uniformis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt') + ggtitle('B. uniformis, accessory genes')
b_vulgatus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt') + ggtitle('B. vulgatus, accessory genes') + theme(plot.title = element_text(colour = "red"))
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
o_splanchnicus_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/accessory_inferred_DFE.txt') + ggtitle('Oscillibacter sp., accessory genes')
oscillibacter_sp_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Oscillibacter_sp_60799/accessory_inferred_DFE.txt') + ggtitle('Oscillibacter sp., accessory genes')
p_distasonis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt') + ggtitle('P. distasonis, accessory genes') + theme(plot.title = element_text(colour = "red"))
p_merdae_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt') + ggtitle('P. merdae, accessory genes') + theme(plot.title = element_text(colour = "red"))
phascolarctobacterium_sp_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/accessory_inferred_DFE.txt') + ggtitle('Phascolarctobacterium sp., accessory genes')
p_copri_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Prevotella_copri_61740/accessory_inferred_DFE.txt') + ggtitle('P. copri, accessory genes')
r_intestinalis_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Roseburia_intestinalis_56239/accessory_inferred_DFE.txt') + ggtitle('R. intestinalist, accessory genes')
r_inulinivorans_fd_accessory_dfe_plot = plot_core_accessory_dfe('../SupplementaryAnalysis/Roseburia_inulinivorans_61943/accessory_inferred_DFE.txt') + ggtitle('R. inulinivorans, accessory genes')
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
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt') + ggtitle('B. bacterium, core genes') + theme(plot.title = element_text(colour = "red"))
b_caccae_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt') + ggtitle('B. caccae, core genes') + theme(plot.title = element_text(colour = "red"))
b_cellulosilyticus_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt') + ggtitle('B. cellulosilyticus, core genes') + theme(plot.title = element_text(colour = "red"))
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
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt') + ggtitle('B. stercoris, core genes') + theme(plot.title = element_text(colour = "red"))
b_thetaiotaomicron_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt') + ggtitle('B. thetaiotaomicron, core genes') + theme(plot.title = element_text(colour = "red"))
b_uniformis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt') + ggtitle('B. uniformis, core genes')
b_vulgatus_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt') + ggtitle('B. vulgatus, core genes') + theme(plot.title = element_text(colour = "red"))
b_xylanisolvens_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt') + ggtitle('B. xylanisolvens, core genes')
b_intestinihominis_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt') + ggtitle('B. intestinihominis, core genes')
coprococcus_sp_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt') + ggtitle('Coprococcus sp., core genes')
d_invisus_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt') + ggtitle('D. invisus, core genes') + theme(plot.title = element_text(colour = "red"))
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
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt') + ggtitle('P. distasonis, core genes') + theme(plot.title = element_text(colour = "red"))
p_merdae_fd_core_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt') + ggtitle('P. merdae, core genes') + theme(plot.title = element_text(colour = "red"))
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
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt') + ggtitle('R. bromii, core genes') + theme(plot.title = element_text(colour = "red"))

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
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt') + ggtitle('B. bacterium, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_caccae_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt') + ggtitle('B. caccae, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_cellulosilyticus_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt') + ggtitle('B. cellulosilyticus, accessory genes') + theme(plot.title = element_text(colour = "red"))
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
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt') + ggtitle('B. stercoris, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_thetaiotaomicron_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt') + ggtitle('B. thetaiotaomicron, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_uniformis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/accessory_two_epoch_demography.txt') + ggtitle('B. uniformis, accessory genes')
b_vulgatus_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt') + ggtitle('B. vulgatus, accessory genes') + theme(plot.title = element_text(colour = "red"))
b_xylanisolvens_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/accessory_two_epoch_demography.txt') + ggtitle('B. xylanisolvens, accessory genes')
b_intestinihominis_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/accessory_two_epoch_demography.txt') + ggtitle('B. intestinihominis, accessory genes')
coprococcus_sp_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/accessory_two_epoch_demography.txt') + ggtitle('Coprococcus sp., accessory genes')
d_invisus_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt') + ggtitle('D. invisus, accessory genes') + theme(plot.title = element_text(colour = "red"))
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
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt') + ggtitle('P. distasonis, accessory genes') + theme(plot.title = element_text(colour = "red"))
p_merdae_fd_accessory_dadi_dfe_plot = plot_core_accessory_dadi_dfe('../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt') + ggtitle('P. merdae, accessory genes') + theme(plot.title = element_text(colour = "red"))
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
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt') + ggtitle('R. bromii, accessory genes') + theme(plot.title = element_text(colour = "red"))

# 

FD_core_accessory_DFE = alistipes_sp_fd_core_dfe_plot + alistipes_sp_fd_accessory_dfe_plot +
  a_putredinis_fd_core_dfe_plot + a_putredinis_fd_accessory_dfe_plot +
  a_finegoldii_fd_core_dfe_plot + a_finegoldii_fd_accessory_dfe_plot +
  a_onderdonkii_fd_core_dfe_plot + a_onderdonkii_fd_accessory_dfe_plot +
  a_shahii_fd_core_dfe_plot + a_shahii_fd_accessory_dfe_plot +
  b_bacterium_fd_core_dfe_plot + b_bacterium_fd_accessory_dfe_plot +
  o_splanchnicus_fd_core_dfe_plot + o_splanchnicus_fd_accessory_dfe_plot +
  p_distasonis_fd_core_dfe_plot + p_distasonis_fd_accessory_dfe_plot +
  p_merdae_fd_core_dfe_plot + p_merdae_fd_accessory_dfe_plot +
  p_copri_fd_core_dfe_plot + p_copri_fd_accessory_dfe_plot +
  b_fragilis_fd_core_dfe_plot + b_fragilis_fd_accessory_dfe_plot +
  b_cellulosilyticus_fd_core_dfe_plot + b_cellulosilyticus_fd_accessory_dfe_plot +
  b_eggerthii_fd_core_dfe_plot + b_eggerthii_fd_accessory_dfe_plot +
  b_stercoris_fd_core_dfe_plot + b_stercoris_fd_accessory_dfe_plot +
  b_uniformis_fd_core_dfe_plot + b_uniformis_fd_accessory_dfe_plot +
  b_thetaiotaomicron_fd_core_dfe_plot + b_thetaiotaomicron_fd_accessory_dfe_plot +
  b_xylanisolvens_fd_core_dfe_plot + b_xylanisolvens_fd_accessory_dfe_plot +
  b_caccae_fd_core_dfe_plot + b_caccae_fd_accessory_dfe_plot +
  b_massiliensis_fd_core_dfe_plot + b_massiliensis_fd_accessory_dfe_plot +
  b_vulgatus_fd_core_dfe_plot + b_vulgatus_fd_accessory_dfe_plot +
  b_plebeius_fd_core_dfe_plot + b_plebeius_fd_accessory_dfe_plot +
  b_coprocola_fd_core_dfe_plot + b_coprocola_fd_accessory_dfe_plot +
  b_intestinihominis_fd_core_dfe_plot + b_intestinihominis_fd_accessory_dfe_plot +
  a_muciniphila_fd_core_dfe_plot + a_muciniphila_fd_accessory_dfe_plot +
  d_invisus_fd_core_dfe_plot + d_invisus_fd_accessory_dfe_plot +
  phascolarctobacterium_sp_fd_core_dfe_plot + phascolarctobacterium_sp_fd_accessory_dfe_plot +
  e_eligens_fd_core_dfe_plot + e_eligens_fd_accessory_dfe_plot +
  e_rectale_fd_core_dfe_plot + e_rectale_fd_accessory_dfe_plot +
  r_intestinalis_fd_core_dfe_plot + r_intestinalis_fd_accessory_dfe_plot +
  r_inulinivorans_fd_core_dfe_plot + r_inulinivorans_fd_accessory_dfe_plot +
  l_bacterium_fd_core_dfe_plot + l_bacterium_fd_accessory_dfe_plot +
  coprococcus_sp_fd_core_dfe_plot + coprococcus_sp_fd_accessory_dfe_plot +
  oscillibacter_sp_fd_core_dfe_plot + oscillibacter_sp_fd_accessory_dfe_plot +
  r_bromii_fd_core_dfe_plot + r_bromii_fd_accessory_dfe_plot +
  r_bicirculans_fd_core_dfe_plot + r_bicirculans_fd_accessory_dfe_plot +
  e_siraeum_fd_core_dfe_plot + e_siraeum_fd_accessory_dfe_plot +
  f_prausnitzii_57453_fd_core_dfe_plot + f_prausnitzii_57453_fd_accessory_dfe_plot +
  f_prausnitzii_62201_fd_core_dfe_plot + f_prausnitzii_62201_fd_accessory_dfe_plot +
  f_prausnitzii_61481_fd_core_dfe_plot + f_prausnitzii_61481_fd_accessory_dfe_plot +
  plot_layout(ncol=1)

# ggsave(filename='./FD_core_accessory_DFE.png', plot=FD_core_accessory_DFE, width=20, height=225, units="in", limitsize=FALSE)

# FD_core_accessory_DFE_reduced = a_putredinis_fd_core_dfe_plot + a_putredinis_fd_accessory_dfe_plot +
#   a_finegoldii_fd_core_dfe_plot + a_finegoldii_fd_accessory_dfe_plot +
#   a_onderdonkii_fd_core_dfe_plot + a_onderdonkii_fd_accessory_dfe_plot +
#   a_shahii_fd_core_dfe_plot + a_shahii_fd_accessory_dfe_plot +
#   b_bacterium_fd_core_dfe_plot + b_bacterium_fd_accessory_dfe_plot +
#   p_distasonis_fd_core_dfe_plot + p_distasonis_fd_accessory_dfe_plot +
#   p_merdae_fd_core_dfe_plot + p_merdae_fd_accessory_dfe_plot +
#   b_cellulosilyticus_fd_core_dfe_plot + b_cellulosilyticus_fd_accessory_dfe_plot +
#   b_stercoris_fd_core_dfe_plot + b_stercoris_fd_accessory_dfe_plot +
#   b_thetaiotaomicron_fd_core_dfe_plot + b_thetaiotaomicron_fd_accessory_dfe_plot +
#   b_caccae_fd_core_dfe_plot + b_caccae_fd_accessory_dfe_plot +
#   b_massiliensis_fd_core_dfe_plot + b_massiliensis_fd_accessory_dfe_plot +
#   b_vulgatus_fd_core_dfe_plot + b_vulgatus_fd_accessory_dfe_plot +
#   d_invisus_fd_core_dfe_plot + d_invisus_fd_accessory_dfe_plot +
#   e_eligens_fd_core_dfe_plot + e_eligens_fd_accessory_dfe_plot +
#   e_rectale_fd_core_dfe_plot + e_rectale_fd_accessory_dfe_plot +
#   e_siraeum_fd_core_dfe_plot + e_siraeum_fd_accessory_dfe_plot +
#   r_bromii_fd_core_dfe_plot + r_bromii_fd_accessory_dfe_plot +
#   plot_layout(ncol=2)

FD_core_accessory_DFE_reduced = a_putredinis_fd_core_dfe_plot + a_finegoldii_fd_core_dfe_plot +
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

FD_core_accessory_dadi_DFE_reduced = a_putredinis_fd_core_dadi_dfe_plot + a_finegoldii_fd_core_dadi_dfe_plot +
  a_putredinis_fd_accessory_dadi_dfe_plot + a_finegoldii_fd_accessory_dadi_dfe_plot +
  a_onderdonkii_fd_core_dadi_dfe_plot + a_shahii_fd_core_dadi_dfe_plot +
  a_onderdonkii_fd_accessory_dadi_dfe_plot + a_shahii_fd_accessory_dadi_dfe_plot +
  b_bacterium_fd_core_dadi_dfe_plot + p_distasonis_fd_core_dadi_dfe_plot +
  b_bacterium_fd_accessory_dadi_dfe_plot + p_distasonis_fd_accessory_dadi_dfe_plot +
  p_merdae_fd_core_dadi_dfe_plot + b_cellulosilyticus_fd_core_dadi_dfe_plot +
  p_merdae_fd_accessory_dadi_dfe_plot + b_cellulosilyticus_fd_accessory_dadi_dfe_plot +
  b_stercoris_fd_core_dadi_dfe_plot + b_thetaiotaomicron_fd_core_dadi_dfe_plot +
  b_stercoris_fd_accessory_dadi_dfe_plot + b_thetaiotaomicron_fd_accessory_dadi_dfe_plot +
  b_caccae_fd_core_dadi_dfe_plot + b_massiliensis_fd_core_dadi_dfe_plot +
  b_caccae_fd_accessory_dadi_dfe_plot + b_massiliensis_fd_accessory_dadi_dfe_plot +
  b_vulgatus_fd_core_dadi_dfe_plot + d_invisus_fd_core_dadi_dfe_plot +
  b_vulgatus_fd_accessory_dadi_dfe_plot + d_invisus_fd_accessory_dadi_dfe_plot +
  e_eligens_fd_core_dadi_dfe_plot + e_rectale_fd_core_dadi_dfe_plot +
  e_eligens_fd_accessory_dadi_dfe_plot + e_rectale_fd_accessory_dadi_dfe_plot +
  e_siraeum_fd_core_dadi_dfe_plot + r_bromii_fd_core_dadi_dfe_plot +
  e_siraeum_fd_accessory_dadi_dfe_plot + r_bromii_fd_accessory_dadi_dfe_plot +
  plot_layout(ncol=2)

ggsave(filename='./FD_core_accessory_dadi_DFE_reduced.png', 
  plot=FD_core_accessory_dadi_DFE_reduced, 
  width=20, height=40, units="in", limitsize=FALSE, dpi=300)

ggsave(filename='./FD_core_accessory_DFE_reduced.png', 
  plot=FD_core_accessory_DFE_reduced, 
  width=20, height=40, units="in", limitsize=FALSE, dpi=300)

# HR SFS DFE comparison
a_muciniphila_HR_DFE = compare_dfe_sfs(a_muciniphila_HR_nonsyn,
  a_muciniphila_HR_gamma,
  a_muciniphila_HR_neugamma) +
  ggtitle('Akkermansia muciniphila (HR) DFE model fit')

a_finegoldii_HR_DFE = compare_dfe_sfs(a_finegoldii_HR_nonsyn,
  a_finegoldii_HR_gamma,
  a_finegoldii_HR_neugamma) +
  ggtitle('Alistipes finegoldii (HR) DFE model fit')

a_onderdonkii_HR_DFE = compare_dfe_sfs(a_onderdonkii_HR_nonsyn,
  a_onderdonkii_HR_gamma,
  a_onderdonkii_HR_neugamma) +
  ggtitle('Alistipes onderdonkii (HR) DFE model fit')

a_shahii_HR_DFE = compare_dfe_sfs(a_shahii_HR_nonsyn,
  a_shahii_HR_gamma,
  a_shahii_HR_neugamma) +
  ggtitle('Alistipes shahii (HR) DFE model fit')

b_caccae_HR_DFE = compare_dfe_sfs(b_caccae_HR_nonsyn,
  b_caccae_HR_gamma,
  b_caccae_HR_neugamma) +
  ggtitle('Bacteroides caccae (HR) DFE model fit')

b_cellulosilyticus_HR_DFE = compare_dfe_sfs(b_cellulosilyticus_HR_nonsyn,
  b_cellulosilyticus_HR_gamma,
  b_cellulosilyticus_HR_neugamma) +
  ggtitle('Bacteroides cellulosilyticus (HR) DFE model fit')

b_coprocola_HR_DFE = compare_dfe_sfs(b_coprocola_HR_nonsyn,
  b_coprocola_HR_gamma,
  b_coprocola_HR_neugamma) +
  ggtitle('Bacteroides copracola (HR) DFE model fit')

b_eggerthii_HR_DFE = compare_dfe_sfs(b_eggerthii_HR_nonsyn,
  b_eggerthii_HR_gamma,
  b_eggerthii_HR_neugamma) +
  ggtitle('Bacteroides eggerthii (HR) DFE model fit')

b_fragilis_HR_DFE = compare_dfe_sfs(b_fragilis_HR_nonsyn,
  b_fragilis_HR_gamma,
  b_fragilis_HR_neugamma) +
  ggtitle('Bacteroides fragilis (HR) DFE model fit')

b_ovatus_HR_DFE = compare_dfe_sfs(b_ovatus_HR_nonsyn,
  b_ovatus_HR_gamma,
  b_ovatus_HR_neugamma) +
  ggtitle('Bacteroides ovatus (HR) DFE model fit')

b_stercoris_HR_DFE = compare_dfe_sfs(b_stercoris_HR_nonsyn,
  b_stercoris_HR_gamma,
  b_stercoris_HR_neugamma) +
  ggtitle('Bacteroides stercoris (HR) DFE model fit')

b_thetaiotaomicron_HR_DFE = compare_dfe_sfs(b_thetaiotaomicron_HR_nonsyn,
  b_thetaiotaomicron_HR_gamma,
  b_thetaiotaomicron_HR_neugamma) +
  ggtitle('Bacteroides thetaiotaomicron (HR) DFE model fit')

b_vulgatus_HR_DFE = compare_dfe_sfs(b_vulgatus_HR_nonsyn,
  b_vulgatus_HR_gamma,
  b_vulgatus_HR_neugamma) +
  ggtitle('Bacteroides vulgatus (HR) DFE model fit')

d_invisus_HR_DFE = compare_dfe_sfs(d_invisus_HR_nonsyn,
  d_invisus_HR_gamma,
  d_invisus_HR_neugamma) +
  ggtitle('Dialister invisus (HR) DFE model fit')

b_intestinihominis_HR_DFE = compare_dfe_sfs(b_intestinihominis_HR_nonsyn,
  b_intestinihominis_HR_gamma,
  b_intestinihominis_HR_neugamma) +
  ggtitle('Barnesiella intestinihominis (HR) DFE model fit')

e_rectale_HR_DFE = compare_dfe_sfs(e_rectale_HR_nonsyn,
  e_rectale_HR_gamma,
  e_rectale_HR_neugamma) +
  ggtitle('Eubacterium rectale (HR) DFE model fit')

e_siraeum_HR_DFE = compare_dfe_sfs(e_siraeum_HR_nonsyn,
  e_siraeum_HR_gamma,
  e_siraeum_HR_neugamma) +
  ggtitle('Eubacterium siraeum (HR) DFE model fit')

oscillibacter_sp_HR_DFE = compare_dfe_sfs(oscillibacter_sp_HR_nonsyn,
  oscillibacter_sp_HR_gamma,
  oscillibacter_sp_HR_neugamma) +
  ggtitle('Oscillibacter sp. (HR) DFE model fit')

p_distasonis_HR_DFE = compare_dfe_sfs(p_distasonis_HR_nonsyn,
  p_distasonis_HR_gamma,
  p_distasonis_HR_neugamma) +
  ggtitle('Parabacteroides distasonis (HR) DFE model fit')

p_merdae_HR_DFE = compare_dfe_sfs(p_merdae_HR_nonsyn,
  p_merdae_HR_gamma,
  p_merdae_HR_neugamma) +
  ggtitle('Parabacteroides merdae (HR) DFE model fit')

r_bicirculans_HR_DFE = compare_dfe_sfs(r_bicirculans_HR_nonsyn,
  r_bicirculans_HR_gamma,
  r_bicirculans_HR_neugamma) +
  ggtitle('Ruminococcus bicirculans (HR) DFE model fit')

r_bromii_HR_DFE = compare_dfe_sfs(r_bromii_HR_nonsyn,
  r_bromii_HR_gamma,
  r_bromii_HR_neugamma) +
  ggtitle('Ruminococcus bromii (HR) DFE model fit')

# HR_DFE_fit = 
#   b_coprocola_HR_DFE +
#   b_eggerthii_HR_DFE +
#   b_ovatus_HR_DFE +
#   e_siraeum_HR_DFE

HR_DFE_fit = a_finegoldii_HR_DFE +
  a_onderdonkii_HR_DFE +
  a_shahii_HR_DFE +
  p_distasonis_HR_DFE +
  p_merdae_HR_DFE +
  b_fragilis_HR_DFE +
  b_cellulosilyticus_HR_DFE +
  b_stercoris_HR_DFE +
  b_thetaiotaomicron_HR_DFE +
  b_caccae_HR_DFE +
  b_vulgatus_HR_DFE +
  b_intestinihominis_HR_DFE +
  a_muciniphila_HR_DFE +
  d_invisus_HR_DFE +
  e_rectale_HR_DFE +
  oscillibacter_sp_HR_DFE +
  r_bromii_HR_DFE +
  r_bicirculans_HR_DFE +
  plot_layout(ncol=1)

# ggsave(filename='./HR_DFE_fit.png', plot=HR_DFE_fit, width=10, height=150, units='in', limitsize=FALSE)


# FD SFS DFE comparison (core)

a_muciniphila_FD_core_DFE = compare_dfe_sfs(a_muciniphila_FD_core_nonsyn,
  a_muciniphila_FD_gamma_core,
  a_muciniphila_FD_neugamma_core) +
  ggtitle('Akkermansia muciniphila (FD, core) DFE model fit')

a_finegoldii_FD_core_DFE = compare_dfe_sfs(a_finegoldii_FD_core_nonsyn,
  a_finegoldii_FD_gamma_core,
  a_finegoldii_FD_neugamma_core) +
  ggtitle('Alistipes finegoldii (FD, core) DFE model fit')

a_onderdonkii_FD_core_DFE = compare_dfe_sfs(a_onderdonkii_FD_core_nonsyn,
  a_onderdonkii_FD_gamma_core,
  a_onderdonkii_FD_neugamma_core) +
  ggtitle('Alistipes onderdonkii (FD, core) DFE model fit')

a_putredinis_FD_core_DFE = compare_dfe_sfs(a_putredinis_FD_core_nonsyn,
  a_putredinis_FD_gamma_core,
  a_putredinis_FD_neugamma_core) +
  ggtitle('Alistipes putredinis (FD, core) DFE model fit')

a_shahii_FD_core_DFE = compare_dfe_sfs(a_shahii_FD_core_nonsyn,
  a_shahii_FD_gamma_core,
  a_shahii_FD_neugamma_core) +
  ggtitle('Alistipes shahii (FD, core) DFE model fit')

alistipes_sp_FD_core_DFE = compare_dfe_sfs(alistipes_sp_FD_core_nonsyn,
  alistipes_sp_FD_gamma_core,
  alistipes_sp_FD_neugamma_core) +
  ggtitle('Alistipes sp. (FD, core) DFE model fit')

b_bacterium_FD_core_DFE = compare_dfe_sfs(b_bacterium_FD_core_nonsyn,
  b_bacterium_FD_gamma_core,
  b_bacterium_FD_neugamma_core) +
  ggtitle('Bacteroidales bacterium (FD, core) DFE model fit')

b_caccae_FD_core_DFE = compare_dfe_sfs(b_caccae_FD_core_nonsyn,
  b_caccae_FD_gamma_core,
  b_caccae_FD_neugamma_core) +
  ggtitle('Bacteroides caccae (FD, core) DFE model fit')

b_cellulosilyticus_FD_core_DFE = compare_dfe_sfs(b_cellulosilyticus_FD_core_nonsyn,
  b_cellulosilyticus_FD_gamma_core,
  b_cellulosilyticus_FD_neugamma_core) +
  ggtitle('Bacteroides cellulosilyticus (FD, core) DFE model fit')

b_coprocola_FD_core_DFE = compare_dfe_sfs(b_coprocola_FD_core_nonsyn,
  b_coprocola_FD_gamma_core,
  b_coprocola_FD_neugamma_core) +
  ggtitle('Bacteroides coprocola (FD, core) DFE model fit')

b_eggerthii_FD_core_DFE = compare_dfe_sfs(b_eggerthii_FD_core_nonsyn,
  b_eggerthii_FD_gamma_core,
  b_eggerthii_FD_neugamma_core) +
  ggtitle('Bacteroides eggerthii (FD, core) DFE model fit')

b_fragilis_FD_core_DFE = compare_dfe_sfs(b_fragilis_FD_core_nonsyn,
  b_fragilis_FD_gamma_core,
  b_fragilis_FD_neugamma_core) +
  ggtitle('Bacteroides fragilis (FD, core) DFE model fit')

b_massiliensis_FD_core_DFE = compare_dfe_sfs(b_massiliensis_FD_core_nonsyn,
  b_massiliensis_FD_gamma_core,
  b_massiliensis_FD_neugamma_core) +
  ggtitle('Bacteroides massiliensis (FD, core) DFE model fit')

b_ovatus_FD_core_DFE = compare_dfe_sfs(b_ovatus_FD_core_nonsyn,
  b_ovatus_FD_gamma_core,
  b_ovatus_FD_neugamma_core) +
  ggtitle('Bacteroides ovatus (FD, core) DFE model fit')

b_plebeius_FD_core_DFE = compare_dfe_sfs(b_plebeius_FD_core_nonsyn,
  b_plebeius_FD_gamma_core,
  b_plebeius_FD_neugamma_core) +
  ggtitle('Bacteroides plebeius (FD, core) DFE model fit')

b_stercoris_FD_core_DFE = compare_dfe_sfs(b_stercoris_FD_core_nonsyn,
  b_stercoris_FD_gamma_core,
  b_stercoris_FD_neugamma_core) +
  ggtitle('Bacteroides stercoris (FD, core) DFE model fit')

b_thetaiotaomicron_FD_core_DFE = compare_dfe_sfs(b_thetaiotaomicron_FD_core_nonsyn,
  b_thetaiotaomicron_FD_gamma_core,
  b_thetaiotaomicron_FD_neugamma_core) +
  ggtitle('Bacteroides thetaiotaomicron (FD, core) DFE model fit')

b_uniformis_FD_core_DFE = compare_dfe_sfs(b_uniformis_FD_core_nonsyn,
  b_uniformis_FD_gamma_core,
  b_uniformis_FD_neugamma_core) +
  ggtitle('Bacteroides uniformis (FD, core) DFE model fit')

b_vulgatus_FD_core_DFE = compare_dfe_sfs(b_vulgatus_FD_core_nonsyn,
  b_vulgatus_FD_gamma_core,
  b_vulgatus_FD_neugamma_core) +
  ggtitle('Bacteroides vulgatus (FD, core) DFE model fit')

b_xylanisolvens_FD_core_DFE = compare_dfe_sfs(b_xylanisolvens_FD_core_nonsyn,
  b_xylanisolvens_FD_gamma_core,
  b_xylanisolvens_FD_neugamma_core) +
  ggtitle('Bacteroides xylanisolvens (FD, core) DFE model fit')

b_intestinihominis_FD_core_DFE = compare_dfe_sfs(b_intestinihominis_FD_core_nonsyn,
  b_intestinihominis_FD_gamma_core,
  b_intestinihominis_FD_neugamma_core) +
  ggtitle('Barnesiella intestinihominis (FD, core) DFE model fit')

coprococcus_sp_FD_core_DFE = compare_dfe_sfs(coprococcus_sp_FD_core_nonsyn,
  coprococcus_sp_FD_gamma_core,
  coprococcus_sp_FD_neugamma_core) +
  ggtitle('Coprococcus sp. (FD, core) DFE model fit')

d_invisus_FD_core_DFE = compare_dfe_sfs(d_invisus_FD_core_nonsyn,
  d_invisus_FD_gamma_core,
  d_invisus_FD_neugamma_core) +
  ggtitle('Dialister invisus (FD, core) DFE model fit')

e_eligens_FD_core_DFE = compare_dfe_sfs(e_eligens_FD_core_nonsyn,
  e_eligens_FD_gamma_core,
  e_eligens_FD_neugamma_core) +
  ggtitle('Eubacterium eligens (FD, core) DFE model fit')

e_rectale_FD_core_DFE = compare_dfe_sfs(e_rectale_FD_core_nonsyn,
  e_rectale_FD_gamma_core,
  e_rectale_FD_neugamma_core) +
  ggtitle('Eubacterium rectale (FD, core) DFE model fit')

e_siraeum_FD_core_DFE = compare_dfe_sfs(e_siraeum_FD_core_nonsyn,
  e_siraeum_FD_gamma_core,
  e_siraeum_FD_neugamma_core) +
  ggtitle('Eubacterium siraeum (FD, core) DFE model fit')

f_prausnitzii_57453_FD_core_DFE = compare_dfe_sfs(f_prausnitzii_57453_FD_core_nonsyn,
  f_prausnitzii_57453_FD_gamma_core,
  f_prausnitzii_57453_FD_neugamma_core) +
  ggtitle('Faecalibacterium prausnitzii 57453 (FD, core) DFE model fit')

f_prausnitzii_61481_FD_core_DFE = compare_dfe_sfs(f_prausnitzii_61481_FD_core_nonsyn,
  f_prausnitzii_61481_FD_gamma_core,
  f_prausnitzii_61481_FD_neugamma_core) +
  ggtitle('Faecalibacterium prausnitzii 61481 (FD, core) DFE model fit')

f_prausnitzii_62201_FD_core_DFE = compare_dfe_sfs(f_prausnitzii_62201_FD_core_nonsyn,
  f_prausnitzii_62201_FD_gamma_core,
  f_prausnitzii_62201_FD_neugamma_core) +
  ggtitle('Faecalibacterium prausnitzii 62201 (FD, core) DFE model fit')

l_bacterium_FD_core_DFE = compare_dfe_sfs(l_bacterium_FD_core_nonsyn,
  l_bacterium_FD_gamma_core,
  l_bacterium_FD_neugamma_core) +
  ggtitle('Lachnospiraceae bacterium (FD, core) DFE model fit')

o_splanchnicus_FD_core_DFE = compare_dfe_sfs(o_splanchnicus_FD_core_nonsyn,
  o_splanchnicus_FD_gamma_core,
  o_splanchnicus_FD_neugamma_core) +
  ggtitle('Odoribacter splanchnicus (FD, core) DFE model fit')

oscillibacter_sp_FD_core_DFE = compare_dfe_sfs(oscillibacter_sp_FD_core_nonsyn,
  oscillibacter_sp_FD_gamma_core,
  oscillibacter_sp_FD_neugamma_core) +
  ggtitle('Oscillibacter sp. (FD, core) DFE model fit')

p_distasonis_FD_core_DFE = compare_dfe_sfs(p_distasonis_FD_core_nonsyn,
  p_distasonis_FD_gamma_core,
  p_distasonis_FD_neugamma_core) +
  ggtitle('Parabacteroides distasonis (FD, core) DFE model fit')

p_merdae_FD_core_DFE = compare_dfe_sfs(p_merdae_FD_core_nonsyn,
  p_merdae_FD_gamma_core,
  p_merdae_FD_neugamma_core) +
  ggtitle('Parabacteroides merdae (FD, core) DFE model fit')

phascolarctobacterium_sp_FD_core_DFE = compare_dfe_sfs(phascolarctobacterium_sp_FD_core_nonsyn,
  phascolarctobacterium_sp_FD_gamma_core,
  phascolarctobacterium_sp_FD_neugamma_core) +
  ggtitle('Phascolarctobacterium sp. (FD, core) DFE model fit')

p_copri_FD_core_DFE = compare_dfe_sfs(p_copri_FD_core_nonsyn,
  p_copri_FD_gamma_core,
  p_copri_FD_neugamma_core) +
  ggtitle('Prevotella copri (FD, core) DFE model fit')

r_intestinalis_FD_core_DFE = compare_dfe_sfs(r_intestinalis_FD_core_nonsyn,
  r_intestinalis_FD_gamma_core,
  r_intestinalis_FD_neugamma_core) +
  ggtitle('Roseburia intestinalis (FD, core) DFE model fit')

r_inulinivorans_FD_core_DFE = compare_dfe_sfs(r_inulinivorans_FD_core_nonsyn,
  r_inulinivorans_FD_gamma_core,
  r_inulinivorans_FD_neugamma_core) +
  ggtitle('Roseburia inulinivorans (FD, core) DFE model fit')

r_bicirculans_FD_core_DFE = compare_dfe_sfs(r_bicirculans_FD_core_nonsyn,
  r_bicirculans_FD_gamma_core,
  r_bicirculans_FD_neugamma_core) +
  ggtitle('Ruminococcus bicirculans (FD, core) DFE model fit')

r_bromii_FD_core_DFE = compare_dfe_sfs(r_bromii_FD_core_nonsyn,
  r_bromii_FD_gamma_core,
  r_bromii_FD_neugamma_core) +
  ggtitle('Ruminococcus bromii (FD, core) DFE model fit')

FD_core_DFE = alistipes_sp_FD_core_DFE +
  a_putredinis_FD_core_DFE +
  a_finegoldii_FD_core_DFE +
  a_onderdonkii_FD_core_DFE +
  a_shahii_FD_core_DFE +
  b_bacterium_FD_core_DFE +
  o_splanchnicus_FD_core_DFE +
  p_distasonis_FD_core_DFE +
  p_merdae_FD_core_DFE +
  p_copri_FD_core_DFE +
  b_fragilis_FD_core_DFE +
  b_cellulosilyticus_FD_core_DFE +
  b_eggerthii_FD_core_DFE +
  b_stercoris_FD_core_DFE +
  b_uniformis_FD_core_DFE +
  b_thetaiotaomicron_FD_core_DFE +
  b_ovatus_FD_core_DFE +
  b_xylanisolvens_FD_core_DFE +
  b_caccae_FD_core_DFE +
  b_massiliensis_FD_core_DFE +
  b_vulgatus_FD_core_DFE +
  b_plebeius_FD_core_DFE +
  b_coprocola_FD_core_DFE +
  b_intestinihominis_FD_core_DFE +
  a_muciniphila_FD_core_DFE +
  d_invisus_FD_core_DFE +
  phascolarctobacterium_sp_FD_core_DFE +
  e_eligens_FD_core_DFE +
  e_rectale_FD_core_DFE +
  r_intestinalis_FD_core_DFE +
  r_inulinivorans_FD_core_DFE +
  l_bacterium_FD_core_DFE +
  coprococcus_sp_FD_core_DFE +
  oscillibacter_sp_FD_core_DFE +
  r_bromii_FD_core_DFE +
  r_bicirculans_FD_core_DFE +
  e_siraeum_FD_core_DFE +
  f_prausnitzii_57453_FD_core_DFE +
  f_prausnitzii_62201_FD_core_DFE +
  f_prausnitzii_61481_FD_core_DFE +
  plot_layout(ncol=1)

# ggsave(filename='./FD_core_DFE.png', plot=FD_core_DFE, width=10, height=225, units="in", limitsize=FALSE)

# FD SFS DFE comparison (accessory)

a_muciniphila_FD_accessory_DFE = compare_dfe_sfs(a_muciniphila_FD_accessory_nonsyn,
  a_muciniphila_FD_gamma_accessory,
  a_muciniphila_FD_neugamma_accessory) +
  ggtitle('Akkermansia muciniphila (FD, accessory) DFE model fit')

a_finegoldii_FD_accessory_DFE = compare_dfe_sfs(a_finegoldii_FD_accessory_nonsyn,
  a_finegoldii_FD_gamma_accessory,
  a_finegoldii_FD_neugamma_accessory) +
  ggtitle('Alistipes finegoldii (FD, accessory) DFE model fit')

a_onderdonkii_FD_accessory_DFE = compare_dfe_sfs(a_onderdonkii_FD_accessory_nonsyn,
  a_onderdonkii_FD_gamma_accessory,
  a_onderdonkii_FD_neugamma_accessory) +
  ggtitle('Alistipes onderdonkii (FD, accessory) DFE model fit')

a_putredinis_FD_accessory_DFE = compare_dfe_sfs(a_putredinis_FD_accessory_nonsyn,
  a_putredinis_FD_gamma_accessory,
  a_putredinis_FD_neugamma_accessory) +
  ggtitle('Alistipes putredinis (FD, accessory) DFE model fit')

a_shahii_FD_accessory_DFE = compare_dfe_sfs(a_shahii_FD_accessory_nonsyn,
  a_shahii_FD_gamma_accessory,
  a_shahii_FD_neugamma_accessory) +
  ggtitle('Alistipes shahii (FD, accessory) DFE model fit')

alistipes_sp_FD_accessory_DFE = compare_dfe_sfs(alistipes_sp_FD_accessory_nonsyn,
  alistipes_sp_FD_gamma_accessory,
  alistipes_sp_FD_neugamma_accessory) +
  ggtitle('Alistipes sp. (FD, accessory) DFE model fit')

b_bacterium_FD_accessory_DFE = compare_dfe_sfs(b_bacterium_FD_accessory_nonsyn,
  b_bacterium_FD_gamma_accessory,
  b_bacterium_FD_neugamma_accessory) +
  ggtitle('Bacteroidales bacterium (FD, accessory) DFE model fit')

b_caccae_FD_accessory_DFE = compare_dfe_sfs(b_caccae_FD_accessory_nonsyn,
  b_caccae_FD_gamma_accessory,
  b_caccae_FD_neugamma_accessory) +
  ggtitle('Bacteroides caccae (FD, accessory) DFE model fit')

b_cellulosilyticus_FD_accessory_DFE = compare_dfe_sfs(b_cellulosilyticus_FD_accessory_nonsyn,
  b_cellulosilyticus_FD_gamma_accessory,
  b_cellulosilyticus_FD_neugamma_accessory) +
  ggtitle('Bacteroides cellulosilyticus (FD, accessory) DFE model fit')

b_coprocola_FD_accessory_DFE = compare_dfe_sfs(b_coprocola_FD_accessory_nonsyn,
  b_coprocola_FD_gamma_accessory,
  b_coprocola_FD_neugamma_accessory) +
  ggtitle('Bacteroides coprocola (FD, accessory) DFE model fit')

b_eggerthii_FD_accessory_DFE = compare_dfe_sfs(b_eggerthii_FD_accessory_nonsyn,
  b_eggerthii_FD_gamma_accessory,
  b_eggerthii_FD_neugamma_accessory) +
  ggtitle('Bacteroides eggerthii (FD, accessory) DFE model fit')

b_fragilis_FD_accessory_DFE = compare_dfe_sfs(b_fragilis_FD_accessory_nonsyn,
  b_fragilis_FD_gamma_accessory,
  b_fragilis_FD_neugamma_accessory) +
  ggtitle('Bacteroides fragilis (FD, accessory) DFE model fit')

b_massiliensis_FD_accessory_DFE = compare_dfe_sfs(b_massiliensis_FD_accessory_nonsyn,
  b_massiliensis_FD_gamma_accessory,
  b_massiliensis_FD_neugamma_accessory) +
  ggtitle('Bacteroides massiliensis (FD, accessory) DFE model fit')

b_ovatus_FD_accessory_DFE = compare_dfe_sfs(b_ovatus_FD_accessory_nonsyn,
  b_ovatus_FD_gamma_accessory,
  b_ovatus_FD_neugamma_accessory) +
  ggtitle('Bacteroides ovatus (FD, accessory) DFE model fit')

b_plebeius_FD_accessory_DFE = compare_dfe_sfs(b_plebeius_FD_accessory_nonsyn,
  b_plebeius_FD_gamma_accessory,
  b_plebeius_FD_neugamma_accessory) +
  ggtitle('Bacteroides plebeius (FD, accessory) DFE model fit')

b_stercoris_FD_accessory_DFE = compare_dfe_sfs(b_stercoris_FD_accessory_nonsyn,
  b_stercoris_FD_gamma_accessory,
  b_stercoris_FD_neugamma_accessory) +
  ggtitle('Bacteroides stercoris (FD, accessory) DFE model fit')

b_thetaiotaomicron_FD_accessory_DFE = compare_dfe_sfs(b_thetaiotaomicron_FD_accessory_nonsyn,
  b_thetaiotaomicron_FD_gamma_accessory,
  b_thetaiotaomicron_FD_neugamma_accessory) +
  ggtitle('Bacteroides thetaiotaomicron (FD, accessory) DFE model fit')

b_uniformis_FD_accessory_DFE = compare_dfe_sfs(b_uniformis_FD_accessory_nonsyn,
  b_uniformis_FD_gamma_accessory,
  b_uniformis_FD_neugamma_accessory) +
  ggtitle('Bacteroides uniformis (FD, accessory) DFE model fit')

b_vulgatus_FD_accessory_DFE = compare_dfe_sfs(b_vulgatus_FD_accessory_nonsyn,
  b_vulgatus_FD_gamma_accessory,
  b_vulgatus_FD_neugamma_accessory) +
  ggtitle('Bacteroides vulgatus (FD, accessory) DFE model fit')

b_xylanisolvens_FD_accessory_DFE = compare_dfe_sfs(b_xylanisolvens_FD_accessory_nonsyn,
  b_xylanisolvens_FD_gamma_accessory,
  b_xylanisolvens_FD_neugamma_accessory) +
  ggtitle('Bacteroides xylanisolvens (FD, accessory) DFE model fit')

b_intestinihominis_FD_accessory_DFE = compare_dfe_sfs(b_intestinihominis_FD_accessory_nonsyn,
  b_intestinihominis_FD_gamma_accessory,
  b_intestinihominis_FD_neugamma_accessory) +
  ggtitle('Barnesiella intestinihominis (FD, accessory) DFE model fit')

coprococcus_sp_FD_accessory_DFE = compare_dfe_sfs(coprococcus_sp_FD_accessory_nonsyn,
  coprococcus_sp_FD_gamma_accessory,
  coprococcus_sp_FD_neugamma_accessory) +
  ggtitle('Coprococcus sp. (FD, accessory) DFE model fit')

d_invisus_FD_accessory_DFE = compare_dfe_sfs(d_invisus_FD_accessory_nonsyn,
  d_invisus_FD_gamma_accessory,
  d_invisus_FD_neugamma_accessory) +
  ggtitle('Dialister invisus (FD, accessory) DFE model fit')

e_eligens_FD_accessory_DFE = compare_dfe_sfs(e_eligens_FD_accessory_nonsyn,
  e_eligens_FD_gamma_accessory,
  e_eligens_FD_neugamma_accessory) +
  ggtitle('Eubacterium eligens (FD, accessory) DFE model fit')

e_rectale_FD_accessory_DFE = compare_dfe_sfs(e_rectale_FD_accessory_nonsyn,
  e_rectale_FD_gamma_accessory,
  e_rectale_FD_neugamma_accessory) +
  ggtitle('Eubacterium rectale (FD, accessory) DFE model fit')

e_siraeum_FD_accessory_DFE = compare_dfe_sfs(e_siraeum_FD_accessory_nonsyn,
  e_siraeum_FD_gamma_accessory,
  e_siraeum_FD_neugamma_accessory) +
  ggtitle('Eubacterium siraeum (FD, accessory) DFE model fit')

f_prausnitzii_57453_FD_accessory_DFE = compare_dfe_sfs(f_prausnitzii_57453_FD_accessory_nonsyn,
  f_prausnitzii_57453_FD_gamma_accessory,
  f_prausnitzii_57453_FD_neugamma_accessory) +
  ggtitle('Faecalibacterium prausnitzii 57453 (FD, accessory) DFE model fit')

f_prausnitzii_61481_FD_accessory_DFE = compare_dfe_sfs(f_prausnitzii_61481_FD_accessory_nonsyn,
  f_prausnitzii_61481_FD_gamma_accessory,
  f_prausnitzii_61481_FD_neugamma_accessory) +
  ggtitle('Faecalibacterium prausnitzii 61481 (FD, accessory) DFE model fit')

f_prausnitzii_62201_FD_accessory_DFE = compare_dfe_sfs(f_prausnitzii_62201_FD_accessory_nonsyn,
  f_prausnitzii_62201_FD_gamma_accessory,
  f_prausnitzii_62201_FD_neugamma_accessory) +
  ggtitle('Faecalibacterium prausnitzii 62201 (FD, accessory) DFE model fit')

l_bacterium_FD_accessory_DFE = compare_dfe_sfs(l_bacterium_FD_accessory_nonsyn,
  l_bacterium_FD_gamma_accessory,
  l_bacterium_FD_neugamma_accessory) +
  ggtitle('Lachnospiraceae bacterium (FD, accessory) DFE model fit')

o_splanchnicus_FD_accessory_DFE = compare_dfe_sfs(o_splanchnicus_FD_accessory_nonsyn,
  o_splanchnicus_FD_gamma_accessory,
  o_splanchnicus_FD_neugamma_accessory) +
  ggtitle('Odoribacter splanchnicus (FD, accessory) DFE model fit')

oscillibacter_sp_FD_accessory_DFE = compare_dfe_sfs(oscillibacter_sp_FD_accessory_nonsyn,
  oscillibacter_sp_FD_gamma_accessory,
  oscillibacter_sp_FD_neugamma_accessory) +
  ggtitle('Oscillibacter sp. (FD, accessory) DFE model fit')

p_distasonis_FD_accessory_DFE = compare_dfe_sfs(p_distasonis_FD_accessory_nonsyn,
  p_distasonis_FD_gamma_accessory,
  p_distasonis_FD_neugamma_accessory) +
  ggtitle('Parabacteroides distasonis (FD, accessory) DFE model fit')

p_merdae_FD_accessory_DFE = compare_dfe_sfs(p_merdae_FD_accessory_nonsyn,
  p_merdae_FD_gamma_accessory,
  p_merdae_FD_neugamma_accessory) +
  ggtitle('Parabacteroides merdae (FD, accessory) DFE model fit')

phascolarctobacterium_sp_FD_accessory_DFE = compare_dfe_sfs(phascolarctobacterium_sp_FD_accessory_nonsyn,
  phascolarctobacterium_sp_FD_gamma_accessory,
  phascolarctobacterium_sp_FD_neugamma_accessory) +
  ggtitle('Phascolarctobacterium sp. (FD, accessory) DFE model fit')

p_copri_FD_accessory_DFE = compare_dfe_sfs(p_copri_FD_accessory_nonsyn,
  p_copri_FD_gamma_accessory,
  p_copri_FD_neugamma_accessory) +
  ggtitle('Prevotella copri (FD, accessory) DFE model fit')

r_intestinalis_FD_accessory_DFE = compare_dfe_sfs(r_intestinalis_FD_accessory_nonsyn,
  r_intestinalis_FD_gamma_accessory,
  r_intestinalis_FD_neugamma_accessory) +
  ggtitle('Roseburia intestinalis (FD, accessory) DFE model fit')

r_inulinivorans_FD_accessory_DFE = compare_dfe_sfs(r_inulinivorans_FD_accessory_nonsyn,
  r_inulinivorans_FD_gamma_accessory,
  r_inulinivorans_FD_neugamma_accessory) +
  ggtitle('Roseburia inulinivorans (FD, accessory) DFE model fit')

r_bicirculans_FD_accessory_DFE = compare_dfe_sfs(r_bicirculans_FD_accessory_nonsyn,
  r_bicirculans_FD_gamma_accessory,
  r_bicirculans_FD_neugamma_accessory) +
  ggtitle('Ruminococcus bicirculans (FD, accessory) DFE model fit')

r_bromii_FD_accessory_DFE = compare_dfe_sfs(r_bromii_FD_accessory_nonsyn,
  r_bromii_FD_gamma_accessory,
  r_bromii_FD_neugamma_accessory) +
  ggtitle('Ruminococcus bromii (FD, accessory) DFE model fit')

FD_accessory_DFE = alistipes_sp_FD_accessory_DFE +
  a_putredinis_FD_accessory_DFE +
  a_finegoldii_FD_accessory_DFE +
  a_onderdonkii_FD_accessory_DFE +
  a_shahii_FD_accessory_DFE +
  b_bacterium_FD_accessory_DFE +
  o_splanchnicus_FD_accessory_DFE +
  p_distasonis_FD_accessory_DFE +
  p_merdae_FD_accessory_DFE +
  p_copri_FD_accessory_DFE +
  b_fragilis_FD_accessory_DFE +
  b_cellulosilyticus_FD_accessory_DFE +
  b_eggerthii_FD_accessory_DFE +
  b_stercoris_FD_accessory_DFE +
  b_uniformis_FD_accessory_DFE +
  b_thetaiotaomicron_FD_accessory_DFE +
  b_ovatus_FD_accessory_DFE +
  b_xylanisolvens_FD_accessory_DFE +
  b_caccae_FD_accessory_DFE +
  b_massiliensis_FD_accessory_DFE +
  b_vulgatus_FD_accessory_DFE +
  b_plebeius_FD_accessory_DFE +
  b_coprocola_FD_accessory_DFE +
  b_intestinihominis_FD_accessory_DFE +
  a_muciniphila_FD_accessory_DFE +
  d_invisus_FD_accessory_DFE +
  phascolarctobacterium_sp_FD_accessory_DFE +
  e_eligens_FD_accessory_DFE +
  e_rectale_FD_accessory_DFE +
  r_intestinalis_FD_accessory_DFE +
  r_inulinivorans_FD_accessory_DFE +
  l_bacterium_FD_accessory_DFE +
  coprococcus_sp_FD_accessory_DFE +
  oscillibacter_sp_FD_accessory_DFE +
  r_bromii_FD_accessory_DFE +
  r_bicirculans_FD_accessory_DFE +
  e_siraeum_FD_accessory_DFE +
  f_prausnitzii_57453_FD_accessory_DFE +
  f_prausnitzii_62201_FD_accessory_DFE +
  f_prausnitzii_61481_FD_accessory_DFE +
  plot_layout(ncol=1)

# ggsave(filename='./FD_accessory_DFE.png', plot=FD_accessory_DFE, width=10, height=225, units="in", limitsize=FALSE)


shared_species_df = data.frame(species=shared_species_list,
  HR_nu_mle = numeric(18),
  FD_nu_mle = numeric(18),
  HR_time_mle = numeric(18),
  FD_time_mle = numeric(18),
  HR_tau_mle = numeric(18),
  FD_tau_mle = numeric(18),
  HR_nanc = numeric(18),
  FD_nanc = numeric(18),
  HR_shape = numeric(18),
  FD_shape = numeric(18),
  HR_scale = numeric(18),
  FD_scale = numeric(18),
  HR_mean_s = numeric(18),
  FD_mean_s = numeric(18),
  HR_allele_sum = numeric(18),
  FD_allele_sum = numeric(18)
)

for (i in 1:length(shared_species_list)) {
  # nu_mle
  ## HR
  shared_species_df[i, 2] = return_nu_mle(hr_likelihood_surface_list[i])
  ## FD
  shared_species_df[i, 3] = return_nu_mle(fd_shared_likelihood_surface_list[i])
  # tau_mle
  ## HR
  shared_species_df[i, 4] = return_time_mle(hr_likelihood_surface_list[i],
    hr_downsampled_sfs_list[i],
    hr_demography_file_list[i])
  ## FD
  shared_species_df[i, 5] = return_time_mle(fd_shared_likelihood_surface_list[i],
    fd_shared_sfs_list[i],
    fd_shared_demography_file_list[i])
  # Tau
  shared_species_df[i, 6] = return_tau_mle(hr_likelihood_surface_list[i])
  shared_species_df[i, 7] = return_tau_mle(fd_shared_likelihood_surface_list[i])
  # Nanc
  ## HR
  shared_species_df[i, 8] = nanc_from_demography(hr_demography_file_list[i])
  ## FD
  shared_species_df[i, 9] = nanc_from_demography(fd_shared_demography_file_list[i])
  # shape
  ## HR
  shared_species_df[i, 10] = return_shape_from_dfe(hr_dfe_file_list[i])
  ## FD
  shared_species_df[i, 11] = return_shape_from_dfe(fd_shared_dfe_file_list[i])
  # scale
  ## HR
  shared_species_df[i, 12] = return_scale_from_dfe(hr_dfe_file_list[i])
  ## FD
  shared_species_df[i, 13] = return_scale_from_dfe(fd_core_dfe_file_list[i])
  # Mean s
  ## HR
  shared_species_df[i, 14] = mean(read_dfe_params(hr_dfe_file_list[i])$gamma_dfe_dist_high)
  ## FD
  shared_species_df[i, 15] = mean(read_dfe_params(fd_shared_dfe_file_list[i])$gamma_dfe_dist_high)
  # Allele sum
  ## HR
  shared_species_df[i, 16] = return_allele_sum(hr_downsampled_sfs_list[i])
  ## FD
  shared_species_df[i, 17] = return_allele_sum(fd_shared_sfs_list[i])
}

shared_species_df

shared_species_df$species = factor(shared_species_df$species, levels=HR_phylogenetic_levels)

shared_species_df <- shared_species_df[order(shared_species_df$species), ]

shared_species_df

shared_species_df$HR_2ns = shared_species_df$HR_nanc * 2 * shared_species_df$HR_mean_s
shared_species_df$FD_2ns = shared_species_df$FD_nanc * 2 * shared_species_df$FD_mean_s

nu_comparison = c('FD_nu_mle', 'HR_nu_mle')

t.test(shared_species_df$FD_nu_mle, shared_species_df$HR_nu_mle, paired=TRUE)

HR_FD_nu_mle_scatter = ggscatter(shared_species_df, x="FD_nu_mle", y="HR_nu_mle", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-2, 1E4)) +
  scale_y_log10(limits=c(1E-2, 1E4)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Maximum likelihood estimate of Nu') +
  theme(plot.title=element_text(size=22))

HR_FD_nu_mle_scatter

HR_FD_time_mle_scatter = ggscatter(shared_species_df, x="FD_time_mle", y="HR_time_mle", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E2, 1E6)) +
  scale_y_log10(limits=c(1E2, 1E6)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Maximum likelihood estimate of Time (years)') +
  theme(plot.title=element_text(size=22))

HR_FD_time_mle_scatter

HR_FD_tau_mle_scatter = ggscatter(shared_species_df, x="FD_tau_mle", y="HR_tau_mle", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-1, 1E4)) +
  scale_y_log10(limits=c(1E-1, 1E4)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Maximum likelihood estimate of tau') +
  theme(plot.title=element_text(size=22))

HR_FD_tau_mle_scatter

HR_FD_nanc_scatter = ggscatter(shared_species_df, x="FD_nanc", y="HR_nanc", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(3E6, 3E8)) +
  scale_y_log10(limits=c(3E6, 3E8)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Effective ancestral population size') +
  theme(plot.title=element_text(size=22))

HR_FD_nanc_scatter

HR_FD_shape_scatter = ggscatter(shared_species_df, x="FD_shape", y="HR_shape", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(0.003, 2.00)) +
  scale_y_log10(limits=c(0.003, 2.00)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Gamma-distributed DFE shape parameter') +
  theme(plot.title=element_text(size=22))

HR_FD_shape_scatter

HR_FD_scale_scatter = ggscatter(shared_species_df, x="FD_scale", y="HR_scale", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-14, 1E3)) +
  scale_y_log10(limits=c(1E-14, 1E3)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Gamma-distributed DFE scale parameter') +
  theme(plot.title=element_text(size=22))

HR_FD_scale_scatter

HR_FD_mean_s_scatter = ggscatter(shared_species_df, x="FD_mean_s", y="HR_mean_s", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-14, 1E3)) +
  scale_y_log10(limits=c(1E-14, 1E3)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Gamma-distributed DFE mean selection coefficient') +
  theme(plot.title=element_text(size=22))

HR_FD_mean_s_scatter

HR_FD_2ns_scatter = ggscatter(shared_species_df, x="FD_2ns", y="HR_2ns", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(1E-8, 1E10)) +
  scale_y_log10(limits=c(1E-8, 1E10)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Estimated 2ns of gamma-distributed DFE') +
  theme(plot.title=element_text(size=22))

HR_FD_2ns_scatter

HR_FD_allele_count_scatter = ggscatter(shared_species_df, x="FD_allele_sum", y="HR_allele_sum", color='species', size=3) +
  ylab('Low recombination sites and selective sweeps removed') +
  xlab('Full data') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=6) +
  scale_x_log10(limits=c(9E4, 5E5)) +
  scale_y_log10(limits=c(9E4, 5E5)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=18),
    axis.title=element_blank()) +
  ggtitle('Number of sites included in SFS') +
  theme(plot.title=element_text(size=22))

HR_FD_allele_count_scatter

# nu
summary(lm(shared_species_df$FD_nu_mle ~ shared_species_df$HR_nu_mle))$r.squared
cor(shared_species_df$FD_nu_mle, shared_species_df$HR_nu_mle)


# tau
summary(lm(shared_species_df$FD_tau_mle ~ shared_species_df$HR_tau_mle))$r.squared

# mean s
summary(lm(shared_species_df$FD_mean_s ~ shared_species_df$HR_mean_s))$r.squared

# shape
summary(lm(shared_species_df$FD_shape ~ shared_species_df$HR_shape))$r.squared

# scale
summary(lm(shared_species_df$FD_scale ~ shared_species_df$HR_scale))$r.squared

# nanc
summary(lm(shared_species_df$FD_nanc ~ shared_species_df$HR_nanc))$r.squared

# design = "
# AABCDE
# AAFGHI
# "
# 
# difference_plot + 
#   HR_FD_nu_mle_scatter + HR_FD_time_mle_scatter +
#   HR_FD_nanc_scatter + HR_FD_allele_count_scatter +
#   HR_FD_mean_s_scatter + HR_FD_2ns_scatter +
#   HR_FD_shape_scatter + HR_FD_scale_scatter +
#   plot_layout(design=design)

HR_FD_param_scatter = HR_FD_nu_mle_scatter + theme(axis.title=element_blank()) +
  HR_FD_time_mle_scatter + theme(axis.title=element_blank()) +
  HR_FD_nanc_scatter + theme(axis.title=element_blank()) +
  HR_FD_mean_s_scatter + theme(axis.title=element_blank()) +
  HR_FD_shape_scatter + theme(axis.title=element_blank()) +
  HR_FD_scale_scatter + theme(axis.title=element_blank()) +
  plot_layout(ncol=3)

ggsave('../Summary/HR_FD_param_scatter.svg', HR_FD_param_scatter, width=24, height=16, units='in', dpi=600)

# Accessory vs. Core (FD)

supplementary_species_df = data.frame(species=supplementary_species_list,
  FD_accessory_nu_mle = numeric(39),
  FD_core_nu_mle = numeric(39),
  FD_accessory_time_mle = numeric(39),
  FD_core_time_mle = numeric(39),
  FD_accessory_tau_mle = numeric(39),
  FD_core_tau_mle = numeric(39),
  FD_accessory_nanc = numeric(39),
  FD_core_nanc = numeric(39),
  FD_accessory_shape = numeric(39),
  FD_core_shape = numeric(39),
  FD_accessory_scale = numeric(39),
  FD_core_scale = numeric(39),
  FD_accessory_mean_s = numeric(39),
  FD_core_mean_s = numeric(39)
)

for (i in 1:length(supplementary_species_list)) {
  # nu_mle
  ## HR
  supplementary_species_df[i, 2] = return_nu_mle(fd_accessory_likelihood_surface_list[i])
  ## FD
  supplementary_species_df[i, 3] = return_nu_mle(fd_core_likelihood_surface_list[i])
  # tau_mle
  ## HR
  supplementary_species_df[i, 4] = return_time_mle(fd_accessory_likelihood_surface_list[i],
    fd_accessory_sfs_list[i],
    fd_accessory_demography_file_list[i])
  ## FD
  supplementary_species_df[i, 5] = return_time_mle(fd_core_likelihood_surface_list[i],
    fd_core_sfs_list[i],
    fd_core_demography_file_list[i])
  # Tau
  supplementary_species_df[i, 6] = return_tau_mle(fd_accessory_likelihood_surface_list[i])
  supplementary_species_df[i, 7] = return_tau_mle(fd_core_likelihood_surface_list[i])
  # Nanc
  ## HR
  supplementary_species_df[i, 8] = nanc_from_demography(fd_accessory_demography_file_list[i])
  ## FD
  supplementary_species_df[i, 9] = nanc_from_demography(fd_core_demography_file_list[i])
  # shape
  ## HR
  supplementary_species_df[i, 10] = return_shape_from_dfe(fd_accessory_dfe_file_list[i])
  ## FD
  supplementary_species_df[i, 11] = return_shape_from_dfe(fd_core_dfe_file_list[i])
  # scale
  ## HR
  supplementary_species_df[i, 12] = return_scale_from_dfe(fd_accessory_dfe_file_list[i])
  ## FD
  supplementary_species_df[i, 13] = return_scale_from_dfe(fd_core_dfe_file_list[i])
  # Mean s
  ## HR
  supplementary_species_df[i, 14] = compute_selection_coefficients(fd_accessory_dfe_file_list[i])[1]
  ## FD
  supplementary_species_df[i, 15] = compute_selection_coefficients(fd_core_dfe_file_list[i])[1]
}

supplementary_species_df

supplementary_species_df$species = factor(supplementary_species_df$species, levels=FD_phylogenetic_levels)

supplementary_species_df <- supplementary_species_df[order(supplementary_species_df$species), ]

supplementary_species_df

supplementary_species_df[1, ]

core_accessory_df = supplementary_species_df[c(2, 3, 4, 5, 6, 8, 9, 12, 14, 16, 18, 19, 20, 25, 27, 28, 34, 36), ]

FD_accessory_core_nu_mle_scatter = ggscatter(core_accessory_df, x="FD_core_nu_mle", y="FD_accessory_nu_mle", color='species', size=3) +
  ylab('Full data (accessory genome)') +
  xlab('Full data (core genome)') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  scale_x_log10(limit=c(1E-5, 1E4)) +
  scale_y_log10(limit=c(1E-5, 1E4)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Maximum likelihood estimate of Nu')

FD_accessory_core_nu_mle_scatter

summary(lm(core_accessory_df$FD_core_nu_mle ~ core_accessory_df$FD_accessory_nu_mle))$r.squared

FD_accessory_core_time_mle_scatter = ggscatter(core_accessory_df, x="FD_core_time_mle", y="FD_accessory_time_mle", color='species', size=3) +
  ylab('Full data (accessory genome)') +
  xlab('Full data (core genome)') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  scale_x_log10(limit=c(1E-1, 1E6)) +
  scale_y_log10(limit=c(1E-1, 1E6)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Maximum likelihood estimate of Time (years)')

FD_accessory_core_time_mle_scatter

summary(lm(core_accessory_df$FD_core_time_mle ~ core_accessory_df$FD_accessory_time_mle))$r.squared

FD_accessory_core_tau_mle_scatter = ggscatter(core_accessory_df, x="FD_core_tau_mle", y="FD_accessory_tau_mle", color='species', size=3) +
  ylab('Full data (accessory genome)') +
  xlab('Full data (core genome)') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  scale_x_log10() +
  scale_y_log10() +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Maximum likelihood estimate of tau')

FD_accessory_core_tau_mle_scatter

summary(lm(core_accessory_df$FD_core_tau_mle ~ core_accessory_df$FD_accessory_tau_mle))$r.squared

FD_accessory_core_nanc_scatter = ggscatter(core_accessory_df, x="FD_core_nanc", y="FD_accessory_nanc", color='species', size=3) +
  ylab('Full data (accessory genome)') +
  xlab('Full data (core genome)') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  scale_x_log10(limit=c(1E5, 1E10)) +
  scale_y_log10(limit=c(1E5, 1E10)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Effective ancestral population size')

FD_accessory_core_nanc_scatter

summary(lm(core_accessory_df$FD_core_nanc ~ core_accessory_df$FD_accessory_nanc))$r.squared

FD_accessory_core_shape_scatter = ggscatter(core_accessory_df, x="FD_core_shape", y="FD_accessory_shape", color='species', size=3) +
  ylab('Full data (accessory genome)') +
  xlab('Full data (core genome)') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  scale_x_log10(limit=c(1E-5, 1E3)) +
  scale_y_log10(limit=c(1E-5, 1E3)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Gamma-distributed DFE shape parameter')

FD_accessory_core_shape_scatter

summary(lm(core_accessory_df$FD_core_shape ~ core_accessory_df$FD_accessory_scale))$r.squared

FD_accessory_core_scale_scatter = ggscatter(core_accessory_df, x="FD_core_scale", y="FD_accessory_scale", color='species', size=3) +
  ylab('Full data (accessory genome)') +
  xlab('Full data (core genome)') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  scale_x_log10(limit=c(1E-14, 1E3)) +
  scale_y_log10(limit=c(1E-14, 1E3)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Gamma-distributed DFE scale parameter')

FD_accessory_core_scale_scatter

summary(lm(core_accessory_df$FD_core_scale ~ core_accessory_df$FD_accessory_scale))$r.squared

FD_accessory_core_mean_s_scatter = ggscatter(core_accessory_df, x="FD_core_mean_s", y="FD_accessory_mean_s", color='species', size=3) +
  ylab('Full data (accessory genome)') +
  xlab('Full data (core genome)') +
  geom_text_repel(aes(label = species, color=species, fontface = 'italic'), size=4) +
  scale_x_log10(limit=c(1E-18, 1E3)) +
  scale_y_log10(limit=c(1E-18, 1E3)) +
  guides(color=guide_legend(title="species")) +
  theme(legend.position = 'none') +
  guides(color = 'none') +
  guides(shape = 'none') +
  geom_abline(slope=1, intercept=0) +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=16)) +
  ggtitle('Gamma-distributed DFE mean selection coefficient')

FD_accessory_core_mean_s_scatter

summary(lm(core_accessory_df$FD_core_mean_s ~ core_accessory_df$FD_accessory_mean_s))$r.squared

FD_accessory_core_param_scatter = FD_accessory_core_nu_mle_scatter + FD_accessory_core_time_mle_scatter + FD_accessory_core_nanc_scatter +
  FD_accessory_core_mean_s_scatter + FD_accessory_core_shape_scatter + FD_accessory_core_scale_scatter +
  plot_layout(ncol=3)

ggsave('../Summary/FD_accessory_core_param_scatter.svg', FD_accessory_core_param_scatter, width=24, height=16, units='in', dpi=600)


# Delta n_Anc
delta_nanc_df = data.frame(shared_species_df$species, shared_species_df$FD_nanc - shared_species_df$HR_nanc)

names(delta_nanc_df) = c('species', 'delta_nanc')
delta_nanc_df

ggplot(delta_nanc_df, aes(x = reorder(species, delta_nanc), y=delta_nanc)) +
  geom_bar(stat = 'identity') +
  labs(title = 'Change in estimated ancestral effective population size',
    x='Species',
    y='Delta N_Anc when removing low recombination sites') +
  coord_flip() +
  theme_minimal()

recombination_percentiles_df = read.csv('../HighRecombinationAnalysis/recombination_percentiles.csv', header = TRUE)

recombination_percentiles_df

recombination_percentiles_df$ratio = recombination_percentiles_df$third_quartile / recombination_percentiles_df$first_quartile

recombination_percentiles_df

ggplot(recombination_percentiles_df, aes(x=reorder(species, ratio), y=first_quartile)) +
  geom_bar(stat = 'identity') +
  labs(title = 'First quartile of recombination rate by species',
    x='Species',
    y='Recombination events / base pair of core genome') +
  coord_flip() +
  ylim(0, 0.03) +
  theme_minimal()

ggplot(recombination_percentiles_df, aes(x=reorder(species, ratio), y=median)) +
  geom_bar(stat = 'identity') +
  labs(title = 'Median recombination rate by species',
    x='Species',
    y='Recombination events / base pair of core genome') +
  coord_flip() +
  ylim(0, 0.03) +
  theme_minimal()

ggplot(recombination_percentiles_df, aes(x=reorder(species, ratio), y=third_quartile)) +
  geom_bar(stat = 'identity') +
  labs(title = 'Third quartile of recombination rate by species',
    x='Species',
    y='Recombination events / base pair of core genome') +
  coord_flip() +
  ylim(0, 0.03) +
  theme_minimal()

ggplot(recombination_percentiles_df, aes(x=reorder(species, ratio), y=ratio)) +
  geom_bar(stat = 'identity') +
  labs(title = '75th percentile divided by 25th percentile recombination rate by species',
    x='Species',
    y='Ratio of third and first quantile recombination rates') +
  coord_flip() +
  theme_minimal()

# Plot DFE Grid

DFE_grid_file_list = c(
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_sp_60764_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_finegoldii_56071_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_onderdonkii_55464_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_shahii_62199_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_putredinis_61533_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroidales_bacterium_58650_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Odoribacter_splanchnicus_62174_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_merdae_56972_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Prevotella_copri_61740_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_fragilis_54507_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_eggerthii_54457_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_stercoris_56735_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_uniformis_57318_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_xylanisolvens_57185_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_caccae_53434_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_massiliensis_44749_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_plebeius_61623_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_coprocola_61586_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Akkermansia_muciniphila_55290_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Dialister_invisus_61905_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Phascolarctobacterium_sp_59817_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_eligens_61678_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Roseburia_inulinivorans_61943_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Roseburia_intestinalis_56239_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Lachnospiraceae_bacterium_51870_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Coprococcus_sp_62244_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Oscillibacter_sp_60799_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Ruminococcus_bromii_62047_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Ruminococcus_bicirculans_59300_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_siraeum_57634_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Faecalibacterium_prausnitzii_62201_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Faecalibacterium_prausnitzii_61481_likelihood_surface.csv'
)


# for (species in DFE_grid_file_list) {
#   print(species)s
#   find_dfe_mle(species)
# }
# 
# cross_species_dfe_comparison(
#   DFE_grid_file_list[1],
#   DFE_grid_file_list[2]
# )

# dfe_comparison_matrix = matrix(, nrow=39, ncol=39)
# 
# for (i in 1:39) {
#   for (j in i:39) {  # This change ensures only the upper right triangle is compared
#     print(DFE_grid_file_list[i])
#     print(DFE_grid_file_list[j])
#     comparison = cross_species_dfe_comparison(DFE_grid_file_list[i], DFE_grid_file_list[j])
#     print(comparison)
#     dfe_comparison_matrix[i, j] = comparison
#     dfe_comparison_matrix[j, i] = comparison  # Mirror the value across the diagonal
#   }
# }

DFE_grid_file_list_constant_s = c(
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_sp_60764_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_finegoldii_56071_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_onderdonkii_55464_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_shahii_62199_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_putredinis_61533_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroidales_bacterium_58650_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Odoribacter_splanchnicus_62174_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_merdae_56972_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Prevotella_copri_61740_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_fragilis_54507_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_eggerthii_54457_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_stercoris_56735_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_uniformis_57318_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_xylanisolvens_57185_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_caccae_53434_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_massiliensis_44749_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_plebeius_61623_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_coprocola_61586_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Akkermansia_muciniphila_55290_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Dialister_invisus_61905_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Phascolarctobacterium_sp_59817_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_eligens_61678_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Roseburia_inulinivorans_61943_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Roseburia_intestinalis_56239_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Lachnospiraceae_bacterium_51870_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Coprococcus_sp_62244_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Oscillibacter_sp_60799_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Ruminococcus_bromii_62047_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Ruminococcus_bicirculans_59300_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_siraeum_57634_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Faecalibacterium_prausnitzii_62201_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Faecalibacterium_prausnitzii_61481_constant_s_likelihood_surface.csv'
)

# for (species in DFE_grid_file_list_constant_s) {
#   print(species)
#   find_dfe_mle(species)
# }
# 
# cross_species_dfe_comparison(
#   DFE_grid_file_list_constant_s[1],
#   DFE_grid_file_list_constant_s[2]
# )

dfe_constant_s_matrix = matrix(, nrow=39, ncol=39)

# for (i in 1:39) {
#   for (j in i:39) {  # This change ensures only the upper right triangle is compared
#     print(DFE_grid_file_list_constant_s[i])
#     print(DFE_grid_file_list_constant_s[j])
#     comparison = cross_species_dfe_comparison(DFE_grid_file_list_constant_s[i], DFE_grid_file_list_constant_s[j])
#     print(comparison)
#     dfe_constant_s_matrix[i, j] = comparison
#     dfe_constant_s_matrix[j, i] = comparison  # Mirror the value across the diagonal
#   }
# }

# HR comparison

HR_DFE_grid_file_list = c(
  '../HighRecombinationAnalysis/cross_species_dfe/Akkermansia_muciniphila_55290_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Alistipes_finegoldii_56071_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Alistipes_onderdonkii_55464_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Alistipes_shahii_62199_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_caccae_53434_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_fragilis_54507_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_stercoris_56735_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Dialister_invisus_61905_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Oscillibacter_sp_60799_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Parabacteroides_merdae_56972_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Ruminococcus_bicirculans_59300_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Ruminococcus_bromii_62047_likelihood_surface.csv'
)

# for (species in HR_DFE_grid_file_list) {
#   print(species)
#   find_dfe_mle(species)
# }
# 
# cross_species_dfe_comparison(
#   HR_DFE_grid_file_list[1],
#   HR_DFE_grid_file_list[2]
# )

HR_dfe_comparison_matrix = matrix(, nrow=18, ncol=18)

# for (i in 1:18) {
#   for (j in i:18) {  # This change ensures only the upper right triangle is compared
#     print(HR_DFE_grid_file_list[i])
#     print(HR_DFE_grid_file_list[j])
#     comparison = cross_species_dfe_comparison(HR_DFE_grid_file_list[i], HR_DFE_grid_file_list[j])
#     print(comparison)
#     HR_dfe_comparison_matrix[i, j] = comparison
#     HR_dfe_comparison_matrix[j, i] = comparison  # Mirror the value across the diagonal
#   }
# }

# HR comparison

HR_DFE_grid_file_list_constant_s = c(
  '../HighRecombinationAnalysis/cross_species_dfe/Akkermansia_muciniphila_55290_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Alistipes_finegoldii_56071_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Alistipes_onderdonkii_55464_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Alistipes_shahii_62199_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_caccae_53434_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_fragilis_54507_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_stercoris_56735_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Dialister_invisus_61905_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Oscillibacter_sp_60799_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Parabacteroides_merdae_56972_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Ruminococcus_bicirculans_59300_constant_s_likelihood_surface.csv',
  '../HighRecombinationAnalysis/cross_species_dfe/Ruminococcus_bromii_62047_constant_s_likelihood_surface.csv'
)

# for (species in HR_DFE_grid_file_list_constant_s) {
#   print(species)
#   find_dfe_mle(species)
# }

# cross_species_dfe_comparison(
#   HR_DFE_grid_file_list_constant_s[1],
#   HR_DFE_grid_file_list_constant_s[2]
# )

HR_dfe_comparison_matrix_constant_s = matrix(, nrow=18, ncol=18)

# for (i in 1:18) {
#   for (j in i:18) {  # This change ensures only the upper right triangle is compared
#     print(HR_DFE_grid_file_list_constant_s[i])
#     print(HR_DFE_grid_file_list_constant_s[j])
#     comparison = cross_species_dfe_comparison(HR_DFE_grid_file_list_constant_s[i], HR_DFE_grid_file_list_constant_s[j])
#     print(comparison)
#     HR_dfe_comparison_matrix_constant_s[i, j] = comparison
#     HR_dfe_comparison_matrix_constant_s[j, i] = comparison  # Mirror the value across the diagonal
#   }
# }

# write.csv(dfe_comparison_matrix, '../SupplementaryAnalysis/cross_species_dfe/dfe_comparison_matrix.csv')
# write.csv(HR_dfe_comparison_matrix, '../HighRecombinationAnalysis/cross_species_dfe/dfe_comparison_matrix.csv')
# write.csv(accessory_dfe_comparison_matrix, '../SupplementaryAnalysis/cross_species_dfe/accessory_dfe_comparison_matrix.csv')
# write.csv(dfe_constant_s_matrix, '../SupplementaryAnalysis/cross_species_dfe/dfe_constant_s_matrix.csv')
# write.csv(HR_dfe_comparison_matrix_constant_s, '../HighRecombinationAnalysis/cross_species_dfe/dfe_constant_s_matrix.csv')
# write.csv(accessory_dfe_constant_s_matrix, '../SupplementaryAnalysis/cross_species_dfe/accessory_dfe_constant_s_matrix.csv')

dfe_comparison_matrix = read.table('../SupplementaryAnalysis/cross_species_dfe/dfe_comparison_matrix.csv', header=TRUE, row.names=NULL, sep=',')[, -c(1)]
dfe_constant_s_matrix = read.table('../SupplementaryAnalysis/cross_species_dfe/dfe_constant_s_matrix.csv', header=TRUE, row.names=NULL, sep=',')[, -c(1)]
# accessory_dfe_comparison_matrix = read.table('../SupplementaryAnalysis/cross_species_dfe/accessory_dfe_comparison_matrix.csv', header=TRUE, row.names=NULL, sep=',')[, -c(1)]
# accessory_dfe_constant_s_matrix = read.table('../SupplementaryAnalysis/cross_species_dfe/accessory_dfe_constant_s_matrix.csv', header=TRUE, row.names=NULL, sep=',')[, -c(1)]
HR_dfe_comparison_matrix = read.table('../HighRecombinationAnalysis/cross_species_dfe/dfe_comparison_matrix.csv', header=TRUE, row.names=NULL, sep=',')[, -c(1)]
HR_dfe_constant_s_matrix = read.table('../HighRecombinationAnalysis/cross_species_dfe/dfe_constant_s_matrix.csv', header=TRUE, row.names=NULL, sep=',')[, -c(1)]


### 2ns DFE comparison within-vs-between genera (Core genes)
names(dfe_comparison_matrix)
FD_alistipes = c(2, 3, 4, 5, 6)
FD_bacteroides = c(8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)
FD_eubacterium = c(23, 24, 25)
FD_faecalibacterium = c(26, 27, 28)
FD_parabacteroides = c(32, 33)
FD_roseburia = c(36, 37)
FD_ruminococcus = c(38, 39)

sum(dfe_comparison_matrix > 19.20747) / 2

sum(dfe_comparison_matrix[lower.tri(dfe_comparison_matrix)] > 19.20747)

sum(dfe_comparison_matrix[FD_alistipes, FD_alistipes] > 19.20747) / 2
# 6

sum(dfe_comparison_matrix[FD_bacteroides, FD_bacteroides] > 19.20747) / 2
# 31

sum(dfe_comparison_matrix[FD_eubacterium, FD_eubacterium] > 19.20747) / 2
# 0

sum(dfe_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium] > 19.20747) / 2
# 2

sum(dfe_comparison_matrix[FD_parabacteroides, FD_parabacteroides] > 19.20747) / 2
# 0

sum(dfe_comparison_matrix[FD_roseburia, FD_roseburia] > 19.20747) / 2
# 1

sum(dfe_comparison_matrix[FD_ruminococcus, FD_ruminococcus] > 19.20747 / 2)
# 0

core_2ns_within_genera_LRT = c()
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_alistipes, FD_alistipes][lower.tri(dfe_comparison_matrix[FD_alistipes, FD_alistipes])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_bacteroides, FD_bacteroides][lower.tri(dfe_comparison_matrix[FD_bacteroides, FD_bacteroides])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_eubacterium, FD_eubacterium][lower.tri(dfe_comparison_matrix[FD_eubacterium, FD_eubacterium])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium][lower.tri(dfe_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_parabacteroides, FD_parabacteroides][lower.tri(dfe_comparison_matrix[FD_parabacteroides, FD_parabacteroides])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_roseburia, FD_roseburia][lower.tri(dfe_comparison_matrix[FD_roseburia, FD_roseburia])])
core_2ns_within_genera_LRT = c(core_2ns_within_genera_LRT, dfe_comparison_matrix[FD_ruminococcus, FD_ruminococcus][lower.tri(dfe_comparison_matrix[FD_ruminococcus, FD_ruminococcus])])
length(core_2ns_within_genera_LRT) # 85 total within-genera comparisons
sum(core_2ns_within_genera_LRT > 19.20747) # 40 within genera are significant

core_2ns_between_genera_LRT = dfe_comparison_matrix[lower.tri(dfe_comparison_matrix)][!dfe_comparison_matrix[lower.tri(dfe_comparison_matrix)] %in% core_2ns_within_genera_LRT]

LRT_list <- melt(list(within_genera = core_2ns_within_genera_LRT, between_genera = core_2ns_between_genera_LRT))

mean(core_2ns_within_genera_LRT)
mean(core_2ns_between_genera_LRT)

between_within_mean_diff = mean(core_2ns_between_genera_LRT) - mean(core_2ns_within_genera_LRT)

permutation_mean_diff = numeric(100000)

for (i in 1:100000) {
  this_scramble_between = sample(LRT_list$value, size=656, replace=FALSE)
  this_scramble_within = sample(LRT_list$value, size=85, replace=FALSE)
  permutation_mean_diff[i] = mean(this_scramble_between) - mean(this_scramble_within)
}

permutation_mean_data = data.frame(permutation_mean_diff)

names(permutation_mean_data) = c('value')

sum(between_within_mean_diff > permutation_mean_data) / 100000

quantile_label = "Proportion of area:"

quantile_label = paste(quantile_label, sum(between_within_mean_diff > permutation_mean_data) / 100000, sep=' ')

permutation_LRT = ggplot(permutation_mean_data, aes(x=value, y=..count..)) +
  geom_histogram(bins=100) +
  xlab('Difference of mean LRT statistics') +
  ylab('Number of simulations') +
  geom_vline(xintercept = between_within_mean_diff, color='green', linetype='dotted', linewidth=3) +
  theme_minimal() +
  ggtitle('Simulated difference of mean LRT statistics') +
  annotate("text", x=25, y=2500, label= quantile_label, size=5) +
  theme(axis.title=element_text(size=18)) +
  theme(plot.title=element_text(size=20))

ggsave('../Summary/permutation_LRT.svg', permutation_LRT, width=18, height=12, dpi=600)


set.seed(1)
LRT_scramble_within_genera = sample(LRT_list$value, size=85, replace=FALSE)
LRT_scramble_between_genera = sample(LRT_list$value, size=656, replace=FALSE)

LRT_list <- melt(
  list(
    within_genera = core_2ns_within_genera_LRT, between_genera = core_2ns_between_genera_LRT, scrambled_within = LRT_scramble_within_genera, scrambled_between = LRT_scramble_between_genera
  )
)

LRT_list$L1 = factor(LRT_list$L1, levels=c('between_genera', 'within_genera', 'scrambled_between', 'scrambled_within'))

comparison_1 = list(c("within_genera", "between_genera"))
comparison_2 = list(c("scrambled_between", "scrambled_within"))
comparison_3 = list(c("between_genera", "scrambled_between"))
comparison_4 = list(c("within_genera", "scrambled_within"))



my_comparisons <- list( c("within_genera", "between_genera"), 
  c("scrambled_between", "scrambled_within")
)

my_other_comparisons <- list( c("between_genera", "scrambled_between"),
  c("within_genera", "scrambled_within"))

vertical_adjustments = c(0, -0.25, -0.5, -0.75)

LRT_distribution = ggplot(LRT_list, aes(x=L1, y=value, fill=L1)) +
  geom_boxplot() +
  ylab('LRT statistic') +
  xlab('Comparison') +
  scale_fill_manual(labels=c('Between-genera', 'Within-genera', 'Permutation test (within)', 'Permutation test (between)'),
    breaks=c('between_genera', 'within_genera', 'scrambled_within', 'scrambled_between'),
    values=c("#69b3a2", "#95fd34", 'black', 'grey'),) +
  theme_minimal() +
  theme(axis.text.x=element_blank(),) +
  guides(fill=guide_legend(title="Type of DFE comparison")) +
  ggtitle('LRT statistics for between-genera and within-genera DFE comparisons') +
  geom_abline(intercept=19.20747, color='red', linetype='dashed') +
  geom_signif(position='identity', size=1, y_position=750,
    comparisons = comparison_1,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1, y_position=850,
    comparisons = comparison_2,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', 
    comparisons = comparison_3, size=1, y_position=800,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1,
    comparisons = comparison_4, y_position=900,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  theme(axis.title=element_text(size=18)) +
  theme(plot.title=element_text(size=20)) +
  theme(legend.title=element_text(size=18)) +
  theme(legend.text=element_text(size=16))

ggsave('../Summary/LRT_distribution.svg', LRT_distribution, width=18, height=12, dpi=600)


### s DFE comparison within-vs-between genera (Core genes)
sum(dfe_constant_s_matrix[lower.tri(dfe_constant_s_matrix)] > 19.20747)
# 344

sum(dfe_constant_s_matrix[FD_alistipes, FD_alistipes] > 19.20747) / 2
# 6

sum(dfe_constant_s_matrix[FD_bacteroides, FD_bacteroides] > 19.20747) / 2
# 38

sum(dfe_constant_s_matrix[FD_eubacterium, FD_eubacterium] > 19.20747) / 2
# 2

sum(dfe_constant_s_matrix[FD_faecalibacterium, FD_faecalibacterium] > 19.20747) / 2
# 1

sum(dfe_constant_s_matrix[FD_parabacteroides, FD_parabacteroides] > 19.20747) / 2
# 0

sum(dfe_constant_s_matrix[FD_roseburia, FD_roseburia] > 19.20747) / 2
# 1

sum(dfe_constant_s_matrix[FD_ruminococcus, FD_ruminococcus] > 19.20747 / 2)
# 2

### 2ns DFE comparison within-vs-between genera (Core genes)
sum(dfe_comparison_matrix[lower.tri(dfe_comparison_matrix)] > 19.20747)
# 344

sum(dfe_comparison_matrix[FD_alistipes, FD_alistipes] > 19.20747) / 2
# 6

sum(dfe_comparison_matrix[FD_bacteroides, FD_bacteroides] > 19.20747) / 2
# 36

sum(dfe_comparison_matrix[FD_eubacterium, FD_eubacterium] > 19.20747) / 2
# 3

sum(dfe_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium] > 19.20747) / 2
# 2

sum(dfe_comparison_matrix[FD_parabacteroides, FD_parabacteroides] > 19.20747) / 2
# 1

sum(dfe_comparison_matrix[FD_roseburia, FD_roseburia] > 19.20747) / 2
# 0

sum(dfe_comparison_matrix[FD_ruminococcus, FD_ruminococcus] > 19.20747 / 2)
# 2

### s DFE comparison within-vs-between genera (Core genes, high recombination)

### s DFE comparison within-vs-between genera (Accessory genes)

row.names(dfe_comparison_matrix) = FD_phylogenetic_levels
colnames(dfe_comparison_matrix) = FD_phylogenetic_levels
dfe_comparison_matrix

# Critical value for FD. 471 unique comparisons
qchisq(1 - 0.05/471, df=2)

# Critical value for HR or for accessory. 153 unique comparisons
qchisq(1 - 0.05/153, df=2)

# Critical value for core vs. accessory DFE, 18 compmarisons
qchisq(1 - 0.05/18, df=2)

DFE_core_file_list = c(
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_putredinis_61533_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_finegoldii_56071_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_onderdonkii_55464_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_shahii_62199_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroidales_bacterium_58650_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_merdae_56972_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_stercoris_56735_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_caccae_53434_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_massiliensis_44749_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Dialister_invisus_61905_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_eligens_61678_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_siraeum_57634_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Ruminococcus_bromii_62047_likelihood_surface.csv'
)

demography_core_file_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt'
)

demography_acc_file_list = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_two_epoch_demography.txt'
)

DFE_core_file_list_constant_s = c(
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_putredinis_61533_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_finegoldii_56071_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_onderdonkii_55464_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Alistipes_shahii_62199_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroidales_bacterium_58650_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Parabacteroides_merdae_56972_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_stercoris_56735_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_caccae_53434_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_massiliensis_44749_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Dialister_invisus_61905_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_eligens_61678_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Eubacterium_siraeum_57634_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/cross_species_dfe/Ruminococcus_bromii_62047_constant_s_likelihood_surface.csv'
)

DFE_acc_file_list = c(
  '../SupplementaryAnalysis/accessory_cross/Alistipes_putredinis_61533_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Alistipes_finegoldii_56071_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Alistipes_onderdonkii_55464_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Alistipes_shahii_62199_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroidales_bacterium_58650_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Parabacteroides_merdae_56972_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_cellulosilyticus_58046_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_stercoris_56735_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_caccae_53434_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_massiliensis_44749_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Dialister_invisus_61905_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Eubacterium_eligens_61678_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Eubacterium_siraeum_57634_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_cross/Ruminococcus_bromii_62047_likelihood_surface.csv'
)

DFE_acc_file_list_constant_s = c(
  '../SupplementaryAnalysis/accessory_constant_s/Alistipes_putredinis_61533_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Alistipes_finegoldii_56071_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Alistipes_onderdonkii_55464_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Alistipes_shahii_62199_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroidales_bacterium_58650_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Parabacteroides_merdae_56972_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_cellulosilyticus_58046_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_stercoris_56735_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_caccae_53434_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_massiliensis_44749_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Dialister_invisus_61905_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Eubacterium_eligens_61678_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Eubacterium_siraeum_57634_constant_s_likelihood_surface.csv',
  '../SupplementaryAnalysis/accessory_constant_s/Ruminococcus_bromii_62047_constant_s_likelihood_surface.csv'
)

DFE_core_files = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt'
)

DFE_acc_files = c(
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/accessory_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/accessory_inferred_DFE.txt'
)

core_acc_species_list = c(
  'Alistipes putredinis',
  'Alistipes finegoldii',
  'Alistipes onderdonkii',
  'Alistipes shahii',
  'Bacteroidales bacterium',
  'Parabacteroides distasonis',
  'Parabacteroides merdae',
  'Bacteroides cellulosilyticus',
  'Bacteroides stercoris',
  'Bacteroides thetaiotaomicron',
  'Bacteroides caccae',
  'Bacteroides massiliensis',
  'Bacteroides vulgatus',
  'Dialister invisus',
  'Eubacterium eligens',
  'Eubacterium rectale',
  'Eubacterium siraeum',
  'Ruminococcus bromii'
)

acc_core_dfe_comparison = numeric(18)
acc_core_dfe_comparison_constant_s = numeric(18)
core_mean_s = numeric(18)
core_mean_2ns = numeric(18)
acc_mean_s = numeric(18)
acc_mean_2ns = numeric(18)

for (i in 1:length(core_acc_species_list)) {
  acc_core_dfe_comparison[i] = cross_species_dfe_comparison(DFE_core_file_list[i], DFE_acc_file_list[i])
  acc_core_dfe_comparison_constant_s[i] = cross_species_dfe_comparison(DFE_core_file_list_constant_s[i], DFE_acc_file_list_constant_s[i])
  core_mean_s[i] = compute_selection_coefficients(DFE_core_files[i])[1]
  core_mean_2ns[i] = nanc_from_demography(demography_core_file_list[i]) * core_mean_s[i] * 2
  acc_mean_s[i] = compute_selection_coefficients(DFE_acc_files[i])[1]
  acc_mean_2ns[i] = nanc_from_demography(demography_acc_file_list[i]) * acc_mean_s[i] * 2
}

acc_core_dfe_LRT_table = data.frame(species=core_acc_species_list, constant_2NAs=acc_core_dfe_comparison, constant_s=acc_core_dfe_comparison_constant_s,
  core_mean_s=core_mean_s, core_mean_2ns = core_mean_2ns,
  acc_mean_s=acc_mean_s, acc_mean_2ns = acc_mean_2ns)

acc_core_dfe_LRT_table

# write.csv(acc_core_dfe_LRT_table, '../Summary/core_acc_dfe_LRT.csv', row.names=FALSE)


color_scale = colorRampPalette(c('white', 'yellow', 'orange', 'red'), bias=5)(1000)

Heatmap(dfe_comparison_matrix, rect_gp = gpar(type = "none"),
  col=color_scale,
  cluster_rows = FALSE, cluster_columns = FALSE,
  cell_fun = function(j, i, x, y, w, h, fill) {
    if (dfe_comparison_matrix[i, j] > 19.20747 && i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col = 'white', fontface='italic'))
      grid.text(sprintf("%.1f", dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
    }
    else if(i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
      grid.text(sprintf("%.1f", dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
    }
  },
  row_names_side='left',
  column_names_gp = gpar(fontsize = 12,fontface='italic'),
  row_names_gp = gpar(fontsize = 12,fontface='italic'),
  show_heatmap_legend = F
  )

sum(dfe_comparison_matrix > 19.20747) / 2


Heatmap(HR_dfe_comparison_matrix, rect_gp = gpar(type = "none"),
  col=color_scale,
  cluster_rows = FALSE, cluster_columns = FALSE,
  cell_fun = function(j, i, x, y, w, h, fill) {
    if (HR_dfe_comparison_matrix[i, j] > 16.05234 && i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col = 'white', fontface='italic'))
      grid.text(sprintf("%.1f", HR_dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
    }
    else if(i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
      grid.text(sprintf("%.1f", HR_dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
    }
  },
  row_names_side='left',
  column_names_gp = gpar(fontsize = 12,fontface='italic'),
  row_names_gp = gpar(fontsize = 12,fontface='italic'),
  show_heatmap_legend = F
  )

sum(HR_dfe_comparison_matrix > 16.05234) / 2


# Heatmap(accessory_dfe_comparison_matrix, rect_gp = gpar(type = "none"),
#   col=color_scale,
#   cluster_rows = FALSE, cluster_columns = FALSE,
#   cell_fun = function(j, i, x, y, w, h, fill) {
#     if (accessory_dfe_comparison_matrix[i, j] > 16.05234 && i >= j) {
#       grid.rect(x, y, w, h, gp = gpar(fill = fill, col = 'white', fontface='italic'))
#       grid.text(sprintf("%.1f", accessory_dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
#     }
#     else if(i >= j) {
#       grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
#       grid.text(sprintf("%.1f", accessory_dfe_comparison_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
#     }
#   },
#   row_names_side='left',
#   column_names_gp = gpar(fontsize = 12,fontface='italic'),
#   row_names_gp = gpar(fontsize = 12,fontface='italic'),
#   show_heatmap_legend = F
#   )
# 
# sum(accessory_dfe_comparison_matrix > 16.05234) / 2


Heatmap(dfe_constant_s_matrix, rect_gp = gpar(type = "none"),
  col=color_scale,
  cluster_rows = FALSE, cluster_columns = FALSE,
  cell_fun = function(j, i, x, y, w, h, fill) {
    if (dfe_constant_s_matrix[i, j] > 19.20747 && i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col = 'white', fontface='italic'))
      grid.text(sprintf("%.1f", dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
    }
    else if(i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
      grid.text(sprintf("%.1f", dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
    }
  },
  row_names_side='left',
  column_names_gp = gpar(fontsize = 12,fontface='italic'),
  row_names_gp = gpar(fontsize = 12,fontface='italic'),
  show_heatmap_legend = F
  )

sum(dfe_constant_s_matrix > 19.20747) / 2


Heatmap(HR_dfe_constant_s_matrix, rect_gp = gpar(type = "none"),
  col=color_scale,
  cluster_rows = FALSE, cluster_columns = FALSE,
  cell_fun = function(j, i, x, y, w, h, fill) {
    if (HR_dfe_constant_s_matrix[i, j] > 16.05234 && i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col = 'white', fontface='italic'))
      grid.text(sprintf("%.1f", HR_dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
    }
    else if(i >= j) {
      grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
      grid.text(sprintf("%.1f", HR_dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
    }
  },
  row_names_side='left',
  column_names_gp = gpar(fontsize = 12,fontface='italic'),
  row_names_gp = gpar(fontsize = 12,fontface='italic'),
  show_heatmap_legend = F
  )

sum(HR_dfe_constant_s_matrix > 16.05234) / 2

# Heatmap(accessory_dfe_constant_s_matrix, rect_gp = gpar(type = "none"),
#   col=color_scale,
#   cluster_rows = FALSE, cluster_columns = FALSE,
#   cell_fun = function(j, i, x, y, w, h, fill) {
#     if (accessory_dfe_constant_s_matrix[i, j] > 16.05234 && i >= j) {
#       grid.rect(x, y, w, h, gp = gpar(fill = fill, col = 'white', fontface='italic'))
#       grid.text(sprintf("%.1f", accessory_dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8, col='blue'))
#     }
#     else if(i >= j) {
#       grid.rect(x, y, w, h, gp = gpar(fill = fill, col='white'))
#       grid.text(sprintf("%.1f", accessory_dfe_constant_s_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
#     }
#   },
#   row_names_side='left',
#   column_names_gp = gpar(fontsize = 12,fontface='italic'),
#   row_names_gp = gpar(fontsize = 12,fontface='italic'),
#   show_heatmap_legend = F
#   )
# 
# sum(accessory_dfe_constant_s_matrix > 16.05234) / 2

# Core vs. Accessory gene DFE and fit

# FD_accessory_species_subtree = c(
#   'Alistipes_finegoldii_56071',
#   'Alistipes_onderdonkii_55464',
#   'Alistipes_putredinis_61533',
#   'Alistipes_shahii_62199',
#   'Bacteroidales_bacterium_58650',
#   'Bacteroides_caccae_53434',
#   'Bacteroides_cellulosilyticus_58046',
#   'Bacteroides_massiliensis_44749',
#   'Bacteroides_stercoris_56735',
#   'Bacteroides_thetaiotaomicron_56941',
#   'Bacteroides_vulgatus_57955',
#   'Dialister_invisus_61905',
#   'Eubacterium_eligens_61678',
#   'Eubacterium_rectale_56927',
#   'Eubacterium_siraeum_57634',
#   'Parabacteroides_distasonis_56985',
#   'Parabacteroides_merdae_56972',
#   'Ruminococcus_bromii_62047'
# )

# Proportion of neutrality
# Assume neutrality is selection coefficient < 1E-6

engraftment_dfe_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt'
)


engraftment_demography_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt'
)

# engraftment_mean_s = numeric(36)
# engraftment_n_anc = numeric(36)
# engraftment_proportion_neutrality = numeric(36)
# engraftment_shape = numeric(36)
# for (i in 1:length(engraftment_dfe_file_list)) {
#   engraftment_mean_s[i] = compute_selection_coefficients(engraftment_dfe_file_list[i])[1]
#   engraftment_n_anc[i] = nanc_from_demography(engraftment_demography_file_list[i])
#   engraftment_proportion_neutrality[i] = compute_selection_coefficients(engraftment_dfe_file_list[i])[2]
#   engraftment_shape[i] = return_shape_from_dfe(engraftment_dfe_file_list[i])
# }
# 
# engraftment_mean_2ns = engraftment_n_anc * 2 * engraftment_mean_s
# 
# engraftment_dataframe = data.frame(
#   engraftment_mean_s,
#   engraftment_n_anc,
#   engraftment_mean_2ns,
#   engraftment_proportion_neutrality,
#   engraftment_shape
# )
# 
# write.csv(engraftment_dataframe, file='../Summary/engraftment_dataframe.csv')

neutrality_threshold = 1E-6

engraftment_tree = read.tree('../Summary/engraftment_species.newick')

neutrality_engraftment = read.csv('../Summary/lethality_engraftment_correlation.csv')
names(neutrality_engraftment) = c(
  'species_ianiro',
  'species_midas',
  'engraftment_rate',
  'proportion_of_neutrality',
  'mean_s',
  'n_anc',
  'mean_2ns',
  'shape'
)

ggplot(neutrality_engraftment, aes(x = proportion_of_neutrality, y = engraftment_rate)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Proportion of neutrality", y = "Engraftment Rate") +
  ggtitle("Correlation between proportion of neutrality and engraftment rate") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()

pgls_engraftment_proportion_neutrality = gls(engraftment_rate ~ proportion_of_neutrality, correlation=corBrownian(phy=engraftment_tree),
    data=neutrality_engraftment, method='ML')

summary(pgls_engraftment_proportion_neutrality)

ggplot(neutrality_engraftment, aes(x = mean_s, y = engraftment_rate)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Mean selection coefficient", y = "Engraftment Rate") +
  ggtitle("Correlation between mean selection coefficient and engraftment rate") +
  # xlim(0, 1) +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()

pgls_engraftment_mean_s = gls(engraftment_rate ~ mean_s, correlation=corBrownian(phy=engraftment_tree),
    data=neutrality_engraftment, method='ML')

summary(pgls_engraftment_mean_s)

ggplot(neutrality_engraftment, aes(x = n_anc, y = engraftment_rate)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Estimated ancestral effective population size", y = "Engraftment Rate") +
  ggtitle("Correlation between estimated ancestral effective population size and engraftment rate") +
  # xlim(0, 1) +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()


pgls_engraftment_n_anc = gls(engraftment_rate ~ n_anc, correlation=corBrownian(phy=engraftment_tree),
    data=neutrality_engraftment, method='ML')

summary(pgls_engraftment_n_anc)

ggplot(neutrality_engraftment, aes(x = mean_2ns, y = engraftment_rate)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Population-scaled mean selection coefficient", y = "Engraftment Rate") +
  ggtitle("Correlation between population-scaled mean selection coefficient and engraftment rate") +
  # xlim(0, 1) +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()

pgls_engraftment_mean_2ns = gls(engraftment_rate ~ mean_2ns, correlation=corBrownian(phy=engraftment_tree),
    data=neutrality_engraftment, method='ML')

summary(pgls_engraftment_mean_2ns)

plot(pgls_engraftment_mean_2ns)

engraftmentPic <- pic(neutrality_engraftment$engraftment_rate, engraftment_tree)
mean_sPic <- pic(neutrality_engraftment$mean_s, engraftment_tree)
mean_2nsPic <- pic(neutrality_engraftment$mean_2ns, engraftment_tree)
n_ancPic <- pic(neutrality_engraftment$n_anc, engraftment_tree)
proportion_of_neutralityPic <- pic(neutrality_engraftment$proportion_of_neutrality, engraftment_tree)
shapePic <- pic(neutrality_engraftment$shape, engraftment_tree)

# PIC models
engraftment_mean_2nsPic <- lm(engraftmentPic ~ mean_2nsPic)
summary(engraftment_mean_2nsPic)

engraftment_mean_sPic <- lm(engraftmentPic ~ mean_sPic)
summary(engraftment_mean_sPic)

engraftment_n_ancPic <- lm(engraftmentPic ~ n_ancPic)
summary(engraftment_n_ancPic)

engraftment_proportion_of_neutralityPic <- lm(engraftmentPic ~ proportion_of_neutralityPic)
summary(engraftment_proportion_of_neutralityPic)

engraftment_shapePic <- lm(engraftmentPic ~ shapePic)
summary(engraftment_shapePic)

plot(engraftmentPic ~ mean_2nsPic)

ggplot(neutrality_engraftment, aes(x = shape, y = engraftment_rate)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Gamma-distributed DFE shape parameter", y = "Engraftment Rate") +
  ggtitle("Correlation between DFE shape parameter and engraftment rate") +
  # xlim(0, 1) +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()


pgls_engraftment_shape = gls(engraftment_rate ~ shape, correlation=corBrownian(phy=engraftment_tree),
    data=neutrality_engraftment, method='ML')

summary(pgls_engraftment_shape)

# Phylosignal

fd_core_phylotree_species = c(
  'Alistipes_sp_60764',
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
  'Lachnospiraceae_bacterium_51870',
  'Roseburia_intestinalis_56239',
  'Roseburia_inulinivorans_61943',
  'Eubacterium_rectale_56927',
  'Coprococcus_sp_62244',
  'Oscillibacter_sp_60799',
  'Ruminococcus_bromii_62047',
  'Eubacterium_siraeum_57634',
  'Ruminococcus_bicirculans_59300',
  'Faecalibacterium_prausnitzii_57453',
  'Faecalibacterium_prausnitzii_62201',
  'Faecalibacterium_prausnitzii_61481'
)

fd_core_demography_file_list_phylotree = c(
  '../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt'
)

fd_core_dfe_file_list_phylotree = c(
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt'
)

fd_core_mean_s = numeric(39)
fd_core_n_anc = numeric(39)
fd_core_proportion_neutrality = numeric(39)
fd_core_proportion_lethal = numeric(39)
fd_core_shape = numeric(39)
for (i in 1:length(fd_core_dfe_file_list_phylotree)) {
  fd_core_mean_s[i] = compute_selection_coefficients(fd_core_dfe_file_list_phylotree[i])[1]
  fd_core_n_anc[i] = nanc_from_demography(fd_core_demography_file_list_phylotree[i])
  fd_core_proportion_neutrality[i] = compute_selection_coefficients(fd_core_dfe_file_list_phylotree[i])[2]
  fd_core_proportion_lethal[i] = compute_selection_coefficients(fd_core_dfe_file_list_phylotree[i])[5]
  fd_core_shape[i] = return_shape_from_dfe(fd_core_dfe_file_list_phylotree[i])
}
fd_core_mean_2ns  = fd_core_mean_s * fd_core_n_anc * 2

phylosignal_dataframe = data.frame(
  species=fd_core_phylotree_species,
  mean_s = fd_core_mean_s,
  N_anc = fd_core_n_anc,
  mean_2ns = fd_core_mean_2ns,
  proportion_neutral = fd_core_proportion_neutrality,
  proportion_lethal = fd_core_proportion_lethal,
  shape = fd_core_shape
)

FD_subtree$node.label = NULL
FD_vcv = vcv(FD_subtree)

phylosignal_dataframe = phylosignal_dataframe[match(FD_subtree$tip.label, phylosignal_dataframe$species),]
phylosignal_dataframe = phylosignal_dataframe[, -c(1)]
# names(phylosignal_dataframe) = c('Mean selection coefficient', 'Ancestral effective population size', 'Mean population-scaled selection coefficient')
 
fd_core_phylo_4d = phylo4d(FD_subtree, phylosignal_dataframe)

fd_core_phylo_4d

barplot(fd_core_phylo_4d, center=FALSE, scale=FALSE)

barplot(fd_core_phylo_4d)

phyloSignal(fd_core_phylo_4d)

lambdaTest(fd_core_mean_s, FD_vcv)
lambdaTest(fd_core_n_anc, FD_vcv)
lambdaTest(fd_core_mean_2ns, FD_vcv)
lambdaTest(fd_core_proportion_neutrality, FD_vcv)
lambdaTest(fd_core_shape, FD_vcv)

# phylosim <- phyloSim(tree = FD_subtree, method = "all", nsim = 100, reps = 99)
# plot(phylosim, stacked.methods = FALSE, quantiles = c(0.05, 0.95))
# plot.phylosim(phylosim, what = "pval", stacked.methods = TRUE)
fd_core_correlogram = phyloCorrelogram(fd_core_phylo_4d)
plot(fd_core_correlogram)

# plot(phyloCorrelogram(fd_core_phylo_4d, trait = 'mean_s'), main='Phylogenetic correlogram of mean selection coefficient')
# plot(phyloCorrelogram(fd_core_phylo_4d, trait = 'N_anc'), main='Phylogenetic correlogram of ancestral effective population size')
# plot(phyloCorrelogram(fd_core_phylo_4d, trait = 'mean_2ns'), main='Phylogenetic correlogram of mean population-scaled selection coefficient')
# plot(phyloCorrelogram(fd_core_phylo_4d, trait = 'proportion_neutral'), main='Phylogenetic correlogram of proportion of neutrality')
# plot(phyloCorrelogram(fd_core_phylo_4d, trait = 'shape'), main='Phylogenetic correlogram of Gamma-distributed DFE shape parameter')

# Engraftment phylosignal
engraftment_subtree$node.label = NULL
neutrality_engraftment = neutrality_engraftment[match(engraftment_subtree$tip.label, neutrality_engraftment$species_midas),]

engraftment_phylosignal_dataframe = data.frame(neutrality_engraftment$engraftment_rate)
engraftment_phylosignal_dataframe

names(engraftment_phylosignal_dataframe) = 'engraftment_rate'
engraftment_phylo_4d = phylo4d(engraftment_subtree, engraftment_phylosignal_dataframe, match.data=TRUE)

phyloSignal(engraftment_phylo_4d)

engraftment_phylosim <- phyloSim(tree = engraftment_subtree, method = "all", nsim = 100, reps = 99)
plot(engraftment_phylosim, stacked.methods = FALSE, quantiles = c(0.05, 0.95))

plot(phyloCorrelogram(engraftment_phylo_4d, trait = 'engraftment_rate'), main='Phylogenetic correlogram of FMT engraftment rate')

barplot(engraftment_phylo_4d, center=FALSE, scale=FALSE)

barplot(engraftment_phylo_4d)

# Sporulation correlation
sporulation_species = c(
  'Akkermansia_muciniphila_55290',
  'Alistipes_finegoldii_56071',
  'Bacteroides_caccae_53434',
  'Bacteroides_coprocola_61586',
  'Bacteroides_fragilis_54507',
  'Bacteroides_ovatus_58035',
  'Bacteroides_plebeius_61623',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_uniformis_57318',
  'Bacteroides_vulgatus_57955',
  'Bacteroides_xylanisolvens_57185',
  'Coprococcus_sp_62244',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Eubacterium_siraeum_57634',
  'Faecalibacterium_prausnitzii_57453',
  'Faecalibacterium_prausnitzii_62201',
  'Faecalibacterium_prausnitzii_61481',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Prevotella_copri_61740',
  'Roseburia_intestinalis_56239',
  'Roseburia_inulinivorans_61943',
  'Ruminococcus_bromii_62047'
)

sporulation_demography_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_ovatus_58035/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt'
)

sporulation_dfe_file_list = c(
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_ovatus_58035/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt'
)

sporulation_mean_s = numeric(24)
sporulation_n_anc = numeric(24)
sporulation_proportion_neutrality = numeric(24)
sporulation_shape = numeric(24)
for (i in 1:length(sporulation_dfe_file_list)) {
  sporulation_mean_s[i] = compute_selection_coefficients(sporulation_dfe_file_list[i])[1]
  sporulation_n_anc[i] = nanc_from_demography(sporulation_demography_file_list[i])
  sporulation_proportion_neutrality[i] = compute_selection_coefficients(sporulation_dfe_file_list[i])[2]
  sporulation_shape[i] = return_shape_from_dfe(sporulation_dfe_file_list[i])
}

sporulation_mean_2ns = sporulation_n_anc * 2 * sporulation_mean_s

sporulation_dataframe = data.frame(
  species=sporulation_species,
  sporulation_mean_s,
  sporulation_n_anc,
  sporulation_mean_2ns,
  sporulation_proportion_neutrality,
  sporulation_shape
)

write.csv(sporulation_dataframe, file='../Summary/sporulation_dataframe.csv')

sporulation_tree = read.tree('../Summary/sporulation_species.newick')
sporulation_tree$node.label = NULL

sporulation_correlation = read.csv('../Summary/sporulation_correlation.csv')

names(sporulation_correlation) = c(
  'species_browne',
  'species_midas',
  'sporulation_score',
  'mean_s',
  'n_anc',
  'mean_2ns',
  'sporulation_proportion_neutrality',
  'shape'
)

sporulationPic <- pic(sporulation_correlation$sporulation_score, sporulation_tree)
mean_sPic <- pic(sporulation_correlation$mean_s, sporulation_tree)
mean_2nsPic <- pic(sporulation_correlation$mean_2ns, sporulation_tree)
n_ancPic <- pic(sporulation_correlation$n_anc, sporulation_tree)
proportion_of_neutralityPic <- pic(sporulation_correlation$sporulation_proportion_neutrality, sporulation_tree)
shapePic <- pic(sporulation_correlation$shape, sporulation_tree)

# Make a model
sporulation_mean_2nsPic <- lm(sporulationPic ~ mean_2nsPic)
summary(sporulation_mean_2nsPic)

sporulation_mean_sPic <- lm(sporulationPic ~ mean_sPic)
summary(sporulation_mean_sPic)

sporulation_n_ancPic <- lm(sporulationPic ~ n_ancPic)
summary(sporulation_n_ancPic)

sporulation_proportion_of_neutralityPic <- lm(sporulationPic ~ proportion_of_neutralityPic)
summary(sporulation_proportion_of_neutralityPic)

sporulation_shapePic <- lm(sporulationPic ~ shapePic)
summary(sporulation_shapePic)

ggplot(sporulation_correlation, aes(x = sporulation_proportion_neutrality, y = sporulation_score)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Proportion of neutrality", y = "Mean sporulation signature") +
  ggtitle("Correlation between proportion of neutrality and mean sporulation signature") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()

pgls_sporulation_proportion_neutrality = gls(sporulation_score ~ sporulation_proportion_neutrality, correlation=corBrownian(phy=sporulation_tree),
    data=sporulation_correlation, method='ML')

summary(pgls_sporulation_proportion_neutrality)

ggplot(sporulation_correlation, aes(x = mean_s, y = sporulation_score)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Mean selection coefficient", y = "Mean sporulation signature") +
  ggtitle("Correlation between mean selection coefficient and mean sporulation signature") +
  # xlim(0, 1) +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()

pgls_sporulation_mean_s = gls(sporulation_score ~ mean_s, correlation=corBrownian(phy=sporulation_tree),
    data=sporulation_correlation, method='ML')

summary(pgls_sporulation_mean_s)

ggplot(sporulation_correlation, aes(x = n_anc, y = sporulation_score)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Estimated ancestral effective population size", y = "Mean sporulation signature") +
  ggtitle("Correlation between estimated ancestral effective population size and mean sporulation signature") +
  # xlim(0, 1) +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()


pgls_sporulation_n_anc = gls(sporulation_score ~ n_anc, correlation=corBrownian(phy=sporulation_tree),
    data=sporulation_correlation, method='ML')

summary(pgls_sporulation_n_anc)

ggplot(sporulation_correlation, aes(x = mean_2ns, y = sporulation_score)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Population-scaled mean selection coefficient", y = "Mean sporulation signature") +
  ggtitle("Correlation between population-scaled mean selection coefficient and mean sporulation signature") +
  # xlim(0, 1) +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()

pgls_sporulation_mean_2ns = gls(sporulation_score ~ mean_2ns, correlation=corBrownian(phy=sporulation_tree),
    data=sporulation_correlation, method='ML')

summary(pgls_sporulation_mean_2ns)

ggplot(sporulation_correlation, aes(x = shape, y = sporulation_score)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Gamma-distributed DFE shape parameter", y = "Mean sporulation signature") +
  ggtitle("Correlation between DFE shape parameter and mean sporulation signature") +
  # xlim(0, 1) +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  stat_cor()

pgls_sporulation_shape = gls(sporulation_score ~ shape, correlation=corBrownian(phy=sporulation_tree),
    data=sporulation_correlation, method='ML')

summary(pgls_sporulation_shape)


# Sporulation phylosignal
sporulation_subtree$node.label = NULL
sporulation_data = read.csv('../Summary/sporulation_score.csv')
sporulation_data = sporulation_data[match(sporulation_subtree$tip.label, sporulation_data$Species..MIDAS.),]

sporulation_score_dataframe = data.frame(sporulation_data$Average.Sporulation.Signature.Score)
names(sporulation_score_dataframe) = 'mean_sporulation_signal'

sporulation_phylo_4d = phylo4d(sporulation_subtree, sporulation_score_dataframe, match.data=TRUE)

phyloSignal(sporulation_phylo_4d)

# sporulation_phylosim <- phyloSim(tree = sporulation_subtree, method = "all", nsim = 100, reps = 99)
# plot(sporulation_phylosim, stacked.methods = FALSE, quantiles = c(0.05, 0.95))

plot(phyloCorrelogram(sporulation_phylo_4d, trait = 'mean_sporulation_signal'), main='Phylogenetic correlogram of mean sporulation signal')

barplot(sporulation_phylo_4d, center=FALSE, scale=FALSE)

barplot(sporulation_phylo_4d)

# Reduced DFE phylosignal
# FD_no_outlier_subtree$node.label = NULL
# 
# fd_no_outlier_species = c(
#   'Alistipes_sp_60764',
#   'Bacteroidales_bacterium_58650',
#   'Alistipes_putredinis_61533',
#   'Alistipes_finegoldii_56071',
#   'Alistipes_onderdonkii_55464',
#   'Alistipes_shahii_62199',
#   'Odoribacter_splanchnicus_62174',
#   'Parabacteroides_distasonis_56985',
#   'Parabacteroides_merdae_56972',
#   'Prevotella_copri_61740',
#   'Bacteroides_fragilis_54507',
#   'Bacteroides_cellulosilyticus_58046',
#   'Bacteroides_eggerthii_54457',
#   'Bacteroides_stercoris_56735',
#   'Bacteroides_uniformis_57318',
#   'Bacteroides_thetaiotaomicron_56941',
#   'Bacteroides_xylanisolvens_57185',
#   'Bacteroides_caccae_53434',
#   'Bacteroides_massiliensis_44749',
#   'Bacteroides_vulgatus_57955',
#   'Bacteroides_plebeius_61623',
#   'Bacteroides_coprocola_61586',
#   'Barnesiella_intestinihominis_62208',
#   'Akkermansia_muciniphila_55290',
#   'Dialister_invisus_61905',
#   'Phascolarctobacterium_sp_59817',
#   'Eubacterium_eligens_61678',
#   'Lachnospiraceae_bacterium_51870',
#   'Roseburia_inulinivorans_61943',
#   'Eubacterium_rectale_56927',
#   'Coprococcus_sp_62244',
#   'Oscillibacter_sp_60799',
#   'Ruminococcus_bromii_62047',
#   'Eubacterium_siraeum_57634',
#   'Ruminococcus_bicirculans_59300',
#   'Faecalibacterium_prausnitzii_57453',
#   'Faecalibacterium_prausnitzii_61481'
# )
# 
# fd_no_outlier_demography_file_list = c(
#   '../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt',
#   '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt'
# )
# 
# fd_no_outlier_dfe_file_list = c(
#   '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
#   '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt'
# )

# fd_no_outlier_mean_s = numeric(37)
# fd_no_outlier_n_anc = numeric(37)
# fd_no_outlier_proportion_neutrality = numeric(37)
# fd_no_outlier_shape = numeric(37)
# for (i in 1:length(fd_no_outlier_dfe_file_list)) {
#   fd_no_outlier_mean_s[i] = compute_selection_coefficients(fd_no_outlier_dfe_file_list[i])[1]
#   fd_no_outlier_n_anc[i] = nanc_from_demography(fd_no_outlier_demography_file_list[i])
#   fd_no_outlier_proportion_neutrality[i] = compute_selection_coefficients(fd_no_outlier_dfe_file_list[i])[2]
#   fd_no_outlier_shape[i] = return_shape_from_dfe(fd_no_outlier_dfe_file_list[i])
# }
# 
# FD_no_outlier_data = data.frame(
#   species=fd_no_outlier_species,
#   mean_s=fd_no_outlier_mean_s,
#   n_anc=fd_no_outlier_n_anc,
#   proportion_neutrality=fd_no_outlier_proportion_neutrality,
#   shape=fd_no_outlier_shape
# )
# 
# FD_no_outlier_data$mean_2ns = fd_no_outlier_mean_s * fd_no_outlier_n_anc * 2
# 
# FD_no_outlier_data = FD_no_outlier_data[match(FD_no_outlier_subtree$tip.label, FD_no_outlier_data$species),]
# 
# FD_no_outlier_data = FD_no_outlier_data[, -c(1)]
# 
# FD_no_outlier_phylo_4d = phylo4d(FD_no_outlier_subtree, FD_no_outlier_data, match.data=TRUE)
# 
# phyloSignal(FD_no_outlier_phylo_4d)

# FD_no_outlier_phylosim <- phyloSim(tree = FD_no_outlier_subtree, method = "all", nsim = 100, reps = 99)
# plot(FD_no_outlier_phylosim, stacked.methods = FALSE, quantiles = c(0.05, 0.95))

# plot(phyloCorrelogram(FD_no_outlier_phylo_4d, trait = 'mean_s'), main='Phylogenetic correlogram of mean selection coefficient')
# plot(phyloCorrelogram(FD_no_outlier_phylo_4d, trait = 'n_anc'), main='Phylogenetic correlogram of ancestral effective population size')
# plot(phyloCorrelogram(FD_no_outlier_phylo_4d, trait = 'mean_2ns'), main='Phylogenetic correlogram of mean population-scaled selection coefficient')
# plot(phyloCorrelogram(FD_no_outlier_phylo_4d, trait = 'proportion_neutrality'), main='Phylogenetic correlogram of proportion of neutrality')
# plot(phyloCorrelogram(FD_no_outlier_phylo_4d, trait = 'shape'), main='Phylogenetic correlogram of Gamma-distributed DFE shape parameter')

# barplot(FD_no_outlier_phylo_4d, center=FALSE, scale=FALSE)
# 
# barplot(FD_no_outlier_phylo_4d)

# Comparison of Mean s

# Plot DFE Grid

mean_s_file_list = c(
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt'
)

# 
mean_s_comparison_matrix = matrix(, nrow=39, ncol=39)

for (i in 1:39) {
  for (j in i:39) {  # This change ensures only the upper right triangle is compared
    mean_i = compute_selection_coefficients(mean_s_file_list[i])[1]
    mean_j = compute_selection_coefficients(mean_s_file_list[j])[1]
    comparison = abs(mean_i - mean_j)
    mean_s_comparison_matrix[i, j] = comparison
    mean_s_comparison_matrix[j, i] = comparison  # Mirror the value across the diagonal
  }
}

core_within_genera_mean_s = c()
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_alistipes, FD_alistipes][lower.tri(mean_s_comparison_matrix[FD_alistipes, FD_alistipes])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_bacteroides, FD_bacteroides][lower.tri(mean_s_comparison_matrix[FD_bacteroides, FD_bacteroides])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_eubacterium, FD_eubacterium][lower.tri(mean_s_comparison_matrix[FD_eubacterium, FD_eubacterium])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium][lower.tri(mean_s_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_parabacteroides, FD_parabacteroides][lower.tri(mean_s_comparison_matrix[FD_parabacteroides, FD_parabacteroides])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_roseburia, FD_roseburia][lower.tri(mean_s_comparison_matrix[FD_roseburia, FD_roseburia])])
core_within_genera_mean_s = c(core_within_genera_mean_s, mean_s_comparison_matrix[FD_ruminococcus, FD_ruminococcus][lower.tri(mean_s_comparison_matrix[FD_ruminococcus, FD_ruminococcus])])
length(core_within_genera_mean_s) # 85 total within-genera comparisons

core_between_genera_mean_s = mean_s_comparison_matrix[lower.tri(mean_s_comparison_matrix)][!mean_s_comparison_matrix[lower.tri(mean_s_comparison_matrix)] %in% core_within_genera_mean_s]

mean_s_list <- melt(list(within_genera = core_within_genera_mean_s, between_genera = core_between_genera_mean_s))

between_within_mean_s_diff = abs(mean(core_between_genera_mean_s) - mean(core_within_genera_mean_s))

permutation_mean_s_diff = numeric(100000)

for (i in 1:100000) {
  this_scramble_between = sample(mean_s_list$value, size=656, replace=FALSE)
  this_scramble_within = sample(mean_s_list$value, size=85, replace=FALSE)
  permutation_mean_s_diff[i] = abs(mean(this_scramble_between) - mean(this_scramble_within))
}

permutation_mean_s_data = data.frame(permutation_mean_s_diff)

names(permutation_mean_s_data) = c('value')

sum(between_within_mean_s_diff > permutation_mean_s_data) / 100000

quantile_label = "Proportion of area:"

quantile_label = paste(quantile_label, sum(between_within_mean_s_diff > permutation_mean_s_data) / 100000, sep=' ')

permutation_mean_s = ggplot(permutation_mean_s_data, aes(x=value, y=..count..)) +
  geom_histogram(bins=100) +
  xlab('Absolute difference of mean selection coefficient') +
  ylab('Number of simulations') +
  geom_vline(xintercept = between_within_mean_s_diff, color='green', linetype='dotted', linewidth=3) +
  theme_minimal() +
  ggtitle('Simulated absolute difference of mean selection coefficients') +
  annotate("text", x=0.04, y=3500, label= quantile_label, size=5) +
  theme(axis.title=element_text(size=18)) +
  theme(plot.title=element_text(size=20))

ggsave('../Summary/permutation_mean_s.svg', permutation_mean_s, width=18, height=12, dpi=600)

set.seed(1)
mean_s_scramble_within_genera = sample(mean_s_list$value, size=85, replace=FALSE)
mean_s_scramble_between_genera = sample(mean_s_list$value, size=656, replace=FALSE)

mean_s_list <- melt(
  list(
    within_genera = core_within_genera_mean_s, between_genera = core_between_genera_mean_s, scrambled_within = mean_s_scramble_within_genera, scrambled_between = mean_s_scramble_between_genera
  )
)


mean_s_list$L1 = factor(mean_s_list$L1, levels=c('between_genera', 'within_genera', 'scrambled_between', 'scrambled_within'))

mean_s_LRT_distribution = ggplot(mean_s_list, aes(x=L1, y=value, fill=L1)) +
  geom_boxplot() +
  ylab('Absolute value of difference') +
  xlab('Comparison') +
  scale_fill_manual(labels=c('Between-genera', 'Within-genera', 'Permutation test (within)', 'Permutation test (between)'),
    breaks=c('between_genera', 'within_genera', 'scrambled_within', 'scrambled_between'),
    values=c("#69b3a2", "#95fd34", 'black', 'grey'),) +
  theme_minimal() +
  theme(axis.text.x=element_blank(),) +
  guides(fill=guide_legend(title="Type of DFE comparison")) +
  ggtitle('Absolute difference in mean selection coefficient for between-genera and within-genera DFE comparisons') +
  geom_signif(position='identity', y_position=0.75,
    comparisons = comparison_1, size=1,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', y_position=0.83,
    comparisons = comparison_2, size=1,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1,
    comparisons = comparison_3, y_position=0.91,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1,
    comparisons = comparison_4, y_position=0.99,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  theme(axis.title=element_text(size=18)) +
  theme(plot.title=element_text(size=20)) +
  theme(legend.title=element_text(size=18)) +
  theme(legend.text=element_text(size=16))

ggsave('../Summary/mean_s_LRT_distribution.svg', mean_s_LRT_distribution, width=18, height=12, dpi=600)

mean_2ns_demography_list = c(
  '../SupplementaryAnalysis/Alistipes_sp_60764/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/two_epoch_demography.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/two_epoch_demography.txt'
)

mean_2ns_dfe_list = c(
  '../SupplementaryAnalysis/Alistipes_sp_60764/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_finegoldii_56071/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_onderdonkii_55464/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_shahii_62199/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Alistipes_putredinis_61533/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroidales_bacterium_58650/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Odoribacter_splanchnicus_62174/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_distasonis_56985/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Parabacteroides_merdae_56972/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Prevotella_copri_61740/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_fragilis_54507/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_cellulosilyticus_58046/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_eggerthii_54457/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_stercoris_56735/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_uniformis_57318/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_thetaiotaomicron_56941/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_xylanisolvens_57185/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_caccae_53434/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_massiliensis_44749/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_vulgatus_57955/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_plebeius_61623/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Bacteroides_coprocola_61586/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Barnesiella_intestinihominis_62208/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Akkermansia_muciniphila_55290/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Dialister_invisus_61905/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Phascolarctobacterium_sp_59817/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_eligens_61678/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_rectale_56927/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_inulinivorans_61943/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Roseburia_intestinalis_56239/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Lachnospiraceae_bacterium_51870/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Coprococcus_sp_62244/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Oscillibacter_sp_60799/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bromii_62047/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Ruminococcus_bicirculans_59300/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Eubacterium_siraeum_57634/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_57453/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_62201/core_inferred_DFE.txt',
  '../SupplementaryAnalysis/Faecalibacterium_prausnitzii_61481/core_inferred_DFE.txt'
)

mean_2ns_comparison_matrix = matrix(, nrow=39, ncol=39)

for (i in 1:39) {
  for (j in i:39) {  # This change ensures only the upper right triangle is compared
    mean_i = compute_selection_coefficients(mean_2ns_dfe_list[i])[1]
    mean_j = compute_selection_coefficients(mean_2ns_dfe_list[j])[1]
    nanc_i = nanc_from_demography(mean_2ns_demography_list[i])
    nanc_j = nanc_from_demography(mean_2ns_demography_list[j])
    mean_2ns_i = 2 * mean_i * nanc_i
    mean_2ns_j = 2 * mean_j * nanc_j
    comparison = abs(mean_2ns_i - mean_2ns_j)
    mean_2ns_comparison_matrix[i, j] = comparison
    mean_2ns_comparison_matrix[j, i] = comparison  # Mirror the value across the diagonal
  }
}

core_within_genera_mean_2ns = c()
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_alistipes, FD_alistipes][lower.tri(mean_2ns_comparison_matrix[FD_alistipes, FD_alistipes])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_bacteroides, FD_bacteroides][lower.tri(mean_2ns_comparison_matrix[FD_bacteroides, FD_bacteroides])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_eubacterium, FD_eubacterium][lower.tri(mean_2ns_comparison_matrix[FD_eubacterium, FD_eubacterium])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium][lower.tri(mean_2ns_comparison_matrix[FD_faecalibacterium, FD_faecalibacterium])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_parabacteroides, FD_parabacteroides][lower.tri(mean_2ns_comparison_matrix[FD_parabacteroides, FD_parabacteroides])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_roseburia, FD_roseburia][lower.tri(mean_2ns_comparison_matrix[FD_roseburia, FD_roseburia])])
core_within_genera_mean_2ns = c(core_within_genera_mean_2ns, mean_2ns_comparison_matrix[FD_ruminococcus, FD_ruminococcus][lower.tri(mean_2ns_comparison_matrix[FD_ruminococcus, FD_ruminococcus])])
length(core_within_genera_mean_2ns) # 85 total within-genera comparisons

core_between_genera_mean_2ns = mean_2ns_comparison_matrix[lower.tri(mean_2ns_comparison_matrix)][!mean_2ns_comparison_matrix[lower.tri(mean_2ns_comparison_matrix)] %in% core_within_genera_mean_2ns]

mean_2ns_list <- melt(list(within_genera = core_within_genera_mean_2ns, between_genera = core_between_genera_mean_2ns))

between_within_mean_2ns_diff = abs(mean(core_between_genera_mean_2ns) - mean(core_within_genera_mean_2ns))

permutation_mean_2ns_diff = numeric(100000)

for (i in 1:100000) {
  this_scramble_between = sample(mean_2ns_list$value, size=656, replace=FALSE)
  this_scramble_within = sample(mean_2ns_list$value, size=85, replace=FALSE)
  permutation_mean_2ns_diff[i] = abs(mean(this_scramble_between) - mean(this_scramble_within))
}

# permutation_mean_2ns_data = data.frame(permutation_mean_2ns_diff)
#
# names(permutation_mean_2ns_data) = c('value')
#
# sum(between_within_mean_2ns_diff > permutation_mean_2ns_data) / 100000
#
# quantile_label = "Proportion of area:"
#
# quantile_label = paste(quantile_label, sum(between_within_mean_2ns_diff > permutation_mean_2ns_data) / 100000, sep=' ')
#
# permutation_mean_2ns = ggplot(permutation_mean_2ns_data, aes(x=value, y=..count..)) +
#   geom_histogram(bins=100) +
#   xlab('Absolute difference of mean population-scale selection coefficient') +
#   ylab('Number of simulations') +
#   geom_vline(xintercept = between_within_mean_2ns_diff, color='green', linetype='dotted', linewidth=3) +
#   theme_minimal() +
#   ggtitle('Simulated difference of mean population-scaled selection coefficients') +
#   annotate("text", x=3E6, y=3500, label= quantile_label, size=5) +
#   theme(axis.title=element_text(size=18)) +
#   theme(plot.title=element_text(size=20))
#
# ggsave('../Summary/permutation_mean_2ns.svg', permutation_mean_2ns, width=18, height=12, dpi=600)

set.seed(1)
mean_2ns_scramble_within_genera = sample(mean_2ns_list$value, size=85, replace=FALSE)
mean_2ns_scramble_between_genera = sample(mean_2ns_list$value, size=656, replace=FALSE)

mean_2ns_list <- melt(
  list(
    within_genera = core_within_genera_mean_2ns, between_genera = core_between_genera_mean_2ns, scrambled_within = mean_2ns_scramble_within_genera, scrambled_between = mean_2ns_scramble_between_genera
  )
)
#
mean_2ns_list$L1 = factor(mean_2ns_list$L1, levels=c('between_genera', 'within_genera', 'scrambled_between', 'scrambled_within'))

mean_2ns_LRT_distribution = ggplot(mean_2ns_list, aes(x=L1, y=value, fill=L1)) +
  geom_boxplot() +
  ylab('Absolute value of difference') +
  xlab('Comparison') +
  scale_fill_manual(labels=c('Between-genera', 'Within-genera', 'Permutation test (within)', 'Permutation test (between)'),
    breaks=c('between_genera', 'within_genera', 'scrambled_within', 'scrambled_between'),
    values=c("#69b3a2", "#95fd34", 'black', 'grey'),) +
  theme_minimal() +
  theme(axis.text.x=element_blank(),) +
  guides(fill=guide_legend(title="Type of DFE comparison")) +
  ggtitle('Absolute difference in mean population-scaled selection coefficient for between-genera and within-genera DFE comparisons') +
  geom_signif(position='identity', y_position=7E7,
    comparisons = comparison_1, size=1,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1, y_position=7.5E7,
    comparisons = comparison_2,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1,
    comparisons = comparison_3, y_position=8E7,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  geom_signif(position='identity', size=1,
    comparisons = comparison_4, y_position=8.5E7,
                map_signif_level = function(x) paste("p =", scales::pvalue(x))) +
  theme(axis.title=element_text(size=18)) +
  theme(plot.title=element_text(size=20)) +
  theme(legend.title=element_text(size=18)) +
  theme(legend.text=element_text(size=16))

ggsave('../Summary/mean_2ns_LRT_distribution.svg', mean_2ns_LRT_distribution, width=18, height=12, dpi=600)

LRT_box_and_whiskers = LRT_distribution + 
  mean_s_LRT_distribution + theme(legend.position = 'none') +
  mean_2ns_LRT_distribution + theme(legend.position = 'none') + plot_layout(ncol=1)

ggsave('../Summary/LRT_box_and_whiskers.svg', LRT_box_and_whiskers, width=18, height=36, dpi=600)
#
# LRT_full_figure = LRT_distribution + permutation_LRT +
#   mean_s_LRT_distribution + theme(legend.position = 'none') + permutation_mean_s +
#   mean_2ns_LRT_distribution + theme(legend.position = 'none') + permutation_mean_2ns +
#   plot_layout(ncol=2)
#
# ggsave('../Summary/LRT_full_figure.svg', LRT_full_figure, width=36, height=36, dpi=600)
# 
# Fraction of sites remaining
survival_curve_file_list = c(
  '../HighRecombinationAnalysis/Akkermansia_muciniphila_55290/survival_curve.csv',
  '../HighRecombinationAnalysis/Alistipes_finegoldii_56071/survival_curve.csv',
  '../HighRecombinationAnalysis/Alistipes_onderdonkii_55464/survival_curve.csv',
  '../HighRecombinationAnalysis/Alistipes_shahii_62199/survival_curve.csv',
  '../HighRecombinationAnalysis/Bacteroides_caccae_53434/survival_curve.csv',
  '../HighRecombinationAnalysis/Bacteroides_cellulosilyticus_58046/survival_curve.csv',
  '../HighRecombinationAnalysis/Bacteroides_fragilis_54507/survival_curve.csv',
  '../HighRecombinationAnalysis/Bacteroides_stercoris_56735/survival_curve.csv',
  '../HighRecombinationAnalysis/Bacteroides_thetaiotaomicron_56941/survival_curve.csv',
  '../HighRecombinationAnalysis/Bacteroides_vulgatus_57955/survival_curve.csv',
  '../HighRecombinationAnalysis/Barnesiella_intestinihominis_62208/survival_curve.csv',
  '../HighRecombinationAnalysis/Dialister_invisus_61905/survival_curve.csv',
  '../HighRecombinationAnalysis/Eubacterium_rectale_56927/survival_curve.csv',
  '../HighRecombinationAnalysis/Oscillibacter_sp_60799/survival_curve.csv',
  '../HighRecombinationAnalysis/Parabacteroides_distasonis_56985/survival_curve.csv',
  '../HighRecombinationAnalysis/Parabacteroides_merdae_56972/survival_curve.csv',
  '../HighRecombinationAnalysis/Ruminococcus_bicirculans_59300/survival_curve.csv',
  '../HighRecombinationAnalysis/Ruminococcus_bromii_62047/survival_curve.csv'
)

survival_curve_fraction_list = c()

for (i in 1:length(survival_curve_file_list)) {
  this_table = read.csv(survival_curve_file_list[i])
  this_fraction = this_table$Remaining.sites[50] / this_table$Remaining.sites[1]
  survival_curve_fraction_list = c(survival_curve_fraction_list, this_fraction)
}

# num_iLDS_peaks = read.csv('../HighRecombinationData/num_iLDS_peaks.csv')

# temp_table = read.csv(survival_curve_file_list[1])


