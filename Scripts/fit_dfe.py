"""
Uses dadi and fitdadi to infer DFE.

JCM 20230308
"""


import sys
import os
import logging
import time
import argparse
import warnings
import re

import ast
import numpy as np
import nlopt
import dadi
import dadi.DFE as DFE
from dadi.DFE import *
import scipy.stats.distributions
import scipy.integrate
import scipy.optimize


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class DFEInference():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def neugamma(self, xx, params):
        """Return Neutral + Gamma distribution"""
        pneu, alpha, beta = params
        xx = np.atleast_1d(xx)
        out = (1-pneu)*DFE.PDFs.gamma(xx, (alpha, beta))
        # Assume gamma < 1e-4 is essentially neutral
        out[np.logical_and(0 <= xx, xx < 1e-4)] += pneu/1e-4
        # Reduce xx back to scalar if it's possible
        return np.squeeze(out)

    def fitDFEParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Given inferred demographic model parameters, this script '
                'infers a maximum-likelihood distriubtion of fitness '
                'effects.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'syn_input_sfs', type=self.ExistingFile,
            help=('Synonynomous site-frequency spectrum from which the '
                  'demographic parameters were inferred.'))
        parser.add_argument(
            'nonsyn_input_sfs', type=self.ExistingFile,
            help=('Nonsynonynomous site-frequency spectrum from which the '
                  'distribution of fitness effects should be inferred.'))
        parser.add_argument(
            'input_demography', type=self.ExistingFile,
            help=('Inferred demographic parameters output by Dadi.'))
        parser.add_argument(
            'input_model', type=str,
            help=('Input demographic model.'))
        parser.add_argument(
            '--initial_alpha', type=float,
            dest='initial_alpha',
            help=('Float value for initial alpha of gamma-DFE.'),
            default=0.2)
        parser.add_argument(
            '--initial_beta', type=float,
            dest='initial_beta',
            help=('Float value for initial beta of gamma-DFE.'),
            default=0.1)
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files')
        return parser

    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.fitDFEParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        syn_input_sfs = args['syn_input_sfs']
        nonsyn_input_sfs = args['nonsyn_input_sfs']
        outprefix = args['outprefix']
        input_demography = args['input_demography']
        input_model = args['input_model']
        initial_alpha = args['initial_alpha']
        initial_beta = args['initial_beta']

        # Numpy options
        np.set_printoptions(linewidth=np.inf)

        # create output directory if needed
        outdir = os.path.dirname(args['outprefix'])
        if outdir:
            if not os.path.isdir(outdir):
                if os.path.isfile(outdir):
                    os.remove(outdir)
                os.mkdir(outdir)

        # Output files: logfile, *demography.txt, inferred_DFE.txt
        # Remove output files if they already exist
        underscore = '' if args['outprefix'][-1] == '/' else '_'
        inferred_DFE = \
           '{0}{1}inferred_DFE.txt'.format(
                args['outprefix'], underscore)
        logfile = '{0}{1}log.log'.format(args['outprefix'], underscore)
        to_remove = [logfile, inferred_DFE]
        for f in to_remove:
            if os.path.isfile(f):
                os.remove(f)

        # Set up to log everything to logfile.
        logging.shutdown()
        logging.captureWarnings(True)
        logging.basicConfig(
            format='%(asctime)s - %(levelname)s - %(message)s',
            level=logging.INFO)
        logger = logging.getLogger(prog)
        warning_logger = logging.getLogger("py.warnings")
        logfile_handler = logging.FileHandler(logfile)
        logger.addHandler(logfile_handler)
        warning_logger.addHandler(logfile_handler)
        formatter = logging.Formatter(
            '%(asctime)s - %(levelname)s - %(message)s')
        logfile_handler.setFormatter(formatter)
        logger.setLevel(logging.INFO)

        # print some basic information
        logger.info('Beginning execution of {0} in directory {1}\n'.format(
            prog, os.getcwd()))
        logger.info('Progress is being logged to {0}\n'.format(logfile))
        logger.info('Parsed the following arguments:\n{0}\n'.format(
            '\n'.join(['\t{0} = {1}'.format(*tup) for tup in args.items()])))

        # Construct initial Spectrum object from input sfs's.
        syn_data = dadi.Spectrum.from_file(syn_input_sfs).fold()
        nonsyn_data = dadi.Spectrum.from_file(nonsyn_input_sfs).fold()

        syn_ns = syn_data.sample_sizes # Number of samples.
        nonsyn_ns = nonsyn_data.sample_sizes # Number of samples

        logger.info('Loading input demography.')
        with open(input_demography, 'r') as f:
            lines = [line for line in f]

        for line in lines:
            if 'Best fit parameters:' in line:
                demog_params = re.findall(r"\d+\.\d+", line)
                demog_params = [float(param) for param in demog_params]
            if 'Optimal value of theta_syn:' in line:
                theta_syn = str(line.split(': ')[1])
                theta_syn = theta_syn[0:-2]
                theta_syn = float(theta_syn)
        logger.info('Input demographic parameters are: ' +
                    str(demog_params) + '.')
        logger.info('Input theta_syn is: ' + str(theta_syn) + '.')
        theta_nonsyn = theta_syn * 2.21

        pts_l = [20, 40, 60]
        logger.info('Generating spectrum from input demography.')
        # input_model = 'two_epoch'
        if input_model == 'two_epoch':
            print('Demographic parameters are: ' + str(demog_params) + '.')
            spectra = DFE.Cache1D(demog_params, nonsyn_ns, DFE.DemogSelModels.two_epoch,
                                  pts=pts_l, gamma_bounds=(1e-5, 500), gamma_pts=100,
                                  verbose=True, cpus=1)
        elif input_model == 'three_epoch':
            spectra = DFE.Cache1D(demog_params, nonsyn_ns, DFE.DemogSelModels.three_epoch,
                                  pts=pts_l, gamma_bounds=(1e-5, 500), gamma_pts=100,
                                  verbose=True, cpus=1)
        else:
            spectra = DFE.Cache1D(demog_params, nonsyn_ns, dadi.Demographics1D.snm,
                                  pts=pts_l, gamma_bounds=(1e-5, 500), gamma_pts=100,
                                  verbose=True, cpus=1)

        logger.info('Fitting DFE.')
        # sel_params = [0.2, 10.]
        initial_guesses = []
        initial_guesses.append([initial_alpha, initial_beta])
        initial_guesses.append([0.2, 1.])
        initial_guesses.append([0.2, 10.])
        initial_guesses.append([0.2, 100.])
        initial_guesses.append([0.2, 1000.])
        initial_guesses.append([0.2, 10000])
        initial_guesses.append([0.2, 100000])
        initial_guesses.append([0.2, 1000000])
        initial_guesses.append([1., 0.1])
        initial_guesses.append([1., 1.])
        initial_guesses.append([1., 10.])
        initial_guesses.append([1., 100.])
        initial_guesses.append([1., 1000.])
        initial_guesses.append([1., 10000])
        initial_guesses.append([1., 100000])
        initial_guesses.append([1., 1000000])
        initial_guesses.append([5., 0.1])
        initial_guesses.append([5., 1.])
        initial_guesses.append([5., 10.])
        initial_guesses.append([5., 100.])
        initial_guesses.append([5., 1000.])
        initial_guesses.append([5., 10000.])
        initial_guesses.append([5., 100000.])
        initial_guesses.append([5., 1000000.])
        initial_guesses.append([10., 100000.])

        max_ll = -100000000000

        for i in range(25):
            sel_params = initial_guesses[i]
            p0 = dadi.Misc.perturb_params(
                sel_params, lower_bound=None,
                upper_bound=None)
            popt = dadi.Inference.optimize_log_fmin(sel_params, nonsyn_data,
                spectra.integrate, pts=None,
                func_args=[DFE.PDFs.gamma, theta_nonsyn],
                verbose=len(sel_params), maxiter=50,
                multinom=True)
            model_sfs = spectra.integrate(
                popt, None, DFE.PDFs.gamma, theta_nonsyn, None)
            model_sfs = dadi.Inference.optimally_scaled_sfs(model_sfs, nonsyn_data)
            this_ll = dadi.Inference.ll_multinom(model_sfs, nonsyn_data)
            print(this_ll)
            if this_ll > max_ll:
                best_model = model_sfs
                max_ll = this_ll
                best_params = popt

        logger.info('Fitting Neutral + Gamma DFE')

        ng_initial_guesses = []
        ng_initial_guesses.append([0.15, 0.2, 0.1])
        ng_initial_guesses.append([0.15, 0.2, 1.])
        ng_initial_guesses.append([0.15, 0.2, 10.])
        ng_initial_guesses.append([0.15, 0.2, 100.])
        ng_initial_guesses.append([0.15, 0.2, 1000.])
        ng_initial_guesses.append([0.15, 0.2, 10000])
        ng_initial_guesses.append([0.15, 0.2, 100000])
        ng_initial_guesses.append([0.15, 0.2, 1000000])
        ng_initial_guesses.append([0.15, 1., 0.1])
        ng_initial_guesses.append([0.15, 1., 1.])
        ng_initial_guesses.append([0.15, 1., 10.])
        ng_initial_guesses.append([0.15, 1., 100.])
        ng_initial_guesses.append([0.15, 1., 1000.])
        ng_initial_guesses.append([0.15, 1., 10000])
        ng_initial_guesses.append([0.15, 1., 100000])
        ng_initial_guesses.append([0.15, 1., 1000000])
        ng_initial_guesses.append([0.15, 5., 0.1])
        ng_initial_guesses.append([0.15, 5., 1.])
        ng_initial_guesses.append([0.15, 5., 10.])
        ng_initial_guesses.append([0.15, 5., 100.])
        ng_initial_guesses.append([0.15, 5., 1000.])
        ng_initial_guesses.append([0.15, 5., 10000.])
        ng_initial_guesses.append([0.15, 5., 100000.])
        ng_initial_guesses.append([0.15, 5., 1000000.])
        ng_initial_guesses.append([0.15, 10., 100000.])

        ng_max_ll = -100000000000
        for i in range(25):
            sel_params = ng_initial_guesses[i]
            lower_bound, upper_bound = [1e-15, 1e-15, 1e-2], [1, 1000, 1000000.]
            ng_p0 = dadi.Misc.perturb_params(sel_params, lower_bound=lower_bound,
                                          upper_bound=upper_bound)
            ng_popt = dadi.Inference.optimize_log_fmin(ng_p0, nonsyn_data,
                                                  spectra.integrate, pts=None,
                                                  func_args=[self.neugamma,
                                                             theta_nonsyn],
                                                  lower_bound=lower_bound,
                                                  upper_bound=upper_bound,
                                                  verbose=len(sel_params),
                                                  maxiter=50, multinom=False)
            ng_model_sfs = spectra.integrate(
                ng_popt, None, self.neugamma, theta_nonsyn, None)
            ng_this_ll = dadi.Inference.ll(ng_model_sfs, nonsyn_data)
            if ng_this_ll > ng_max_ll:
                ng_best_model = ng_model_sfs
                ng_max_ll = ng_this_ll
                ng_best_params = ng_popt

        logger.info('Computing intermediate summary statistics.')

        # Compute L_syn from input_syn_sfs
        # L_syn is given as the sum of allele counts for the input
        # synonymous SFS.
        with open(syn_input_sfs, 'r') as f:
            syn_sfs_lines = [line for line in f]
            syn_sfs_array = syn_sfs_lines[1].split(' ')
            syn_sfs_array = [float(i) for i in syn_sfs_array]

        # Compute scaling factor of params, i.e., 2 * Na
        L_syn = np.sum(syn_sfs_array)
        # L_syn = 1
        mu_high = 6.93E-10 # High estimate of mutation rate
        mu_low = 4.08E-10 # Low estimate of mutation rate
        Na_low = theta_syn / (4 * L_syn * mu_high) # Low estimate of N_anc
        Na_high = theta_syn / (4 * L_syn * mu_low) # High estimate of N_anc
        #  Theta is given in terms of 4 * L_syn * mu * Na, thus,
        #  we don't need to divide by nu in order to get ancestral popultion
        #
        # Na_low = Ne_low / float(demog_params[0])
        # Na_high = Ne_high / float(demog_params[0])

        logger.info('Outputting results.')

        with open(inferred_DFE, 'w') as f:
            f.write('Assuming a gamma-distributed DFE...\n')
            f.write('The maximum likelihood is: ' +
                    str(max_ll) +  '.\n')
            f.write('The maximum likelihood scaled ' +
                    'gamma-distributed DFE is parameterized ' +
                    'as: ' + str(best_params)  + '.\n')
            # Non-scaled params are divided by
            f.write(
                'The maximum likelihood parameters have a high '
                'estimate of: '
                '{0}.\n'.format(
                    np.divide(best_params,
                              np.array([1, 2 * Na_low]))))
            f.write(
                'The maximum likelihood parameters have a low '
                'estimate of: '
                '{0}.\n'.format(
                    np.divide(best_params,
                              np.array([1, 2 * Na_high]))))
            f.write('The empirical nonsynonymous SFS is: ' +
                    str(nonsyn_data) + '.\n')
            f.write('The best fit model SFS is: ' +
                    str(best_model.fold()) + '.\n')
            f.write('Assuming a neu-gamma-distributed DFE...\n')
            f.write('The maximum likelihood is: ' +
                    str(ng_max_ll) +  '.\n')
            f.write('The maximum likelihood scaled ' +
                    'neu-gamma-distributed DFE is parameterized ' +
                    'as: ' + str(ng_best_params)  + '.\n')
            # Non-scaled params are divided by
            f.write(
                'The maximum likelihood parameters have a high '
                'estimate of: '
                '{0}.\n'.format(
                    np.divide(ng_best_params,
                              np.array([1, 1, 2 * Na_low]))))
            f.write(
                'The maximum likelihood parameters have a low '
                'estimate of: '
                '{0}.\n'.format(
                    np.divide(ng_best_params,
                              np.array([1, 1, 2 * Na_high]))))
            f.write('The empirical nonsynonymous SFS is: ' +
                    str(nonsyn_data) + '.\n')
            f.write('The best fit model SFS is: ' +
                    str(ng_best_model.fold()) + '.\n')
        logger.info('Pipeline executed succesfully.')

if __name__ == '__main__':
    DFEInference().main()
