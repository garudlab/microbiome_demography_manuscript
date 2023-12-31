#! /bin/env python
import sys
from optparse import OptionParser
import copy

# Numpy is the numerical library dadi is built upon
import scipy.optimize
import numpy
from numpy import array

import dadi

# In demographic_models.py, we've defined a custom model for this problem
import DemoModelsDGRP


def runModel(outFile, nuB_start, nuF_start, TB_start, TF_start):


    # Parse the data file to generate the data dictionary
    dd = dadi.Misc.make_data_dict(‘AllData_forDadi.txt')   


    # Extract the spectrum for ['YRI','CEU'] from that dictionary, with both  
    # projected down to 130 samples.
    fs = dadi.Spectrum.from_data_dict(dd, ['DME'], [130], polarized=False)

    ns = fs.sample_sizes
    print 'sample sizes:', ns

    # These are the grid point settings will use for extrapolation.
    pts_l = [40,50,60]
    #pts_l = [140, 150, 160] # suggested that the smallest grid be slightly larger than the largest sample size. But this may take a long time. 
    # This ensures that the integration takes timesteps properly sized for the grids we are using.
    dadi.Integration.set_timescale_factor(pts_l[-1], factor=10)

    # bottleneck model
    func=DemoModelsDGRP.bottleneck
    params = array([nuB_start, nuF_start, TB_start, TF_start])
    upper_bound=[1,3,1,1]
    lower_bound=[0.001, 0.001, 0, 0]


    # growth model
    #func=DemoModelsDGRP.growth
    #params = array([0.5, 0.05])
    #upper_bound=[3,1]
    #lower_bound=[0.001, 0]

    # bottleneckAndGrowth model
    #func=DemoModelsDGRP.bottleneckAndGrowth
    #params = array([0.2, 0.8, 0.05, 0.05])
    #upper_bound=[1,3,1,1]
    #lower_bound=[0.001, 0.001, 0, 0]




    # Make the extrapolating version of the demographic model function.
    func_ex = dadi.Numerics.make_extrap_func(func)

    # Calculate the model AFS.
    model = func_ex(params, ns, pts_l)

    # Likelihood of the data given the model AFS.
    ll_model = dadi.Inference.ll_multinom(model, fs)

    #print 'Model log-likelihood:', ll_model
    # The optimal value of theta given the model.
    theta = dadi.Inference.optimal_sfs_scaling(model, fs)

    p0 = dadi.Misc.perturb_params(params, fold=1, lower_bound=lower_bound, upper_bound=upper_bound)
    

    popt = dadi.Inference.optimize_log(p0, fs, func_ex, pts_l, upper_bound=upper_bound, lower_bound=lower_bound, maxiter=None,  verbose=len(params))
    
    new_model = func_ex(popt, ns, pts_l)

    ll_opt = dadi.Inference.ll_multinom(new_model, fs)
    
    # Write the parameters and log-likelihood to the outFile
    s = str(nuB_start) + '\t' + str(nuF_start) + '\t' + str(TB_start) + '\t' + str(TF_start) + '\t'
    for i in range(0, len(popt)):
        s += str(popt[i]) + '\t'
    s += str(ll_opt) + '\t' + str(fs.Watterson_theta()) + '\t' + str(new_model.Watterson_theta()) + '\t' +  str(fs.pi()) + '\t' + str(new_model.pi()) + '\t' + str(fs.Tajima_D()) + '\t' + str(new_model.Tajima_D()) + '\t' + str(fs.S()) + '\t' + str(new_model.S()) + '\n'

    outFile.write(s)
    
    

    # Plot a comparison of the resulting fs with the data.
    #import pylab
    ##pylab.figure()
    #p = dadi.Plotting.plot_1d_comp_multinom(new_model, fs)
    #pylab.savefig('DGRP.png')




###############


def mkOptionParser():
    """ Defines options and returns parser """
    
    usage = """%prog  <output.txt> <nuB_start> <nuF_start> <TB_start> <TF_start>
    %prog runs DaDi on input SFS. """

    parser = OptionParser(usage)
   

    return parser



def main():
    """ see usage in mkOptionParser. """
    parser = mkOptionParser()
    options, args= parser.parse_args()

    if len(args) != 5:
        parser.error("Incorrect number of arguments")

    outFN        = args[0]
    nuB_start    = float(args[1])
    nuF_start    = float(args[2])
    TB_start     = float(args[3])
    TF_start     = float(args[4])
    
    if outFN == '-':
        outFile = sys.stdout
    else:
        outFile      = open(outFN, 'a')


    runModel(outFile, nuB_start, nuF_start, TB_start, TF_start)


    

#run main
if __name__ == '__main__':
    main()
