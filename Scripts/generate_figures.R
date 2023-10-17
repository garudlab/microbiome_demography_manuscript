library(ggplot2)
library(ggrepel)
library(ggsignif)
#install.packages("ggpubr")
library(ggpubr)
library(dplyr)
library(fitdistrplus)
library(scales)
library(reshape2)
library(stringr)
library(ggridges)
library(forcats)
library("ggrepel")
library(patchwork)
library(ape)
library(ggtree)
library(treeio)
# install.packages('plotly')
library(plotly)
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
library(latex2exp)
library(ggvis)
library(pheatmap)
library(ComplexHeatmap)
library(phytools)
# BiocManager::install("ComplexHeatmap")
library(mdthemes)

# BiocManager::install("treeio")
# BiocManager::install("ggtree")

fold_sfs = function(input_sfs) {
  input_length = length(input_sfs)
  folded_length = length(input_sfs) / 2
  if (input_length %% 2 == 1) {
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
  return (input_sfs / sum(input_sfs))
}

read_input_sfs = function(input_file)  {
  ## Reads input SFS in Dadi Format
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[2]
  output_sfs = as.numeric(unlist(strsplit(sfs_string, ' ')))
  output_sfs = output_sfs[-1] ## Remove 0-tons
  output_sfs = fold_sfs(output_sfs)
  return(output_sfs)
}

read_input_sfs_original = function(input_file)  {
  ## Reads input SFS in Dadi Format
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[2]
  output_sfs = as.numeric(unlist(strsplit(sfs_string, ' ')))
  return(output_sfs)
}

sfs_from_demography = function(input_file) {
  ## Reads input SFS from output *demography.txt
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[8]
  output_sfs = strsplit(sfs_string, '-- ')
  output_sfs = unlist(output_sfs)[2]
  output_sfs = unlist(strsplit(output_sfs, ' '))
  output_sfs = output_sfs[-length(output_sfs)]
  ## output_sfs = output_sfs[-1]
  output_sfs = as.numeric(output_sfs)
  output_sfs = fold_sfs(output_sfs)
  return(output_sfs)
}

gamma_sfs_from_dfe = function(input_file) {
  ## Reads input SFS from output *demography.txt
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[7]
  output_sfs = strsplit(sfs_string, '-- ')
  output_sfs = unlist(output_sfs)[2]
  output_sfs = unlist(strsplit(output_sfs, ' '))
  # output_sfs = output_sfs[-length(output_sfs)]
  ## output_sfs = output_sfs[-1]
  output_sfs = as.numeric(output_sfs)
  return(output_sfs)
}

neugamma_sfs_from_dfe = function(input_file) {
  ## Reads input SFS from output *demography.txt
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[14]
  output_sfs = strsplit(sfs_string, '-- ')
  output_sfs = unlist(output_sfs)[2]
  output_sfs = unlist(strsplit(output_sfs, ' '))
  # output_sfs = output_sfs[-length(output_sfs)]
  ## output_sfs = output_sfs[-1]
  output_sfs = as.numeric(output_sfs)
  return(output_sfs)
}

empirical_sfs_from_dfe = function(input_file) {
  ## Reads input SFS from output *demography.txt
  this_file = file(input_file)
  on.exit(close(this_file))
  sfs_string = readLines(this_file)[6]
  output_sfs = strsplit(sfs_string, '-- ')
  output_sfs = unlist(output_sfs)[2]
  output_sfs = unlist(strsplit(output_sfs, ' '))
  # output_sfs = output_sfs[-length(output_sfs)]
  ## output_sfs = output_sfs[-1]
  output_sfs = as.numeric(output_sfs)
  return(output_sfs)
}

plot_likelihood_surface = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')

  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]

  MLE = max(species_surface$likelihood)
  MLE_minus_3 = MLE - 3
  MLE_minus_3_label = paste('<= ', str_trunc(toString(MLE_minus_3), 6, ellipsis=''), sep='')
  MLE_minus_1 = MLE - 1
  MLE_minus_1_label = paste(str_trunc(toString(MLE_minus_3), 6, ellipsis=''), ' <= ', str_trunc(toString(MLE_minus_1), 9, ellipsis=''), sep='')
  MLE_minus_half = MLE - 0.5
  MLE_minus_half_label  = paste(str_trunc(toString(MLE_minus_1), 6, ellipsis=''), ' <= ', str_trunc(toString(MLE_minus_half), 6, ellipsis=''), sep='')
  MLE_label = paste(str_trunc(toString(MLE_minus_half), 6, ellipsis=''), ' <= ', str_trunc(toString(MLE), 6, ellipsis=''), sep='')
  color_breakpoints = cut(species_surface$likelihood, c(-Inf, MLE_minus_3, MLE_minus_1, MLE_minus_half, MLE))
  species_surface_scatter = ggplot(data=species_surface, aes(x=nu, y=tau), color=likelihood) + 
    # geom_point(aes(colour = likelihood), size=1) +
    geom_point(aes(colour = color_breakpoints), size = 4, shape=15) +
    scale_color_manual(name='Log Likelihood',
                       values=c('#a6611a', '#dfc27d', '#80cdc1', '#018571'),
                       labels=c('(-Inf, -3]', '(-3, -1]', '(-1, -0.5', '(-0,5, 0]')) +
    geom_vline(xintercept=1.0, color='red', linewidth=2) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    xlab('Nu') +
    ylab('Tau')

  return(species_surface_scatter)
}

