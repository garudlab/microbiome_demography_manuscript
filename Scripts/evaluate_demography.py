""" Evaluate the likelihood of a given set of demographic parameters.

JCM 20230217
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
import pandas as pd

class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class EvaluateDemography():
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
            'model_type', type=str,
            help=('Model specification for which the dmeographic '
                  'parameters should be evaluated.'))
        parser.add_argument(
            '--params_list', type=float, nargs="*", default=[],
            help=('List params in float format.'))
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

    def compute_allele_sum(self, file_path):
        """Return sum of allele counts from input SFS file.
        """
        with open(file_path, 'r') as file:
             lines = file.readlines()
             if len(lines) >= 2:
                 second_line = lines[1].strip()
                 values = list(map(float, second_line.split()))
                 array_sum = sum(values)
                 return array_sum


    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.fitDemographicModelParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        syn_input_sfs = args['syn_input_sfs']
        outprefix = args['outprefix']
        model_type = args['model_type']
        params_list = args['params_list']
        if model_type == 'one_epoch':
            dummy = params_list[0]
        elif model_type == 'two_epoch':
            nu = params_list[0]
            tau = params_list[1]
        else:
            nu_b = params_list[0]
            nu_f = params_list[1]
            tau_b = params_list[2]
            tau_f = params_list[3]
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
        logfile = '{0}{1}evaluate_demography.log'.format(args['outprefix'], underscore)
        output_file = \
            '{0}{1}{2}_demography.txt'.format(
                args['outprefix'], underscore, model_type)
        to_remove = [logfile, output_file]
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
        syn_data = dadi.Spectrum.from_file(syn_input_sfs).fold()
        # syn_data = dadi.Spectrum.from_file(syn_input_sfs)
        #  syn_data = syn_data.fold()
        if mask_singletons:
            syn_data.mask[1] = True
        if mask_doubletons:
            syn_data.mask[2] = True
        syn_ns = syn_data.sample_sizes  # Number of samples.
        pts_l = [1200, 1400, 1600]

        initial_guess = params_list
        if model_type == 'exponential_growth':
            # file = exponential_growth_demography
            func_ex = dadi.Numerics.make_extrap_log_func(self.growth)
            logger.info('Beginning demographic evaluation for exponential '
                        'growth demographic model.')
        elif model_type == 'two_epoch':
            # file = two_epoch_demography
            func_ex = dadi.Numerics.make_extrap_log_func(self.two_epoch)
            logger.info('Beginning demographic evaluation for two-epoch '
                        'demographic model.')
        elif model_type == 'bottleneck_growth':
            # file = bottleneck_growth_demography
            func_ex = dadi.Numerics.make_extrap_log_func(self.bottlegrowth)
            logger.info('Beginning demographic evaluation for bottleneck + '
                        'growth demographic model.')
        elif model_type == 'three_epoch':
            # file = three_epoch_demography
            func_ex = dadi.Numerics.make_extrap_log_func(self.three_epoch)
            logger.info('Beginning demographic evaluation for three-epoch '
                        'demographic model.')
        elif model_type == 'one_epoch':
            initial_guess = [0.1]
            # file = one_epoch_demography
            func_ex = dadi.Numerics.make_extrap_log_func(self.snm)
            logger.info('Beginning demographic evaluation for one-epoch '
                        'demographic model.')

        with open(output_file, 'w') as f:
            # Start at initial guess
            p0 = initial_guess
            logger.info(
                'Beginning optimization with guess, {0}.'.format(p0))
            # popt = dadi.Inference.optimize_log_fmin(
            #    p0=p0, data=syn_data, model_func=func_ex, pts=pts_l,
            #    lower_bound=None,
            #    upper_bound=None,
            #    verbose=len(p0), maxiter=1)
            popt = p0
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
            params = popt
            theta_syn = theta
            scaled_spectrum = theta_syn * non_scaled_spectrum
            logger.info(
                'Synonymous input SFS: {}.'.format(syn_data))
            logger.info(
                'Scaled spectrum: {}.'.format(scaled_spectrum.fold()))
            theta_nonsyn = theta_syn * 2.14
            poisson_ll = dadi.Inference.ll(
                model=scaled_spectrum, data=syn_data)
            f.write('Best fit parameters: {0}.\n'.format(params))
            f.write(
                'Maximum multinomial log composite '
                'likelihood: {0}.\n'.format(
                    multinomial_ll_non_scaled_spectrum))
            f.write(
                'Maximum poisson log composite likelihood: {0}.\n'.format(
                    poisson_ll))
            f.write('Non-scaled best-fit model spectrum: {0}.\n'.format(
                non_scaled_spectrum))
            f.write('Optimal value of theta_syn: {0}.\n'.format(theta_syn))
            f.write('Optimal value of theta_nonsyn: {0}.\n'.format(
                theta_nonsyn))
            f.write('Empirical synonymous sfs: {0}.\n'.format(
                syn_data))
            f.write('Scaled best-fit model spectrum: {0}.\n'.format(
                scaled_spectrum))
            logger.info('Converting and interpreting Tau estimates.')
            allele_sum = self.compute_allele_sum(syn_input_sfs)
            # Don't hard  code in mu as value
            mu_low = 4.08E-10
            mu_high = 6.93E-10
            if model_type == 'one_epoch':
                f.write(
                    'Low estimate for ancestral population size is ' +
                    str(theta / (4 * allele_sum * mu_high)) + '.\n')
                f.write(
                    'High estimate for ancestral population size is ' +
                    str(theta / (4 * allele_sum * mu_low)) + '.\n')
            elif model_type == 'two_epoch':
                generations_low = 2 * tau * theta / (4 * mu_high * allele_sum)
                generations_high = 2 * tau * theta / (4 * mu_low * allele_sum)
                f.write(
                    'Low estimate for years is ' +
                    str(generations_low / 365) + '.\n')
                f.write(
                    'High estimate for years is ' +
                    str(generations_high / 365) + '.\n')
                f.write(
                    'Low estimate for ancestral population size is ' +
                    str(theta / (4 * allele_sum * mu_high)) + '.\n')
                f.write(
                    'High estimate for ancestral population size is ' +
                    str(theta / (4 * allele_sum * mu_low)) + '.\n')
            else:
                # Correct the algebra
                generations_b_low = 2 * tau_b * theta / (4 * mu_high * allele_sum)
                generations_b_high = 2 * tau_b * theta / (4 * mu_low * allele_sum)
                generations_f_low = 2 * tau_f * theta / (4 * mu_high * allele_sum)
                generations_f_high = 2 * tau_f * theta / (4 * mu_low * allele_sum)
                generations_total_low = generations_b_low + generations_f_low
                generations_total_high = generations_b_high + generations_f_high
                f.write(
                    'Low estimate for bottleneck length in years is '  +
                    str(generations_b_low / 365) + '.\n')
                f.write(
                    'High estimate for bottleneck length in years is ' +
                    str(generations_b_high / 365) + '.\n')
                f.write(
                    'Low estimate for time since bottleneck in years is ' +
                    str(generations_f_low / 365) + '.\n')
                f.write(
                    'High estimate for time since bottleneck in years is ' +
                    str(generations_f_high / 365) + '.\n')
                f.write(
                    'Low estimate for total time is ' +
                    str(generations_total_low / 365) + '.\n')
                f.write(
                    'High estimate for total time is ' +
                    str(generations_total_high / 365) + '.\n')
                f.write(
                    'Low estimate for ancestral population size is ' +
                    str(theta / (4 * allele_sum * mu_high)) + '.\n')
                f.write(
                    'High estimate for ancestral population size is ' +
                    str(theta / (4 * allele_sum * mu_low)) + '.\n')
        logger.info('Finished demographic evaluation.')
        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    EvaluateDemography().main()
