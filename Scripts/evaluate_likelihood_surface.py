""" Evaluate the likelihood surface of several points for a given species.

JCM 20221018
"""


import sys
import os
import logging
import time
import argparse
import warnings

import numpy
import dadi
import scipy.stats.distributions
import scipy.integrate
import scipy.optimize
import matplotlib
matplotlib.use('Agg') # Must be before importing matplotlib.pyplot or pylab!
import matplotlib.pyplot as plt
from matplotlib import ticker, cm
import pandas as pd

class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class MidpointNormalize(matplotlib.colors.Normalize):
    def __init__(self, vmin=None, vmax=None, vcenter=None, clip=False):
        self.vcenter = vcenter
        super().__init__(vmin, vmax, clip)

    def __call__(self, value, clip=None):
        # I'm ignoring masked values and all kinds of edge cases to make a
        # simple example...
        # Note also that we must extrapolate beyond vmin/vmax
        x, y = [self.vmin, self.vcenter, self.vmax], [0, 0.5, 1.]
        return numpy.ma.masked_array(numpy.interp(value, x, y,
                                            left=-numpy.inf, right=numpy.inf))

    def inverse(self, value):
        y, x = [self.vmin, self.vcenter, self.vmax], [0, 0.5, 1]
        return numpy.interp(value, x, y, left=-numpy.inf, right=numpy.inf)