plot_likelihood_surface_contour = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  unique_nu = unique(species_surface$nu)
  unique_tau = unique(species_surface$tau)
  Z = matrix(data=NA, nrow=length(unique_nu), ncol=length(unique_tau))
  count = 1
  for (i in 1:length(unique_nu)) {
    for (j in 1:length(unique_tau)) {
      Z[i, j] = species_surface$likelihood[count]
      if (species_surface$nu[count] != unique_nu[i]) {
        print('break')
      } else if (species_surface$tau[count] != unique_tau[j]) {
        print('break')
      }
      count = count + 1
    }
 }
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  best_params = c(species_surface$nu[1], species_surface$tau[1])
  print(best_params)
  MLE = max(species_surface$likelihood)
  print(MLE)
  species_surface$likelihood = species_surface$likelihood - MLE
  color_breakpoints = cut(species_surface$likelihood, c(-Inf, -3, -1, -0.5, 0))

  likelihood_surface_title = paste('MLE @ [', str_trunc(toString(best_params[1]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ', ', sep='')
  likelihood_surface_title = paste(likelihood_surface_title, str_trunc(toString(best_params[2]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ']', sep='')
  
  xlabel_text = expression(nu == frac(N[current], N[ancestral]))
  ylabel_text = expression(tau == frac(generations, 2 * N[ancestral]))
  fig = ggplot(species_surface) +
    geom_contour_filled(aes(x=nu, y=tau, z=likelihood), 
      # breaks = c(-Inf, -3, -1, -0.5, 0)) +
      breaks = c(0, -0.5, -1, -3, -Inf)) +
    scale_fill_brewer(palette = "YlGnBu", direction=1, name='Log Likelihood') +
    geom_vline(xintercept=1.0, color='red', linewidth=1, linetype='dashed') +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    annotate('point', x=best_params[1], y=best_params[2], color='orange', size=2) +
    xlab(xlabel_text)  +
    ylab(ylabel_text)
    # ggtitle(likelihood_surface_title)
  return(fig)
}

plot_likelihood_surface_contour_3C = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  unique_nu = unique(species_surface$nu)
  unique_tau = unique(species_surface$tau)
  Z = matrix(data=NA, nrow=length(unique_nu), ncol=length(unique_tau))
  count = 1
  for (i in 1:length(unique_nu)) {
    for (j in 1:length(unique_tau)) {
      Z[i, j] = species_surface$likelihood[count]
      if (species_surface$nu[count] != unique_nu[i]) {
        print('break')
      } else if (species_surface$tau[count] != unique_tau[j]) {
        print('break')
      }
      count = count + 1
    }
 }
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  best_params = c(species_surface$nu[1], species_surface$tau[1])
  print(best_params)
  MLE = max(species_surface$likelihood)
  species_surface$likelihood = species_surface$likelihood - MLE
  color_breakpoints = cut(species_surface$likelihood, c(-Inf, -3, -1, -0.5, 0))

  likelihood_surface_title = paste('MLE @ [', str_trunc(toString(best_params[1]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ', ', sep='')
  likelihood_surface_title = paste(likelihood_surface_title, str_trunc(toString(best_params[2]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ']', sep='')
  
  xlabel_text = expression(nu == frac(N[current], N[ancestral]))
  ylabel_text = expression(tau == frac(generations, 2 * N[ancestral]))
  fig = ggplot(species_surface) +
    geom_contour_filled(aes(x=nu, y=tau, z=likelihood), 
      # breaks = c(-Inf, -3, -1, -0.5, 0)) +
      breaks = c(0, -0.5, -1, -3, -Inf)) +
    scale_fill_brewer(palette = "YlGnBu", direction=1, name='Log Likelihood') +
    geom_vline(xintercept=1.0, color='red', linewidth=1, linetype='dashed') +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    annotate('point', x=best_params[1], y=best_params[2], color='orange', size=1) +
    theme(legend.position = c(0.75, 0.75)) +
    theme(legend.text=element_text(size=10)) +
    theme(axis.title.x = element_blank()) +
    ylab(ylabel_text) +
    theme(axis.text=element_text(size=12),
      axis.title=element_text(size=16))
  return(fig)
}

plot_likelihood_surface_contour_3D = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  unique_nu = unique(species_surface$nu)
  unique_tau = unique(species_surface$tau)
  Z = matrix(data=NA, nrow=length(unique_nu), ncol=length(unique_tau))
  count = 1
  for (i in 1:length(unique_nu)) {
    for (j in 1:length(unique_tau)) {
      Z[i, j] = species_surface$likelihood[count]
      if (species_surface$nu[count] != unique_nu[i]) {
        print('break')
      } else if (species_surface$tau[count] != unique_tau[j]) {
        print('break')
      }
      count = count + 1
    }
 }
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  best_params = c(species_surface$nu[1], species_surface$tau[1])
  print(best_params)
  MLE = max(species_surface$likelihood)
  species_surface$likelihood = species_surface$likelihood - MLE
  color_breakpoints = cut(species_surface$likelihood, c(-Inf, -3, -1, -0.5, 0))

  likelihood_surface_title = paste('MLE @ [', str_trunc(toString(best_params[1]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ', ', sep='')
  likelihood_surface_title = paste(likelihood_surface_title, str_trunc(toString(best_params[2]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ']', sep='')
  
  xlabel_text = expression(nu == frac(N[current], N[ancestral]))
  ylabel_text = expression(tau == frac(generations, 2 * N[ancestral]))
  fig = ggplot(species_surface) +
    geom_contour_filled(aes(x=nu, y=tau, z=likelihood), 
      breaks = c(0, -0.5, -1, -3, -Inf)) +
    scale_fill_brewer(palette = "YlGnBu", direction=1, name='Log Likelihood') +
    geom_vline(xintercept=1.0, color='red', linewidth=1, linetype='dashed') +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    annotate('point', x=best_params[1], y=best_params[2], color='orange', size=1) +
    theme(legend.position = "none") +
    xlab(xlabel_text) +
    ylab(ylabel_text) +
    theme(axis.text=element_text(size=12),
      axis.title=element_text(size=16))
    # ggtitle(likelihood_surface_title)
  return(fig)
}

plot_likelihood_surface_contour_talk = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  unique_nu = unique(species_surface$nu)
  unique_tau = unique(species_surface$tau)
  Z = matrix(data=NA, nrow=length(unique_nu), ncol=length(unique_tau))
  count = 1
  for (i in 1:length(unique_nu)) {
    for (j in 1:length(unique_tau)) {
      Z[i, j] = species_surface$likelihood[count]
      if (species_surface$nu[count] != unique_nu[i]) {
        print('break')
      } else if (species_surface$tau[count] != unique_tau[j]) {
        print('break')
      }
      count = count + 1
    }
 }
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  best_params = c(species_surface$nu[1], species_surface$tau[1])
  print(best_params)
  MLE = max(species_surface$likelihood)
  species_surface$likelihood = species_surface$likelihood - MLE
  color_breakpoints = cut(species_surface$likelihood, c(-Inf, -3, -1, -0.5, 0))

  likelihood_surface_title = paste('MLE @ [', str_trunc(toString(best_params[1]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ', ', sep='')
  likelihood_surface_title = paste(likelihood_surface_title, str_trunc(toString(best_params[2]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ']', sep='')
  
  xlabel_text = expression(nu == frac(N[current], N[ancestral]))
  ylabel_text = expression(tau == frac(generations, 2 * N[ancestral]))
  fig = ggplot(species_surface) +
    geom_contour_filled(aes(x=nu, y=tau, z=likelihood), 
      # breaks = c(-Inf, -3, -1, -0.5, 0)) +
      breaks = c(0, -0.5, -1, -3, -Inf)) +
    scale_fill_brewer(palette = "YlGnBu", direction=1, name='Log Likelihood') +
    geom_vline(xintercept=1.0, color='red', linewidth=1, linetype='dashed') +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    annotate('point', x=best_params[1], y=best_params[2], color='orange', size=2) +
    theme(legend.position = c(0.77, 0.65)) +
    theme(legend.text=element_text(size=14)) +
    xlab(xlabel_text) +
    ylab(ylabel_text) +
    theme(axis.text=element_text(size=12),
      axis.title=element_text(size=16))
    theme(axis.text=element_text(size=12),
      axis.title=element_text(size=16))
  return(fig)
}



compare_sfs = function(empirical, one_epoch, two_epoch) {
  x_axis = 1:length(empirical)

  input_df = data.frame(empirical,
                        two_epoch,
                        one_epoch,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'Two-epoch',
                      'One-epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}


compare_hmp_sfs = function(complete, one_epoch, two_epoch, three_epoch, nonsyn, gamma, neugamma) {
  x_axis = 1:length(one_epoch)
  
  input_df = data.frame(proportional_sfs(complete[-1]),
                        proportional_sfs(one_epoch),
                        proportional_sfs(two_epoch),
                        proportional_sfs(three_epoch),
                        proportional_sfs(nonsyn[-1]),
                        proportional_sfs(gamma),
                        proportional_sfs(neugamma),
                        x_axis)
  
  names(input_df) = c('Synonymous SFS',
                      'One Epoch',
                      'Two Epoch',
                      'Three Epoch',
                      'Nonsynonymous SFS',
                      'Gamma DFE',
                      'Neu + Gamma DFE',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    scale_fill_manual(values=c("blue4", "dodgerblue3", "steelblue1",  "lightskyblue2",
      "goldenrod3", "goldenrod1", "yellow2"))
  
  return(p_input_comparison)
}

compare_isolate_sfs = function(HMP_QP, Isolate, one_epoch, two_epoch) {
  x_axis = 1:length(HMP_QP)
  
  input_df = data.frame(proportional_sfs(HMP_QP), 
                        proportional_sfs(Isolate), 
                        proportional_sfs(one_epoch),
                        proportional_sfs(two_epoch),
                        x_axis)
  
  names(input_df) = c('HMP QP',
                      'Isolate',
                      'One epoch (Isolate)',
                      'Two epoch (Isolate)',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    ylim(0, 1.0)
  return(p_input_comparison)
}

compare_sfs_cornejo_count = function(input_directory) {
  empirical_syn_sfs_file = paste(input_directory, 'downsampled_syn_sfs.txt', sep='')
  model_syn_sfs_file = paste(input_directory, 'two_epoch_demography.txt', sep='')
  nonsyn_sfs_file = paste(input_directory, 'inferred_DFE.txt', sep='')
  
  model_syn_sfs = sfs_from_demography(model_syn_sfs_file)
  empirical_nonsyn_sfs = empirical_sfs_from_dfe(nonsyn_sfs_file)
  model_nonsyn_sfs = gamma_sfs_from_dfe(nonsyn_sfs_file)
  neugamma_nonsyn_sfs = neugamma_sfs_from_dfe(nonsyn_sfs_file)
  
  x_axis = 1:length(empirical_nonsyn_sfs)
  
  input_df = data.frame(empirical_nonsyn_sfs,
                        model_syn_sfs,
                        model_nonsyn_sfs,
                        neugamma_nonsyn_sfs,
                        x_axis)
  
  names(input_df) = c('Empirical nonsynonymous',
                      'Two-epoch Demography',
                      'Gamma-distributed DFE',
                      'Neu-gamma-distributed DFE',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)  
}

compare_isolate_hmp_sfs = function(hmp_orig, orig_demo, hmp_complete, complete_demo, isolate, isolate_demo, one_epoch) {
  x_axis = 1:length(hmp_orig)
  
  input_df = data.frame(proportional_sfs(hmp_orig),
                        proportional_sfs(orig_demo),
                        proportional_sfs(hmp_complete),
                        proportional_sfs(complete_demo),
                        proportional_sfs(isolate),
                        proportional_sfs(isolate_demo),
                        proportional_sfs(one_epoch),
                        x_axis)
  
  names(input_df) = c('HMP (Garud/Good)',
                      'Garud/Good Two Epoch',
                      'HMP (Complete)',
                      'Complete Two Epoch',
                      'UHGG Isolate',
                      'Isolate Two Epoch',
                      'One Epoch',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    ylim(0, 1.0)
  return(p_input_comparison)
}

compare_sfs_cornejo_proportional = function(input_directory) {
  empirical_syn_sfs_file = paste(input_directory, 'downsampled_syn_sfs.txt', sep='')
  model_syn_sfs_file = paste(input_directory, 'two_epoch_demography.txt', sep='')
  nonsyn_sfs_file = paste(input_directory, 'inferred_DFE.txt', sep='')
  
  model_syn_sfs = proportional_sfs(sfs_from_demography(model_syn_sfs_file))
  empirical_nonsyn_sfs = proportional_sfs(empirical_sfs_from_dfe(nonsyn_sfs_file))
  model_nonsyn_sfs = proportional_sfs(gamma_sfs_from_dfe(nonsyn_sfs_file))
  neugamma_nonsyn_sfs = proportional_sfs(neugamma_sfs_from_dfe(nonsyn_sfs_file))
  
  x_axis = 1:length(empirical_nonsyn_sfs)
  
  input_df = data.frame(empirical_nonsyn_sfs,
                        model_syn_sfs,
                        model_nonsyn_sfs,
                        neugamma_nonsyn_sfs,
                        x_axis)
  
  names(input_df) = c('Empirical nonsynonymous',
                      'Two-epoch Demography',
                      'Gamma-distributed DFE',
                      'Neu-gamma-distributed DFE',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)  
}

compare_sfs_with_selection_count = function(input_directory) {
  empirical_syn_sfs_file = paste(input_directory, 'downsampled_syn_sfs.txt', sep='')
  model_syn_sfs_file = paste(input_directory, 'two_epoch_demography.txt', sep='')
  nonsyn_sfs_file = paste(input_directory, 'inferred_DFE.txt', sep='')

  empirical_syn_sfs = read_input_sfs(empirical_syn_sfs_file)
  model_syn_sfs = sfs_from_demography(model_syn_sfs_file)
  empirical_nonsyn_sfs = empirical_sfs_from_dfe(nonsyn_sfs_file)
  model_nonsyn_sfs = gamma_sfs_from_dfe(nonsyn_sfs_file)
  
  x_axis = 1:length(empirical_syn_sfs)
  
  input_df = data.frame(empirical_syn_sfs,
                        model_syn_sfs,
                        empirical_nonsyn_sfs,
                        model_nonsyn_sfs,
                        x_axis)
  
  names(input_df) = c('Empirical synonymous',
                      'Two-epoch Demography',
                      'Empirical nonsynonymous',
                      'Gamma-distributed DFE',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_sfs_with_selection_proportional = function(input_directory) {
  empirical_syn_sfs_file = paste(input_directory, 'downsampled_syn_sfs.txt', sep='')
  model_syn_sfs_file = paste(input_directory, 'two_epoch_demography.txt', sep='')
  nonsyn_sfs_file = paste(input_directory, 'inferred_DFE.txt', sep='')

  empirical_syn_sfs = proportional_sfs(read_input_sfs(empirical_syn_sfs_file))
  model_syn_sfs = proportional_sfs(sfs_from_demography(model_syn_sfs_file))
  empirical_nonsyn_sfs = proportional_sfs(empirical_sfs_from_dfe(nonsyn_sfs_file))
  model_nonsyn_sfs = proportional_sfs(gamma_sfs_from_dfe(nonsyn_sfs_file))
  
  x_axis = 1:length(empirical_syn_sfs)
  
  input_df = data.frame(empirical_syn_sfs,
                        model_syn_sfs,
                        empirical_nonsyn_sfs,
                        model_nonsyn_sfs,
                        x_axis)
  
  names(input_df) = c('Empirical synonymous',
                      'Two-epoch Demography',
                      'Empirical nonsynonymous',
                      'Gamma-distributed DFE',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Count of Segregating Sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

plot_original_empirical_sfs = function(input) {
  x_axis = 0:(length(input)-1)
  
  input_df = data.frame(input,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(-0.5, length(x_axis) + 0.5)) +
    ylab('Number of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

  return(p_input_comparison)
}

plot_empirical_sfs = function(input) {
  x_axis = 1:(length(input))
  
  input_df = data.frame(input,
                        x_axis)
  
  names(input_df) = c('Empirical',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                               aes(x=x_axis, 
                                   y=value,
                                   fill=variable)) +
    geom_bar(position='dodge2', stat='identity', color='black', fill='black') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Number of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    theme(legend.position='none')

  return(p_input_comparison)
}

read_dfe_params = function(input_dfe_file) {
    ## Reads input DFE from output *inferred_DFE.txt
  this_file = file(input_dfe_file) # Open file
  on.exit(close(this_file)) # Close when done
  # Parse file and string manipulation
  param_string_high = readLines(this_file)[4]

  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string_high, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  # Convert the extracted strings to numeric values
  gamma_shape <- as.numeric(floats[[1]][1])
  gamma_scale_high <- as.numeric(floats[[1]][2])

  param_string_low = readLines(this_file)[5]
  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string_low, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  # Convert the extracted strings to numeric values
  gamma_scale_low <- as.numeric(floats[[1]][2])
  
  gamma_dfe_dist_high = rgamma(100000, shape=gamma_shape, scale=gamma_scale_high)
  gamma_dfe_dist_low = rgamma(100000, shape=gamma_shape, scale=gamma_scale_low)
  
  param_string_high = readLines(this_file)[11]
  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string_high, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  # Convert the extracted strings to numeric values
  neugamma_proportion = as.numeric(floats[[1]][1])
  neugamma_shape = as.numeric(floats[[1]][2])
  neugamma_scale_high = as.numeric(floats[[1]][3])
  
  param_string_low = readLines(this_file)[12]
  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string_low, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  neugamma_scale_low <- as.numeric(floats[[1]][2])

  neugamma_dfe_dist_high = rgamma(100000, shape=neugamma_shape, scale=neugamma_scale_high)
  neugamma_dfe_dist_low = rgamma(100000, shape=neugamma_shape, scale=neugamma_scale_low)
  
  zeroed_sites = as.integer(100000 * neugamma_proportion)
  
  neugamma_dfe_dist_high[1:zeroed_sites] = 0 
  neugamma_dfe_dist_low[1:zeroed_sites] = 0
  
  dfe_df = data.frame(gamma_dfe_dist_high, 
                      gamma_dfe_dist_low,
                      neugamma_dfe_dist_high,
                      neugamma_dfe_dist_low)
  return(dfe_df)
}

read_dfe_dadi_params = function(input_dfe_file) {
  # Reads input DFE from output *inferred_DFE.txt
  this_file = file(input_dfe_file) # Open file
  on.exit(close(this_file)) # Close when done
  # Parse file and string manipulation
  param_string = readLines(this_file)[3]
  
  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  # Convert the extracted strings to numeric values
  gamma_shape <- as.numeric(floats[[1]][1])
  gamma_scale <- as.numeric(floats[[1]][2])

  gamma_dfe_dist = rgamma(100000, shape=gamma_shape, scale=gamma_scale)

  param_string = readLines(this_file)[10]
  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  # Convert the extracted strings to numeric values
  neugamma_proportion <- as.numeric(floats[[1]][1])
  neugamma_shape <- as.numeric(floats[[1]][2])
  neugamma_scale <- as.numeric(floats[[1]][3])
  
  neugamma_dfe_dist = rgamma(100000, shape=neugamma_shape, scale=neugamma_scale)

  zeroed_sites = as.integer(100000 * neugamma_proportion)
  
  neugamma_dfe_dist[1:zeroed_sites] = 0 

  dfe_df = data.frame(gamma_dfe_dist, 
                      neugamma_dfe_dist)
  return(dfe_df)
}

plot_dfe = function(input_dfe_file) {
  ## Reads input DFE from output *inferred_DFE.txt
  this_file = file(input_dfe_file) # Open file
  on.exit(close(this_file)) # Close when done
  # Parse file and string manipulation
  param_string_high = readLines(this_file)[4]
  param_string_high = strsplit(param_string_high, split=': ')
  param_string_high = unlist(param_string_high)[2]
  param_string_high = str_sub(param_string_high, 2, -3)
  param_string_high = unlist(strsplit(param_string_high, ' '))
  param_string_high = as.numeric(param_string_high)
  
  gamma_shape = param_string_high[1]
  gamma_scale_high = param_string_high[2]
  
  param_string_low = readLines(this_file)[5]
  param_string_low = strsplit(param_string_low, split=': ')
  param_string_low = unlist(param_string_low)[2]
  param_string_low = str_sub(param_string_low, 2, -3)
  param_string_low = unlist(strsplit(param_string_low, ' '))
  param_string_low = as.numeric(param_string_low)
  
  gamma_scale_low = param_string_low[2]
  
  # gamma_dfe_bound_high = compute_dfe_height(shape=gamma_shape, scale=gamma_scale_high)
  # gamma_dfe_bound_low = compute_dfe_height(shape=gamma_shape, scale=gamma_scale_low)
  
  gamma_dfe_dist_high = rgamma(100000, shape=gamma_shape, scale=gamma_scale_high)
  gamma_dfe_dist_low = rgamma(100000, shape=gamma_shape, scale=gamma_scale_low)
  
  param_string_high = readLines(this_file)[11]
  param_string_high = strsplit(param_string_high, split=': ')
  param_string_high = unlist(param_string_high)[2]
  param_string_high = str_sub(param_string_high, 2, -3)
  param_string_high = unlist(strsplit(param_string_high, ' '))
  param_string_high = as.numeric(param_string_high)
  
  neugamma_proportion = param_string_high[1]
  neugamma_shape = param_string_high[2]
  neugamma_scale_high = param_string_high[3]
  
  param_string_low = readLines(this_file)[12]
  param_string_low = strsplit(param_string_low, split=': ')
  param_string_low = unlist(param_string_low)[2]
  param_string_low = str_sub(param_string_low, 2, -3)
  param_string_low = unlist(strsplit(param_string_low, ' '))
  param_string_low = as.numeric(param_string_low)
  
  neugamma_scale_low = param_string_low[3]
  
  # neugamma_dfe_bound_high = compute_dfe_height(shape=neugamma_shape, scale=neugamma_scale_high)
  # neugamma_dfe_bound_low = compute_dfe_height(shape=neugamma_shape, scale=neugamma_scale_low)
  
  neugamma_dfe_dist_high = rgamma(100000, shape=neugamma_shape, scale=neugamma_scale_high)
  neugamma_dfe_dist_low = rgamma(100000, shape=neugamma_shape, scale=neugamma_scale_low)
  
  zeroed_sites = as.integer(100000 * neugamma_proportion)
  
  neugamma_dfe_dist_high[1:zeroed_sites] = 1e-06* 1.1
  neugamma_dfe_dist_low[1:zeroed_sites] = 1e-06 * 1.1
  
  dfe_df = data.frame(gamma_dfe_dist_high, 
                      gamma_dfe_dist_low,
                      neugamma_dfe_dist_high,
                      neugamma_dfe_dist_low)
  dfe_df[dfe_df < 1e-9] = 1e-9
  
  names(dfe_df) = c('Gamma, mu=6.93E-10', 'Gamma, mu=4.08E-10',
                    'Neugamma, mu=6.93E-10', 'Neugamma, mu=4.08E-10')

  fig = ggplot(melt(dfe_df), aes(x=value, y=..density.., fill=variable)) +
    geom_histogram(position='dodge',
                   breaks=c(0.000000001, 0.00000001,  0.0000001, 0.000001, 0.0001)) +
    scale_x_log10() +
    ylab('Proportion of sites') +
    xlab('Selection coefficient') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    guides(fill=guide_legend(title="Estimated mutation rate"))
  return(fig)
}

plot_core_accessory_dfe = function(input_dfe_file) {
  ## Reads input DFE from output *inferred_DFE.txt
  this_file = file(input_dfe_file) # Open file
  on.exit(close(this_file)) # Close when done
  # Parse file and string manipulation

  param_string_low = readLines(this_file)[5]
  
  # Extract the two floats using regular expression
  floats <- str_extract_all(param_string_low, "[+-]?\\d*\\.?\\d+(?:[eE][+-]?\\d+)?")
  
  # Convert the extracted strings to numeric values
  gamma_shape <- as.numeric(floats[[1]][1])
  gamma_scale_low <- as.numeric(floats[[1]][2])

  gamma_dfe_dist_low = rgamma(100000, shape=gamma_shape, scale=gamma_scale_low)

  dfe_df = data.frame(gamma_dfe_dist_low)
  dfe_df[dfe_df < 1e-15] = 1e-12
  dfe_df[dfe_df > 0.5] = 0.5

  grey_red_gradient <- c("#9b9b9b",
  "#9f9391",
  "#a28b87",
  "#a5837d",
  "#a77b74",
  "#a9736a",
  "#aa6a61",
  "#ab6257",
  "#ab594e",
  "#ab5045",
  "#ab463c",
  "#aa3c33",
  "#a9302b",
  "#a82222")

  fig = ggplot(melt(dfe_df), aes(x=value, y=..density.., fill=variable)) +
    geom_histogram(position='dodge',
                   breaks=c(1E-13, 1E-12, 1E-11, 1E-10, 1E-9, 1E-8, 1E-7, 1E-6, 1E-5, 1E-4, 1E-3, 1E-2, 1E-1, 1E0, 1E1),
      show.legend = FALSE, fill=grey_red_gradient) +
    # geom_density() +
    scale_x_log10(limits=c(1E-13, 1E1)) +
    ylab('Proportion of variants') +
    xlab('Selection coefficient') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  return(fig)
}

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
    theme(legend.position="none") +
    theme(plot.title = element_text(face = "italic"))
  return(fig)
}

plot_best_fit_sfs_3A = function(input_data) {
  input_data = data.frame(input_data)
  colnames(input_data) = c(
    'Empirical Synonymous', 
    'MLE Synonymous',
    'Empirical Nonsynonymous',
    'MLE Nonsynonymous',
    'Species',
    'X.axis')
  fig = ggplot(melt(input_data, id=c('Species', 'X.axis')), aes(x=X.axis, y=as.numeric(value), fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    scale_fill_manual(values=c("blue4", "steelblue3", "goldenrod3", "goldenrod1"), name='Site-frequency-spectra') +
    # scale_fill_manual(values=c("#cb181d", "#fb6a4a", "blue4", "steelblue3"), name='Site-frequency-spectra') +
    theme(legend.position = c(0.7, 0.75)) +
    theme(legend.text=element_text(size=10)) +    
    theme(plot.title = element_text(face = "italic", size=16)) +
    theme(axis.text=element_text(size=12),
      axis.title=element_text(size=16))
  return(fig)
}

plot_best_fit_sfs_3B = function(input_data) {
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
    # scale_fill_manual(values=c("#cb181d", "#fb6a4a", "blue4", "steelblue3"), name='Site-frequency-spectra') +
    theme(legend.position="none") +
    theme(plot.title = element_text(face = "italic", size=16)) +
    theme(axis.text=element_text(size=12),
      axis.title=element_text(size=16))
  return(fig)
}

plot_best_fit_sfs_talk = function(input_data) {
  input_data = data.frame(input_data)
  colnames(input_data) = c(
    'Empirical Synonymous', 
    'MLE Synonymous',
    'Empirical Nonsynonymous',
    'MLE Nonsynonymous',
    'Species',
    'X.axis')
  
  input_data <- input_data[, c(1, 2, 5, 6)]
  
  fig = ggplot(melt(input_data, id=c('Species', 'X.axis')), aes(x=X.axis, y=as.numeric(value), fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
    # scale_fill_manual(values=c("blue4", "steelblue3", "goldenrod3", "goldenrod1"), name='Site-frequency-spectra') +
    scale_fill_manual(values=c("#cb181d", "#fb6a4a"), name='Site-frequency-spectra') +
    theme(legend.position = c(0.72, 0.75)) +
    theme(legend.text=element_text(size=10)) +    
    theme(plot.title = element_text(face = "italic", size=16)) +
    theme(axis.text=element_text(size=12),
      axis.title=element_text(size=16))
  return(fig)
}

plot_dfe_grid = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('shape', 'scale', 'likelihood')
  unique_shape = unique(species_surface$shape)
  unique_scale = unique(species_surface$scale)
  Z = matrix(data=NA, nrow=length(unique_shape), ncol=length(unique_scale))
  count = 1
  for (i in 1:length(unique_shape)) {
    for (j in 1:length(unique_scale)) {
      Z[i, j] = species_surface$likelihood[count]
      if (species_surface$shape[count] != unique_shape[i]) {
        print('break')
      } else if (species_surface$scale[count] != unique_scale[j]) {
        print('break')
      }
      count = count + 1
    }
 }
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  best_params = c(species_surface$shape[1], species_surface$scale[1])
  print(best_params)
  MLE = max(species_surface$likelihood)
  species_surface$likelihood = species_surface$likelihood - MLE
  color_breakpoints = cut(species_surface$likelihood, c(-Inf, -3, -1, -0.5, 0))

  likelihood_surface_title = paste('MLE @ [', str_trunc(toString(best_params[1]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ', ', sep='')
  likelihood_surface_title = paste(likelihood_surface_title, str_trunc(toString(best_params[2]), 8, ellipsis=''), sep='')
  likelihood_surface_title = paste(likelihood_surface_title, ']', sep='')
  
  fig = ggplot(species_surface) +
    geom_contour_filled(aes(x=shape, y=scale, z=likelihood), 
      breaks = c(0, -0.5, -1, -3, -Inf)) +
    scale_fill_brewer(palette = "YlGnBu", direction=1, name='Log Likelihood') +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    annotate('point', x=best_params[1], y=best_params[2], color='orange', size=2) +
    xlab('Shape')  +
    ylab('Scale') +
    scale_y_log10()
    #ggtitle(likelihood_surface_title)
  return(fig)
}

find_dfe_mle = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('shape', 'scale', 'likelihood')
  unique_shape = unique(species_surface$shape)
  unique_scale = unique(species_surface$scale)
  Z = matrix(data=NA, nrow=length(unique_shape), ncol=length(unique_scale))
  count = 1
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  best_params = c(species_surface$shape[1], species_surface$scale[1])
  print(best_params)
  MLE = max(species_surface$likelihood)
  print(MLE)
}

cross_species_dfe_comparison = function(input_A, input_B) {
  species_surface_A = read.csv(input_A, header=TRUE)
  names(species_surface_A) = c('shape', 'scale', 'likelihood')
  unique_shape_A = unique(species_surface_A$shape)
  unique_scale_A = unique(species_surface_A$scale)
  Z_A = matrix(data=NA, nrow=length(unique_shape_A), ncol=length(unique_scale_A))
  count = 1
  for (i in 1:length(unique_shape_A)) {
    for (j in 1:length(unique_scale_A)) {
      Z_A[i, j] = species_surface_A$likelihood[count]
      if (species_surface_A$shape[count] != unique_shape_A[i]) {
        print('break')
      } else if (species_surface_A$scale[count] != unique_scale_A[j]) {
        print('break')
      }
      count = count + 1
    }
 }
  temp_surface_A = species_surface_A[order(species_surface_A$likelihood, decreasing=TRUE), ]
  best_params_A = c(temp_surface_A$shape[1], temp_surface_A$scale[1])
  ML_A = temp_surface_A$likelihood[1]
  
  species_surface_B = read.csv(input_B, header=TRUE)
  names(species_surface_B) = c('shape', 'scale', 'likelihood')
  unique_shape_B = unique(species_surface_B$shape)
  unique_scale_B = unique(species_surface_B$scale)
  Z_B = matrix(data=NA, nrow=length(unique_shape_B), ncol=length(unique_scale_B))
  count = 1
  for (i in 1:length(unique_shape_B)) {
    for (j in 1:length(unique_scale_B)) {
      Z_B[i, j] = species_surface_B$likelihood[count]
      if (species_surface_B$shape[count] != unique_shape_B[i]) {
        print('break')
      } else if (species_surface_B$scale[count] != unique_scale_B[j]) {
        print('break')
      }
      count = count + 1
    }
 }
  temp_surface_B = species_surface_B[order(species_surface_B$likelihood, decreasing=TRUE), ]
  best_params_B = c(temp_surface_B$shape[1], temp_surface_B$scale[1])
  ML_B = temp_surface_B$likelihood[1]
  combined_likelihood = species_surface_A$likelihood + species_surface_B$likelihood
  comparison_surface = data.frame(species_surface_A$shape, species_surface_A$scale, combined_likelihood)
  temp_comparison_surface = comparison_surface[order(comparison_surface$combined_likelihood, decreasing=TRUE), ]
  best_params_comparison = c(temp_comparison_surface$species_surface_A.shape[1], temp_comparison_surface$species_surface_A.scale[1])
  ML_comparison = temp_comparison_surface$combined_likelihood[1]
  independent_sum = ML_A + ML_B
  Lambda = independent_sum - ML_comparison
  return(2 * Lambda)
}

compare_core_accessory_sfs = function(all, core, accessory) {
  x_axis = 1:length(all)

  input_df = data.frame(proportional_sfs(all),
                        proportional_sfs(core),
                        proportional_sfs(accessory),
                        x_axis)
  
  names(input_df) = c('All genes',
                      'Core genes',
                      'Accessory genes',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_core_accessory_sfs_count = function(all, core, accessory) {
  x_axis = 1:length(all)

  input_df = data.frame(all,
                        core,
                        accessory,
                        x_axis)
  
  names(input_df) = c('All genes',
                      'Core genes',
                      'Accessory genes',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

compare_core_accessory_sfs_syn_ns = function(core_syn, core_nonsyn, accessory_syn, accessory_nonsyn) {
  x_axis = 1:length(core_syn)

  input_df = data.frame(proportional_sfs(core_syn),
                        proportional_sfs(core_nonsyn),
                        proportional_sfs(accessory_syn),
                        proportional_sfs(accessory_nonsyn),
                        x_axis)
  
  names(input_df) = c('Core genes (Syn)',
                      'Core genes (Nonsyn)',
                      'Accessory genes (Syn)',
                      'Accessory genes (Nonsyn)',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
    scale_fill_manual(values=c("blue4", "steelblue3", "goldenrod3", "goldenrod1"))
  
  return(p_input_comparison)
}

compare_core_accessory_sfs_syn_ns_5A = function(core_syn, core_nonsyn, accessory_syn, accessory_nonsyn) {
  x_axis = 1:length(core_syn)

  input_df = data.frame(proportional_sfs(core_syn),
                        proportional_sfs(core_nonsyn),
                        proportional_sfs(accessory_syn),
                        proportional_sfs(accessory_nonsyn),
                        x_axis)
  
  names(input_df) = c('Core genes (Syn)',
                      'Core genes (Nonsyn)',
                      'Accessory genes (Syn)',
                      'Accessory genes (Nonsyn)',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
    scale_fill_manual(values=c("blue4", "steelblue3", "goldenrod3", "goldenrod1")) +
    theme(legend.position = c(0.72, 0.75)) +
    theme(plot.title = element_text(face = "italic", size=16)) +
    theme(legend.text=element_text(size=10))
  
  return(p_input_comparison)
}

compare_core_accessory_sfs_syn_ns_5B = function(core_syn, core_nonsyn, accessory_syn, accessory_nonsyn) {
  x_axis = 1:length(core_syn)

  input_df = data.frame(proportional_sfs(core_syn),
                        proportional_sfs(core_nonsyn),
                        proportional_sfs(accessory_syn),
                        proportional_sfs(accessory_nonsyn),
                        x_axis)
  
  names(input_df) = c('Core genes (Syn)',
                      'Core genes (Nonsyn)',
                      'Accessory genes (Syn)',
                      'Accessory genes (Nonsyn)',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
    scale_fill_manual(values=c("blue4", "steelblue3", "goldenrod3", "goldenrod1")) +
    theme(plot.title = element_text(face = "italic", size=16)) +
    theme(legend.position='none')
  
  return(p_input_comparison)
}


compare_core_sfs = function(all, core) {
  x_axis = 1:length(all)

  input_df = data.frame(proportional_sfs(all),
                        proportional_sfs(core),
                        x_axis)
  
  names(input_df) = c('All genes',
                      'Core genes',
                      'x_axis')
  
  p_input_comparison <- ggplot(data = melt(input_df, id='x_axis'),
                                                     aes(x=x_axis, 
                                                         y=value,
                                                         fill=variable)) +
    geom_bar(position='dodge2', stat='identity') +
    labs(x = "", fill = "") +
    scale_x_continuous(name='Minor allele frequency in sample', breaks=x_axis, limits=c(0.5, length(x_axis) + 0.5)) +
    ylab('Proportion of segregating sites') +
    theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    ## scale_fill_manual(values=c("darkslateblue", "darkslategrey", "darkturquoise"))
  
  return(p_input_comparison)
}

extract_array_length <- function(input_string) {
  array_string <- str_extract(input_string, "\\[(.*?)\\]")
  num_elements <- length(strsplit(array_string, "[ ,]")[[1]])
  return(num_elements)
}

AIC_from_demography = function(input_file) {
  ## Reads input SFS from output *demography.txt
  if(grepl("one_epoch", input_file)) {
    k=2
  } else if(grepl("two_epoch", input_file)) {
    k=4
  } else {
    k=8
  }
  this_file = file(input_file)
  on.exit(close(this_file))
  ll_string = readLines(this_file)[2]
  loglik <- as.numeric(str_extract(ll_string, "-?\\d+\\.\\d+"))
  return(k - 2*loglik)
}

theta_from_demography = function(input_file) {
  ## Returns theta from given *demography.txt
  # Read the second line of the file
  theta_line <- readLines(input_file, n = 5)[5]
  # Extract numeric values using regular expression
  theta <- as.numeric(regmatches(theta_line, regexpr("[0-9]+\\.[0-9]+", theta_line)))
  return(theta)
}

nanc_from_demography = function(input_file) {
  ## Returns nanc from given *demography.txt
  # Read the second line of the file
  nanc_line <- readLines(input_file)[length(readLines(input_file))]
  # Extract numeric values using regular expression
  nanc <- as.numeric(regmatches(nanc_line, regexpr("[0-9]+\\.[0-9]+", nanc_line)))
  return(nanc)
}

return_nu_high = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  MLE = max(species_surface$likelihood)
  
  # Task 1: Remove rows with likelihood less than MLE - 3
  species_surface <- species_surface[species_surface$likelihood >= MLE - 3, ]
  
  # Task 2: Get the highest nu value from the remaining rows
  highest_nu <- max(species_surface$nu)
  
  return(highest_nu)
}

return_nu_low = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  MLE = max(species_surface$likelihood)
  
  # Task 1: Remove rows with likelihood less than MLE - 3
  species_surface <- species_surface[species_surface$likelihood >= MLE - 3, ]
  
  # Task 2: Get the highest nu value from the remaining rows
  lowest_nu <- min(species_surface$nu)
  
  return(lowest_nu)
}

return_nu_mle = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  return(species_surface$nu[1])
}

return_tau_mle = function(input) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  return(species_surface$nu[2])
}

return_time_high = function(input, sfs_file, theta_file) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  MLE = max(species_surface$likelihood)
  
  # Task 1: Remove rows with likelihood less than MLE - 3
  species_surface <- species_surface[species_surface$likelihood >= MLE - 3, ]
  
  # Task 2: Get the highest nu value from the remaining rows
  highest_tau <- max(species_surface$tau)
  
  # Read the contents of the file into a variable
  sfs_lines <- readLines(sfs_file)

  # Extract the second line and split it into individual values
  sfs_line <- sfs_lines[2]
  sfs_vector <- as.numeric(unlist(strsplit(sfs_line, " ")))
  
  allele_sum = sum(sfs_vector)
  
  # Read the contents of the file into a variable
  theta_lines <- readLines(theta_file)

  # Extract the fifth line
  theta_line <- theta_lines[5]

  theta <- as.numeric(regmatches(theta_line, regexpr("\\d+\\.\\d+", theta_line)))

  mu_low = 4.08E-10
  
  generations_high = 2 * highest_tau * theta / (4 * mu_low * allele_sum)
  
  years = 2 * highest_tau * theta / (4 * 4.08E-10 * allele_sum * 365)
  
  return(years)
}

return_time_low = function(input, sfs_file, theta_file) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  MLE = max(species_surface$likelihood)
  
  # Task 1: Remove rows with likelihood less than MLE - 3
  species_surface <- species_surface[species_surface$likelihood >= MLE - 3, ]
  
  # Task 2: Get the highest nu value from the remaining rows
  lowest_tau <- min(species_surface$tau)
  
  # Read the contents of the file into a variable
  sfs_lines <- readLines(sfs_file)

  # Extract the second line and split it into individual values
  sfs_line <- sfs_lines[2]
  sfs_vector <- as.numeric(unlist(strsplit(sfs_line, " ")))
  
  allele_sum = sum(sfs_vector)
  
  # Read the contents of the file into a variable
  theta_lines <- readLines(theta_file)

  # Extract the fifth line
  theta_line <- theta_lines[5]

  theta <- as.numeric(regmatches(theta_line, regexpr("\\d+\\.\\d+", theta_line)))

  mu_low = 4.08E-10
  
  generations_high = 2 * lowest_tau * theta / (4 * mu_low * allele_sum)
  
  years = 2 * lowest_tau * theta / (4 * 4.08E-10 * allele_sum * 365)
  
  return(years)
}

return_time_mle = function(input, sfs_file, theta_file) {
  species_surface = read.csv(input, header=TRUE)
  names(species_surface) = c('index', 'nu', 'tau', 'likelihood')
  species_surface = species_surface[order(species_surface$likelihood, decreasing=TRUE), ]
  
  mle_tau = species_surface$tau[i]
  
  # Read the contents of the file into a variable
  sfs_lines <- readLines(sfs_file)

  # Extract the second line and split it into individual values
  sfs_line <- sfs_lines[2]
  sfs_vector <- as.numeric(unlist(strsplit(sfs_line, " ")))
  
  allele_sum = sum(sfs_vector)
  
  # Read the contents of the file into a variable
  theta_lines <- readLines(theta_file)

  # Extract the fifth line
  theta_line <- theta_lines[5]

  theta <- as.numeric(regmatches(theta_line, regexpr("\\d+\\.\\d+", theta_line)))

  mu_low = 4.08E-10
  
  generations_high = 2 * mle_tau * theta / (4 * mu_low * allele_sum)
  
  years = 2 * mle_tau * theta / (4 * 4.08E-10 * allele_sum * 365)
  
  return(years)
}

read_demography_info <- function(filepath) {
  # Read the content of the file
  file_content <- readLines(filepath)
  
  # Extract the relevant lines
  nu <- as.numeric(regmatches(file_content[1], regexpr("\\d+\\.\\d+", file_content[1])))
  low_years <- as.numeric(regmatches(file_content[length(file_content)-3], regexpr("\\d+\\.\\d+", file_content[length(file_content)-3])))
  low_ancestral_size <- as.numeric(regmatches(file_content[length(file_content)-1], regexpr("\\d+\\.\\d+", file_content[length(file_content)-1])))
  
  # Create a vector with the extracted information
  result_vector <- c(nu, low_years, low_ancestral_size)
  
  return(result_vector)
}

compute_selection_coefficients <- function(input_file) {
  input_dfe_params = read_dfe_params(input_file)
  input_dfe_df = melt(input_dfe_params)
  input_dfe_df$value[input_dfe_df$value <= 1e-12] = 1e-12
  input_dfe_df$value[input_dfe_df$value >= 1] = 1
  input_dfe_df = rbind(
    input_dfe_df[input_dfe_df$variable == 'gamma_dfe_dist_low', ],
    input_dfe_df[input_dfe_df$variable == 'neugamma_dfe_dist_low',])

  input_dfe_df$variable <- as.character(input_dfe_df$variable)

  input_dfe_df$variable[input_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
  input_dfe_df$variable[input_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'
  
  weakly_deleterious_s =  1E-6
  moderately_deleterious_s = 1E-2
  lethal_s = 0.5
  
  DFE_cutoffs = c(-Inf, 1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1, Inf)
  
  input_gamma_dfe = input_dfe_df[input_dfe_df$variable=='Gamma-Distributed DFE', ]

  input_gamma_dfe[input_gamma_dfe$value < 1e-13, ]= 1e-13
  input_gamma_dfe[input_gamma_dfe$value > 1e2, ]= 1e2
  input_gamma_dfe_bins = cut(input_gamma_dfe$value, breaks=DFE_cutoffs)

  input_mean_s = mean(input_gamma_dfe$value)
  input_weakly_deleterious = mean(input_gamma_dfe$value < weakly_deleterious_s)
  input_moderately_deleterious =  mean(weakly_deleterious_s < input_gamma_dfe$value & input_gamma_dfe$value < moderately_deleterious_s)
  input_highly_deleterious = mean(moderately_deleterious_s < input_gamma_dfe$value & input_gamma_dfe$value < lethal_s)
  input_lethal = mean(input_gamma_dfe$value > lethal_s)
  return(c(input_mean_s, input_weakly_deleterious, input_moderately_deleterious, input_highly_deleterious, input_lethal))
}

return_demography_params <- function(input_file) {
  # Read the line from the input file
  line <- readLines(input_file, n = 1)

  # Extract the list of floats using regular expressions
  matches <- regmatches(line, gregexpr("\\d+\\.\\d+", line))

  # Convert the matched strings to numeric values
  floats <- as.numeric(matches[[1]])

  return(floats)
}
return_demography_likelihood = function(input_file) {
  # Read the second line of the file
  second_line <- readLines(input_file, n = 2)[2]
  # Extract numeric values using regular expression
  model_likelihood <- as.numeric(regmatches(second_line, regexpr("-[0-9]+\\.[0-9]+", second_line)))
  return(model_likelihood)
}

time_from_demography = function(input_file) {
  # Read the content of the file
  file_content <- readLines(input_file)
  
  # Extract the relevant lines
  years <- as.numeric(regmatches(file_content[length(file_content)-2], regexpr("\\d+\\.\\d+", file_content[length(file_content)-2])))
  
  return(years)
}

return_DFE_params = function(input_file) {
  # # Read the first line of the file
  fifth_line <- readLines(input_file)[5]
  # # Extract numeric values using regular expression
  pattern <- "[-+]?\\d*\\.?\\d+(?:[eE][-+]?\\d+)?"
  
  matches <- regmatches(fifth_line, gregexpr(pattern, fifth_line, perl = TRUE))[[1]]
  
  if (length(matches) < 2) {
    stop("Insufficient number of floats found in the input string.")
  }
  
  gamma_params <- numeric(2)
  for (i in 1:2) {
    gamma_params[i] <- as.numeric(matches[i])
  }
  
  twelfth_line <- readLines(input_file)[12]
  # Extract numeric values using regular expression
  matches <- regmatches(twelfth_line, gregexpr(pattern, twelfth_line, perl = TRUE))[[1]]
  
  if (length(matches) < 3) {
    stop("Insufficient number of floats found in the input string.")
  }
  
  neugamma_params <- numeric(3)
  for (i in 1:3) {
    neugamma_params[i] <- as.numeric(matches[i])
  }
  return_vector = c(
    gamma_params[1],
    gamma_params[2],
    neugamma_params[1],
    neugamma_params[2],
    neugamma_params[3]
  )
  return(return_vector)
}

return_DFE_likelihood = function(input_file) {
  # Read the second line of the file
  second_line <- readLines(input_file)[2]
  # Extract numeric values using regular expression
  gamma_likelihood <- as.numeric(regmatches(second_line, regexpr("-[0-9]+\\.[0-9]+", second_line)))
  # Read the ninth line of the file
  ninth_line <- readLines(input_file)[9]
  # Extract numeric values using regular expression
  neugamma_likelihood <- as.numeric(regmatches(ninth_line, regexpr("-[0-9]+\\.[0-9]+", ninth_line)))
  return_vector = c(
    gamma_likelihood,
    neugamma_likelihood
  )
  return(return_vector)
}

plot_figure_s9 = function(no_clade_control,
  clade_control,
  downsample) {
  x_axis = 1:(length(no_clade_control))
  
  max_length <- max(length(no_clade_control), length(clade_control), length(downsample))
  
  # Extend the vectors with "0" to make them all the same length
  no_clade_control <- c(no_clade_control, rep(0, max_length - length(no_clade_control)))
  clade_control <- c(clade_control, rep(0, max_length - length(clade_control)))
  downsample <- c(downsample, rep(0, max_length - length(downsample)))
  

  fig_s9_a = plot_empirical_sfs(no_clade_control) + 
    ggtitle('*Bacteroides vulgatus*, synonymous without clade control') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))
  
  fig_s9_c = plot_empirical_sfs(clade_control) +
    ggtitle('*Bacteroides vulgatus*, synonymous with clade control') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))

  fig_s9_e = plot_empirical_sfs(downsample) +
    ggtitle('*Bacteroides vulgatus*, synonymous with clade control and downsampling') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))

  
  figure_s9 = fig_s9_a + fig_s9_c + fig_s9_e + plot_layout(ncol=1)
}

get_pangenome_size = function(input_file) {
  # Read the last two lines from the file
  lines <- readLines(input_file)
  
  # Extract the number of genes from the second to last line
  second_to_last_line <- lines[length(lines) - 1]
  gene_count <- as.numeric(sub(".*There are (\\d+) genes in the pangenome.*", "\\1", second_to_last_line))
  
  return(gene_count)
}

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
options(digits = 15)
# 

# Analysis assumes a mutation rate of mu = 4.08E-10 substitutions / bp per generation

# HMP-QP with and without 0-tons

a_muciniphila_orig = fold_sfs(read_input_sfs_original('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/downsampled_syn_sfs.txt'))
a_finegoldii_orig = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_finegoldii_56071_downsampled_14/downsampled_syn_sfs.txt'))
a_onderdonkii_orig = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/downsampled_syn_sfs.txt'))
a_putredinis_orig = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_putredinis_61533_downsampled_14/downsampled_syn_sfs.txt'))
a_shahii_orig = fold_sfs(read_input_sfs_original('../Analysis/Alistipes_shahii_62199_downsampled_14/downsampled_syn_sfs.txt'))
b_bacterium_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/downsampled_syn_sfs.txt'))
b_caccae_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_caccae_53434_downsampled_14/downsampled_syn_sfs.txt'))
b_cellulosilyticus_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/downsampled_syn_sfs.txt'))
b_fragilis_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_fragilis_54507_downsampled_14/downsampled_syn_sfs.txt'))
# b_massiliensis_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/downsampled_syn_sfs.txt'))
b_ovatus_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_ovatus_58035_downsampled_14/downsampled_syn_sfs.txt'))
b_stercoris_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_stercoris_56735_downsampled_14/downsampled_syn_sfs.txt'))
b_thetaiotaomicron_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/downsampled_syn_sfs.txt'))
b_uniformis_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_uniformis_57318_downsampled_14/downsampled_syn_sfs.txt'))
b_vulgatus_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/downsampled_syn_sfs.txt'))
b_xylanisolvens_orig = fold_sfs(read_input_sfs_original('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/downsampled_syn_sfs.txt'))
b_intestinihominis_orig = fold_sfs(read_input_sfs_original('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/downsampled_syn_sfs.txt'))
# c_sp_orig = fold_sfs(read_input_sfs_original('../Analysis/Coprococcus_sp_62244_downsampled_14/downsampled_syn_sfs.txt'))
d_invisus_orig = fold_sfs(read_input_sfs_original('../Analysis/Dialister_invisus_61905_downsampled_14/downsampled_syn_sfs.txt'))
e_eligens_orig = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_eligens_61678_downsampled_14/downsampled_syn_sfs.txt'))
e_rectale_orig = fold_sfs(read_input_sfs_original('../Analysis/Eubacterium_rectale_56927_downsampled_14/downsampled_syn_sfs.txt'))
f_prausnitzii_orig = fold_sfs(read_input_sfs_original('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/downsampled_syn_sfs.txt'))
o_splanchnicus_orig = fold_sfs(read_input_sfs_original('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/downsampled_syn_sfs.txt'))
oscillibacter_sp_orig = fold_sfs(read_input_sfs_original('../Analysis/Oscillibacter_sp_60799_downsampled_14/downsampled_syn_sfs.txt'))
p_distasonis_orig = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/downsampled_syn_sfs.txt'))
p_merdae_orig = fold_sfs(read_input_sfs_original('../Analysis/Parabacteroides_merdae_56972_downsampled_14/downsampled_syn_sfs.txt'))
phascolarctobacterium_sp_orig = fold_sfs(read_input_sfs_original('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/downsampled_syn_sfs.txt'))
p_copri_orig = fold_sfs(read_input_sfs_original('../Analysis/Prevotella_copri_61740_downsampled_14/downsampled_syn_sfs.txt'))
r_bicirculans_orig = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/downsampled_syn_sfs.txt'))
r_bromii_orig = fold_sfs(read_input_sfs_original('../Analysis/Ruminococcus_bromii_62047_downsampled_14/downsampled_syn_sfs.txt'))

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

one_epoch_14 = sfs_from_demography('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_one_epoch_demography.txt')

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

a_muciniphila_core_three_epoch = sfs_from_demography('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_three_epoch_demography.txt')
a_finegoldii_core_three_epoch = sfs_from_demography('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_three_epoch_demography.txt') 
a_onderdonkii_core_three_epoch = sfs_from_demography('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_three_epoch_demography.txt') 
a_putredinis_core_three_epoch = sfs_from_demography('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_three_epoch_demography.txt') 
a_shahii_core_three_epoch = sfs_from_demography('../Analysis/Alistipes_shahii_62199_downsampled_14/core_three_epoch_demography.txt') 
b_bacterium_core_three_epoch = sfs_from_demography('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_three_epoch_demography.txt') 
b_caccae_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_three_epoch_demography.txt') 
b_cellulosilyticus_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_three_epoch_demography.txt') 
b_fragilis_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_three_epoch_demography.txt') 
b_ovatus_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_three_epoch_demography.txt') 
b_stercoris_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_three_epoch_demography.txt') 
b_thetaiotaomicron_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_three_epoch_demography.txt') 
b_uniformis_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_three_epoch_demography.txt') 
b_vulgatus_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_three_epoch_demography.txt') 
b_xylanisolvens_core_three_epoch = sfs_from_demography('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_three_epoch_demography.txt') 
b_intestinihominis_core_three_epoch = sfs_from_demography('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_three_epoch_demography.txt') 
d_invisus_core_three_epoch = sfs_from_demography('../Analysis/Dialister_invisus_61905_downsampled_14/core_three_epoch_demography.txt') 
e_eligens_core_three_epoch = sfs_from_demography('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_three_epoch_demography.txt') 
e_rectale_core_three_epoch = sfs_from_demography('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_three_epoch_demography.txt') 
f_prausnitzii_core_three_epoch = sfs_from_demography('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_three_epoch_demography.txt') 
o_splanchnicus_core_three_epoch = sfs_from_demography('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_three_epoch_demography.txt') 
oscillibacter_sp_core_three_epoch = sfs_from_demography('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_three_epoch_demography.txt') 
p_distasonis_core_three_epoch = sfs_from_demography('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_three_epoch_demography.txt') 
p_merdae_core_three_epoch = sfs_from_demography('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_three_epoch_demography.txt') 
phascolarctobacterium_sp_core_three_epoch = sfs_from_demography('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_three_epoch_demography.txt') 
p_copri_core_three_epoch = sfs_from_demography('../Analysis/Prevotella_copri_61740_downsampled_14/core_three_epoch_demography.txt') 
r_bicirculans_core_three_epoch = sfs_from_demography('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_three_epoch_demography.txt') 
r_bromii_core_three_epoch = sfs_from_demography('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_three_epoch_demography.txt') 

a_muciniphila_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/inferred_DFE.txt')
a_finegoldii_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_finegoldii_56071_downsampled_14/inferred_DFE.txt') 
a_onderdonkii_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/inferred_DFE.txt') 
a_putredinis_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_putredinis_61533_downsampled_14/inferred_DFE.txt') 
a_shahii_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Alistipes_shahii_62199_downsampled_14/inferred_DFE.txt') 
b_bacterium_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/inferred_DFE.txt') 
b_caccae_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_caccae_53434_downsampled_14/inferred_DFE.txt') 
b_cellulosilyticus_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/inferred_DFE.txt') 
b_fragilis_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/inferred_DFE.txt') 
b_ovatus_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_ovatus_58035_downsampled_14/inferred_DFE.txt') 
b_stercoris_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_stercoris_56735_downsampled_14/inferred_DFE.txt') 
b_thetaiotaomicron_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/inferred_DFE.txt') 
b_uniformis_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/inferred_DFE.txt') 
b_vulgatus_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/inferred_DFE.txt') 
b_xylanisolvens_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/inferred_DFE.txt') 
b_intestinihominis_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/inferred_DFE.txt') 
d_invisus_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/inferred_DFE.txt') 
e_eligens_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/inferred_DFE.txt') 
e_rectale_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/inferred_DFE.txt') 
f_prausnitzii_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/inferred_DFE.txt') 
o_splanchnicus_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/inferred_DFE.txt') 
oscillibacter_sp_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/inferred_DFE.txt') 
p_distasonis_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/inferred_DFE.txt') 
p_merdae_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/inferred_DFE.txt') 
phascolarctobacterium_sp_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/inferred_DFE.txt') 
p_copri_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/inferred_DFE.txt') 
r_bicirculans_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/inferred_DFE.txt') 
r_bromii_complete_gamma_dfe = gamma_sfs_from_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/inferred_DFE.txt') 

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

a_muciniphila_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/inferred_DFE.txt')
a_finegoldii_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Alistipes_finegoldii_56071_downsampled_14/inferred_DFE.txt') 
a_onderdonkii_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/inferred_DFE.txt') 
a_putredinis_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Alistipes_putredinis_61533_downsampled_14/inferred_DFE.txt') 
a_shahii_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Alistipes_shahii_62199_downsampled_14/inferred_DFE.txt') 
b_bacterium_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/inferred_DFE.txt') 
b_caccae_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_caccae_53434_downsampled_14/inferred_DFE.txt') 
b_cellulosilyticus_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/inferred_DFE.txt') 
b_fragilis_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/inferred_DFE.txt') 
b_ovatus_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_ovatus_58035_downsampled_14/inferred_DFE.txt') 
b_stercoris_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_stercoris_56735_downsampled_14/inferred_DFE.txt') 
b_thetaiotaomicron_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/inferred_DFE.txt') 
b_uniformis_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/inferred_DFE.txt') 
b_vulgatus_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/inferred_DFE.txt') 
b_xylanisolvens_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/inferred_DFE.txt') 
b_intestinihominis_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/inferred_DFE.txt') 
d_invisus_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/inferred_DFE.txt') 
e_eligens_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/inferred_DFE.txt') 
e_rectale_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/inferred_DFE.txt') 
f_prausnitzii_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/inferred_DFE.txt') 
o_splanchnicus_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/inferred_DFE.txt') 
oscillibacter_sp_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/inferred_DFE.txt') 
p_distasonis_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/inferred_DFE.txt') 
p_merdae_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/inferred_DFE.txt') 
phascolarctobacterium_sp_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/inferred_DFE.txt') 
p_copri_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/inferred_DFE.txt') 
r_bicirculans_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/inferred_DFE.txt') 
r_bromii_complete_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/inferred_DFE.txt') 

a_muciniphila_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_inferred_DFE.txt')
a_finegoldii_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_inferred_DFE.txt') 
a_onderdonkii_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_inferred_DFE.txt') 
a_putredinis_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_inferred_DFE.txt') 
a_shahii_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Alistipes_shahii_62199_downsampled_14/core_inferred_DFE.txt') 
b_bacterium_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_inferred_DFE.txt') 
b_caccae_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_inferred_DFE.txt') 
b_cellulosilyticus_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_inferred_DFE.txt') 
b_fragilis_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_inferred_DFE.txt') 
b_ovatus_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_inferred_DFE.txt') 
b_stercoris_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_inferred_DFE.txt') 
b_thetaiotaomicron_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt') 
b_uniformis_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt') 
b_vulgatus_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt') 
b_xylanisolvens_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_inferred_DFE.txt') 
b_intestinihominis_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt') 
d_invisus_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/core_inferred_DFE.txt') 
e_eligens_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_inferred_DFE.txt') 
e_rectale_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt') 
f_prausnitzii_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt') 
o_splanchnicus_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_inferred_DFE.txt') 
oscillibacter_sp_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_inferred_DFE.txt') 
p_distasonis_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt') 
p_merdae_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_inferred_DFE.txt') 
phascolarctobacterium_sp_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_inferred_DFE.txt') 
p_copri_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/core_inferred_DFE.txt') 
r_bicirculans_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_inferred_DFE.txt') 
r_bromii_core_neugamma_dfe = neugamma_sfs_from_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_inferred_DFE.txt') 

compare_hmp_sfs(a_muciniphila_hmp_qp_syn, one_epoch_14, a_muciniphila_core_two_epoch, a_muciniphila_core_three_epoch, a_muciniphila_hmp_qp_nonsyn, a_muciniphila_core_gamma_dfe, a_muciniphila_core_neugamma_dfe) + ggtitle('A. muciniphila (Core genes, downsampled to 14)')
compare_hmp_sfs(a_finegoldii_hmp_qp_syn, one_epoch_14, a_finegoldii_core_two_epoch, a_finegoldii_core_three_epoch, a_finegoldii_hmp_qp_nonsyn, a_finegoldii_core_gamma_dfe, a_finegoldii_core_neugamma_dfe) + ggtitle('A. finegoldii (Core genes, downsampled to 14)')
compare_hmp_sfs(a_onderdonkii_hmp_qp_syn, one_epoch_14, a_onderdonkii_core_two_epoch, a_onderdonkii_core_three_epoch, a_onderdonkii_hmp_qp_nonsyn, a_onderdonkii_core_gamma_dfe, a_onderdonkii_core_neugamma_dfe) + ggtitle('A. onderdonkii (Core genes, downsampled to 14)')
compare_hmp_sfs(a_putredinis_hmp_qp_syn, one_epoch_14, a_putredinis_core_two_epoch, a_putredinis_core_three_epoch, a_putredinis_hmp_qp_nonsyn, a_putredinis_core_gamma_dfe, a_putredinis_core_neugamma_dfe) + ggtitle('A. putredinis (Core genes, downsampled to 14)')
compare_hmp_sfs(a_shahii_hmp_qp_syn, one_epoch_14, a_shahii_core_two_epoch, a_shahii_core_three_epoch, a_shahii_hmp_qp_nonsyn, a_shahii_core_gamma_dfe, a_shahii_core_neugamma_dfe) + ggtitle('Alistipes shahii (Core genes, downsampled to 14)')
compare_hmp_sfs(b_bacterium_hmp_qp_syn, one_epoch_14, b_bacterium_core_two_epoch, b_bacterium_core_three_epoch, b_bacterium_hmp_qp_nonsyn, b_bacterium_core_gamma_dfe, b_bacterium_core_neugamma_dfe) + ggtitle('B. bacterium (Core genes, downsampled to 14)')
compare_hmp_sfs(b_caccae_hmp_qp_syn, one_epoch_14, b_caccae_core_two_epoch, b_caccae_core_three_epoch, b_caccae_hmp_qp_nonsyn, b_caccae_core_gamma_dfe, b_caccae_core_neugamma_dfe) + ggtitle('B. caccae (Core genes, downsampled to 14)')
compare_hmp_sfs(b_cellulosilyticus_hmp_qp_syn, one_epoch_14, b_cellulosilyticus_core_two_epoch, b_cellulosilyticus_core_three_epoch, b_cellulosilyticus_hmp_qp_nonsyn, b_cellulosilyticus_core_gamma_dfe, b_cellulosilyticus_core_neugamma_dfe) + ggtitle('B. cellulosilyticus (Core genes, downsampled to 14)')
compare_hmp_sfs(b_fragilis_hmp_qp_syn, one_epoch_14, b_fragilis_core_two_epoch, b_fragilis_core_three_epoch, b_fragilis_hmp_qp_nonsyn, b_fragilis_core_gamma_dfe, b_fragilis_core_neugamma_dfe) + ggtitle('B. fragilis (Core genes, downsampled to 14)')
compare_hmp_sfs(b_ovatus_hmp_qp_syn, one_epoch_14, b_ovatus_core_two_epoch, b_ovatus_core_three_epoch, b_ovatus_hmp_qp_nonsyn, b_ovatus_core_gamma_dfe, b_ovatus_core_neugamma_dfe) + ggtitle('B. ovatus (Core genes, downsampled to 14)')
compare_hmp_sfs(b_stercoris_hmp_qp_syn, one_epoch_14, b_stercoris_core_two_epoch, b_stercoris_core_three_epoch, b_stercoris_hmp_qp_nonsyn, b_stercoris_core_gamma_dfe, b_stercoris_core_neugamma_dfe) + ggtitle('B. stercoris (Core genes, downsampled to 14)')
compare_hmp_sfs(b_thetaiotaomicron_hmp_qp_syn, one_epoch_14, b_thetaiotaomicron_core_two_epoch, b_thetaiotaomicron_core_three_epoch, b_thetaiotaomicron_hmp_qp_nonsyn, b_thetaiotaomicron_core_gamma_dfe, b_thetaiotaomicron_core_neugamma_dfe) + ggtitle('B. thetaiotaomicron (Core genes, downsampled to 14)')
compare_hmp_sfs(b_uniformis_hmp_qp_syn, one_epoch_14, b_uniformis_core_two_epoch, b_uniformis_core_three_epoch, b_uniformis_hmp_qp_nonsyn, b_uniformis_core_gamma_dfe, b_uniformis_core_neugamma_dfe) + ggtitle('B. uniformis (Core genes, downsampled, to 14)')
compare_hmp_sfs(b_vulgatus_hmp_qp_syn, one_epoch_14, b_vulgatus_core_two_epoch, b_vulgatus_core_three_epoch, b_vulgatus_hmp_qp_nonsyn, b_vulgatus_core_gamma_dfe, b_vulgatus_core_neugamma_dfe) + ggtitle('B. vulgatus (Core genes, downsampled to 14)')
compare_hmp_sfs(b_xylanisolvens_hmp_qp_syn, one_epoch_14, b_xylanisolvens_core_two_epoch, b_xylanisolvens_core_three_epoch, b_xylanisolvens_hmp_qp_nonsyn, b_xylanisolvens_core_gamma_dfe, b_xylanisolvens_core_neugamma_dfe) + ggtitle('B. xylanisolvens (Core genes, downsampled to 14)')
compare_hmp_sfs(b_intestinihominis_hmp_qp_syn, one_epoch_14, b_intestinihominis_core_two_epoch, b_intestinihominis_core_three_epoch, b_intestinihominis_hmp_qp_nonsyn, b_intestinihominis_core_gamma_dfe, b_intestinihominis_core_neugamma_dfe) + ggtitle('B. intestinihominis (Core genes, downsampled to 14)')
compare_hmp_sfs(d_invisus_hmp_qp_syn, one_epoch_14, d_invisus_core_two_epoch, d_invisus_core_three_epoch, d_invisus_hmp_qp_nonsyn, d_invisus_core_gamma_dfe, d_invisus_core_neugamma_dfe) + ggtitle('D. invisus (Core genes, downsampled to 14)')
compare_hmp_sfs(e_eligens_hmp_qp_syn, one_epoch_14, e_eligens_core_two_epoch, e_eligens_core_three_epoch, e_eligens_hmp_qp_nonsyn, e_eligens_core_gamma_dfe, e_eligens_core_neugamma_dfe) + ggtitle('E. eligens (Core genes, downsampled to 14)')
compare_hmp_sfs(e_rectale_hmp_qp_syn, one_epoch_14, e_rectale_core_two_epoch, e_rectale_core_three_epoch, e_rectale_hmp_qp_nonsyn, e_rectale_core_gamma_dfe, e_rectale_core_neugamma_dfe) + ggtitle('E. rectale (Core genes, downsampled to 14)')
compare_hmp_sfs(f_prausnitzii_hmp_qp_syn, one_epoch_14, f_prausnitzii_core_two_epoch, f_prausnitzii_core_three_epoch, f_prausnitzii_hmp_qp_nonsyn, f_prausnitzii_core_gamma_dfe, f_prausnitzii_core_neugamma_dfe) + ggtitle('F. prausnitzii (Core genes, downsampled to 14)')
compare_hmp_sfs(o_splanchnicus_hmp_qp_syn, one_epoch_14, o_splanchnicus_core_two_epoch, o_splanchnicus_core_three_epoch,  o_splanchnicus_hmp_qp_nonsyn, o_splanchnicus_core_gamma_dfe, o_splanchnicus_core_neugamma_dfe) + ggtitle('O. splanchnicus (Core genes, downsampled to 14)')
compare_hmp_sfs(oscillibacter_sp_hmp_qp_syn, one_epoch_14, oscillibacter_sp_core_two_epoch, oscillibacter_sp_core_three_epoch, oscillibacter_sp_hmp_qp_nonsyn, oscillibacter_sp_core_gamma_dfe, oscillibacter_sp_core_neugamma_dfe) + ggtitle('Oscillibacter sp. (Core genes, downsampled to 14)')
compare_hmp_sfs(p_distasonis_hmp_qp_syn, one_epoch_14, p_distasonis_core_two_epoch, p_distasonis_core_three_epoch, p_distasonis_hmp_qp_nonsyn, p_distasonis_core_gamma_dfe, p_distasonis_core_neugamma_dfe) + ggtitle('P. distasonis (Core genes, downsampled to 14)')
compare_hmp_sfs(p_merdae_hmp_qp_syn, one_epoch_14, p_merdae_core_two_epoch, p_merdae_core_three_epoch, p_merdae_hmp_qp_nonsyn, p_merdae_core_gamma_dfe, p_merdae_core_neugamma_dfe) + ggtitle('P. merdae (Core genes, downsampled to 14)')
compare_hmp_sfs(phascolarctobacterium_sp_hmp_qp_syn, one_epoch_14, phascolarctobacterium_sp_core_two_epoch, phascolarctobacterium_sp_core_three_epoch, phascolarctobacterium_sp_hmp_qp_nonsyn, phascolarctobacterium_sp_core_gamma_dfe, phascolarctobacterium_sp_core_neugamma_dfe) + ggtitle('Phascolarctobacterium sp. (Core genes, downsampled to 14)')
compare_hmp_sfs(p_copri_hmp_qp_syn, one_epoch_14, p_copri_core_two_epoch, p_copri_core_three_epoch, p_copri_hmp_qp_nonsyn, p_copri_core_gamma_dfe, p_copri_core_neugamma_dfe) + ggtitle('P. copri (Core genes, downsampled to 14)')
compare_hmp_sfs(r_bicirculans_hmp_qp_syn, one_epoch_14, r_bicirculans_core_two_epoch, r_bicirculans_core_three_epoch, r_bicirculans_hmp_qp_nonsyn, r_bicirculans_core_gamma_dfe, r_bicirculans_core_neugamma_dfe) + ggtitle('R. bicirculans (Core genes, downsampled to 14)')
compare_hmp_sfs(r_bromii_hmp_qp_syn, one_epoch_14, r_bromii_core_two_epoch, r_bromii_core_three_epoch, r_bromii_hmp_qp_nonsyn, r_bromii_core_gamma_dfe, r_bromii_core_neugamma_dfe) + ggtitle('R. bromii (Core genes, downsampled to 14)')

# DFE Comparison
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

# Dadi Scaling

a_muciniphila_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_inferred_DFE.txt')
a_muciniphila_dfe_dadi_params$species = 'Akkermansia muciniphila'

a_finegoldii_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_inferred_DFE.txt')
a_finegoldii_dfe_dadi_params$species = 'Alistipes finegoldii'

a_onderdonkii_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_inferred_DFE.txt')
a_onderdonkii_dfe_dadi_params$species = 'Alistipes onderdonkii'

a_putredinis_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_inferred_DFE.txt')
a_putredinis_dfe_dadi_params$species = 'Alistipes putredinis'

a_shahii_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Alistipes_shahii_62199_downsampled_14/core_inferred_DFE.txt')
a_shahii_dfe_dadi_params$species = 'Alistipes shahii'

b_bacterium_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_inferred_DFE.txt')
b_bacterium_dfe_dadi_params$species = 'Bacteroidales bacterium'

b_caccae_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_inferred_DFE.txt')
b_caccae_dfe_dadi_params$species = 'Bacteroides caccae'

b_cellulosilyticus_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_inferred_DFE.txt')
b_cellulosilyticus_dfe_dadi_params$species = 'Bacteroides cellulosilyticus'

b_fragilis_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_inferred_DFE.txt')
b_fragilis_dfe_dadi_params$species = 'Bacteroides fragilis'

b_ovatus_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_inferred_DFE.txt')
b_ovatus_dfe_dadi_params$species = 'Bacteroides ovatus'

b_stercoris_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_inferred_DFE.txt')
b_stercoris_dfe_dadi_params$species = 'Bacteroides stercoris'

b_thetaiotaomicron_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt')
b_thetaiotaomicron_dfe_dadi_params$species = 'Bacteroides thetaiotaomicron'

b_uniformis_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt')
b_uniformis_dfe_dadi_params$species = 'Bacteroides uniformis'

b_vulgatus_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt')
b_vulgatus_dfe_dadi_params$species = 'Bacteroides vulgatus'

b_xylanisolvens_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_inferred_DFE.txt')
b_xylanisolvens_dfe_dadi_params$species = 'Bacteroides xylanisolvens'

b_intestinihominis_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt')
b_intestinihominis_dfe_dadi_params$species = 'Barnesiella intestinihominis'

d_invisus_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Dialister_invisus_61905_downsampled_14/core_inferred_DFE.txt')
d_invisus_dfe_dadi_params$species = 'Dialister invisus'

e_eligens_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_inferred_DFE.txt')
e_eligens_dfe_dadi_params$species = 'Eubacterium eligens'

e_rectale_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt')
e_rectale_dfe_dadi_params$species = 'Eubacterium rectale'

f_prausnitzii_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt')
f_prausnitzii_dfe_dadi_params$species = 'Faecalibacterium prausnitzii'

o_splanchnicus_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_inferred_DFE.txt')
o_splanchnicus_dfe_dadi_params$species = 'Odoribacter splanchnicus'

oscillibacter_sp_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_inferred_DFE.txt')
oscillibacter_sp_dfe_dadi_params$species = 'Oscillibacter species'

p_distasonis_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt')
p_distasonis_dfe_dadi_params$species = 'Parabacteroides distasonis'

p_merdae_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_inferred_DFE.txt')
p_merdae_dfe_dadi_params$species = 'Parabacteroides merdae'

phascolarctobacterium_sp_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_inferred_DFE.txt')
phascolarctobacterium_sp_dfe_dadi_params$species = 'Phascolarctobacterium species'

p_copri_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Prevotella_copri_61740_downsampled_14/core_inferred_DFE.txt')
p_copri_dfe_dadi_params$species = 'Prevotella copri'

r_bicirculans_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_inferred_DFE.txt')
r_bicirculans_dfe_dadi_params$species = 'Ruminococcus bicirculans'

r_bromii_dfe_dadi_params = read_dfe_dadi_params('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_inferred_DFE.txt')
r_bromii_dfe_dadi_params$species = 'Ruminococcus bromii'

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

dfe_dadi_df = rbind(
  melt(a_muciniphila_dfe_dadi_params),
  melt(a_finegoldii_dfe_dadi_params),
  melt(a_onderdonkii_dfe_dadi_params),
  melt(a_putredinis_dfe_dadi_params),
  melt(a_shahii_dfe_dadi_params),
  melt(b_bacterium_dfe_dadi_params),
  melt(b_caccae_dfe_dadi_params),
  melt(b_cellulosilyticus_dfe_dadi_params),
  melt(b_fragilis_dfe_dadi_params),
  # melt(b_ovatus_dfe_dadi_params),
  melt(b_stercoris_dfe_dadi_params),
  melt(b_thetaiotaomicron_dfe_dadi_params),
  melt(b_uniformis_dfe_dadi_params),
  melt(b_vulgatus_dfe_dadi_params),
  melt(b_xylanisolvens_dfe_dadi_params),
  melt(b_intestinihominis_dfe_dadi_params),
  melt(d_invisus_dfe_dadi_params),
  melt(e_eligens_dfe_dadi_params),
  melt(e_rectale_dfe_dadi_params),
  melt(f_prausnitzii_dfe_dadi_params),
  melt(o_splanchnicus_dfe_dadi_params),
  melt(oscillibacter_sp_dfe_dadi_params),
  melt(p_distasonis_dfe_dadi_params),
  melt(p_merdae_dfe_dadi_params),
  melt(phascolarctobacterium_sp_dfe_dadi_params),
  melt(p_copri_dfe_dadi_params),
  melt(r_bicirculans_dfe_dadi_params),
  melt(r_bromii_dfe_dadi_params)
)
# dfe_df

## Due to Dadi internal scaling which considers genotype
## fitness as (1, 1 + 2sh, 1 + 2s), and the fact that
## we are working with a haploid sample, we
## wish to multiply the _inferred_ s by 2 to get the true
## selective coefficient of the haploid bacteria.
## However, s is for the heterozygote case.

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

dfe_df$species = factor(dfe_df$species, levels=phylogenetic_levels)
dfe_dadi_df$species = factor(dfe_dadi_df$species, levels=phylogenetic_levels)

# dfe_df$value = dfe_df$value * 2
dfe_df$value[dfe_df$value <= 1e-11] = 1e-11
dfe_df$value[dfe_df$value >= 0.5] = 0.5

### Figure 4
# 600 x 1000

# DFE Comparison

grey_red_gradient <- c("#9b9b9b",
"#9f9391",
"#a28b87",
"#a5837d",
"#a77b74",
"#a9736a",
"#aa6a61",
"#ab6257",
"#ab594e",
"#ab5045",
"#ab463c",
"#aa3c33",
"#a9302b",
"#a82222")

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

ggplot(dfe_df[dfe_df$variable == 'gamma_dfe_dist_high', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 1) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=6.93E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e1)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") + 
  xlab('Selection Coefficient')

### Figure S3
# 600 x 1000

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

ggplot(dfe_df[dfe_df$variable == 'neugamma_dfe_dist_high', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 0.95) +
  #labs(
  #  title = 'Neutral + Gamma-Distributed DFE',
  #  subtitle = 'Assuming a mutation rate of mu=6.93E-10'
  #) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-12, 1e1)) +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") + 
  xlab('Selection Coefficient')

dfe_dadi_df$value[dfe_dadi_df$value <= 1e-1] = 1e-1

ggplot(dfe_dadi_df[dfe_dadi_df$variable == 'gamma_dfe_dist', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 0.95) +
  #labs(
  #  title = 'Gamma-Distributed DFE',
  #  subtitle = 'Selection coefficient multiplied by N_anc'
  #) +
  theme_ridges() +
  scale_x_log10() +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") + 
  xlab('Selection Coefficient')

ggplot(dfe_dadi_df[dfe_dadi_df$variable == 'neugamma_dfe_dist', ], aes(x=value, y=fct_rev(species), fill=species)) +
  geom_density_ridges2(aes(fill = species), stat = "binline", binwidth = 1, scale = 0.95) +
  #labs(
  #  title = 'Neutral + Gamma-Distributed DFE',
  #  subtitle = 'Selection coefficient multiplied by 2N_anc'
  #) +
  theme_ridges() +
  scale_x_log10() +
  ylab('Proportion of Sites') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "none") + 
  xlab('Selection Coefficient')

a_shahii_dfe_df = melt(a_shahii_dfe_params)
# a_shahii_dfe_df$value = a_shahii_dfe_df$value * 2
a_shahii_dfe_df$value[a_shahii_dfe_df$value <= 1e-12] = 1e-12
a_shahii_dfe_df$value[a_shahii_dfe_df$value >= 1] = 1
# a_shahii_dfe_df = a_shahii_dfe_df[a_shahii_dfe_df$variable == 'gamma_dfe_dist_low' || a_shahii_dfe_df$variable == 'neugamma_dfe_dist_low', ]
a_shahii_dfe_df = rbind(
  a_shahii_dfe_df[a_shahii_dfe_df$variable == 'gamma_dfe_dist_low', ],
  a_shahii_dfe_df[a_shahii_dfe_df$variable == 'neugamma_dfe_dist_low',])

a_shahii_dfe_df$variable <- as.character(a_shahii_dfe_df$variable)

a_shahii_dfe_df$variable[a_shahii_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
a_shahii_dfe_df$variable[a_shahii_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

ggplot(a_shahii_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Alistipes shahii DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10() +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))

o_splanchnicus_dfe_df = melt(o_splanchnicus_dfe_params)
# o_splanchnicus_dfe_df$value = o_splanchnicus_dfe_df$value * 2
o_splanchnicus_dfe_df$value[o_splanchnicus_dfe_df$value <= 1e-12] = 1e-12
o_splanchnicus_dfe_df$value[o_splanchnicus_dfe_df$value >= 1] = 1
# o_splanchnicus_dfe_df = o_splanchnicus_dfe_df[o_splanchnicus_dfe_df$variable == 'gamma_dfe_dist_low' || o_splanchnicus_dfe_df$variable == 'neugamma_dfe_dist_low', ]
o_splanchnicus_dfe_df = rbind(
  o_splanchnicus_dfe_df[o_splanchnicus_dfe_df$variable == 'gamma_dfe_dist_low', ],
  o_splanchnicus_dfe_df[o_splanchnicus_dfe_df$variable == 'neugamma_dfe_dist_low',])

o_splanchnicus_dfe_df$variable <- as.character(o_splanchnicus_dfe_df$variable)

o_splanchnicus_dfe_df$variable[o_splanchnicus_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
o_splanchnicus_dfe_df$variable[o_splanchnicus_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

o_splanchnicus_dfe_figure = ggplot(o_splanchnicus_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Odoribacter splanchnicus DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))

e_eligens_dfe_df = melt(e_eligens_dfe_params)
# e_eligens_dfe_df$value = e_eligens_dfe_df$value * 2
e_eligens_dfe_df$value[e_eligens_dfe_df$value <= 1e-12] = 1e-12
e_eligens_dfe_df$value[e_eligens_dfe_df$value >= 1] = 1
# e_eligens_dfe_df = e_eligens_dfe_df[e_eligens_dfe_df$variable == 'gamma_dfe_dist_low' || e_eligens_dfe_df$variable == 'neugamma_dfe_dist_low', ]
e_eligens_dfe_df = rbind(
  e_eligens_dfe_df[e_eligens_dfe_df$variable == 'gamma_dfe_dist_low', ],
  e_eligens_dfe_df[e_eligens_dfe_df$variable == 'neugamma_dfe_dist_low',])

e_eligens_dfe_df$variable <- as.character(e_eligens_dfe_df$variable)

e_eligens_dfe_df$variable[e_eligens_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
e_eligens_dfe_df$variable[e_eligens_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

e_eligens_dfe_figure = ggplot(e_eligens_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Eubacterium eligens DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))

b_fragilis_dfe_df = melt(b_fragilis_dfe_params)
b_fragilis_dfe_df$value[b_fragilis_dfe_df$value <= 1e-12] = 1e-12
b_fragilis_dfe_df$value[b_fragilis_dfe_df$value >= 1] = 1
b_fragilis_dfe_df = rbind(
  b_fragilis_dfe_df[b_fragilis_dfe_df$variable == 'gamma_dfe_dist_low', ],
  b_fragilis_dfe_df[b_fragilis_dfe_df$variable == 'neugamma_dfe_dist_low',])

b_fragilis_dfe_df$variable <- as.character(b_fragilis_dfe_df$variable)

b_fragilis_dfe_df$variable[b_fragilis_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
b_fragilis_dfe_df$variable[b_fragilis_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

b_cellulosilyticus_dfe_df = melt(b_cellulosilyticus_dfe_params)
b_cellulosilyticus_dfe_df$value[b_cellulosilyticus_dfe_df$value <= 1e-12] = 1e-12
b_cellulosilyticus_dfe_df$value[b_cellulosilyticus_dfe_df$value >= 1] = 1
b_cellulosilyticus_dfe_df = rbind(
  b_cellulosilyticus_dfe_df[b_cellulosilyticus_dfe_df$variable == 'gamma_dfe_dist_low', ],
  b_cellulosilyticus_dfe_df[b_cellulosilyticus_dfe_df$variable == 'neugamma_dfe_dist_low',])

b_cellulosilyticus_dfe_df$variable <- as.character(b_cellulosilyticus_dfe_df$variable)

b_cellulosilyticus_dfe_df$variable[b_cellulosilyticus_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
b_cellulosilyticus_dfe_df$variable[b_cellulosilyticus_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'


b_cellulosilyticus_dfe_figure = ggplot(b_cellulosilyticus_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Bacteroides cellulosilyticus DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))

b_stercoris_dfe_df = melt(b_stercoris_dfe_params)
b_stercoris_dfe_df$value[b_stercoris_dfe_df$value <= 1e-12] = 1e-12
b_stercoris_dfe_df$value[b_stercoris_dfe_df$value >= 1] = 1
# b_stercoris_dfe_df = b_stercoris_dfe_df[b_stercoris_dfe_df$variable == 'gamma_dfe_dist_low' || b_stercoris_dfe_df$variable == 'neugamma_dfe_dist_low', ]
b_stercoris_dfe_df = rbind(
  b_stercoris_dfe_df[b_stercoris_dfe_df$variable == 'gamma_dfe_dist_low', ],
  b_stercoris_dfe_df[b_stercoris_dfe_df$variable == 'neugamma_dfe_dist_low',])

b_stercoris_dfe_df$variable <- as.character(b_stercoris_dfe_df$variable)

b_stercoris_dfe_df$variable[b_stercoris_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
b_stercoris_dfe_df$variable[b_stercoris_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

b_stercoris_dfe_figure = ggplot(b_stercoris_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Bacteroides stercoris DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))

b_uniformis_dfe_df = melt(b_uniformis_dfe_params)
b_uniformis_dfe_df$value[b_uniformis_dfe_df$value <= 1e-12] = 1e-12
b_uniformis_dfe_df$value[b_uniformis_dfe_df$value >= 1] = 1
b_uniformis_dfe_df = rbind(
  b_uniformis_dfe_df[b_uniformis_dfe_df$variable == 'gamma_dfe_dist_low', ],
  b_uniformis_dfe_df[b_uniformis_dfe_df$variable == 'neugamma_dfe_dist_low',])

b_uniformis_dfe_df$variable <- as.character(b_uniformis_dfe_df$variable)

b_uniformis_dfe_df$variable[b_uniformis_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
b_uniformis_dfe_df$variable[b_uniformis_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

b_thetaiotaomicron_dfe_df = melt(b_thetaiotaomicron_dfe_params)
b_thetaiotaomicron_dfe_df$value[b_thetaiotaomicron_dfe_df$value <= 1e-12] = 1e-12
b_thetaiotaomicron_dfe_df$value[b_thetaiotaomicron_dfe_df$value >= 1] = 1
b_thetaiotaomicron_dfe_df = rbind(
  b_thetaiotaomicron_dfe_df[b_thetaiotaomicron_dfe_df$variable == 'gamma_dfe_dist_low', ],
  b_thetaiotaomicron_dfe_df[b_thetaiotaomicron_dfe_df$variable == 'neugamma_dfe_dist_low',])

b_thetaiotaomicron_dfe_df$variable <- as.character(b_thetaiotaomicron_dfe_df$variable)

b_thetaiotaomicron_dfe_df$variable[b_thetaiotaomicron_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
b_thetaiotaomicron_dfe_df$variable[b_thetaiotaomicron_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

b_xylanisolvens_dfe_df = melt(b_xylanisolvens_dfe_params)
b_xylanisolvens_dfe_df$value[b_xylanisolvens_dfe_df$value <= 1e-12] = 1e-12
b_xylanisolvens_dfe_df$value[b_xylanisolvens_dfe_df$value >= 1] = 1
b_xylanisolvens_dfe_df = rbind(
  b_xylanisolvens_dfe_df[b_xylanisolvens_dfe_df$variable == 'gamma_dfe_dist_low', ],
  b_xylanisolvens_dfe_df[b_xylanisolvens_dfe_df$variable == 'neugamma_dfe_dist_low',])

b_xylanisolvens_dfe_df$variable <- as.character(b_xylanisolvens_dfe_df$variable)

b_xylanisolvens_dfe_df$variable[b_xylanisolvens_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
b_xylanisolvens_dfe_df$variable[b_xylanisolvens_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

b_caccae_dfe_df = melt(b_caccae_dfe_params)
b_caccae_dfe_df$value[b_caccae_dfe_df$value <= 1e-12] = 1e-12
b_caccae_dfe_df$value[b_caccae_dfe_df$value >= 1] = 1
b_caccae_dfe_df = rbind(
  b_caccae_dfe_df[b_caccae_dfe_df$variable == 'gamma_dfe_dist_low', ],
  b_caccae_dfe_df[b_caccae_dfe_df$variable == 'neugamma_dfe_dist_low',])

b_caccae_dfe_df$variable <- as.character(b_caccae_dfe_df$variable)

b_caccae_dfe_df$variable[b_caccae_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
b_caccae_dfe_df$variable[b_caccae_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

b_vulgatus_dfe_df = melt(b_vulgatus_dfe_params)
b_vulgatus_dfe_df$value[b_vulgatus_dfe_df$value <= 1e-12] = 1e-12
b_vulgatus_dfe_df$value[b_vulgatus_dfe_df$value >= 1] = 1
b_vulgatus_dfe_df = rbind(
  b_vulgatus_dfe_df[b_vulgatus_dfe_df$variable == 'gamma_dfe_dist_low', ],
  b_vulgatus_dfe_df[b_vulgatus_dfe_df$variable == 'neugamma_dfe_dist_low',])

b_vulgatus_dfe_df$variable <- as.character(b_vulgatus_dfe_df$variable)

b_vulgatus_dfe_df$variable[b_vulgatus_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
b_vulgatus_dfe_df$variable[b_vulgatus_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'


a_finegoldii_dfe_df = melt(a_finegoldii_dfe_params)
a_finegoldii_dfe_df$value[a_finegoldii_dfe_df$value <= 1e-12] = 1e-12
a_finegoldii_dfe_df$value[a_finegoldii_dfe_df$value >= 1] = 1
# a_finegoldii_dfe_df = a_finegoldii_dfe_df[a_finegoldii_dfe_df$variable == 'gamma_dfe_dist_low' || a_finegoldii_dfe_df$variable == 'neugamma_dfe_dist_low', ]
a_finegoldii_dfe_df = rbind(
  a_finegoldii_dfe_df[a_finegoldii_dfe_df$variable == 'gamma_dfe_dist_low', ],
  a_finegoldii_dfe_df[a_finegoldii_dfe_df$variable == 'neugamma_dfe_dist_low',])

a_finegoldii_dfe_df$variable <- as.character(a_finegoldii_dfe_df$variable)

a_finegoldii_dfe_df$variable[a_finegoldii_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
a_finegoldii_dfe_df$variable[a_finegoldii_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

a_finegoldii_dfe_figure = ggplot(a_finegoldii_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Bacteroides stercoris DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))


a_onderdonkii_dfe_df = melt(a_onderdonkii_dfe_params)
a_onderdonkii_dfe_df$value[a_onderdonkii_dfe_df$value <= 1e-12] = 1e-12
a_onderdonkii_dfe_df$value[a_onderdonkii_dfe_df$value >= 1] = 1
# a_onderdonkii_dfe_df = a_onderdonkii_dfe_df[a_onderdonkii_dfe_df$variable == 'gamma_dfe_dist_low' || a_onderdonkii_dfe_df$variable == 'neugamma_dfe_dist_low', ]
a_onderdonkii_dfe_df = rbind(
  a_onderdonkii_dfe_df[a_onderdonkii_dfe_df$variable == 'gamma_dfe_dist_low', ],
  a_onderdonkii_dfe_df[a_onderdonkii_dfe_df$variable == 'neugamma_dfe_dist_low',])

a_onderdonkii_dfe_df$variable <- as.character(a_onderdonkii_dfe_df$variable)

a_onderdonkii_dfe_df$variable[a_onderdonkii_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
a_onderdonkii_dfe_df$variable[a_onderdonkii_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

a_onderdonkii_dfe_figure = ggplot(a_onderdonkii_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Bacteroides stercoris DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))

e_eligens_dfe_df = melt(e_eligens_dfe_params)
e_eligens_dfe_df$value[e_eligens_dfe_df$value <= 1e-12] = 1e-12
e_eligens_dfe_df$value[e_eligens_dfe_df$value >= 1] = 1
# e_eligens_dfe_df = e_eligens_dfe_df[e_eligens_dfe_df$variable == 'gamma_dfe_dist_low' || e_eligens_dfe_df$variable == 'neugamma_dfe_dist_low', ]
e_eligens_dfe_df = rbind(
  e_eligens_dfe_df[e_eligens_dfe_df$variable == 'gamma_dfe_dist_low', ],
  e_eligens_dfe_df[e_eligens_dfe_df$variable == 'neugamma_dfe_dist_low',])

e_eligens_dfe_df$variable <- as.character(e_eligens_dfe_df$variable)

e_eligens_dfe_df$variable[e_eligens_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
e_eligens_dfe_df$variable[e_eligens_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

e_eligens_dfe_figure = ggplot(e_eligens_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Bacteroides stercoris DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))

e_rectale_dfe_df = melt(e_rectale_dfe_params)
e_rectale_dfe_df$value[e_rectale_dfe_df$value <= 1e-12] = 1e-12
e_rectale_dfe_df$value[e_rectale_dfe_df$value >= 1] = 1
# e_rectale_dfe_df = e_rectale_dfe_df[e_rectale_dfe_df$variable == 'gamma_dfe_dist_low' || e_rectale_dfe_df$variable == 'neugamma_dfe_dist_low', ]
e_rectale_dfe_df = rbind(
  e_rectale_dfe_df[e_rectale_dfe_df$variable == 'gamma_dfe_dist_low', ],
  e_rectale_dfe_df[e_rectale_dfe_df$variable == 'neugamma_dfe_dist_low',])

e_rectale_dfe_df$variable <- as.character(e_rectale_dfe_df$variable)

e_rectale_dfe_df$variable[e_rectale_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
e_rectale_dfe_df$variable[e_rectale_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

e_rectale_dfe_figure = ggplot(e_rectale_dfe_df, aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 0.95) +
  labs(
    title = 'Bacteroides stercoris DFE Comparison',
    subtitle = 'Assuming a mutation rate of mu=4.08E-10'
  ) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection coefficient') +
  scale_fill_manual(values=c("goldenrod1", "yellow2"))

a_muciniphila_dfe_df = melt(a_muciniphila_dfe_params)
# a_muciniphila_dfe_df$value = a_muciniphila_dfe_df$value * 2
a_muciniphila_dfe_df$value[a_muciniphila_dfe_df$value <= 1e-12] = 1e-12
a_muciniphila_dfe_df$value[a_muciniphila_dfe_df$value >= 1] = 1
# a_muciniphila_dfe_df = a_muciniphila_dfe_df[a_muciniphila_dfe_df$variable == 'gamma_dfe_dist_low' || a_muciniphila_dfe_df$variable == 'neugamma_dfe_dist_low', ]
a_muciniphila_dfe_df = rbind(
  a_muciniphila_dfe_df[a_muciniphila_dfe_df$variable == 'gamma_dfe_dist_low', ],
  a_muciniphila_dfe_df[a_muciniphila_dfe_df$variable == 'neugamma_dfe_dist_low',])

a_muciniphila_dfe_df$variable <- as.character(a_muciniphila_dfe_df$variable)

a_muciniphila_dfe_df$variable[a_muciniphila_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
a_muciniphila_dfe_df$variable[a_muciniphila_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

r_bromii_dfe_df = melt(r_bromii_dfe_params)
# r_bromii_dfe_df$value = r_bromii_dfe_df$value * 2
r_bromii_dfe_df$value[r_bromii_dfe_df$value <= 1e-12] = 1e-12
r_bromii_dfe_df$value[r_bromii_dfe_df$value >= 1] = 1
# r_bromii_dfe_df = r_bromii_dfe_df[r_bromii_dfe_df$variable == 'gamma_dfe_dist_low' || r_bromii_dfe_df$variable == 'neugamma_dfe_dist_low', ]
r_bromii_dfe_df = rbind(
  r_bromii_dfe_df[r_bromii_dfe_df$variable == 'gamma_dfe_dist_low', ],
  r_bromii_dfe_df[r_bromii_dfe_df$variable == 'neugamma_dfe_dist_low',])

r_bromii_dfe_df$variable <- as.character(r_bromii_dfe_df$variable)

r_bromii_dfe_df$variable[r_bromii_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
r_bromii_dfe_df$variable[r_bromii_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

p_distasonis_dfe_df = melt(p_distasonis_dfe_params)
# p_distasonis_dfe_df$value = p_distasonis_dfe_df$value * 2
p_distasonis_dfe_df$value[p_distasonis_dfe_df$value <= 1e-12] = 1e-12
p_distasonis_dfe_df$value[p_distasonis_dfe_df$value >= 1] = 1
# p_distasonis_dfe_df = p_distasonis_dfe_df[p_distasonis_dfe_df$variable == 'gamma_dfe_dist_low' || p_distasonis_dfe_df$variable == 'neugamma_dfe_dist_low', ]
p_distasonis_dfe_df = rbind(
  p_distasonis_dfe_df[p_distasonis_dfe_df$variable == 'gamma_dfe_dist_low', ],
  p_distasonis_dfe_df[p_distasonis_dfe_df$variable == 'neugamma_dfe_dist_low',])

p_distasonis_dfe_df$variable <- as.character(p_distasonis_dfe_df$variable)

p_distasonis_dfe_df$variable[p_distasonis_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
p_distasonis_dfe_df$variable[p_distasonis_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

p_merdae_dfe_df = melt(p_merdae_dfe_params)
# p_merdae_dfe_df$value = p_merdae_dfe_df$value * 2
p_merdae_dfe_df$value[p_merdae_dfe_df$value <= 1e-12] = 1e-12
p_merdae_dfe_df$value[p_merdae_dfe_df$value >= 1] = 1
# p_merdae_dfe_df = p_merdae_dfe_df[p_merdae_dfe_df$variable == 'gamma_dfe_dist_low' || p_merdae_dfe_df$variable == 'neugamma_dfe_dist_low', ]
p_merdae_dfe_df = rbind(
  p_merdae_dfe_df[p_merdae_dfe_df$variable == 'gamma_dfe_dist_low', ],
  p_merdae_dfe_df[p_merdae_dfe_df$variable == 'neugamma_dfe_dist_low',])

p_merdae_dfe_df$variable <- as.character(p_merdae_dfe_df$variable)

p_merdae_dfe_df$variable[p_merdae_dfe_df$variable == 'neugamma_dfe_dist_low'] <- 'Neutral + Gamma-Distributed DFE'
p_merdae_dfe_df$variable[p_merdae_dfe_df$variable == 'gamma_dfe_dist_low'] <- 'Gamma-Distributed DFE'

a_muciniphila_dfe_figure = ggplot(a_muciniphila_dfe_df[a_muciniphila_dfe_df$variable == 'Gamma-Distributed DFE', ], aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 2.5) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.x = element_blank()) + 
  ylab('Proportion of Sites') +
  theme(legend.position = "none") + 
  xlab('Selection Coefficient') +
  ggtitle('Akkermansia muciniphila') +
  theme(plot.title = element_text(face = "italic")) +
  scale_fill_manual(values=c("#3da1ff"))

r_bromii_dfe_figure = ggplot(r_bromii_dfe_df[r_bromii_dfe_df$variable == 'Gamma-Distributed DFE', ], aes(x=value, y=fct_rev(variable), fill=variable)) +
  geom_density_ridges2(aes(fill = variable), stat = "binline", binwidth = 1, scale = 2.5) +
  theme_ridges() +
  scale_x_log10(limits=c(1e-13, 1e2)) +
  theme(axis.title.y = element_blank()) + 
  theme(legend.position = "none") + 
  xlab('Selection Coefficient') +
  ggtitle('Ruminococcus bromii') +
  theme(plot.title = element_text(face = "italic")) +
  scale_fill_manual(values=c("#fe61cf"))

a_muciniphila_dfe_figure + r_bromii_dfe_figure + plot_layout(ncol = 1)

# Weakly Deleterious

weakly_deleterious_s =  1E-6
moderately_deleterious_s = 1E-2
lethal_s = 0.5

DFE_cutoffs = c(-Inf, 1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1, Inf)

a_muciniphila_gamma_dfe = a_muciniphila_dfe_df[a_muciniphila_dfe_df$variable=='Gamma-Distributed DFE', ]
r_bromii_gamma_dfe = r_bromii_dfe_df[r_bromii_dfe_df$variable=='Gamma-Distributed DFE', ]

a_muciniphila_gamma_dfe[a_muciniphila_gamma_dfe$value < 1e-13, ]= 1e-13
a_muciniphila_gamma_dfe[a_muciniphila_gamma_dfe$value > 1e2, ]= 1e2
a_muciniphila_gamma_dfe_bins = cut(a_muciniphila_gamma_dfe$value, breaks=DFE_cutoffs)

r_bromii_gamma_dfe[r_bromii_gamma_dfe$value < 1e-13, ]= 1e-13
r_bromii_gamma_dfe[r_bromii_gamma_dfe$value > 1e2, ]= 1e2
r_bromii_gamma_dfe_bins = cut(r_bromii_gamma_dfe$value, breaks=DFE_cutoffs)

a_muciniphila_weakly_deleterious = mean(a_muciniphila_gamma_dfe$value < weakly_deleterious_s)
a_muciniphila_weakly_deleterious
a_muciniphila_moderately_deleterious =  mean(weakly_deleterious_s < a_muciniphila_gamma_dfe$value & a_muciniphila_gamma_dfe$value < moderately_deleterious_s)
a_muciniphila_moderately_deleterious
a_muciniphila_highly_deleterious = mean(moderately_deleterious_s < a_muciniphila_gamma_dfe$value & a_muciniphila_gamma_dfe$value < lethal_s)
a_muciniphila_highly_deleterious
a_muciniphila_lethal = mean(a_muciniphila_gamma_dfe$value > lethal_s)
a_muciniphila_lethal

r_bromii_weakly_deleterious = mean(r_bromii_gamma_dfe$value < weakly_deleterious_s)
r_bromii_weakly_deleterious
r_bromii_moderately_deleterious =  mean(weakly_deleterious_s < r_bromii_gamma_dfe$value & r_bromii_gamma_dfe$value < moderately_deleterious_s)
r_bromii_moderately_deleterious
r_bromii_highly_deleterious = mean(moderately_deleterious_s < r_bromii_gamma_dfe$value & r_bromii_gamma_dfe$value < lethal_s)
r_bromii_highly_deleterious
r_bromii_lethal = mean(r_bromii_gamma_dfe$value > lethal_s)
r_bromii_lethal

b_fragilis_gamma_dfe = b_fragilis_dfe_df[b_fragilis_dfe_df$variable=='Gamma-Distributed DFE', ]
b_cellulosilyticus_gamma_dfe = b_cellulosilyticus_dfe_df[b_cellulosilyticus_dfe_df$variable=='Gamma-Distributed DFE', ]
b_stercoris_gamma_dfe = b_stercoris_dfe_df[b_stercoris_dfe_df$variable=='Gamma-Distributed DFE', ]
b_uniformis_gamma_dfe = b_uniformis_dfe_df[b_uniformis_dfe_df$variable=='Gamma-Distributed DFE', ]
b_thetaiotaomicron_gamma_dfe = b_thetaiotaomicron_dfe_df[b_thetaiotaomicron_dfe_df$variable=='Gamma-Distributed DFE', ]
b_xylanisolvens_gamma_dfe = b_xylanisolvens_dfe_df[b_xylanisolvens_dfe_df$variable=='Gamma-Distributed DFE', ]
b_caccae_gamma_dfe = b_caccae_dfe_df[b_caccae_dfe_df$variable=='Gamma-Distributed DFE', ]
b_vulgatus_gamma_dfe = b_vulgatus_dfe_df[b_vulgatus_dfe_df$variable=='Gamma-Distributed DFE', ]

b_fragilis_weakly_deleterious = mean(b_fragilis_gamma_dfe$value < weakly_deleterious_s)
b_fragilis_weakly_deleterious
b_fragilis_moderately_deleterious =  mean(weakly_deleterious_s < b_fragilis_gamma_dfe$value & b_fragilis_gamma_dfe$value < moderately_deleterious_s)
b_fragilis_moderately_deleterious
b_fragilis_highly_deleterious = mean(moderately_deleterious_s < b_fragilis_gamma_dfe$value & b_fragilis_gamma_dfe$value < lethal_s)
b_fragilis_highly_deleterious
b_fragilis_lethal = mean(b_fragilis_gamma_dfe$value > lethal_s)
b_fragilis_lethal

b_fragilis_gamma_dfe[b_fragilis_gamma_dfe$value < 1e-13, ]= 1e-13
b_fragilis_gamma_dfe[b_fragilis_gamma_dfe$value > 1e2, ]= 1e2
b_fragilis_gamma_dfe_bins = cut(b_fragilis_gamma_dfe$value, breaks=DFE_cutoffs)

b_cellulosilyticus_weakly_deleterious = mean(b_cellulosilyticus_gamma_dfe$value < weakly_deleterious_s)
b_cellulosilyticus_weakly_deleterious
b_cellulosilyticus_moderately_deleterious =  mean(weakly_deleterious_s < b_cellulosilyticus_gamma_dfe$value & b_cellulosilyticus_gamma_dfe$value < moderately_deleterious_s)
b_cellulosilyticus_moderately_deleterious
b_cellulosilyticus_highly_deleterious = mean(moderately_deleterious_s < b_cellulosilyticus_gamma_dfe$value & b_cellulosilyticus_gamma_dfe$value < lethal_s)
b_cellulosilyticus_highly_deleterious
b_cellulosilyticus_lethal = mean(b_cellulosilyticus_gamma_dfe$value > lethal_s)
b_cellulosilyticus_lethal

b_cellulosilyticus_gamma_dfe[b_cellulosilyticus_gamma_dfe$value < 1e-13, ]= 1e-13
b_cellulosilyticus_gamma_dfe[b_cellulosilyticus_gamma_dfe$value > 1e2, ]= 1e2
b_cellulosilyticus_gamma_dfe_bins = cut(b_cellulosilyticus_gamma_dfe$value, breaks=DFE_cutoffs)


b_stercoris_weakly_deleterious = mean(b_stercoris_gamma_dfe$value < weakly_deleterious_s)
b_stercoris_weakly_deleterious
b_stercoris_moderately_deleterious =  mean(weakly_deleterious_s < b_stercoris_gamma_dfe$value & b_stercoris_gamma_dfe$value < moderately_deleterious_s)
b_stercoris_moderately_deleterious
b_stercoris_highly_deleterious = mean(moderately_deleterious_s < b_stercoris_gamma_dfe$value & b_stercoris_gamma_dfe$value < lethal_s)
b_stercoris_highly_deleterious
b_stercoris_lethal = mean(b_stercoris_gamma_dfe$value > lethal_s)
b_stercoris_lethal

b_stercoris_gamma_dfe[b_stercoris_gamma_dfe$value < 1e-13, ]= 1e-13
b_stercoris_gamma_dfe[b_stercoris_gamma_dfe$value > 1e2, ]= 1e2
b_stercoris_gamma_dfe_bins = cut(b_stercoris_gamma_dfe$value, breaks=DFE_cutoffs)

b_uniformis_weakly_deleterious = mean(b_uniformis_gamma_dfe$value < weakly_deleterious_s)
b_uniformis_weakly_deleterious
b_uniformis_moderately_deleterious =  mean(weakly_deleterious_s < b_uniformis_gamma_dfe$value & b_uniformis_gamma_dfe$value < moderately_deleterious_s)
b_uniformis_moderately_deleterious
b_uniformis_highly_deleterious = mean(moderately_deleterious_s < b_uniformis_gamma_dfe$value & b_uniformis_gamma_dfe$value < lethal_s)
b_uniformis_highly_deleterious
b_uniformis_lethal = mean(b_uniformis_gamma_dfe$value > lethal_s)
b_uniformis_lethal

b_uniformis_gamma_dfe[b_uniformis_gamma_dfe$value < 1e-13, ]= 1e-13
b_uniformis_gamma_dfe[b_uniformis_gamma_dfe$value > 1e2, ]= 1e2
b_uniformis_gamma_dfe_bins = cut(b_uniformis_gamma_dfe$value, breaks=DFE_cutoffs)

b_thetaiotaomicron_weakly_deleterious = mean(b_thetaiotaomicron_gamma_dfe$value < weakly_deleterious_s)
b_thetaiotaomicron_weakly_deleterious
b_thetaiotaomicron_moderately_deleterious =  mean(weakly_deleterious_s < b_thetaiotaomicron_gamma_dfe$value & b_thetaiotaomicron_gamma_dfe$value < moderately_deleterious_s)
b_thetaiotaomicron_moderately_deleterious
b_thetaiotaomicron_highly_deleterious = mean(moderately_deleterious_s < b_thetaiotaomicron_gamma_dfe$value & b_thetaiotaomicron_gamma_dfe$value < lethal_s)
b_thetaiotaomicron_highly_deleterious
b_thetaiotaomicron_lethal = mean(b_thetaiotaomicron_gamma_dfe$value > lethal_s)
b_thetaiotaomicron_lethal

b_thetaiotaomicron_gamma_dfe[b_thetaiotaomicron_gamma_dfe$value < 1e-13, ]= 1e-13
b_thetaiotaomicron_gamma_dfe[b_thetaiotaomicron_gamma_dfe$value > 1e2, ]= 1e2
b_thetaiotaomicron_gamma_dfe_bins = cut(b_thetaiotaomicron_gamma_dfe$value, breaks=DFE_cutoffs)

b_xylanisolvens_weakly_deleterious = mean(b_xylanisolvens_gamma_dfe$value < weakly_deleterious_s)
b_xylanisolvens_weakly_deleterious
b_xylanisolvens_moderately_deleterious =  mean(weakly_deleterious_s < b_xylanisolvens_gamma_dfe$value & b_xylanisolvens_gamma_dfe$value < moderately_deleterious_s)
b_xylanisolvens_moderately_deleterious
b_xylanisolvens_highly_deleterious = mean(moderately_deleterious_s < b_xylanisolvens_gamma_dfe$value & b_xylanisolvens_gamma_dfe$value < lethal_s)
b_xylanisolvens_highly_deleterious
b_xylanisolvens_lethal = mean(b_xylanisolvens_gamma_dfe$value > lethal_s)
b_xylanisolvens_lethal

b_xylanisolvens_gamma_dfe[b_xylanisolvens_gamma_dfe$value < 1e-13, ]= 1e-13
b_xylanisolvens_gamma_dfe[b_xylanisolvens_gamma_dfe$value > 1e2, ]= 1e2
b_xylanisolvens_gamma_dfe_bins = cut(b_xylanisolvens_gamma_dfe$value, breaks=DFE_cutoffs)

b_caccae_weakly_deleterious = mean(b_caccae_gamma_dfe$value < weakly_deleterious_s)
b_caccae_weakly_deleterious
b_caccae_moderately_deleterious =  mean(weakly_deleterious_s < b_caccae_gamma_dfe$value & b_caccae_gamma_dfe$value < moderately_deleterious_s)
b_caccae_moderately_deleterious
b_caccae_highly_deleterious = mean(moderately_deleterious_s < b_caccae_gamma_dfe$value & b_caccae_gamma_dfe$value < lethal_s)
b_caccae_highly_deleterious
b_caccae_lethal = mean(b_caccae_gamma_dfe$value > lethal_s)
b_caccae_lethal

b_caccae_gamma_dfe[b_caccae_gamma_dfe$value < 1e-13, ]= 1e-13
b_caccae_gamma_dfe[b_caccae_gamma_dfe$value > 1e2, ]= 1e2
b_caccae_gamma_dfe_bins = cut(b_caccae_gamma_dfe$value, breaks=DFE_cutoffs)

b_vulgatus_weakly_deleterious = mean(b_vulgatus_gamma_dfe$value < weakly_deleterious_s)
b_vulgatus_weakly_deleterious
b_vulgatus_moderately_deleterious =  mean(weakly_deleterious_s < b_vulgatus_gamma_dfe$value & b_vulgatus_gamma_dfe$value < moderately_deleterious_s)
b_vulgatus_moderately_deleterious
b_vulgatus_highly_deleterious = mean(moderately_deleterious_s < b_vulgatus_gamma_dfe$value & b_vulgatus_gamma_dfe$value < lethal_s)
b_vulgatus_highly_deleterious
b_vulgatus_lethal = mean(b_vulgatus_gamma_dfe$value > lethal_s)
b_vulgatus_lethal

b_vulgatus_gamma_dfe[b_vulgatus_gamma_dfe$value < 1e-13, ]= 1e-13
b_vulgatus_gamma_dfe[b_vulgatus_gamma_dfe$value > 1e2, ]= 1e2
b_vulgatus_gamma_dfe_bins = cut(b_vulgatus_gamma_dfe$value, breaks=DFE_cutoffs)

# Bacteroides genus
sum(b_fragilis_weakly_deleterious,
  b_cellulosilyticus_weakly_deleterious,
  b_stercoris_weakly_deleterious,
  b_uniformis_weakly_deleterious,
  b_thetaiotaomicron_weakly_deleterious,
  b_xylanisolvens_weakly_deleterious,
  b_caccae_weakly_deleterious,
  b_vulgatus_weakly_deleterious) / 8

sum(b_fragilis_moderately_deleterious,
  b_cellulosilyticus_moderately_deleterious,
  b_stercoris_moderately_deleterious,
  b_uniformis_moderately_deleterious,
  b_thetaiotaomicron_moderately_deleterious,
  b_xylanisolvens_moderately_deleterious,
  b_caccae_moderately_deleterious,
  b_vulgatus_moderately_deleterious) / 8

sum(b_fragilis_highly_deleterious,
  b_cellulosilyticus_highly_deleterious,
  b_stercoris_highly_deleterious,
  b_uniformis_highly_deleterious,
  b_thetaiotaomicron_highly_deleterious,
  b_xylanisolvens_highly_deleterious,
  b_caccae_highly_deleterious,
  b_vulgatus_highly_deleterious) / 8

sum(b_fragilis_lethal,
  b_cellulosilyticus_lethal,
  b_stercoris_lethal,
  b_uniformis_lethal,
  b_thetaiotaomicron_lethal,
  b_xylanisolvens_lethal,
  b_caccae_lethal,
  b_vulgatus_lethal) / 8

print(c(b_fragilis_weakly_deleterious,
  b_cellulosilyticus_weakly_deleterious,
  b_stercoris_weakly_deleterious,
  b_uniformis_weakly_deleterious,
  b_thetaiotaomicron_weakly_deleterious,
  b_xylanisolvens_weakly_deleterious,
  b_caccae_weakly_deleterious,
  b_vulgatus_weakly_deleterious))

print(c(b_fragilis_moderately_deleterious,
  b_cellulosilyticus_moderately_deleterious,
  b_stercoris_moderately_deleterious,
  b_uniformis_moderately_deleterious,
  b_thetaiotaomicron_moderately_deleterious,
  b_xylanisolvens_moderately_deleterious,
  b_caccae_moderately_deleterious,
  b_vulgatus_moderately_deleterious))

print(c(b_fragilis_highly_deleterious,
  b_cellulosilyticus_highly_deleterious,
  b_stercoris_highly_deleterious,
  b_uniformis_highly_deleterious,
  b_thetaiotaomicron_highly_deleterious,
  b_xylanisolvens_highly_deleterious,
  b_caccae_highly_deleterious,
  b_vulgatus_highly_deleterious))

print(c(b_fragilis_lethal,
  b_cellulosilyticus_lethal,
  b_stercoris_lethal,
  b_uniformis_lethal,
  b_thetaiotaomicron_lethal,
  b_xylanisolvens_lethal,
  b_caccae_lethal,
  b_vulgatus_lethal))

e_eligens_gamma_dfe = e_eligens_dfe_df[e_eligens_dfe_df$variable=='Gamma-Distributed DFE', ]
e_rectale_gamma_dfe = e_rectale_dfe_df[e_rectale_dfe_df$variable=='Gamma-Distributed DFE', ]

e_eligens_weakly_deleterious = mean(e_eligens_gamma_dfe$value < weakly_deleterious_s)
e_eligens_weakly_deleterious
e_eligens_moderately_deleterious =  mean(weakly_deleterious_s < e_eligens_gamma_dfe$value & e_eligens_gamma_dfe$value < moderately_deleterious_s)
e_eligens_moderately_deleterious
e_eligens_highly_deleterious = mean(moderately_deleterious_s < e_eligens_gamma_dfe$value & e_eligens_gamma_dfe$value < lethal_s)
e_eligens_highly_deleterious
e_eligens_lethal = mean(e_eligens_gamma_dfe$value > lethal_s)
e_eligens_lethal

e_rectale_weakly_deleterious = mean(e_rectale_gamma_dfe$value < weakly_deleterious_s)
e_rectale_weakly_deleterious
e_rectale_moderately_deleterious =  mean(weakly_deleterious_s < e_rectale_gamma_dfe$value & e_rectale_gamma_dfe$value < moderately_deleterious_s)
e_rectale_moderately_deleterious
e_rectale_highly_deleterious = mean(moderately_deleterious_s < e_rectale_gamma_dfe$value & e_rectale_gamma_dfe$value < lethal_s)
e_rectale_highly_deleterious
e_rectale_lethal = mean(e_rectale_gamma_dfe$value > lethal_s)
e_rectale_lethal

p_merdae_gamma_dfe = p_merdae_dfe_df[p_merdae_dfe_df$variable=='Gamma-Distributed DFE', ]
p_distasonis_gamma_dfe = p_distasonis_dfe_df[p_distasonis_dfe_df$variable=='Gamma-Distributed DFE', ]

p_merdae_gamma_dfe[p_merdae_gamma_dfe$value < 1e-13, ]= 1e-13
p_merdae_gamma_dfe[p_merdae_gamma_dfe$value > 1e2, ]= 1e2
p_merdae_gamma_dfe_bins = cut(p_merdae_gamma_dfe$value, breaks=DFE_cutoffs)

p_distasonis_gamma_dfe[p_distasonis_gamma_dfe$value < 1e-13, ]= 1e-13
p_distasonis_gamma_dfe[p_distasonis_gamma_dfe$value > 1e2, ]= 1e2
p_distasonis_gamma_dfe_bins = cut(p_distasonis_gamma_dfe$value, breaks=DFE_cutoffs)

p_merdae_weakly_deleterious = mean(p_merdae_gamma_dfe$value < weakly_deleterious_s)
p_merdae_weakly_deleterious
p_merdae_moderately_deleterious =  mean(weakly_deleterious_s < p_merdae_gamma_dfe$value & p_merdae_gamma_dfe$value < moderately_deleterious_s)
p_merdae_moderately_deleterious
p_merdae_highly_deleterious = mean(moderately_deleterious_s < p_merdae_gamma_dfe$value & p_merdae_gamma_dfe$value < lethal_s)
p_merdae_highly_deleterious
p_merdae_lethal = mean(p_merdae_gamma_dfe$value > lethal_s)
p_merdae_lethal

p_distasonis_weakly_deleterious = mean(p_distasonis_gamma_dfe$value < weakly_deleterious_s)
p_distasonis_weakly_deleterious
p_distasonis_moderately_deleterious =  mean(weakly_deleterious_s < p_distasonis_gamma_dfe$value & p_distasonis_gamma_dfe$value < moderately_deleterious_s)
p_distasonis_moderately_deleterious
p_distasonis_highly_deleterious = mean(moderately_deleterious_s < p_distasonis_gamma_dfe$value & p_distasonis_gamma_dfe$value < lethal_s)
p_distasonis_highly_deleterious
p_distasonis_lethal = mean(p_distasonis_gamma_dfe$value > lethal_s)
p_distasonis_lethal

b_cellulosilyticus_dfe_figure + b_stercoris_dfe_figure + plot_layout(ncol=1)

o_splanchnicus_dfe_figure + e_eligens_dfe_figure + b_cellulosilyticus_dfe_figure + plot_layout(ncol = 1)

DFE_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Prevotella_copri_61740_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_inferred_DFE.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt'
)

mean_s = numeric(27)
weak_s = numeric(27)
moderate_s = numeric(27)
high_s = numeric(27)
lethal_s = numeric(27)

for (i in 1:length(DFE_file_list)) {
  mean_s[i] = compute_selection_coefficients(DFE_file_list[i])[1]
  weak_s[i] = compute_selection_coefficients(DFE_file_list[i])[2]
  moderate_s[i] = compute_selection_coefficients(DFE_file_list[i])[3]
  high_s[i] = compute_selection_coefficients(DFE_file_list[i])[4]
  lethal_s[i] = compute_selection_coefficients(DFE_file_list[i])[5]
}

DFE_lethality = data.frame(
  species=phylogenetic_levels,
  mean_s,
  weak_s,
  moderate_s,
  high_s,
  lethal_s
)

DFE_lethality

# write.csv(DFE_lethality, file = "../Summary/DFE_lethality.csv", row.names = FALSE)

lethality_engraftment_correlation = read.csv('../Summary/lethality_engraftment_correlation.csv')
names(lethality_engraftment_correlation) = c(
  'species_ianiro',
  'species_midas',
  'engraftment',
  'mean_s',
  'weak_s',
  'moderate_s',
  'high_s',
  'lethal_s'
)

lethality_engraftment_correlation$more_than_high_s = lethality_engraftment_correlation$high_s + lethality_engraftment_correlation$lethal_s
lethality_engraftment_correlation$more_than_moderate_s = lethality_engraftment_correlation$moderate_s + lethality_engraftment_correlation$high_s + lethality_engraftment_correlation$lethal_s
lethality_engraftment_correlation

ggplot(lethality_engraftment_correlation, aes(x = mean_s, y = engraftment)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Average selection coefficient", y = "Engraftment Rate") +
  ggtitle("Correlation between mean selection coefficient and engraftment rate") +
  scale_x_log10() +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth")

ggplot(lethality_engraftment_correlation, aes(x = mean_s, y = engraftment)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Average selection coefficient", y = "Engraftment Rate") +
  ggtitle("Correlation between mean selection coefficient and engraftment rate") +
  xlim(0, 0.75) +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth")

ggplot(lethality_engraftment_correlation, aes(x = lethal_s, y = engraftment)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Proportion of lethal mutations", y = "Engraftment Rate") +
  ggtitle("Correlation between lethal proportion and engraftment rate") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth")

ggplot(lethality_engraftment_correlation, aes(x = more_than_high_s, y = engraftment)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Proportion of mutations with s >= 1E-2", y = "Engraftment Rate") +
  ggtitle("Correlation between deleterious proportion and engraftment rate") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth")

ggplot(lethality_engraftment_correlation, aes(x = more_than_moderate_s, y = engraftment)) +
  geom_point(aes(color=species_midas), show.legend=FALSE) +
  labs(x = "Proportion of mutations with s >= 1E-6", y = "Engraftment Rate") +
  ggtitle("Correlation between deleterious proportion and engraftment rate") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_text_repel(aes(label = species_midas, color=species_midas, fontface = 'italic'), show.legend = FALSE, size=3) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth")

compare_hmp_sfs(b_cellulosilyticus_hmp_qp_syn, one_epoch_14, b_cellulosilyticus_core_two_epoch, b_cellulosilyticus_core_three_epoch, b_cellulosilyticus_hmp_qp_nonsyn, b_cellulosilyticus_complete_gamma_dfe, b_cellulosilyticus_complete_neugamma_dfe) + ggtitle('B. cellulosilyticus (Downsampled to 14)')
compare_hmp_sfs(e_eligens_hmp_qp_syn, one_epoch_14, e_eligens_core_two_epoch, e_eligens_core_three_epoch, e_eligens_hmp_qp_nonsyn, e_eligens_complete_gamma_dfe, e_eligens_complete_neugamma_dfe) + ggtitle('E. eligens (Downsampled to 14)')
compare_hmp_sfs(b_ovatus_hmp_qp_syn, one_epoch_14, b_ovatus_core_two_epoch, b_ovatus_core_three_epoch, b_ovatus_hmp_qp_nonsyn, b_ovatus_complete_gamma_dfe, b_ovatus_complete_neugamma_dfe) + ggtitle('B. ovatus (Downsampled to 14)')

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


# 800 x 1200
# Phylogenetic Tree in APE

get_species_code_reference = function(code, reference) {
  if (code %in% reference$species_id) {
    return(reference[reference$species_id == code, ]$midas_number)
  } else if(code %in% reference$midas_number) {
    return(reference[reference$midas_number == code, ]$species_id)
  }
}

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
species_subtree = c(
  'Akkermansia_muciniphila_55290',
  'Alistipes_finegoldii_56071',
  'Alistipes_onderdonkii_55464',
  'Alistipes_putredinis_61533',
  'Alistipes_shahii_62199',
  'Bacteroidales_bacterium_58650',
  'Bacteroides_caccae_53434',
  'Bacteroides_cellulosilyticus_58046',
  'Bacteroides_fragilis_54507',
  # 'Bacteroides_massiliensis_44749',
  # 'Bacteroides_ovatus_58035',
  'Bacteroides_stercoris_56735',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_uniformis_57318',
  'Bacteroides_vulgatus_57955',
  'Bacteroides_xylanisolvens_57185',
  'Barnesiella_intestinihominis_62208',
  # 'Coprococcus_sp_62244',
  'Dialister_invisus_61905',
  'Eubacterium_eligens_61678',
  'Eubacterium_rectale_56927',
  'Faecalibacterium_prausnitzii_57453',
  'Odoribacter_splanchnicus_62174',
  'Oscillibacter_sp_60799',
  'Parabacteroides_distasonis_56985',
  'Parabacteroides_merdae_56972',
  'Phascolarctobacterium_sp_59817',
  'Prevotella_copri_61740',
  'Ruminococcus_bicirculans_59300',
  'Ruminococcus_bromii_62047'
)

#' # Specify the tip labels for the subtree you want to extract
#' species_subtree = c(
#'   #'Akkermansia_muciniphila_55290',
#'   #'Alistipes_finegoldii_56071',
#'   #'Alistipes_onderdonkii_55464',
#'   #'Alistipes_putredinis_61533',
#'   #'Alistipes_shahii_62199',
#'   #'Bacteroidales_bacterium_58650',
#'   #'Bacteroides_caccae_53434',
#'   #'Bacteroides_cellulosilyticus_58046',
#'   #'Bacteroides_fragilis_54507',
#'   # 'Bacteroides_massiliensis_44749',
#'   # 'Bacteroides_ovatus_58035',
#'   #'Bacteroides_stercoris_56735',
#'   'Bacteroides_thetaiotaomicron_56941',
#'   'Bacteroides_uniformis_57318',
#'   'Bacteroides_vulgatus_57955',
#'   #'Bacteroides_xylanisolvens_57185',
#'   'Barnesiella_intestinihominis_62208',
#'   # 'Coprococcus_sp_62244',
#'   #'Dialister_invisus_61905',
#'   #'Eubacterium_eligens_61678',
#'   'Eubacterium_rectale_56927',
#'   'Faecalibacterium_prausnitzii_57453',
#'   #'Odoribacter_splanchnicus_62174',
#'   #'Oscillibacter_sp_60799',
#'   'Parabacteroides_distasonis_56985'
#'   #'Parabacteroides_merdae_56972',
#'   #'Phascolarctobacterium_sp_59817',
#'   #'Prevotella_copri_61740',
#'   #'Ruminococcus_bicirculans_59300',
#'   #'Ruminococcus_bromii_62047'
#' )

midas_code_subtree = c()

for (species in species_subtree) {
  midas_code_subtree = c(midas_code_subtree, get_species_code_reference(species, output_table))
}

print(midas_code_subtree)

subtree_tips = midas_code_subtree

# Extract the subtree
subtree <- keep.tip(input_tree, subtree_tips)

# Print the extracted subtree
print(subtree)

for (i in 1:length(subtree$tip.label)) {
  print(subtree$tip.label[i])
  new_tip = get_species_code_reference(subtree$tip.label[i], output_table)
  # new_tip = str_sub(new_tip, 1, str_length(new_tip)-6)
  subtree$tip.label[i] = new_tip
  print(subtree$tip.label[i])
}

plot(subtree)
# write.tree(subtree, file='../Summary/good_species.newick')

# write.tree(subtree, file='../Summary/core_accessory.newick')

# Likelihood Surfaces for Core Genes
plot_likelihood_surface_contour('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_likelihood_surface.csv') + ggtitle('A. finegoldii likelihood surface')
plot_likelihood_surface_contour('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_likelihood_surface.csv') + ggtitle('A. onderdonkii likelihood surface')
plot_likelihood_surface_contour('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Alistipes_shahii_62199_downsampled_14/core_likelihood_surface.csv') + ggtitle('A. shahii likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. bacterium likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. caccae likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. cellulosilyticus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. fragilis likelihood surface')
# plot_likelihood_surface('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/core_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. ovatus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. stercoris likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. thetaiotaomicron likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. vulgatus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. xylanisolvens likelihood surface')
plot_likelihood_surface_contour('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_likelihood_surface.csv') + ggtitle('B. intestinihominis likelihood surface')
# plot_likelihood_surface('../Analysis/Coprococcus_sp_62244_downsampled_14/core_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Dialister_invisus_61905_downsampled_14/core_likelihood_surface.csv') + ggtitle('D. invisus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_likelihood_surface.csv') + ggtitle('E. eligens likelihood surface')
plot_likelihood_surface_contour('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_likelihood_surface.csv') + ggtitle('E. rectale likelihood surface')
plot_likelihood_surface_contour('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_likelihood_surface.csv') + ggtitle('F. prausnitzii likelihood surface')
plot_likelihood_surface_contour('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_likelihood_surface.csv') + ggtitle('O. splanchnicus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_likelihood_surface.csv') + ggtitle('Oscillibacter species likelihood surface')
plot_likelihood_surface_contour('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_likelihood_surface.csv') + ggtitle('P. distasonis likelihood surface')
plot_likelihood_surface_contour('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_likelihood_surface.csv') + ggtitle('P. merdae likelihood surface')
plot_likelihood_surface_contour('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_likelihood_surface.csv') + ggtitle('Phascolarctobacterium species likelihood surface')
plot_likelihood_surface_contour('../Analysis/Prevotella_copri_61740_downsampled_14/core_likelihood_surface.csv') + ggtitle('P. copri likelihood surface')
plot_likelihood_surface_contour('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_likelihood_surface.csv') + ggtitle('R. bicirculans likelihood surface')
plot_likelihood_surface_contour('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_likelihood_surface.csv') + ggtitle('R. bromii likelihood surface')

# Likelihood Surfaces for accessory genes
plot_likelihood_surface_contour('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. finegoldii likelihood surface')
plot_likelihood_surface_contour('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. onderdonkii likelihood surface')
plot_likelihood_surface_contour('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. shahii likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. bacterium likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. caccae likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. cellulosilyticus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. cellulosilyticus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. fragilis likelihood surface')
# plot_likelihood_surface('../Analysis/Bacteroides_massiliensis_44749_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. stercoris likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. thetaiotaomicron likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. vulgatus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. xylanisolvens likelihood surface')
plot_likelihood_surface_contour('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('B. intestinihominis likelihood surface')
# plot_likelihood_surface('../Analysis/Coprococcus_sp_62244_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('A. muciniphila likelihood surface')
plot_likelihood_surface_contour('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('E. eligens likelihood surface')
plot_likelihood_surface_contour('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('E. eligens likelihood surface')
plot_likelihood_surface_contour('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('E. rectale likelihood surface')
plot_likelihood_surface_contour('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('F. prausnitzii likelihood surface')
plot_likelihood_surface_contour('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('O. splanchnicus likelihood surface')
plot_likelihood_surface_contour('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('Oscillibacter species likelihood surface')
plot_likelihood_surface_contour('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('P. distasonis likelihood surface')
plot_likelihood_surface_contour('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('P. merdae likelihood surface')
plot_likelihood_surface_contour('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('Phascolarctobacterium species likelihood surface')
plot_likelihood_surface_contour('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('P. copri likelihood surface')
plot_likelihood_surface_contour('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('R. bicirculans likelihood surface')
plot_likelihood_surface_contour('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_likelihood_surface.csv') + ggtitle('R. bromii likelihood surface')

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

### Figure S1

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

sfs_and_likelihood

### Figure S6
# 1600 x 16000

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

sfs_and_likelihood_accessory

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
p13_core_dfe_talk = plot_core_accessory_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_inferred_DFE.txt') + ggtitle('*B. thetaiotaomicron*') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))
p14_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p14_core_dfe_talk = plot_core_accessory_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_inferred_DFE.txt') + ggtitle('*B. uniformis*') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))
p15_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. vulgatus, Core Genes')
p15_core_dfe_talk = plot_core_accessory_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_inferred_DFE.txt') + ggtitle('*B. vulgatus*') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))

p16_core_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. xylanisolvens, Core Genes')
p17_core_dfe = plot_core_accessory_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt') + ggtitle('B. intestinihominis, Core Genes')
p17_core_dfe_talk = plot_core_accessory_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_inferred_DFE.txt') + ggtitle('*B. intestinihominis*') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))

# p18 = plot_core_accessory_dfe('../Analysis/Coprococcus_sp_62244_downsampled_14/core_inferred_DFE.txt') + ggtitle('Coprococcus species, Core Genes')
p19_core_dfe = plot_core_accessory_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/core_inferred_DFE.txt') + ggtitle('D. invisus, Core Genes')
p20_core_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_inferred_DFE.txt') + ggtitle('E. eligens, Core Genes')
p21_core_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p21_core_dfe_talk = plot_core_accessory_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_inferred_DFE.txt') + ggtitle('*E. rectale*') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))

p22_core_dfe = plot_core_accessory_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt') + ggtitle('Core Genes')
p22_core_dfe_talk = plot_core_accessory_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_inferred_DFE.txt') + ggtitle('*F. prausnitzii*') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))

p23_core_dfe = plot_core_accessory_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_inferred_DFE.txt') + ggtitle('O. splanchnicus, Core Genes')
p24_core_dfe = plot_core_accessory_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_inferred_DFE.txt') + ggtitle('Oscillibacter species, Core Genes')
p25_core_dfe = plot_core_accessory_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt') + ggtitle('P. distasonis, Core Genes')
p25_core_dfe_talk = plot_core_accessory_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_inferred_DFE.txt') + ggtitle('*P. distasonis*') + 
    md_theme_minimal() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))

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
p13_acc_dfe_talk = plot_core_accessory_dfe('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_inferred_DFE.txt')  # + ggtitle('*Bacteroides thetaiotaomicron*, Accessory Genes') + 
    # md_theme_minimal() + 
    # theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    #   panel.background = element_blank(), axis.line = element_line(colour = "black"))

p14_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')
p14_acc_dfe_talk = plot_core_accessory_dfe('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_inferred_DFE.txt') # + ggtitle('*Bacteroides uniformis*, Accessory Genes') + 
#     md_theme_minimal() + 
#     theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
#       panel.background = element_blank(), axis.line = element_line(colour = "black"))

p15_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. vulgatus, Accessory Genes')
p15_acc_dfe_talk = plot_core_accessory_dfe('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_inferred_DFE.txt') #+ ggtitle('*Bacteroides vulgatus*, Accessory Genes') + 
    # md_theme_minimal() + 
    # theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    #   panel.background = element_blank(), axis.line = element_line(colour = "black"))

p16_acc_dfe = plot_core_accessory_dfe('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. xylanisolvens, Accessory Genes')
p17_acc_dfe = plot_core_accessory_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('B. intestinihominis, Accessory Genes')
p17_acc_dfe_talk = plot_core_accessory_dfe('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_inferred_DFE.txt') # + ggtitle('*Barnesiella intestinihominis*, Accessory Genes') + 
    # md_theme_minimal() + 
    # theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    #   panel.background = element_blank(), axis.line = element_line(colour = "black"))

# p18 = plot_core_accessory_dfe('../Analysis/Coprococcus_sp_62244_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Coprococcus species, Accessory Genes')
p19_acc_dfe = plot_core_accessory_dfe('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('D. invisus, Accessory Genes')
p20_acc_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('E. eligens, Accessory Genes')
p21_acc_dfe = plot_core_accessory_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')
p21_acc_dfe_talk = plot_core_accessory_dfe('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_inferred_DFE.txt') #+ ggtitle('*Eubacterium rectale*, Accessory Genes') + 
    # md_theme_minimal() + 
    # theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    #   panel.background = element_blank(), axis.line = element_line(colour = "black"))

p22_acc_dfe = plot_core_accessory_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Accessory Genes')
p22_acc_dfe_talk = plot_core_accessory_dfe('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_inferred_DFE.txt') #+ ggtitle('*Faecalibacterium prausnitzii*, Accessory Genes') + 
    # md_theme_minimal() + 
    # theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    #   panel.background = element_blank(), axis.line = element_line(colour = "black"))

p23_acc_dfe = plot_core_accessory_dfe('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('O. splanchnicus, Accessory Genes')
p24_acc_dfe = plot_core_accessory_dfe('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Oscillibacter species, Accessory Genes')
p25_acc_dfe = plot_core_accessory_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('P. distasonis, Accessory Genes')
p25_acc_dfe_talk = plot_core_accessory_dfe('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_inferred_DFE.txt') #+ ggtitle('*Parabacteroides distasonis*, Accessory Genes') + 
    # md_theme_minimal() + 
    # theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    #   panel.background = element_blank(), axis.line = element_line(colour = "black"))

p26_acc_dfe = plot_core_accessory_dfe('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('P. merdae, Accessory Genes')
p27_acc_dfe = plot_core_accessory_dfe('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('Phascolarctobacterium species, Accessory Genes')
p28_acc_dfe = plot_core_accessory_dfe('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('P. copri, Accessory Genes')
p29_acc_dfe = plot_core_accessory_dfe('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('R. bicirculans, Accessory Genes')
p30_acc_dfe = plot_core_accessory_dfe('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_inferred_DFE.txt') + ggtitle('R. bromii, Accessory Genes')

# 3200 x 16000

# Reorder area distribution
# Take out E. eligens
# Rescale legends to match font size
# Legend in upper right corner of figure


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

better_pi_comparison_iid + compare_iid_over_5_means + plot_layout(widths = c(3, 1))
# 1600 x 900 dimensions for saved image

# Plot DFE Grid

DFE_grid_file_list = c(
  '../Analysis/cross_species_dfe/Bacteroidales_bacterium_58650_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_putredinis_61533_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_finegoldii_56071_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_onderdonkii_55464_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_shahii_62199_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Odoribacter_splanchnicus_62174_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Parabacteroides_merdae_56972_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Prevotella_copri_61740_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_fragilis_54507_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_stercoris_56735_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_uniformis_57318_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_xylanisolvens_57185_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_caccae_53434_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Akkermansia_muciniphila_55290_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Dialister_invisus_61905_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Phascolarctobacterium_sp_59817_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_eligens_61678_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Oscillibacter_sp_60799_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Ruminococcus_bromii_62047_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Ruminococcus_bicirculans_59300_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_likelihood_surface.csv'
)

DFE_grid_file_list_constant_s = c(
  '../Analysis/cross_species_dfe/Bacteroidales_bacterium_58650_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_putredinis_61533_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_finegoldii_56071_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_onderdonkii_55464_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_shahii_62199_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Odoribacter_splanchnicus_62174_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Parabacteroides_merdae_56972_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Prevotella_copri_61740_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_fragilis_54507_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_cellulosilyticus_58046_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_stercoris_56735_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_uniformis_57318_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_xylanisolvens_57185_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_caccae_53434_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Akkermansia_muciniphila_55290_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Dialister_invisus_61905_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Phascolarctobacterium_sp_59817_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_eligens_61678_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Oscillibacter_sp_60799_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Ruminococcus_bromii_62047_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Ruminococcus_bicirculans_59300_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_constant_s_likelihood_surface.csv'
)

# for (species in DFE_grid_file_list) {
#   print(species)
#   find_dfe_mle(species)
# }

# test
cross_species_dfe_comparison(
  '../Analysis/cross_species_dfe/Akkermansia_muciniphila_55290_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Alistipes_finegoldii_56071_likelihood_surface.csv')

# dfe_comparison_matrix = matrix(, nrow=27, ncol=27)
# 
# for (i in 1:27) {
#   for (j in i:27) {  # This change ensures only the upper right triangle is compared
#     print(DFE_grid_file_list[i])
#     print(DFE_grid_file_list[j])
#     comparison = cross_species_dfe_comparison(DFE_grid_file_list[i], DFE_grid_file_list[j])
#     print(comparison)
#     dfe_comparison_matrix[i, j] = comparison
#     dfe_comparison_matrix[j, i] = comparison  # Mirror the value across the diagonal
#   }
# }
# 
# row.names(dfe_comparison_matrix) = phylogenetic_levels
# colnames(dfe_comparison_matrix) = phylogenetic_levels
# dfe_comparison_matrix

# write.csv(dfe_comparison_matrix, '../Analysis/cross_species_dfe/dfe_comparison_matrix.csv')

# dfe_constant_s_matrix = matrix(, nrow=27, ncol=27)
# 
# for (i in 1:27) {
#   for (j in i:27) {  # This change ensures only the upper right triangle is compared
#     print(DFE_grid_file_list_constant_s[i])
#     print(DFE_grid_file_list_constant_s[j])
#     comparison = cross_species_dfe_comparison(DFE_grid_file_list_constant_s[i], DFE_grid_file_list_constant_s[j])
#     print(comparison)
#     dfe_constant_s_matrix[i, j] = comparison
#     dfe_constant_s_matrix[j, i] = comparison  # Mirror the value across the diagonal
#   }
# }
# 
# row.names(dfe_constant_s_matrix) = phylogenetic_levels
# colnames(dfe_constant_s_matrix) = phylogenetic_levels
# dfe_constant_s_matrix
# 

DFE_core_file_list = c(
  '../Analysis/cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_uniformis_57318_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_likelihood_surface.csv'
)

DFE_core_file_list_constant_s = c(
  '../Analysis/cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_uniformis_57318_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../Analysis/cross_species_dfe/Faecalibacterium_prausnitzii_57453_constant_s_likelihood_surface.csv'
)

DFE_acc_file_list = c(
  '../Analysis/accessory_cross_species_dfe/Parabacteroides_distasonis_56985_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_uniformis_57318_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_thetaiotaomicron_56941_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_vulgatus_57955_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Barnesiella_intestinihominis_62208_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Eubacterium_rectale_56927_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Faecalibacterium_prausnitzii_57453_likelihood_surface.csv'
)

DFE_acc_file_list_constant_s = c(
  '../Analysis/accessory_cross_species_dfe/Parabacteroides_distasonis_56985_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_uniformis_57318_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_thetaiotaomicron_56941_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Bacteroides_vulgatus_57955_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Barnesiella_intestinihominis_62208_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Eubacterium_rectale_56927_constant_s_likelihood_surface.csv',
  '../Analysis/accessory_cross_species_dfe/Faecalibacterium_prausnitzii_57453_constant_s_likelihood_surface.csv'
)

core_acc_species_list = c(
  'Parabacteroides distasonis',
  'Bacteroides uniformis',
  'Bacteroides thetaiotaomicron',
  'Bacteroides vulgatus',
  'Barnesiella intestinihominis',
  'Eubacterium rectale',
  'Faecalibacterium prausnitzii'
)

acc_core_dfe_comparison = numeric(7)
acc_core_dfe_comparison_constant_s = numeric(7)

for (i in 1:length(core_acc_species_list)) {
  acc_core_dfe_comparison[i] = cross_species_dfe_comparison(DFE_core_file_list[i], DFE_acc_file_list[i])
  acc_core_dfe_comparison_constant_s[i] = cross_species_dfe_comparison(DFE_core_file_list_constant_s[i], DFE_acc_file_list_constant_s[i])
}

acc_core_dfe_LRT_table = data.frame(species=core_acc_species_list, constant_2NAs=acc_core_dfe_comparison, constant_s=acc_core_dfe_comparison_constant_s)

acc_core_dfe_LRT_table

write.csv(acc_core_dfe_LRT_table, '../Summary/core_acc_dfe_LRT.csv', row.names =FALSE)

# 95% CI based on chi-squared distribution with two degrees of freedom (Gamma DFE)
qchisq(1 - 0.05/7, df=2)

qchisq(1 - 0.05/351, df=2)

# write.csv(dfe_constant_s_matrix, '../Analysis/cross_species_dfe/dfe_comparison_constant_s_matrix.csv')

dfe_comparison_matrix = read.csv('../Analysis/cross_species_dfe/dfe_comparison_matrix.csv', header=TRUE)

dfe_comparison_matrix = dfe_comparison_matrix[, -1]
rownames(dfe_comparison_matrix) = phylogenetic_levels
colnames(dfe_comparison_matrix) = phylogenetic_levels
dfe_comparison_matrix

# 206
sum(dfe_comparison_matrix > 17.71234) / 2

dfe_constant_s_matrix = read.csv('../Analysis/cross_species_dfe/dfe_comparison_constant_s_matrix.csv', header=TRUE)

dfe_constant_s_matrix = dfe_constant_s_matrix[, -1]
rownames(dfe_constant_s_matrix) = phylogenetic_levels
colnames(dfe_constant_s_matrix) = phylogenetic_levels
dfe_constant_s_matrix

# 131
sum(dfe_constant_s_matrix > 17.71234) / 2


pheatmap(dfe_comparison_matrix,
  cluster_rows = F, cluster_cols = F, fontsize_number = 10,
  display_numbers = T,
  show_colnames     = FALSE,
  show_rownames     = FALSE,
  color = colorRampPalette(c('red','orange', 'yellow', 'white'), bias=0.05)(100),
  legend=TRUE)

dfe_comparison_matrix[upper.tri(dfe_comparison_matrix)] <- NA
#dfe_constant_s_matrix[is.na(dfe_constant_s_matrix)] = as.double('NA')
dfe_constant_s_matrix[upper.tri(dfe_constant_s_matrix)] <- NA


# test_matrix =  dfe_constant_s_matrix
# test_matrix[upper.tri(test_matrix)] = NA
# test_matrix[is.na(test_matrix)] = ''

pheatmap(dfe_constant_s_matrix,
  cluster_rows = F, cluster_cols = F, fontsize_number = 10,
  na_col="white",
  display_numbers = T,
  show_colnames     = T,
  show_rownames     = T,
  row_names_side='left',
  fontface_row = 'italic',
  fontface_col = 'italic',
  color = colorRampPalette(c('red','orange', 'yellow', 'white'), bias=0.5)(100),
  legend=TRUE,
  border_color ="white" )

color_scale = colorRampPalette(c('red','orange', 'yellow', 'white'), bias=0.5)(100)


col_scheme = c(rep('black', each=1), rep('darkorange', each=4), rep('black', each=4), rep('darkviolet', each=8), rep('black', each=10
))

### Figure S4A
# 800 x 1200

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
  column_names_gp = gpar(fontsize = 12,fontface='italic', col=col_scheme),
  row_names_gp = gpar(fontsize = 12,fontface='italic', col=col_scheme),
  show_heatmap_legend = F
  )

### Figure S4B
# 800 x 1200

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
  column_names_gp = gpar(fontsize = 12,fontface='italic', col=col_scheme),
  row_names_gp = gpar(fontsize = 12,fontface='italic', col=col_scheme),
  show_heatmap_legend = F
  )


# Bacteroides is 10:17 in phylogenetic levels

dfe_comparison_significant = numeric(27)
dfe_constant_s_significant = numeric(27)

dfe_comparison_significant_within = numeric(27)
dfe_constant_s_significant_within = numeric(27)

# Comparing outside of genus

for (i in 1:27) {
  for (j in 1:i) {
    genus_i = strsplit(phylogenetic_levels[i], ' ')[[1]][1]
    genus_j = strsplit(phylogenetic_levels[j], ' ')[[1]][1]
    if (genus_i !=  genus_j){
      if (dfe_comparison_matrix[i, j] > 17.7) {
        dfe_comparison_significant[i] = dfe_comparison_significant[i] + 1
        dfe_comparison_significant[j] = dfe_comparison_significant[j] + 1
      }
      if (dfe_constant_s_matrix[i, j] > 17.7) {
        dfe_constant_s_significant[i] = dfe_constant_s_significant[i] + 1
        dfe_constant_s_significant[j] = dfe_constant_s_significant[j] + 1
      }
    }
    if (genus_i == genus_j){
      if (dfe_comparison_matrix[i, j] > 17.7) {
        dfe_comparison_significant_within[i] = dfe_comparison_significant_within[i] + 1
        dfe_comparison_significant_within[j] = dfe_comparison_significant_within[j] + 1
      }
      if (dfe_constant_s_matrix[i, j] > 17.7) {
        dfe_constant_s_significant_within[i] = dfe_constant_s_significant_within[i] + 1
        dfe_constant_s_significant_within[j] = dfe_constant_s_significant_within[j] + 1
      }
    }
  }
}

#dfe_comparison_significant_total = dfe_comparison_significant + dfe_comparison_significant_within
#dfe_constant_s_significant_total = dfe_constant_s_significant + dfe_constant_s_significant_within

dfe_comparison_table = data.frame(species=phylogenetic_levels, 
  dfe_comparison_between=dfe_comparison_significant,
  dfe_comparison_within=dfe_comparison_significant_within,
  dfe_constant_s_between=dfe_constant_s_significant,
  dfe_constant_s_within=dfe_constant_s_significant_within)

names(dfe_comparison_table) = c(
  'Species',
  'num_sig outside genera, s',
  'num_sig within genera, s',
  'num_sig outside genera, 2Na*s',
  'num_sig within genera, 2Na*s'
)


# 206 significant comparisons when holding s constant
sum(dfe_comparison_table[2:3]) / 2
# 131 significant comparisons when holding 2Nas constant
sum(dfe_comparison_table[4:5])/ 2

sum(dfe_comparison_table$`num_sig outside genera, s`) / 2
sum(dfe_comparison_table$`num_sig within genera, s`) / 2
sum(dfe_comparison_table$`num_sig outside genera, 2Na*s`) / 2
sum(dfe_comparison_table$`num_sig within genera, 2Na*s`) / 2

sum(dfe_comparison_table[2:5, ]$`num_sig outside genera, s`)
sum(dfe_comparison_table[2:5, ]$`num_sig within genera, s`)
sum(dfe_comparison_table[2:5, ]$`num_sig outside genera, 2Na*s`)
sum(dfe_comparison_table[2:5, ]$`num_sig within genera, 2Na*s`)

sum(dfe_comparison_table[10:17, ]$`num_sig outside genera, s`)
sum(dfe_comparison_table[10:17, ]$`num_sig within genera, s`)
sum(dfe_comparison_table[10:17, ]$`num_sig outside genera, 2Na*s`)
sum(dfe_comparison_table[10:17, ]$`num_sig within genera, 2Na*s`)

# write.csv(dfe_comparison_table, '../Summary/DFE_comparison_summary.csv', row.names=FALSE)

as.numeric((dfe_comparison_matrix[10, ] > 17.7))

# Core vs. Accessory genes
## Proportional

b_bacterium_all = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/empirical_syn_downsampled_sfs.txt')
b_bacterium_core = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_bacterium_accessory = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

compare_core_accessory_sfs(b_bacterium_all,
  b_bacterium_core,
  b_bacterium_accessory) + ggtitle('B. bacterium synonymous')

a_finegoldii_all = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/empirical_syn_downsampled_sfs.txt')
a_finegoldii_core = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_finegoldii_accessory = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

compare_core_accessory_sfs(a_finegoldii_all,
  a_finegoldii_core,
  a_finegoldii_accessory) + ggtitle('A. finegoldii synonymous')

a_onderdonkii_all = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/empirical_syn_downsampled_sfs.txt')
a_onderdonkii_core = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_onderdonkii_accessory = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

compare_core_accessory_sfs(a_onderdonkii_all,
  a_onderdonkii_core,
  a_onderdonkii_accessory) + ggtitle('A. onderdonkii synonymous')

a_shahii_all = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/empirical_syn_downsampled_sfs.txt')
a_shahii_core = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_shahii_accessory = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

compare_core_accessory_sfs(a_shahii_all,
  a_shahii_core,
  a_shahii_accessory) + ggtitle('A. shahii synonymous')

o_splanchnicus_all = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/empirical_syn_downsampled_sfs.txt') 
o_splanchnicus_core = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
o_splanchnicus_accessory = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(o_splanchnicus_all,
  o_splanchnicus_core,
  o_splanchnicus_accessory) + ggtitle('O. splanchnicus synonymous')

p_distasonis_all = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/empirical_syn_downsampled_sfs.txt') 
p_distasonis_core = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
p_distasonis_accessory = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(p_distasonis_all,
  p_distasonis_core,
  p_distasonis_accessory) + ggtitle('P. distasonis synonymous')

p_merdae_all = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/empirical_syn_downsampled_sfs.txt') 
p_merdae_core = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
p_merdae_accessory = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(p_merdae_all,
  p_merdae_core,
  p_merdae_accessory) + ggtitle('P. merdae synonymous')

p_copri_all = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/empirical_syn_downsampled_sfs.txt') 
p_copri_core = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
p_copri_accessory = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(p_copri_all,
  p_copri_core,
  p_copri_accessory) + ggtitle('P. copri synonymous')

b_fragilis_all = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/empirical_syn_downsampled_sfs.txt') 
b_fragilis_core = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_fragilis_accessory = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_fragilis_all,
  b_fragilis_core,
  b_fragilis_accessory) + ggtitle('B. fragilis synonymous')

b_cellulosilyticus_all = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/empirical_syn_downsampled_sfs.txt') 
b_cellulosilyticus_core = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_cellulosilyticus_accessory = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_cellulosilyticus_all,
  b_cellulosilyticus_core,
  b_cellulosilyticus_accessory) + ggtitle('B. cellulosilyticus synonymous')

b_stercoris_all = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/empirical_syn_downsampled_sfs.txt') 
b_stercoris_core = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_stercoris_accessory = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_stercoris_all,
  b_stercoris_core,
  b_stercoris_accessory) + ggtitle('B. stercoris synonymous')

b_thetaiotaomicron_all = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/empirical_syn_downsampled_sfs.txt') 
b_thetaiotaomicron_core = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_thetaiotaomicron_accessory = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_thetaiotaomicron_all,
  b_thetaiotaomicron_core,
  b_thetaiotaomicron_accessory) + ggtitle('B. thetaiotaomicron synonymous')

b_xylanisolvens_all = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/empirical_syn_downsampled_sfs.txt') 
b_xylanisolvens_core = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_xylanisolvens_accessory = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_xylanisolvens_all,
  b_xylanisolvens_core,
  b_xylanisolvens_accessory) + ggtitle('B. xylanisolvens synonymous')

b_vulgatus_all = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/empirical_syn_downsampled_sfs.txt') 
b_vulgatus_core = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_vulgatus_accessory = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_vulgatus_all,
  b_vulgatus_core,
  b_vulgatus_accessory) + ggtitle('B. vulgatus synonymous')

b_intestinihominis_all = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/empirical_syn_downsampled_sfs.txt') 
b_intestinihominis_core = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
b_intestinihominis_accessory = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_intestinihominis_all,
  b_intestinihominis_core,
  b_intestinihominis_accessory) + ggtitle('B. intestinihominis')

a_muciniphila_all = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/empirical_syn_downsampled_sfs.txt')
a_muciniphila_core = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_muciniphila_accessory = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

compare_core_accessory_sfs(a_muciniphila_all,
  a_muciniphila_core,
  a_muciniphila_accessory)  + ggtitle('A. muciniphila synonymous')

p_sp_all = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/empirical_syn_downsampled_sfs.txt') 
p_sp_core = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
p_sp_accessory = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(p_sp_all,
  p_sp_core,
  p_sp_accessory) + ggtitle('Phascolarctobacterium species synonymous')

e_eligens_all = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/empirical_syn_downsampled_sfs.txt') 
e_eligens_core = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
e_eligens_accessory = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(e_eligens_all,
  e_eligens_core,
  e_eligens_accessory) + ggtitle('E. eligens synonymous')

e_rectale_all = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/empirical_syn_downsampled_sfs.txt') 
e_rectale_core = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
e_rectale_accessory = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(e_rectale_all,
  e_rectale_core,
  e_rectale_accessory) + ggtitle('E. rectale synonymous')

o_sp_all = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/empirical_syn_downsampled_sfs.txt') 
o_sp_core = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
o_sp_accessory = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(o_sp_all,
  o_sp_core,
  o_sp_accessory) + ggtitle('Oscillibacter species synonymous')

r_bromii_all = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/empirical_syn_downsampled_sfs.txt')
r_bromii_core = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
r_bromii_accessory = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

compare_core_accessory_sfs(r_bromii_all,
  r_bromii_core,
  r_bromii_accessory) + ggtitle('Ruminococcus bromii synonymous')

r_bicirculans_all = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/empirical_syn_downsampled_sfs.txt') 
r_bicirculans_core = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_syn_downsampled_sfs.txt') 
r_bicirculans_accessory = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt') 

compare_core_accessory_sfs(r_bicirculans_all,
  r_bicirculans_core,
  r_bicirculans_accessory) + ggtitle('Ruminococcus bicirculans synonymous')

f_prausnitzii_all = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/empirical_syn_downsampled_sfs.txt')
f_prausnitzii_core = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
f_prausnitzii_accessory = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

compare_core_accessory_sfs(f_prausnitzii_all,
  f_prausnitzii_core,
  f_prausnitzii_accessory) + ggtitle('F. prausnitzii synonymous')

# Nonsyn

b_bacterium_all_ns = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
b_bacterium_core_ns = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
b_bacterium_accessory_ns = read_input_sfs('../Analysis/Bacteroidales_bacterium_58650_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

compare_core_accessory_sfs(b_bacterium_all_ns,
  b_bacterium_core_ns,
  b_bacterium_accessory_ns) + ggtitle('B. bacterium nonsynonymous')

a_finegoldii_all_ns = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
a_finegoldii_core_ns = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_finegoldii_accessory_ns = read_input_sfs('../Analysis/Alistipes_finegoldii_56071_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

compare_core_accessory_sfs(a_finegoldii_all_ns,
  a_finegoldii_core_ns,
  a_finegoldii_accessory_ns) + ggtitle('A. finegoldii nonsynonymous')

a_onderdonkii_all_ns = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
a_onderdonkii_core_ns = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_onderdonkii_accessory_ns = read_input_sfs('../Analysis/Alistipes_onderdonkii_55464_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

compare_core_accessory_sfs(a_onderdonkii_all_ns,
  a_onderdonkii_core_ns,
  a_onderdonkii_accessory_ns) + ggtitle('A. onderdonkii nonsynonymous')

a_shahii_all_ns = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
a_shahii_core_ns = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_shahii_accessory_ns = read_input_sfs('../Analysis/Alistipes_shahii_62199_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

compare_core_accessory_sfs(a_shahii_all_ns,
  a_shahii_core_ns,
  a_shahii_accessory_ns) + ggtitle('A. shahii nonsynonymous')

o_splanchnicus_all_ns = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
o_splanchnicus_core_ns = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
o_splanchnicus_accessory_ns = read_input_sfs('../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(o_splanchnicus_all_ns,
  o_splanchnicus_core_ns,
  o_splanchnicus_accessory_ns) + ggtitle('O. splanchnicus nonsynonymous')

p_distasonis_all_ns = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
p_distasonis_core_ns = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
p_distasonis_accessory_ns = read_input_sfs('../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(p_distasonis_all_ns,
  p_distasonis_core_ns,
  p_distasonis_accessory_ns) + ggtitle('P. distasonis nonsynonymous')

p_merdae_all_ns = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
p_merdae_core_ns = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
p_merdae_accessory_ns = read_input_sfs('../Analysis/Parabacteroides_merdae_56972_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(p_merdae_all_ns,
  p_merdae_core_ns,
  p_merdae_accessory_ns) + ggtitle('P. merdae nonsynonymous')

p_copri_all_ns = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
p_copri_core_ns = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
p_copri_accessory_ns = read_input_sfs('../Analysis/Prevotella_copri_61740_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(p_copri_all_ns,
  p_copri_core_ns,
  p_copri_accessory_ns) + ggtitle('P. copri nonsynonymous')

b_fragilis_all_ns = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
b_fragilis_core_ns = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_fragilis_accessory_ns = read_input_sfs('../Analysis/Bacteroides_fragilis_54507_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_fragilis_all_ns,
  b_fragilis_core_ns,
  b_fragilis_accessory_ns) + ggtitle('B. fragilis nonsynonymous')

b_cellulosilyticus_all_ns = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
b_cellulosilyticus_core_ns = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_cellulosilyticus_accessory_ns = read_input_sfs('../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_cellulosilyticus_all_ns,
  b_cellulosilyticus_core_ns,
  b_cellulosilyticus_accessory_ns) + ggtitle('B. cellulosilyticus nonsynonymous')

b_stercoris_all_ns = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
b_stercoris_core_ns = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_stercoris_accessory_ns = read_input_sfs('../Analysis/Bacteroides_stercoris_56735_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_stercoris_all_ns,
  b_stercoris_core_ns,
  b_stercoris_accessory_ns) + ggtitle('B. stercoris nonsynonymous')

b_thetaiotaomicron_all_ns = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
b_thetaiotaomicron_core_ns = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_thetaiotaomicron_accessory_ns = read_input_sfs('../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_thetaiotaomicron_all_ns,
  b_thetaiotaomicron_core_ns,
  b_thetaiotaomicron_accessory_ns) + ggtitle('B. thetaiotaomicron nonsynonymous')

b_xylanisolvens_all_ns = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
b_xylanisolvens_core_ns = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_xylanisolvens_accessory_ns = read_input_sfs('../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_xylanisolvens_all_ns,
  b_xylanisolvens_core_ns,
  b_xylanisolvens_accessory_ns) + ggtitle('B. xylanisolvens nonsynonymous')

b_vulgatus_all_ns = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
b_vulgatus_core_ns = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_vulgatus_accessory_ns = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_vulgatus_all_ns,
  b_vulgatus_core_ns,
  b_vulgatus_accessory_ns) + ggtitle('B. vulgatus nonsynonymous')

b_intestinihominis_all_ns = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
b_intestinihominis_core_ns = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
b_intestinihominis_accessory_ns = read_input_sfs('../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(b_intestinihominis_all_ns,
  b_intestinihominis_core_ns,
  b_intestinihominis_accessory_ns) + ggtitle('B. intestinihominis nonsynonymous')

a_muciniphila_all_ns = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
a_muciniphila_core_ns = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_muciniphila_accessory_ns = read_input_sfs('../Analysis/Akkermansia_muciniphila_55290_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

compare_core_accessory_sfs(a_muciniphila_all_ns,
  a_muciniphila_core_ns,
  a_muciniphila_accessory_ns)  + ggtitle('A. muciniphila nonsynonymous')

p_sp_all_ns = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
p_sp_core_ns = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
p_sp_accessory_ns = read_input_sfs('../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(p_sp_all_ns,
  p_sp_core_ns,
  p_sp_accessory_ns) + ggtitle('Phascolarctobacterium species nonsynonymous')

e_eligens_all_ns = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
e_eligens_core_ns = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
e_eligens_accessory_ns = read_input_sfs('../Analysis/Eubacterium_eligens_61678_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(e_eligens_all_ns,
  e_eligens_core_ns,
  e_eligens_accessory_ns) + ggtitle('E. eligens nonsynonymous')

e_rectale_all_ns = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
e_rectale_core_ns = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
e_rectale_accessory_ns = read_input_sfs('../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(e_rectale_all_ns,
  e_rectale_core_ns,
  e_rectale_accessory_ns) + ggtitle('E. rectale nonsynonymous')

o_sp_all_ns = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
o_sp_core_ns = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
o_sp_accessory_ns = read_input_sfs('../Analysis/Oscillibacter_sp_60799_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(o_sp_all_ns,
  o_sp_core_ns,
  o_sp_accessory_ns) + ggtitle('Oscillibacter species nonsynonymous')

r_bromii_all_ns = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
r_bromii_core_ns = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
r_bromii_accessory_ns = read_input_sfs('../Analysis/Ruminococcus_bromii_62047_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

compare_core_accessory_sfs(r_bromii_all_ns,
  r_bromii_core_ns,
  r_bromii_accessory_ns) + ggtitle('Ruminococcus bromii nonsynonymous')

r_bicirculans_all_ns = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/empirical_nonsyn_downsampled_sfs.txt') 
r_bicirculans_core_ns = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt') 
r_bicirculans_accessory_ns = read_input_sfs('../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt') 

compare_core_accessory_sfs(r_bicirculans_all_ns,
  r_bicirculans_core_ns,
  r_bicirculans_accessory_ns) + ggtitle('Ruminococcus bicirculans nonsynonymous')

f_prausnitzii_all_ns = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
f_prausnitzii_core_ns = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
f_prausnitzii_accessory_ns = read_input_sfs('../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

compare_core_accessory_sfs(f_prausnitzii_all_ns,
  f_prausnitzii_core_ns,
  f_prausnitzii_accessory_ns) + ggtitle('F. prausnitzii nonsynonymous')

## Raw Count

compare_core_accessory_sfs_count(b_bacterium_all,
  b_bacterium_core,
  b_bacterium_accessory) + ggtitle('B. bacterium synonymous')

compare_core_accessory_sfs_count(a_finegoldii_all,
  a_finegoldii_core,
  a_finegoldii_accessory) + ggtitle('A. finegoldii synonymous')

compare_core_accessory_sfs_count(a_onderdonkii_all,
  a_onderdonkii_core,
  a_onderdonkii_accessory) + ggtitle('A. onderdonkii synonymous')

compare_core_accessory_sfs_count(a_shahii_all,
  a_shahii_core,
  a_shahii_accessory) + ggtitle('A. shahii synonymous')

compare_core_accessory_sfs_count(o_splanchnicus_all,
  o_splanchnicus_core,
  o_splanchnicus_accessory) + ggtitle('O. splanchnicus synonymous')

compare_core_accessory_sfs_count(p_distasonis_all,
  p_distasonis_core,
  p_distasonis_accessory) + ggtitle('P. distasonis synonymous')

compare_core_accessory_sfs_count(p_merdae_all,
  p_merdae_core,
  p_merdae_accessory) + ggtitle('P. merdae synonymous')

compare_core_accessory_sfs_count(p_copri_all,
  p_copri_core,
  p_copri_accessory) + ggtitle('P. copri synonymous')

compare_core_accessory_sfs_count(b_fragilis_all,
  b_fragilis_core,
  b_fragilis_accessory) + ggtitle('B. fragilis synonymous')

compare_core_accessory_sfs_count(b_cellulosilyticus_all,
  b_cellulosilyticus_core,
  b_cellulosilyticus_accessory) + ggtitle('B. cellulosilyticus synonymous')

compare_core_accessory_sfs_count(b_stercoris_all,
  b_stercoris_core,
  b_stercoris_accessory) + ggtitle('B. stercoris synonymous')

compare_core_accessory_sfs_count(b_thetaiotaomicron_all,
  b_thetaiotaomicron_core,
  b_thetaiotaomicron_accessory) + ggtitle('B. thetaiotaomicron synonymous')

compare_core_accessory_sfs_count(b_xylanisolvens_all,
  b_xylanisolvens_core,
  b_xylanisolvens_accessory) + ggtitle('B. xylanisolvens synonymous')

compare_core_accessory_sfs_count(b_vulgatus_all,
  b_vulgatus_core,
  b_vulgatus_accessory) + ggtitle('B. vulgatus synonymous')

compare_core_accessory_sfs_count(b_intestinihominis_all,
  b_intestinihominis_core,
  b_intestinihominis_accessory) + ggtitle('B. intestinihominis')

compare_core_accessory_sfs_count(a_muciniphila_all,
  a_muciniphila_core,
  a_muciniphila_accessory)  + ggtitle('A. muciniphila synonymous')

compare_core_accessory_sfs_count(p_sp_all,
  p_sp_core,
  p_sp_accessory) + ggtitle('Phascolarctobacterium species synonymous')

compare_core_accessory_sfs_count(e_eligens_all,
  e_eligens_core,
  e_eligens_accessory) + ggtitle('E. eligens synonymous')

compare_core_accessory_sfs_count(e_rectale_all,
  e_rectale_core,
  e_rectale_accessory) + ggtitle('E. rectale synonymous')

compare_core_accessory_sfs_count(o_sp_all,
  o_sp_core,
  o_sp_accessory) + ggtitle('Oscillibacter species synonymous')

compare_core_accessory_sfs_count(r_bromii_all,
  r_bromii_core,
  r_bromii_accessory) + ggtitle('Ruminococcus bromii synonymous')

compare_core_accessory_sfs_count(r_bicirculans_all,
  r_bicirculans_core,
  r_bicirculans_accessory) + ggtitle('Ruminococcus bicirculans synonymous')

compare_core_accessory_sfs_count(f_prausnitzii_all,
  f_prausnitzii_core,
  f_prausnitzii_accessory) + ggtitle('F. prausnitzii synonymous')

# Nonsyn

compare_core_accessory_sfs_count(b_bacterium_all_ns,
  b_bacterium_core_ns,
  b_bacterium_accessory_ns) + ggtitle('B. bacterium nonsynonymous')

compare_core_accessory_sfs_count(a_finegoldii_all_ns,
  a_finegoldii_core_ns,
  a_finegoldii_accessory_ns) + ggtitle('A. finegoldii nonsynonymous')

compare_core_accessory_sfs_count(a_onderdonkii_all_ns,
  a_onderdonkii_core_ns,
  a_onderdonkii_accessory_ns) + ggtitle('A. onderdonkii nonsynonymous')

compare_core_accessory_sfs_count(a_shahii_all_ns,
  a_shahii_core_ns,
  a_shahii_accessory_ns) + ggtitle('A. shahii nonsynonymous')

compare_core_accessory_sfs_count(o_splanchnicus_all_ns,
  o_splanchnicus_core_ns,
  o_splanchnicus_accessory_ns) + ggtitle('O. splanchnicus nonsynonymous')

compare_core_accessory_sfs_count(p_distasonis_all_ns,
  p_distasonis_core_ns,
  p_distasonis_accessory_ns) + ggtitle('P. distasonis nonsynonymous')

compare_core_accessory_sfs_count(p_merdae_all_ns,
  p_merdae_core_ns,
  p_merdae_accessory_ns) + ggtitle('P. merdae nonsynonymous')

compare_core_accessory_sfs_count(p_copri_all_ns,
  p_copri_core_ns,
  p_copri_accessory_ns) + ggtitle('P. copri nonsynonymous')

compare_core_accessory_sfs_count(b_fragilis_all_ns,
  b_fragilis_core_ns,
  b_fragilis_accessory_ns) + ggtitle('B. fragilis nonsynonymous')

compare_core_accessory_sfs_count(b_cellulosilyticus_all_ns,
  b_cellulosilyticus_core_ns,
  b_cellulosilyticus_accessory_ns) + ggtitle('B. cellulosilyticus nonsynonymous')

compare_core_accessory_sfs_count(b_stercoris_all_ns,
  b_stercoris_core_ns,
  b_stercoris_accessory_ns) + ggtitle('B. stercoris nonsynonymous')

compare_core_accessory_sfs_count(b_thetaiotaomicron_all_ns,
  b_thetaiotaomicron_core_ns,
  b_thetaiotaomicron_accessory_ns) + ggtitle('B. thetaiotaomicron nonsynonymous')

compare_core_accessory_sfs_count(b_xylanisolvens_all_ns,
  b_xylanisolvens_core_ns,
  b_xylanisolvens_accessory_ns) + ggtitle('B. xylanisolvens nonsynonymous')

compare_core_accessory_sfs_count(b_vulgatus_all_ns,
  b_vulgatus_core_ns,
  b_vulgatus_accessory_ns) + ggtitle('B. vulgatus nonsynonymous')

compare_core_accessory_sfs_count(b_intestinihominis_all_ns,
  b_intestinihominis_core_ns,
  b_intestinihominis_accessory_ns) + ggtitle('B. intestinihominis nonsynonymous')

compare_core_accessory_sfs_count(a_muciniphila_all_ns,
  a_muciniphila_core_ns,
  a_muciniphila_accessory_ns)  + ggtitle('A. muciniphila nonsynonymous')

compare_core_accessory_sfs_count(p_sp_all_ns,
  p_sp_core_ns,
  p_sp_accessory_ns) + ggtitle('Phascolarctobacterium species nonsynonymous')

compare_core_accessory_sfs_count(e_eligens_all_ns,
  e_eligens_core_ns,
  e_eligens_accessory_ns) + ggtitle('E. eligens nonsynonymous')

compare_core_accessory_sfs_count(e_rectale_all_ns,
  e_rectale_core_ns,
  e_rectale_accessory_ns) + ggtitle('E. rectale nonsynonymous')

compare_core_accessory_sfs_count(o_sp_all_ns,
  o_sp_core_ns,
  o_sp_accessory_ns) + ggtitle('Oscillibacter species nonsynonymous')

compare_core_accessory_sfs_count(r_bromii_all_ns,
  r_bromii_core_ns,
  r_bromii_accessory_ns) + ggtitle('Ruminococcus bromii nonsynonymous')

compare_core_accessory_sfs_count(r_bicirculans_all_ns,
  r_bicirculans_core_ns,
  r_bicirculans_accessory_ns) + ggtitle('Ruminococcus bicirculans nonsynonymous')

compare_core_accessory_sfs_count(f_prausnitzii_all_ns,
  f_prausnitzii_core_ns,
  f_prausnitzii_accessory_ns) + ggtitle('F. prausnitzii nonsynonymous')

# syn vs. nonsyn

a_putredinis_all = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/empirical_syn_downsampled_sfs.txt')
a_putredinis_core = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
a_putredinis_accessory = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

a_putredinis_all_ns = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
a_putredinis_core_ns = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
a_putredinis_accessory_ns = read_input_sfs('../Analysis/Alistipes_putredinis_61533_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

b_uniformis_all = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/empirical_syn_downsampled_sfs.txt')
b_uniformis_core = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_uniformis_accessory = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

b_uniformis_all_ns = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
b_uniformis_core_ns = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
b_uniformis_accessory_ns = read_input_sfs('../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

b_ovatus_all = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/empirical_syn_downsampled_sfs.txt')
b_ovatus_core = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_ovatus_accessory = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

b_ovatus_all_ns = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
b_ovatus_core_ns = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
b_ovatus_accessory_ns = read_input_sfs('../Analysis/Bacteroides_ovatus_58035_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

b_caccae_all = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/empirical_syn_downsampled_sfs.txt')
b_caccae_core = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_caccae_accessory = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

b_caccae_all_ns = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
b_caccae_core_ns = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
b_caccae_accessory_ns = read_input_sfs('../Analysis/Bacteroides_caccae_53434_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

d_invisus_all = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/empirical_syn_downsampled_sfs.txt')
d_invisus_core = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
d_invisus_accessory = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_empirical_syn_downsampled_sfs.txt')

d_invisus_all_ns = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/empirical_nonsyn_downsampled_sfs.txt')
d_invisus_core_ns = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')
d_invisus_accessory_ns = read_input_sfs('../Analysis/Dialister_invisus_61905_downsampled_14/accessory_empirical_nonsyn_downsampled_sfs.txt')

fig_s5_1 = compare_core_accessory_sfs_syn_ns(b_bacterium_core,
  b_bacterium_core_ns,
  b_bacterium_accessory,
  b_bacterium_accessory_ns) + ggtitle('B. bacterium')

fig_s5_2 = compare_core_accessory_sfs_syn_ns(a_putredinis_core,
  a_putredinis_core_ns,
  a_putredinis_accessory,
  a_putredinis_accessory_ns) + ggtitle('A. putredinis')

fig_s5_3 = compare_core_accessory_sfs_syn_ns(a_finegoldii_core,
  a_finegoldii_core_ns,
  a_finegoldii_accessory,
  a_finegoldii_accessory_ns) + ggtitle('A. finegoldii')

fig_s5_4 = compare_core_accessory_sfs_syn_ns(a_onderdonkii_core,
  a_onderdonkii_core_ns,
  a_onderdonkii_accessory,
  a_onderdonkii_accessory_ns) + ggtitle('A. onderdonkii')

fig_s5_5 = compare_core_accessory_sfs_syn_ns(a_shahii_core,
  a_shahii_core_ns,
  a_shahii_accessory,
  a_shahii_accessory_ns) + ggtitle('A. shahii')

fig_s5_6 = compare_core_accessory_sfs_syn_ns(o_splanchnicus_core,
  o_splanchnicus_core_ns,
  o_splanchnicus_accessory,
  o_splanchnicus_accessory_ns) + ggtitle('O. splanchnicus')

fig_s5_7 = compare_core_accessory_sfs_syn_ns(p_distasonis_core,
  p_distasonis_core_ns,
  p_distasonis_accessory,
  p_distasonis_accessory_ns) + ggtitle('P. distasonis')

fig_s5_8 = compare_core_accessory_sfs_syn_ns(p_merdae_core,
  p_merdae_core_ns,
  p_merdae_accessory,
  p_merdae_accessory_ns) + ggtitle('P. merdae')

fig_s5_9 = compare_core_accessory_sfs_syn_ns(p_copri_core,
  p_copri_core_ns,
  p_copri_accessory,
  p_copri_accessory_ns) + ggtitle('P. copri')

fig_s5_10 = compare_core_accessory_sfs_syn_ns(b_fragilis_core,
  b_fragilis_core_ns,
  b_fragilis_accessory,
  b_fragilis_accessory_ns) + ggtitle('B. fragilis')

fig_s5_11 = compare_core_accessory_sfs_syn_ns(b_cellulosilyticus_core,
  b_cellulosilyticus_core_ns,
  b_cellulosilyticus_accessory,
  b_cellulosilyticus_accessory_ns) + ggtitle('B. cellulosilyticus')

fig_s5_12 = compare_core_accessory_sfs_syn_ns(b_stercoris_core,
  b_stercoris_core_ns,
  b_stercoris_accessory,
  b_stercoris_accessory_ns) + ggtitle('B. stercoris')

fig_s5_13 = compare_core_accessory_sfs_syn_ns(b_uniformis_core,
  b_uniformis_core_ns,
  b_vulgatus_accessory,
  b_vulgatus_accessory_ns) +  ggtitle('B. uniformis')

### used in Figure 5

fig_s5_14 = compare_core_accessory_sfs_syn_ns(b_thetaiotaomicron_core,
  b_thetaiotaomicron_core_ns,
  b_thetaiotaomicron_accessory,
  b_thetaiotaomicron_accessory_ns) + ggtitle('B. thetaiotaomicron')

fig_s5_15 = compare_core_accessory_sfs_syn_ns(b_xylanisolvens_core,
  b_xylanisolvens_core_ns,
  b_xylanisolvens_accessory,
  b_xylanisolvens_accessory_ns) + ggtitle('B. xylanisolvens')

fig_s5_16 = compare_core_accessory_sfs_syn_ns(b_caccae_core,
  b_caccae_core_ns,
  b_caccae_accessory,
  b_caccae_accessory_ns) + ggtitle('B. caccae')

fig_s5_17 = compare_core_accessory_sfs_syn_ns(b_vulgatus_core,
  b_vulgatus_core_ns,
  b_vulgatus_accessory,
  b_vulgatus_accessory_ns) + ggtitle('B. vulgatus')

fig_s5_18 = compare_core_accessory_sfs_syn_ns(b_intestinihominis_core,
  b_intestinihominis_core_ns,
  b_intestinihominis_accessory,
  b_intestinihominis_accessory_ns) + ggtitle('B. intestinihominis')

fig_s5_19 = compare_core_accessory_sfs_syn_ns(a_muciniphila_core,
  a_muciniphila_core_ns,
  a_muciniphila_accessory,
  a_muciniphila_accessory_ns)  + ggtitle('A. muciniphila')

fig_s5_20 = compare_core_accessory_sfs_syn_ns(d_invisus_core,
  d_invisus_core_ns,
  d_invisus_accessory,
  d_invisus_accessory_ns) + ggtitle('D. invisus')

fig_s5_21 = compare_core_accessory_sfs_syn_ns(p_sp_core,
  p_sp_core_ns,
  p_sp_accessory,
  p_sp_accessory_ns) + ggtitle('Phascolarctobacterium species')

fig_s5_22 = compare_core_accessory_sfs_syn_ns(e_eligens_core,
  e_eligens_core_ns,
  e_eligens_accessory,
  e_eligens_accessory_ns) + ggtitle('E. eligens')

### used in Figure 5

fig_s5_23 = compare_core_accessory_sfs_syn_ns(e_rectale_core,
  e_rectale_core_ns,
  e_rectale_accessory,
  e_rectale_accessory_ns) + ggtitle('E. rectale')

fig_s5_24 = compare_core_accessory_sfs_syn_ns(o_sp_core,
  o_sp_core_ns,
  o_sp_accessory,
  o_sp_accessory_ns) + ggtitle('Oscillibacter species')

fig_s5_25 = compare_core_accessory_sfs_syn_ns(r_bromii_core,
  r_bromii_core_ns,
  r_bromii_accessory,
  r_bromii_accessory_ns) + ggtitle('Ruminococcus bromii')

fig_s5_26 = compare_core_accessory_sfs_syn_ns(r_bicirculans_core,
  r_bicirculans_core_ns,
  r_bicirculans_accessory,
  r_bicirculans_accessory_ns) + ggtitle('Ruminococcus bicirculans')

fig_s5_27 = compare_core_accessory_sfs_syn_ns(f_prausnitzii_core,
  f_prausnitzii_core_ns,
  f_prausnitzii_accessory,
  f_prausnitzii_accessory_ns) + ggtitle('F. prausnitzii')

### Figure S5
# 800 x 16000

fig_s5_1 +
  fig_s5_2 +
  fig_s5_3 +
  fig_s5_4 +
  fig_s5_5 +
  fig_s5_6 +
  fig_s5_7 +
  fig_s5_8 +
  fig_s5_9 +
  fig_s5_10 +
  fig_s5_11 +
  fig_s5_12 +
  fig_s5_13 +
  fig_s5_14 +
  fig_s5_15 +
  fig_s5_16 +
  fig_s5_17 +
  fig_s5_18 +
  fig_s5_19 +
  fig_s5_20 +
  fig_s5_21 +
  fig_s5_22 +
  fig_s5_23 +
  fig_s5_24 +
  fig_s5_25 +
  fig_s5_26 +
  fig_s5_27 +
  plot_layout(ncol=1)

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

three_epoch_file_list = c(
  '../Analysis/Bacteroidales_bacterium_58650_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Alistipes_putredinis_61533_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Alistipes_finegoldii_56071_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Alistipes_onderdonkii_55464_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Alistipes_shahii_62199_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Odoribacter_splanchnicus_62174_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Parabacteroides_merdae_56972_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Prevotella_copri_61740_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_fragilis_54507_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_cellulosilyticus_58046_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_stercoris_56735_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_xylanisolvens_57185_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_caccae_53434_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Akkermansia_muciniphila_55290_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Dialister_invisus_61905_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Phascolarctobacterium_sp_59817_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Eubacterium_eligens_61678_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Oscillibacter_sp_60799_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Ruminococcus_bromii_62047_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Ruminococcus_bicirculans_59300_downsampled_14/core_three_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/core_three_epoch_demography.txt'
)

species_list = c(
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


AIC_matrix = data.frame(
  one_epoch = numeric(27),
  two_epoch = numeric(27), 
  three_epoch = numeric(27), 
  delta_AIC = numeric(27))
row.names(AIC_matrix) = species_list


for (i in 1:length(species_list)) {
  AIC_matrix[i, 1] = AIC_from_demography(one_epoch_file_list[i])
  AIC_matrix[i, 2] = AIC_from_demography(two_epoch_file_list[i])
  AIC_matrix[i, 3] = AIC_from_demography(three_epoch_file_list[i])
  AIC_matrix[i, 4] = abs(min(AIC_matrix[i, 1], AIC_matrix[i, 3]) - AIC_matrix[i, 2])
}

AIC_matrix

# write.csv(AIC_matrix,  file='../Summary/AIC_matrix.csv')

#  Distributions of Nu and Tau

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

nu_label_text = expression(nu == frac(N[current], N[ancestral]))
# tau_label_text = expression(tau == frac(generations, 2 * N[ancestral]))
tau_label_text = 'Estimated time in years since most recent demographic event'


# 1000 x 1000
plot_nu_distribution = ggplot() +
  geom_linerange(data=nu_tau_distribution, mapping=aes(x=fct_rev(species), ymin=nu_low, ymax=nu_high), size=1, color="blue") + 
  geom_point(data=nu_tau_distribution, mapping=aes(x=fct_rev(species), y=nu_mle), size=4, shape=21, fill="white") +
  scale_y_log10() +
  coord_flip() +
  theme_bw() +
  xlab('') +
  ylab(nu_label_text) +
  geom_hline(yintercept=1.0, color='red', linewidth=1, linetype='dashed') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(axis.text=element_text(size=16)) +
  theme(axis.title=element_text(size=16,face="bold"))

plot_nu_distribution

plot_tau_distribution = ggplot() +
  geom_linerange(data=nu_tau_distribution, mapping=aes(x=fct_rev(species), ymin=time_low, ymax=time_high), size=1, color="blue") + 
  geom_point(data=nu_tau_distribution, mapping=aes(x=fct_rev(species), y=time_mle), size=4, shape=21, fill="white") +
  scale_y_log10() +
  coord_flip() +
  theme_bw() +
  xlab('') +
  ylab(tau_label_text) +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(axis.text=element_text(size=16)) +
  theme(axis.title=element_text(size=16,face="bold"))

plot_tau_distribution

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

### Figure S2
# 2000 x 1100

plot_nu_distribution_fig + plot_tau_distribution_fig + plot_layout(ncol=2)

### Figure 3

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

p9_talk = plot_best_fit_sfs_3A(a_muciniphila_best_fit) + ggtitle('Akkermansia muciniphila')
# p30_talk = plot_best_fit_sfs_3B(r_bromii_best_fit) + ggtitle('Ruminococcus bromii')

p30_talk = plot_best_fit_sfs_talk(r_bromii_best_fit) + ggtitle('Ruminococcus bromii')

p9 + p9_l + # A. muciniphila
  p30 + p30_l + #R. bicirculans
  demography_scatter +
  plot_layout(design=design)

# Talk version

design = "
AACCC
BBCCC
"

# 1200 x 700

p30_talk + p30_l + demography_scatter + plot_layout(design=design)

# 2000 x 1900

# p1 + p1_l + # A. muciniphila
#   p30 + p30_l + #R. bicirculans
#   demography_scatter +
#   plot_nu_distribution_fig +
#   plot_tau_distribution_fig +
#   plot_layout(design=design)

# Accessory vs. Core genes demographic comparison
accessory_core_demography = data.frame(species=phylogenetic_levels, 
  core_nu = numeric(27),
  core_years = numeric(27),
  core_na = numeric(27),
  acc_nu = numeric(27),
  acc_years = numeric(27),
  acc_na = numeric(27))

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

ggplot(accessory_core_demography[c(7, 13, 14, 17, 18, 22, 23, 27), ], aes(x = `Core, N_anc`, y = `Accessory, N_Anc`)) +
  geom_point(aes(color=Species), show.legend=FALSE) +
  labs(x = "Core genes", y = "Accessory genes") +
  ggtitle("Estimated ancestral effective population size") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  xlim(0, 4E7) +
  ylim(0, 4E7) +
  geom_text_repel(aes(label = Species, color=Species, fontface = 'italic'), show.legend = FALSE) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

### Supplemental Table 3

one_epoch_likelihood = numeric(27)
one_epoch_AIC = numeric(27)
one_epoch_theta = numeric(27)
one_epoch_nanc = numeric(27)
two_epoch_likelihood = numeric(27)
two_epoch_AIC = numeric(27)
two_epoch_nu = numeric(27)
two_epoch_tau = numeric(27)
two_epoch_time = numeric(27)
two_epoch_theta = numeric(27)
two_epoch_nanc = numeric(27)
two_epoch_ncurr = numeric(27)
three_epoch_likelihood = numeric(27)
three_epoch_AIC = numeric(27)
three_epoch_nu_bottleneck = numeric(27)
three_epoch_nu_contemporary = numeric(27)
three_epoch_tau_bottleneck = numeric(27)
three_epoch_tau_contemporary = numeric(27)
three_epoch_time_total = numeric(27)
three_epoch_theta = numeric(27)
three_epoch_nanc = numeric(27)
three_epoch_ncurr = numeric(27)

for (i in 1:length(one_epoch_file_list)) {
  one_epoch_likelihood[i] = return_demography_likelihood(one_epoch_file_list[i])
  one_epoch_AIC[i] = AIC_from_demography(one_epoch_file_list[i])
  one_epoch_theta[i] = theta_from_demography(one_epoch_file_list[i])
  one_epoch_nanc[i] = nanc_from_demography(one_epoch_file_list[i])
  two_epoch_likelihood[i] = return_demography_likelihood(two_epoch_file_list[i])
  two_epoch_AIC[i] = AIC_from_demography(two_epoch_file_list[i])
  two_epoch_nu[i] = return_demography_params(two_epoch_file_list[i])[1]
  two_epoch_tau[i] = return_demography_params(two_epoch_file_list[i])[2]
  two_epoch_time[i] = time_from_demography(two_epoch_file_list[i])
  two_epoch_theta[i] = theta_from_demography(two_epoch_file_list[i])
  two_epoch_nanc[i] = nanc_from_demography(two_epoch_file_list[i])
  two_epoch_ncurr[i] = two_epoch_nu[i] * two_epoch_nanc[i]
  three_epoch_likelihood[i] = return_demography_likelihood(three_epoch_file_list[i])
  three_epoch_AIC[i] = AIC_from_demography(three_epoch_file_list[i])
  three_epoch_nu_bottleneck[i] = return_demography_params(three_epoch_file_list[i])[1]
  three_epoch_nu_contemporary[i] = return_demography_params(three_epoch_file_list[i])[2]
  three_epoch_tau_bottleneck[i] = return_demography_params(three_epoch_file_list[i])[3]
  three_epoch_tau_contemporary[i] = return_demography_params(three_epoch_file_list[i])[4]
  three_epoch_time_total[i] = time_from_demography(three_epoch_file_list[i])
  three_epoch_theta[i] = theta_from_demography(three_epoch_file_list[i])
  three_epoch_nanc[i] = nanc_from_demography(three_epoch_file_list[i])
  three_epoch_ncurr[i] = three_epoch_nu_contemporary[i] * three_epoch_nanc[i]
}

table_s3 = data.frame(
  species=phylogenetic_levels_MIDAS,
  one_epoch_likelihood,
  one_epoch_AIC,
  one_epoch_theta,
  one_epoch_nanc,
  two_epoch_likelihood,
  two_epoch_AIC,
  two_epoch_nu,
  two_epoch_tau,
  two_epoch_time,
  two_epoch_theta,
  two_epoch_nanc,
  two_epoch_ncurr,
  three_epoch_likelihood,
  three_epoch_AIC,
  three_epoch_nu_bottleneck,
  three_epoch_nu_contemporary,
  three_epoch_tau_bottleneck,
  three_epoch_tau_contemporary,
  three_epoch_time_total,
  three_epoch_theta,
  three_epoch_nanc,
  three_epoch_ncurr
)

names(table_s3) = c(
  'Species',
  'One epoch, log likelihood',
  'One epoch, AIC',
  'One epoch, theta',
  'One epoch, Ancestral effective population size',
  'Two epoch, log likelihood',
  'Two epoch, AIC',
  'Two epoch, nu',
  'Two epoch, tau',
  'Two epoch, time in years',
  'Two epoch, theta',
  'Two epoch, Ancestral effective population size',
  'Two epoch, Current effective population size',
  'Three epoch, log likelihood',
  'Three epoch, AIC',
  'Three epoch, nu (bottleneck)',
  'Three epoch, nu (contemporary)',
  'Three epoch, tau (bottleneck)',
  'Three epoch, tau (contemporary)',
  'Three epoch, time in years',
  'Three epoch, theta',
  'Three epoch, Ancestral effective population size',
  'Three epoch, Current effective population size'
)

write.csv(table_s3, '../Supplement/Supplemental_Table_3.csv', row.names = F)

### Supplemental Table 4
names(nu_tau_distribution) = c(
  'Species',
  'Nu, MLE',
  'Time in years, MLE',
  'Low estimate of Nu',
  'High estimate of Nu',
  'Low estimate of time in years',
  'High estimate of time in years'
)

write.csv(nu_tau_distribution, '../Supplement/Supplemental_Table_4.csv', row.names = F)

### Supplemental Table 5

dfe_nanc = numeric(27)
gamma_likelihood = numeric(27)
gamma_AIC = numeric(27)
gamma_alpha = numeric(27)
gamma_beta = numeric(27)
neugamma_likelihood = numeric(27)
neugamma_AIC = numeric(27)
neugamma_pneu = numeric(27)
neugamma_alpha = numeric(27)
neugamma_beta = numeric(27)


for (i in 1:length(DFE_file_list)) {
  dfe_nanc[i] = nanc_from_demography(two_epoch_file_list[i])
  gamma_likelihood[i] = return_DFE_likelihood(DFE_file_list[i])[1]
  gamma_AIC[i] = 4 - 2 * gamma_likelihood[i]
  gamma_alpha[i] = return_DFE_params(DFE_file_list[i])[1]
  gamma_beta[i] = return_DFE_params(DFE_file_list[i])[2]
  neugamma_likelihood[i] = return_DFE_likelihood(DFE_file_list[i])[2]
  neugamma_AIC[i] = 6 - 2 * neugamma_likelihood[i]
  neugamma_pneu[i] = return_DFE_params(DFE_file_list[i])[3]
  neugamma_alpha[i] = return_DFE_params(DFE_file_list[i])[4]
  neugamma_beta[i] = return_DFE_params(DFE_file_list[i])[5]
}

table_s5 = data.frame(
  species=phylogenetic_levels_MIDAS,
  dfe_nanc,
  gamma_likelihood,
  gamma_AIC,
  gamma_alpha,
  gamma_beta,
  neugamma_likelihood,
  neugamma_AIC,
  neugamma_pneu,
  neugamma_alpha,
  neugamma_beta
)

names(table_s5) = c(
  'Species',
  'Ancestral effective population size',
  'Gamma DFE, Log likelihood',
  'Gamma DFE, AIC',
  'Gamma DFE, Shape',
  'Gamma DFE, Scale',
  'Neu-Gamma DFE, Log likelihood',
  'Neu-Gamma DFE, AIC',
  'Neu-Gamma DFE, Proportion of Neutral Mutations',
  'Neu-Gamma DFE, Shape',
  'Neu-Gamma DFE, Scale'
)

table_s5

write.csv(table_s5, '../Supplement/Supplemental_Table_5.csv', row.names = F)

### Supplemental Table 6
accessory_phylogenetic_levels = c(
  'Parabacteroides_distasonis_56985',
  'Bacteroides_uniformis_57318',
  'Bacteroides_thetaiotaomicron_56941',
  'Bacteroides_vulgatus_57955',
  'Barnesiella_intestinihominis_62208',
  'Eubacterium_rectale_56927',
  'Faecalibacterium_prausnitzii_57453'
)

accessory_one_epoch_file_list = c(
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_one_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_one_epoch_demography.txt'
)

accessory_two_epoch_file_list = c(
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_two_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_two_epoch_demography.txt'
)

accessory_three_epoch_file_list = c(
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_three_epoch_demography.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_three_epoch_demography.txt'
)

accessory_one_epoch_likelihood = numeric(7)
accessory_one_epoch_AIC = numeric(7)
accessory_one_epoch_theta = numeric(7)
accessory_one_epoch_nanc = numeric(7)
accessory_two_epoch_likelihood = numeric(7)
accessory_two_epoch_AIC = numeric(7)
accessory_two_epoch_nu = numeric(7)
accessory_two_epoch_tau = numeric(7)
accessory_two_epoch_time = numeric(7)
accessory_two_epoch_theta = numeric(7)
accessory_two_epoch_nanc = numeric(7)
accessory_two_epoch_ncurr = numeric(7)
accessory_three_epoch_likelihood = numeric(7)
accessory_three_epoch_AIC = numeric(7)
accessory_three_epoch_nu_bottleneck = numeric(7)
accessory_three_epoch_nu_contemporary = numeric(7)
accessory_three_epoch_tau_bottleneck = numeric(7)
accessory_three_epoch_tau_contemporary = numeric(7)
accessory_three_epoch_time_total = numeric(7)
accessory_three_epoch_theta = numeric(7)
accessory_three_epoch_nanc = numeric(7)
accessory_three_epoch_ncurr = numeric(7)

for (i in 1:length(accessory_one_epoch_file_list)) {
  accessory_one_epoch_likelihood[i] = return_demography_likelihood(accessory_one_epoch_file_list[i])
  accessory_one_epoch_AIC[i] = AIC_from_demography(accessory_one_epoch_file_list[i])
  accessory_one_epoch_theta[i] = theta_from_demography(accessory_one_epoch_file_list[i])
  accessory_one_epoch_nanc[i] = nanc_from_demography(accessory_one_epoch_file_list[i])
  accessory_two_epoch_likelihood[i] = return_demography_likelihood(accessory_two_epoch_file_list[i])
  accessory_two_epoch_AIC[i] = AIC_from_demography(accessory_two_epoch_file_list[i])
  accessory_two_epoch_nu[i] = return_demography_params(accessory_two_epoch_file_list[i])[1]
  accessory_two_epoch_tau[i] = return_demography_params(accessory_two_epoch_file_list[i])[2]
  accessory_two_epoch_time[i] = time_from_demography(accessory_two_epoch_file_list[i])
  accessory_two_epoch_theta[i] = theta_from_demography(accessory_two_epoch_file_list[i])
  accessory_two_epoch_nanc[i] = nanc_from_demography(accessory_two_epoch_file_list[i])
  accessory_two_epoch_ncurr[i] = accessory_two_epoch_nu[i] * accessory_two_epoch_ncurr[i]
  accessory_three_epoch_likelihood[i] = return_demography_likelihood(accessory_three_epoch_file_list[i])
  accessory_three_epoch_AIC[i] = AIC_from_demography(accessory_three_epoch_file_list[i])
  accessory_three_epoch_nu_bottleneck[i] = return_demography_params(accessory_three_epoch_file_list[i])[1]
  accessory_three_epoch_nu_contemporary[i] = return_demography_params(accessory_three_epoch_file_list[i])[2]
  accessory_three_epoch_tau_bottleneck[i] = return_demography_params(accessory_three_epoch_file_list[i])[3]
  accessory_three_epoch_tau_contemporary[i] = return_demography_params(accessory_three_epoch_file_list[i])[4]
  accessory_three_epoch_time_total[i] = time_from_demography(accessory_three_epoch_file_list[i])
  accessory_three_epoch_theta[i] = theta_from_demography(accessory_three_epoch_file_list[i])
  accessory_three_epoch_nanc[i] = nanc_from_demography(accessory_three_epoch_file_list[i])
  accessory_three_epoch_ncurr[i] = accessory_three_epoch_nu_contemporary[i] * accessory_three_epoch_nanc[i]
}

core_ancestral = table_s3[c(7, 13, 14, 17, 18, 23, 27), ]

table_s6 = data.frame(
  species=accessory_phylogenetic_levels,
  accessory_one_epoch_likelihood,
  accessory_one_epoch_AIC,
  accessory_one_epoch_theta,
  accessory_one_epoch_nanc,
  accessory_two_epoch_likelihood,
  accessory_two_epoch_AIC,
  accessory_two_epoch_nu,
  accessory_two_epoch_tau,
  accessory_two_epoch_time,
  accessory_two_epoch_theta,
  accessory_two_epoch_nanc,
  accessory_two_epoch_ncurr,
  accessory_three_epoch_likelihood,
  accessory_three_epoch_AIC,
  accessory_three_epoch_nu_bottleneck,
  accessory_three_epoch_nu_contemporary,
  accessory_three_epoch_tau_bottleneck,
  accessory_three_epoch_tau_contemporary,
  accessory_three_epoch_time_total,
  accessory_three_epoch_theta,
  accessory_three_epoch_nanc,
  accessory_three_epoch_ncurr,
  core_ancestral$`One epoch, Ancestral effective population size`,
  core_ancestral$`Two epoch, Ancestral effective population size`,
  core_ancestral$`Three epoch, Ancestral effective population size`
)

names(table_s6) = c(
  'Species',
  'One epoch, log likelihood (Accessory)',
  'One epoch, AIC (Accessory)',
  'One epoch, theta (Accessory)',
  'One epoch, Ancestral effective population size (Accessory)',
  'Two epoch, log likelihood (Accessory)',
  'Two epoch, AIC (Accessory)',
  'Two epoch, nu (Accessory)',
  'Two epoch, tau (Accessory)',
  'Two epoch, time in years (Accessory)',
  'Two epoch, theta (Accessory)',
  'Two epoch, Ancestral effective population size (Accessory)',
  'Two epoch, Current effective population size (Accessory)',
  'Three epoch, log likelihood (Accessory)',
  'Three epoch, AIC (Accessory)',
  'Three epoch, nu at end of epoch one (Accessory)',
  'Three epoch, nu at end of epoch two (Accessory)',
  'Three epoch, tau at end of epoch one (Accessory)',
  'Three epoch, tau at end of epoch two (Accessory)',
  'Three epoch, time in years (Accessory)',
  'Three epoch, theta (Accessory)',
  'Three epoch, Ancestral effective population size (Accessory)',
  'Three epoch, Current effective population size (Accessory)',
  'One epoch, Ancestral effective population size (Core)',
  'Two epoch, Ancestral effective population size (Core)',
  'Three epoch, Ancestral effective population size (Core)'
)

table_s6
write.csv(table_s6, '../Supplement/Supplemental_Table_6.csv', row.names = F)


### Supplemental Table 7
accessory_DFE_file_list = c(
  '../Analysis/Parabacteroides_distasonis_56985_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Bacteroides_uniformis_57318_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Bacteroides_thetaiotaomicron_56941_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Bacteroides_vulgatus_57955_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Barnesiella_intestinihominis_62208_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Eubacterium_rectale_56927_downsampled_14/accessory_inferred_DFE.txt',
  '../Analysis/Faecalibacterium_prausnitzii_57453_downsampled_14/accessory_inferred_DFE.txt'
)

accessory_dfe_nanc = numeric(7)
accessory_gamma_likelihood = numeric(7)
accessory_gamma_AIC = numeric(7)
accessory_gamma_alpha = numeric(7)
accessory_gamma_beta = numeric(7)
accessory_neugamma_likelihood = numeric(7)
accessory_neugamma_AIC = numeric(7)
accessory_neugamma_pneu = numeric(7)
accessory_neugamma_alpha = numeric(7)
accessory_neugamma_beta = numeric(7)

for (i in 1:length(accessory_DFE_file_list)) {
  accessory_dfe_nanc[i] = nanc_from_demography(accessory_two_epoch_file_list[i])
  accessory_gamma_likelihood[i] = return_DFE_likelihood(accessory_DFE_file_list[i])[1]
  accessory_gamma_AIC[i] = 4 - 2 * accessory_gamma_likelihood[i]
  accessory_gamma_alpha[i] = return_DFE_params(accessory_DFE_file_list[i])[1]
  accessory_gamma_beta[i] = return_DFE_params(accessory_DFE_file_list[i])[2]
  accessory_neugamma_likelihood[i] = return_DFE_likelihood(accessory_DFE_file_list[i])[2]
  accessory_neugamma_AIC[i] = 6 - 2 * accessory_neugamma_likelihood[i]
  accessory_neugamma_pneu[i] = return_DFE_params(accessory_DFE_file_list[i])[3]
  accessory_neugamma_alpha[i] = return_DFE_params(accessory_DFE_file_list[i])[4]
  accessory_neugamma_beta[i] = return_DFE_params(accessory_DFE_file_list[i])[5]
}

table_s7 = data.frame(
  species=accessory_phylogenetic_levels,
  accessory_dfe_nanc,
  accessory_gamma_likelihood,
  accessory_gamma_AIC,
  accessory_gamma_alpha,
  accessory_gamma_beta,
  accessory_neugamma_likelihood,
  accessory_neugamma_AIC,
  accessory_neugamma_pneu,
  accessory_neugamma_alpha,
  accessory_neugamma_beta
)

names(table_s7) = c(
  'Species',
  'Ancestral effective population size',
  'Gamma DFE, Log likelihood',
  'Gamma DFE, AIC',
  'Gamma DFE, Shape',
  'Gamma DFE, Scale',
  'Neu-Gamma DFE, Log likelihood',
  'Neu-Gamma DFE, AIC',
  'Neu-Gamma DFE, Proportion of Neutral Mutations',
  'Neu-Gamma DFE, Shape',
  'Neu-Gamma DFE, Scale'
)

table_s7

write.csv(table_s7, '../Supplement/Supplemental_Table_7.csv', row.names = F)

### Supplemental Table 8
names(acc_core_dfe_LRT_table) = c(
  'Species',
  'LRT Statistic, 2N_Anc*s',
  'LRT Statistic, s'
)

acc_core_dfe_LRT_table

write.csv(acc_core_dfe_LRT_table, '../Supplement/Supplemental_Table_8.csv', row.names = F)

### Figure S7

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

# 800 x 750

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

difference_plot

wilcox.test(temp_demography_df$nu_mle, all_genes_demography_df$nu_mle, paired=T)

### Figure S8
# 1200 x 2800

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

core_accessory_comparison = 
  p25a + p25_core_dfe + p25_acc_dfe +
  p14a + p14_core_dfe + p14_acc_dfe +
  p13a + p13_core_dfe + p13_acc_dfe +
  p15a + p15_core_dfe + p15_acc_dfe +
  p17a + p17_core_dfe + p17_acc_dfe +
  p21a + p21_core_dfe + p21_acc_dfe +
  p22a + p22_core_dfe + p22_acc_dfe +
  plot_layout(design=design)

core_accessory_comparison

### Figure 5

# 1000 x 800

design = "
ABB
ACC
DEE
DFF
"

# p <- ggplot( c, aes(x=c$a, fill=c$b) ) + geom_histogram( binwidth=0.2 ) + 

fig_5A = compare_core_accessory_sfs_syn_ns_5A(b_thetaiotaomicron_core,
  b_thetaiotaomicron_core_ns,
  b_thetaiotaomicron_accessory,
  b_thetaiotaomicron_accessory_ns) + ggtitle('B. thetaiotaomicron')

fig_5B = compare_core_accessory_sfs_syn_ns_5B(e_rectale_core,
  e_rectale_core_ns,
  e_rectale_accessory,
  e_rectale_accessory_ns) + ggtitle('E. rectale')

fig_5A + p13_core_dfe + p13_acc_dfe +
  fig_5B + p21_core_dfe + p21_acc_dfe +
  plot_layout(design=design)

# Talk Version
# 600 x 800
p13_core_dfe_talk + p13_acc_dfe_talk + p21_core_dfe_talk + p21_acc_dfe_talk + plot_layout(ncol=1)

p25_core_dfe_talk + p25_acc_dfe_talk +
  p14_core_dfe_talk + p14_acc_dfe_talk +
  p13_core_dfe_talk + p13_acc_dfe_talk +
  p15_core_dfe_talk + p15_acc_dfe_talk +
  p17_core_dfe_talk + p17_acc_dfe_talk +
  p21_core_dfe_talk + p21_acc_dfe_talk +
  p22_core_dfe_talk + p22_acc_dfe_talk + plot_layout(ncol=2)

# 1400 x 600

p25_core_dfe_talk + p14_core_dfe_talk + p13_core_dfe_talk + p15_core_dfe_talk + p17_core_dfe_talk + p21_core_dfe_talk + p22_core_dfe_talk +
  p25_acc_dfe_talk + p14_acc_dfe_talk + p13_acc_dfe_talk + p15_acc_dfe_talk + p17_acc_dfe_talk + p21_acc_dfe_talk + p22_acc_dfe_talk +
  plot_layout(ncol=7)

### Figure S9

# B. vulgatus, no clade control

b_vulgatus_all_clades_syn = fold_sfs(read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_no_clade_control/empirical_syn_sfs.txt'))
b_vulgatus_all_clades_nonsyn = fold_sfs(read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_no_clade_control/empirical_nonsyn_sfs.txt'))

fig_s9_a = plot_empirical_sfs(b_vulgatus_all_clades_syn) + 
  ggtitle('*Bacteroides vulgatus*, synonymous') + 
  md_theme_minimal() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    panel.background = element_blank(), axis.line = element_line(colour = "black"))

fig_s9_b = plot_empirical_sfs(b_vulgatus_all_clades_nonsyn) + 
  ggtitle('*Bacteroides vulgatus*, nonsynonymous') + 
  md_theme_minimal() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    panel.background = element_blank(), axis.line = element_line(colour = "black"))


# B. vulgatus, clade control

b_vulgatus_clade_control_syn = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955/core_empirical_syn_sfs.txt')
b_vulgatus_clade_control_nonsyn = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955/core_empirical_nonsyn_sfs.txt')

fig_s9_c = plot_empirical_sfs(b_vulgatus_clade_control_syn)
fig_s9_d = plot_empirical_sfs(b_vulgatus_clade_control_nonsyn)

# B. vulgatus, clade control + downsampling

b_vulgatus_clade_control_downsampled_syn = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_syn_downsampled_sfs.txt')
b_vulgatus_clade_control_downsampled_nonsyn = read_input_sfs('../Analysis/Bacteroides_vulgatus_57955_downsampled_14/core_empirical_nonsyn_downsampled_sfs.txt')

fig_s9_e = plot_empirical_sfs(b_vulgatus_clade_control_downsampled_syn)
fig_s9_f = plot_empirical_sfs(b_vulgatus_clade_control_downsampled_nonsyn)

design = "
AB
CD
EF
"

# 2400 x 800

fig_s9 = plot_figure_s9(b_vulgatus_all_clades_syn,
  b_vulgatus_clade_control_syn,
  b_vulgatus_clade_control_downsampled_syn)

fig_s9

# fig_s9_a + fig_s9_b +
#   fig_s9_c + fig_s9_d +
#   fig_s9_e + fig_s9_f +
#   plot_layout(design=design)

fig_s9_a
fig_s9_c
fig_s9_e

 ### Is there a phylogenetic relationship for `nu`?

phylosig(subtree, nu_tau_distribution$`Nu, MLE`)

K<-phylosig(subtree,nu_tau_distribution$`Nu, MLE`,test=T)

lambda<-phylosig(subtree,nu_tau_distribution$`Nu, MLE`,method="lambda",test=T)

# There does not appear to be a phylogenetic trend in `nu`

### Current effective population size
N_anc = table_s3$`Two epoch, Ancestral effective population size`

N_curr_low = nu_tau_distribution$`Low estimate of Nu` * N_anc
N_curr_high = nu_tau_distribution$`High estimate of Nu` * N_anc
N_curr_MLE = nu_tau_distribution$`Nu, MLE` * N_anc

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

plot_N_curr_distribution

# N_curr for core genes vs. for all genes

N_curr_data$N_anc = N_anc
N_curr_data$species = factor(N_curr_data$species, levels=all_genes_phylogenetic_levels)
N_curr_data = na.omit(N_curr_data)
N_curr_data <- N_curr_data[order(N_curr_data$species), ]
row.names(N_curr_data) = NULL

core_all_N_curr = data.frame(species=all_genes_phylogenetic_levels,
  core_N_curr=N_curr_data$N_curr_MLE,
  core_time=temp_demography_df$time_mle,
  all_N_curr=all_genes_demography_df$nu_mle * all_genes_demography_df$n_anc,
  all_time=all_genes_demography_df$time_mle)

core_all_N_curr$species = factor(core_all_N_curr$species, levels=all_genes_phylogenetic_levels)

plot_core_all_N_curr_comparison = ggplot() +
  # geom_linerange(data=core_all_N_curr, mapping=aes(x=fct_rev(species), ymin=core_N_curr, ymax=all_N_curr, col=species), size=1, show.legend=FALSE) + 
  scale_y_log10() +
  coord_flip() +
  theme_bw() +
  xlab('') +
  ylab(N_curr_label) +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  #theme(axis.text.y = element_blank()) +
  theme(axis.text=element_text(size=16)) +
  theme(axis.title=element_text(size=16,face="bold")) +
  geom_segment(data=core_all_N_curr, aes(x=fct_rev(species), y=core_N_curr, xend=fct_rev(species), yend=all_N_curr, col=species), arrow = arrow(length=unit(.5, 'cm')), show.legend=FALSE)

plot_core_all_N_curr_comparison

plot_core_all_time_comparison = ggplot() +
  #geom_linerange(data=core_all_N_curr, mapping=aes(x=fct_rev(species), ymin=core_time, ymax=all_time, col=species), size=1, show.legend=FALSE) + 
  #geom_point(data=core_all_N_curr, mapping=aes(x=fct_rev(species), y=core_time), size=4, shape=21, fill="white") +
  #geom_point(data=core_all_N_curr, mapping=aes(x=fct_rev(species), y=all_time), size=4, shape=21, fill="black") +
  scale_y_log10() +
  coord_flip() +
  theme_bw() +
  xlab('') +
  ylab('Estimated time in years since most recent demographic event') +
  theme(axis.text.y = element_text(face='italic')) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(axis.text.y = element_blank()) +
  theme(axis.text=element_text(size=16)) +
  theme(axis.title=element_text(size=16,face="bold")) +
  geom_segment(data=core_all_N_curr, aes(x=fct_rev(species), y=core_time, xend=fct_rev(species), yend=all_time, col=species), arrow = arrow(length=unit(.5, 'cm')), show.legend=FALSE)

plot_core_all_time_comparison

### Core vs. All Figure S7

# 1500 x 1500

difference_plot

design = "
AAA
BBC
"

difference_plot + plot_core_all_N_curr_comparison + plot_core_all_time_comparison + plot_layout(design=design)

### Delta AIC

table_s3$Species = factor(table_s3$Species, levels=phylogenetic_levels_MIDAS)
table_s3 = table_s3[order(table_s3$Species), ]

plot_AIC = ggplot() +
  geom_jitter(data=table_s3, mapping=aes(x=Species, y=`Three epoch, AIC`), size=2, shape=21, fill="blue", width = 0.15) +
  geom_jitter(data=table_s3, mapping=aes(x=Species, y=`Two epoch, AIC`), size=2, shape=21, fill="green", width = 0.15) +
  geom_jitter(data=table_s3, mapping=aes(x=Species, y=`One epoch, AIC`), size=2, shape=21, fill="red", width = 0.15) +
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

plot_AIC

### Mean selection coefficient, N_curr, 2Ns

table_s5$Species = factor(table_s3$Species, levels=phylogenetic_levels_MIDAS)
table_s5 = table_s5[order(table_s5$Species), ]

mean_s = table_s5$`Gamma DFE, Shape` * table_s5$`Gamma DFE, Scale`
mean_2Ns = mean_s * 2 * N_anc

selection_vs_N_curr = data.frame(
  species=phylogenetic_levels_MIDAS,
  N_curr=N_curr_MLE,
  mean_s=mean_s,
  mean_2Ns=mean_2Ns
)

# Calculate the correlation coefficient
cor_mean_s_N_curr_MLE = cor(mean_s, N_curr_MLE)
cor_mean_2Ns_N_curr_MLE = cor(N_curr_MLE, mean_2Ns)
cor_mean_s_mean_2Ns = cor(mean_s, mean_2Ns)

plot(mean_s, N_curr_MLE)
abline(lm(N_curr_MLE ~ mean_s))
text(20, 2E10, paste("Correlation:", round(cor_mean_s_N_curr_MLE, 2)), pos = 3)
text(20, 1.5E10, paste("P-value:", round(cor.test(mean_s, N_curr_MLE)$p.value, 2)), pos = 3)
title('No correlation between N_curr_MLE and mean_s')
cor.test(mean_s, N_curr_MLE)

plot(mean_2Ns, N_curr_MLE)
abline(lm(N_curr_MLE ~ mean_2Ns))
text(1E8, 2E10, paste("Correlation:", round(cor_mean_2Ns_N_curr_MLE, 2)), pos = 3)
text(1E8, 1.5E10, paste("P-value:", round(cor.test(mean_2Ns, N_curr_MLE)$p.value, 2)), pos = 3)
title('No correlation between N_curr_MLE and mean_2Ns')

plot(mean_s, mean_2Ns)
abline(lm(mean_2Ns ~ mean_s))
text(60, 1.5E8, paste("Correlation:", round(cor_mean_s_mean_2Ns, 2)), pos=3)
text(60, 1E8, paste("P-value:", round(cor.test(mean_2Ns, mean_s)$p.value, 4), pos=3))
title('Correlation between mean_s and mean_2Ns')

### Pangenome size

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
  
mean_relative_abundance_scatter

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
  
prevalence_scatter
