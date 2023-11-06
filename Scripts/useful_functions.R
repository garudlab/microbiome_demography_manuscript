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
    # theme(legend.position="none") +
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
    scale_fill_manual(values=c('#a6611a', '#dfc27d', '#80cdc1', '#018571'))
  
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
    scale_fill_manual(values=c('#a6611a', '#dfc27d', '#80cdc1', '#018571')) +
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
    scale_fill_manual(values=c('#a6611a', '#dfc27d', '#80cdc1', '#018571')) +
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