class EvaluateLikelihoodSurface():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def fitDemographicModelParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Given the number of individuals in population one and two, '
                'this script outputs a `*pops_file.txt` in the format '
                'specified for use by the python package, `easySFS.py`.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'syn_input_sfs', type=self.ExistingFile,
            help=('Synonynomous site-frequency spectrum from which the '
                  'demographic parameters should be inferred.'))
        parser.add_argument(
            'num_points', type=int,
            help=('Number of points to evaluate on likelihood surface.'))
        parser.add_argument(
            '--mask_singletons', dest='mask_singletons',
            help=('Boolean flag for masking singlestons in Spectrum.'),
            action='store_true')
        parser.add_argument(
            '--mask_doubletons', dest='mask_doubletons',
            help=('Boolean flag for masking doublestons in Spectrum.'),
            action='store_true')
        parser.set_defaults(mask_singletons=True)
        parser.set_defaults(mask_doubletons=False)
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files.')
        return parser

    def snm(self, notused, ns, pts):
        """Return a standard neutral model.

        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def two_epoch(self, params, ns, pts):
        """Define a two-epoch demography, i.e., an instantaneous size change.

        params = (nu, T)
            nu: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nu, T = params  # Define given parameters.
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        phi = dadi.Integration.one_pop(phi, xx, T, nu)  # Integrate.

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx,))
        return fs

    def two_epoch_sel(self, params, ns, pts):
        """Define a two-epoch demography, i.e., an instantaneous size change.

        This method incorporates a gamma parameter.

        params = (nu, T, gamma)
            nu: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
            gamma: Parameter tuple describing a gamma distribution.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nu, T, gamma = params  # Define given parameters.
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx, gamma=gamma)  # Define initial phi

        phi = dadi.Integration.one_pop(phi, xx, T, nu, gamma=gamma)

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def growth(self, params, ns, pts):
        """Exponential growth beginning some time ago.

        params = (nu, T)
            nu: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nu, T = params  # Define given parameters.
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        def nu_func(t): return numpy.exp(numpy.log(nu) * t / T)  # Exp growth.
        phi = dadi.Integration.one_pop(phi, xx, T, nu_func)  # Integrate.

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def bottlegrowth(self, params, ns, pts):
        """Instantaneous size change followed by exponential growth.

        params = (nuB, nuF, T)
            nuB: Ratio of population size after instantaneous change to ancient
                population size.
            nuF: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nuB, nuF, T = params  # Define given parameters.

        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi

        # Exponential growth function
        def nu_func(t): return nuB * numpy.exp(numpy.log(nuF / nuB) * t / T)

        phi = dadi.Integration.one_pop(phi, xx, T, nu_func)  # Integrate.

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def three_epoch(self, params, ns, pts):
        """Define a three-epoch demography.

        params = (nuB, nuF, TB, TF)
            nuB: Ratio of bottleneck population size to ancient
                population size.
            nuF: Ratio of contemporary to ancient population size.
            TB: Length of bottleneck, in units of 2 * N_a.
            TF: Time since bottleneck recovery, in units of 2 * N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nuB, nuF, TB, TF = params  # Define given parameters.

        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        phi = dadi.Integration.one_pop(phi, xx, TB, nuB)  # Integrate 1 to 2.
        phi = dadi.Integration.one_pop(phi, xx, TF, nuF)  # Integrate 2 to 3.

        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def four_epoch(self, params, ns, pts):
        """Define a four-epoch demography.

        params = (Na, Nb, Nc, Ta, Tb, Tc)
            Na: ratio of population size between epoch 1 and 2.
            Nb: ratio of population size between epoch 2 and 3.
            Nc: ratio of population size between epoch 3 and 4.
            Ta: Bottleneck length between epoch 1 and 2, in units of 2 * N_a.
            Tb: Length of bottleneck between epoch 2 and 3,
                in units of 2 * N_a.
            Tc: Length of bottleneck between epoch 3 and 4,
                in units of 2 * N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        Na, Nb, Nc, Ta, Tb, Tc = params  # Define given parameters.

        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        # Integrate epochs.
        phi = dadi.Integration.one_pop(phi, xx, Ta, Na)  # Integrate 1 to 2.
        phi = dadi.Integration.one_pop(phi, xx, Tb, Nb)  # Integrate 2 to 3.
        phi = dadi.Integration.one_pop(phi, xx, Tc, Nc)  # Integrate 3 to 4.

        # Construct spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def one_epoch(self, params, ns, pts):
        """Define a one-epoch demography.
        params = (nu, T)
            nu: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        # Construct spectrum object
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs


    def one_pop(phi, xx, T, nu=1, gamma=0, h=0.5, theta0=1.0, initial_t=0,
                frozen=False, beta=1):
        """
        Integrate a 1-dimensional phi foward.

        phi: Initial 1-dimensional phi
        xx: Grid upon (0,1) overwhich phi is defined.

        nu, gamma, and theta0 may be functions of time.
        nu: Population size
        gamma: Selection coefficient on *all* segregating alleles
        h: Dominance coefficient. h = 0.5 corresponds to genic selection.
        Heterozygotes have fitness 1+2sh and homozygotes have fitness 1+2s.
        theta0: Propotional to ancestral size. Typically constant.
        beta: Breeding ratio, beta=Nf/Nm.

        T: Time at which to halt integration
        initial_t: Time at which to start integration. (Note that this only
            matters if one of the demographic parameters is a function of time.)

        frozen: If True, population is 'frozen' so that it does not change.
            In the one_pop case, this is equivalent to not running the
            integration at all.
        """
        phi = phi.copy()

        # For a one population integration, freezing means just not integrating.
        if frozen:
            return phi

        if T - initial_t == 0:
            return phi
        elif T - initial_t < 0:
            raise ValueError('Final integration time T (%f) is less than '
                            'intial_time (%f). Integration cannot be run '
                            'backwards.' % (T, initial_t))

        vars_to_check = (nu, gamma, h, theta0, beta)
        if numpy.all([numpy.isscalar(var) for var in vars_to_check]):
            return _one_pop_const_params(phi, xx, T, nu, gamma, h, theta0,
                                     initial_t, beta)

        nu_f = Misc.ensure_1arg_func(nu)
        gamma_f = Misc.ensure_1arg_func(gamma)
        h_f = Misc.ensure_1arg_func(h)
        theta0_f = Misc.ensure_1arg_func(theta0)
        beta_f = Misc.ensure_1arg_func(beta)

        current_t = initial_t
        nu, gamma, h = nu_f(current_t), gamma_f(current_t), h_f(current_t)
        beta = beta_f(current_t)
        dx = numpy.diff(xx)
        while current_t < T:
            dt = _compute_dt(dx,nu,[0],gamma,h)
            this_dt = min(dt, T - current_t)

            # Because this is an implicit method, I need the *next* time's params.
            # So there's a little inconsistency here, in that I'm estimating dt
            # using the last timepoints nu,gamma,h.
            next_t = current_t + this_dt
            nu, gamma, h = nu_f(next_t), gamma_f(next_t), h_f(next_t)
            beta = beta_f(next_t)
            theta0 = theta0_f(next_t)

            if numpy.any(numpy.less([T,nu,theta0], 0)):
                raise ValueError('A time, population size, migration rate, or '
                             'theta0 is < 0. Has the model been mis-specified?')
            if numpy.any(numpy.equal([nu], 0)):
                raise ValueError('A population size is 0. Has the model been '
                             'mis-specified?')

            _inject_mutations_1D(phi, this_dt, xx, theta0)
            # Do each step in C, since it will be faster to compute the a,b,c
            # matrices there.
            phi = int_c.implicit_1Dx(phi, xx, nu, gamma, h, beta, this_dt,
                                 use_delj_trick=use_delj_trick)
            current_t = next_t
        return phi

    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.fitDemographicModelParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        syn_input_sfs = args['syn_input_sfs']
        outprefix = args['outprefix']
        mask_singletons = args['mask_singletons']
        mask_doubletons = args['mask_doubletons']
        num_points=args['num_points']

        # Numpy options
        numpy.set_printoptions(linewidth=numpy.inf)

        # create output directory if needed
        outdir = os.path.dirname(args['outprefix'])
        if outdir:
            if not os.path.isdir(outdir):
                if os.path.isfile(outdir):
                    os.remove(outdir)
                os.mkdir(outdir)

        # Output files: logfile
        # Remove output files if they already exist
        underscore = '' if args['outprefix'][-1] == '/' else '_'
        logfile = '{0}{1}likelihood_surface.log'.format(args['outprefix'], underscore)
        # output_plot = \
        #     '{0}{1}full_likelihood_surface.jpg'.format(
        #         args['outprefix'], underscore)
        to_remove = [logfile]
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

        # Construct initial Spectrum object from input synonymous sfs.
        syn_data = dadi.Spectrum.from_file(syn_input_sfs)
        if mask_singletons:
            syn_data.mask[1] = True
        if mask_doubletons:
            syn_data.mask[2] = True
        syn_ns = syn_data.sample_sizes  # Number of samples.
        pts_l = [1200, 1400, 1600]

        ll_grid = []

        # Optomize parameters for this model.
        # First set parameter bounds for optimization
        model_list = ['two_epoch']
        for model in model_list:
            if model == 'two_epoch':
                upper_bound = None
                lower_bound = None
                func_ex = dadi.Numerics.make_extrap_log_func(self.two_epoch)
                logger.info('Beginning demographic inference for two-epoch '
                            'demographic model.')
            min_nu = 1E-8
            # max_nu = 1.9 * nu_prime
            min_tau = 1E-8
            max_tau = 1
            max_nu = 5.0
            nx = num_points
            ny = num_points

            x = numpy.random.uniform(low=min_nu, high=max_nu, size=nx)
            y = numpy.random.uniform(low=min_tau, high=max_tau, size=ny)
            max_ll = -100000
            for i in range(nx):
                for j in range(ny):
                    p0 = [x[i], y[j]]
                    # p0 = [nu_prime, tau_prime]
                    popt = dadi.Inference.optimize_log_lbfgsb(
                        p0=p0, data=syn_data, model_func=func_ex, pts=pts_l,
                        lower_bound=lower_bound, upper_bound=upper_bound,
                        verbose=len(p0), maxiter=0)
                    print(popt)
                    non_scaled_spectrum = func_ex(popt, syn_ns, pts_l)
                    theta = dadi.Inference.optimal_sfs_scaling(
                        non_scaled_spectrum, syn_data)
                    loglik = dadi.Inference.ll_multinom(
                        model=non_scaled_spectrum, data=syn_data)
                    theta = dadi.Inference.optimal_sfs_scaling(
                        non_scaled_spectrum, syn_data)
                    if loglik > max_ll:
                        max_ll = loglik
                        mle_x = x[i]
                        mle_y = y[j]
                        best_non_scaled_spectrum = non_scaled_spectrum
                        best_theta = theta
                        best_scaled_spectrum = best_theta * best_non_scaled_spectrum
                    ll_array = [x[i], y[j], theta, loglik]
                    # ll_string = str(nu_grid[i]) + ', '
                    # ll_string += str(tau_grid[j]) + ', '
                    # ll_string += str(loglik)
                    ll_grid.append(ll_array)
                    del ll_array
            ll_df = pd.DataFrame(ll_grid)
            # ll_df.to_csv('ll_df.csv')
            mle = [mle_x, mle_y]

        logger.info('Finished plotting likelihood surface.')
        logger.info('Pipeline executed succesfully.')
        logger.info('The best fit parameters are: ' + str(mle)+ '.')
        logger.info('The likelihood of the mle is: ' + str(max_ll) + '.')
        logger.info('Non-scaled best-fit model spectrum: {0}.\n'.format(
            best_non_scaled_spectrum))
        logger.info('Scaled best-fit model spectrum: {0}.\n'.format(
            best_scaled_spectrum))

if __name__ == '__main__':
    EvaluateLikelihoodSurface().main()
