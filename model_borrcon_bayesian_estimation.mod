var b c lb y b_obs c_obs y_obs;
varexo u;

parameters RHO, BETA, M, R, GAMMAC;

R = 1.05;
BETA = 0.945;
RHO = 0.9;
M = 1;
GAMMAC = 1;

model;
c = y + b - R*b(-1);
b =  M*y;
lb = 1/c^GAMMAC - BETA*R/c(+1)^GAMMAC;
log(y) = RHO*log(y(-1)) + u;

b_obs = b;
c_obs = c;
y_obs = y;
end;

steady_state_model;
b=M;
c=1+M-R*M;
lb=(1-BETA*R)/(c^GAMMAC);
y=1;
c_obs = c;
b_obs = b;
y_obs = y;
end;

steady;
check;

estimated_params;
R, gamma_pdf, 1.03, 0.05;
RHO, beta_pdf, 0.85, 0.1;
M, inv_gamma_pdf, 3, 100;
//M, uniform_pdf, , , 0, 100;
//M, uniform_pdf, 0, 100;
stderr u, inv_gamma_pdf, 0.1, inf;
stderr b_obs, inv_gamma_pdf, 0.05, 0.5;
stderr c_obs, inv_gamma_pdf, 0.05, 0.5;
end;

varobs b_obs c_obs y_obs;

options_.TeX=1;
estimation(order=1, datafile='param_borrcon.mat', mh_replic=3000, mh_nblocks=2, mh_jscale=0.8, smoother, bayesian_irf);
collect_latex_files;

// smoother
// generate_trace_plots(1);
// mh_autocorrelation_function(options_,M_,estim_params_,'StructuralShock',1,'u');
// raftery_lewis_diagnostics
