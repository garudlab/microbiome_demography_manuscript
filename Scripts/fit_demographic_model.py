""" Uses dadi to infer the best-fit demographic model for given sfs.

JCM 201907011
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


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class DemographicInference():
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
            '--mask_singletons', dest='mask_singletons',
            help=('Boolean flag for masking singlestons in Spectrum.'),
            action='store_true')
        parser.add_argument(
            '--mask_doubletons', dest='mask_doubletons',
            help=('Boolean flag for masking doublestons in Spectrum.'),
            action='store_true')
        parser.set_defaults(mask_singletons=False)
        parser.set_defaults(mask_doubletons=False)
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files')
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
        exponential_growth_demography = \
            '{0}{1}exponential_growth_demography.txt'.format(
                args['outprefix'], underscore)
        two_epoch_demography = \
            '{0}{1}two_epoch_demography.txt'.format(
                args['outprefix'], underscore)
        bottleneck_growth_demography = \
            '{0}{1}bottleneck_growth_demography.txt'.format(
                args['outprefix'], underscore)
        three_epoch_demography = \
            '{0}{1}three_epoch_demography.txt'.format(
                args['outprefix'], underscore)
        one_epoch_demography = \
           '{0}{1}one_epoch_demography.txt'.format(
                args['outprefix'], underscore)
        expected_sfs_comparison = \
           '{0}{1}expected_sfs_comparison.txt'.format(
                args['outprefix'], underscore)
        logfile = '{0}{1}log.log'.format(args['outprefix'], underscore)
        # to_remove = [logfile, exponential_growth_demography,
        #              two_epoch_demography, bottleneck_growth_demography,
        #              three_epoch_demography, one_epoch_demography,
        #              expected_sfs_comparison]
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
        syn_data = syn_data.fold()
        if mask_singletons:
            syn_data.mask[1] = True
        if mask_doubletons:
            syn_data.mask[2] = True
        syn_ns = syn_data.sample_sizes  # Number of samples.
        pts_l = [1200, 1400, 1600]

        # Optomize parameters for this model.
        # First set parameter bounds for optimization
        # model_list = ['exponential_growth', 'two_epoch', 'bottleneck_growth',
        #               'three_epoch', 'one_epoch']
        # model_list = ['three_epoch']
        # model_list = ['two_epoch']
        # model_list = ['two_epoch', 'three_epoch']
        model_list = ['one_epoch', 'two_epoch', 'three_epoch']
        # Fit different one-epoch models and compute likelihood
        # method_list = ['expectation']
        method_list = ['null']
        for method in method_list:
            if method == 'expectation':
                print('compute_likelihood from expectation')
                model_sum = numpy.ma.sum(syn_data)
                # print(model_sum)
                model_data = numpy.divide(
                    numpy.ones(shape=syn_ns+1), numpy.arange(1, syn_ns+2))
                syn_data_mask = numpy.zeros(syn_ns+1)
                syn_data_mask[0] = 1
                model_data = numpy.ma.masked_array(model_data, syn_data_mask)
                model_data = dadi.Spectrum(model_data)
                model_data = dadi.Spectrum.fold(model_data)
                model_data.mask[1] = True
                model_data = numpy.divide(model_data, numpy.ma.sum(model_data))
                model_data = model_data * model_sum
                with open(expected_sfs_comparison, 'w') as f:
                   f.write('The log likelihood when comparing the expected '
                           'SFS is: ' + str(
                           dadi.Inference.ll_multinom(model_data, syn_data)))
        for model in model_list:
            if model == 'exponential_growth':
                upper_bound = [80, 0.15]
                lower_bound = [0, 0]
                initial_guesses = []
                initial_guesses.append([0.000001, 0.01])
                initial_guesses.append([0.00001, 0.01])
                initial_guesses.append([0.0001, 0.01])
                initial_guesses.append([0.001, 0.01])
                initial_guesses.append([0.01, 0.01])
                initial_guesses.append([0.6, 0.01])
                initial_guesses.append([0.7, 0.01])
                initial_guesses.append([0.8, 0.01])
                initial_guesses.append([0.9, 0.01])
                initial_guesses.append([1, 0.01])
                initial_guesses.append([1.25, 0.01])
                initial_guesses.append([1.5, 0.01])
                initial_guesses.append([1.75, 0.01])
                initial_guesses.append([2, 0.01])
                initial_guesses.append([2.25, 0.01])
                initial_guesses.append([2.5, 0.01])
                initial_guesses.append([2.75, 0.01])
                initial_guesses.append([3, 0.01])
                initial_guesses.append([3.33, 0.01])
                initial_guesses.append([3.66, 0.01])
                initial_guesses.append([4, 0.01])
                initial_guesses.append([5, 0.01])
                initial_guesses.append([6, 0.01])
                initial_guesses.append([7, 0.01])
                initial_guesses.append([8, 0.01])
                file = exponential_growth_demography
                func_ex = dadi.Numerics.make_extrap_log_func(self.growth)
                logger.info('Beginning demographic inference for exponential '
                            'growth demographic model.')
            elif model == 'two_epoch':
                upper_bound = [80, 0.15]
                lower_bound = [0, 0]
                initial_guesses = []
                initial_guesses.append([0.1, 0.01])
                initial_guesses.append([0.2, 0.01])
                initial_guesses.append([0.3, 0.01])
                initial_guesses.append([0.4, 0.01])
                initial_guesses.append([0.5, 0.01])
                initial_guesses.append([0.6, 0.01])
                initial_guesses.append([0.7, 0.01])
                initial_guesses.append([0.8, 0.01])
                initial_guesses.append([0.9, 0.01])
                initial_guesses.append([1, 0.01])
                initial_guesses.append([1.25, 0.01])
                initial_guesses.append([1.5, 0.01])
                initial_guesses.append([1.75, 0.01])
                initial_guesses.append([2, 0.01])
                initial_guesses.append([2.25, 0.01])
                initial_guesses.append([2.5, 0.01])
                initial_guesses.append([2.75, 0.01])
                initial_guesses.append([3, 0.01])
                initial_guesses.append([3.33, 0.01])
                initial_guesses.append([3.66, 0.01])
                initial_guesses.append([4, 0.01])
                initial_guesses.append([5, 0.01])
                initial_guesses.append([6, 0.01])
                initial_guesses.append([7, 0.01])
                initial_guesses.append([8, 0.01])
                file = two_epoch_demography
                func_ex = dadi.Numerics.make_extrap_log_func(self.two_epoch)
                logger.info('Beginning demographic inference for two-epoch '
                            'demographic model.')
            elif model == 'bottleneck_growth':
                upper_bound = [80, 80, 0.15]
                lower_bound = [0, 0, 0]
                initial_guess = [0.1, 0.1, 0.01]
                initial_guesses = []
                initial_guesses.append([0.000001, 0.000001, 0.01])
                initial_guesses.append([0.00001, 0.00001, 0.01])
                initial_guesses.append([0.0001, 0.0001, 0.01])
                initial_guesses.append([0.001, 0.001, 0.01])
                initial_guesses.append([0.01, 0.01, 0.01])
                initial_guesses.append([0.6, 0.6, 0.01])
                initial_guesses.append([0.7, 0.7, 0.01])
                initial_guesses.append([0.8, 0.8, 0.01])
                initial_guesses.append([0.9, 0.9, 0.01])
                initial_guesses.append([1, 1, 0.01])
                initial_guesses.append([1.25, 1.25, 0.01])
                initial_guesses.append([1.5, 1.5, 0.01])
                initial_guesses.append([1.75, 1.75, 0.01])
                initial_guesses.append([2, 2, 0.01])
                initial_guesses.append([2.25, 2.25, 0.01])
                initial_guesses.append([2.5, 2.5, 0.01])
                initial_guesses.append([2.75, 2.75, 0.01])
                initial_guesses.append([3, 3, 0.01])
                initial_guesses.append([3.33, 3.33, 0.01])
                initial_guesses.append([3.66, 3.66, 0.01])
                initial_guesses.append([4, 4, 0.01])
                initial_guesses.append([5, 5, 0.01])
                initial_guesses.append([6, 6, 0.01])
                initial_guesses.append([7, 7, 0.01])
                initial_guesses.append([8, 8, 0.01])
                file = bottleneck_growth_demography
                func_ex = dadi.Numerics.make_extrap_log_func(self.bottlegrowth)
                logger.info('Beginning demographic inference for bottleneck + '
                            'growth demographic model.')
            elif model == 'three_epoch':
                upper_bound = [80, 80, 0.15, 0.15]
                lower_bound = [0.0, 0.0, 0.0, 0.0]
                initial_guesses = []
                initial_guesses.append([0.01, 0.01, 0.01, 0.01])
                initial_guesses.append([0.02, 0.02, 0.01, 0.01])
                initial_guesses.append([0.03, 0.03, 0.01, 0.01])
                initial_guesses.append([0.04, 0.04, 0.01, 0.01])
                initial_guesses.append([0.05, 0.05, 0.01, 0.01])
                initial_guesses.append([0.6, 0.6, 0.01, 0.01])
                initial_guesses.append([0.7, 0.7, 0.01, 0.01])
                initial_guesses.append([0.8, 0.8, 0.01, 0.01])
                initial_guesses.append([0.9, 0.9, 0.01, 0.01])
                initial_guesses.append([1, 1, 0.01, 0.01])
                initial_guesses.append([1.25, 1.25, 0.01, 0.01])
                initial_guesses.append([1.5, 1.5, 0.01, 0.01])
                initial_guesses.append([1.75, 1.75, 0.01, 0.01])
                initial_guesses.append([2, 2, 0.01, 0.01])
                initial_guesses.append([2.25, 2.25, 0.01, 0.01])
                initial_guesses.append([2.5, 2.5, 0.01, 0.01])
                initial_guesses.append([2.75, 2.75, 0.01, 0.01])
                initial_guesses.append([3, 3, 0.01, 0.01])
                initial_guesses.append([3.33, 3.33, 0.01, 0.01])
                initial_guesses.append([3.66, 3.66, 0.01, 0.01])
                initial_guesses.append([4, 4, 0.01, 0.01])
                initial_guesses.append([5, 5, 0.01, 0.01])
                initial_guesses.append([6, 6, 0.01, 0.01])
                initial_guesses.append([7, 7, 0.01, 0.01])
                initial_guesses.append([8, 8, 0.01, 0.01])
                file = three_epoch_demography
                func_ex = dadi.Numerics.make_extrap_log_func(self.three_epoch)
                logger.info('Beginning demographic inference for three-epoch '
                            'demographic model.')
            elif model == 'one_epoch':
                upper_bound = [80]
                lower_bound = [0]
                initial_guesses = []
                initial_guesses.append([0.1])
                initial_guesses.append([0.2])
                initial_guesses.append([0.3])
                initial_guesses.append([0.4])
                initial_guesses.append([0.5])
                initial_guesses.append([0.6])
                initial_guesses.append([0.7])
                initial_guesses.append([0.8])
                initial_guesses.append([0.9])
                initial_guesses.append([1])
                initial_guesses.append([1.25])
                initial_guesses.append([1.5])
                initial_guesses.append([1.75])
                initial_guesses.append([2])
                initial_guesses.append([2.25])
                initial_guesses.append([2.5])
                initial_guesses.append([2.75])
                initial_guesses.append([3])
                initial_guesses.append([3.33])
                initial_guesses.append([3.66])
                initial_guesses.append([4])
                initial_guesses.append([5])
                initial_guesses.append([6])
                initial_guesses.append([7])
                initial_guesses.append([8])
                # initial_guess = [0.1]
                file = one_epoch_demography
                func_ex = dadi.Numerics.make_extrap_log_func(self.snm)
                logger.info('Beginning demographic inference for one-epoch '
                            'demographic model.')
            with open(file, 'w') as f:
                max_likelihood = -1e25
                for i in range(24):
                    # Start at initial guess
                    p0 = initial_guesses[i]
                    # Randomly perturb parameters before optimization.
                    p0 = dadi.Misc.perturb_params(
                        p0, fold=1, upper_bound=None,
                        lower_bound=None)
                    logger.info(
                        'Beginning optimization with guess, {0}.'.format(p0))
                    popt = dadi.Inference.optimize_log_fmin(
                        p0=p0, data=syn_data, model_func=func_ex, pts=pts_l,
                        lower_bound=None,
                        upper_bound=None,
                        verbose=len(p0), maxiter=25)
                    logger.info(
                        'Finished optimization with guess, ' + str(p0) + '.')
                    logger.info('Best fit parameters: {0}.'.format(popt))
                    # Calculate the best-fit model allele-frequency spectrum.
                    # Note, this spectrum needs to be multiplied by "theta".
                    non_scaled_spectrum = func_ex(popt, syn_ns, pts_l)
                    # Likelihood of the data given the model AFS.
                    multinomial_ll_non_scaled_spectrum = \
                        dadi.Inference.ll_multinom(
                            model=non_scaled_spectrum, data=syn_data)
                    logger.info(
                        'Maximum log composite likelihood: {0}.'.format(
                            multinomial_ll_non_scaled_spectrum))
                    theta = dadi.Inference.optimal_sfs_scaling(
                        non_scaled_spectrum, syn_data)
                    logger.info(
                        'Optimal value of theta: {0}.'.format(theta))
                    if multinomial_ll_non_scaled_spectrum > max_likelihood:
                        best_params = popt
                        best_non_scaled_spectrum = non_scaled_spectrum
                        max_likelihood = multinomial_ll_non_scaled_spectrum
                        theta_syn = theta
                best_scaled_spectrum = theta_syn * best_non_scaled_spectrum
                theta_nonsyn = theta_syn * 2.14
                poisson_ll = dadi.Inference.ll(
                    model=best_scaled_spectrum, data=syn_data)
                f.write('Best fit parameters: {0}.\n'.format(best_params))
                f.write(
                    'Maximum multinomial log composite '
                    'likelihood: {0}.\n'.format(
                        max_likelihood))
                f.write(
                    'Maximum poisson log composite likelihood: {0}.\n'.format(
                        poisson_ll))
                f.write('Non-scaled best-fit model spectrum: {0}.\n'.format(
                    best_non_scaled_spectrum))
                f.write('Optimal value of theta_syn: {0}.\n'.format(theta_syn))
                f.write('Optimal value of theta_nonsyn: {0}.\n'.format(
                    theta_nonsyn))
                f.write('Empirical synonymous sfs: {0}.\n'.format(
                    syn_data))
                f.write('Scaled best-fit model spectrum: {0}.\n'.format(
                    best_scaled_spectrum))
        logger.info('Finished demographic inference.')
        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    DemographicInference().main()
