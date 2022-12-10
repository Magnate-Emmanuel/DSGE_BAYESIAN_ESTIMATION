dynare model_borrcon_Occbin

pos_b = strmatch('b',M_.endo_names,'exact');
pos_c = strmatch('c',M_.endo_names,'exact');
pos_lb = strmatch('lb',M_.endo_names,'exact');
pos_y = strmatch('y',M_.endo_names,'exact');

b_obs = oo_.occbin.simul.piecewise(:,pos_b);
c_obs = oo_.occbin.simul.piecewise(:,pos_c);
lb_obs = oo_.occbin.simul.piecewise(:,pos_lb);
y_obs = oo_.occbin.simul.piecewise(:,pos_y);

% Adding errors
% randn('seed',10);
% T = length(b_obs);
% add_errors = 0.05*randn(T,4);
% b_obs = b_obs + add_errors(:,1);
% c_obs = c_obs + add_errors(:,2);
% lb_obs = lb_obs + add_errors(:,3);
% y_obs = y_obs + add_errors(:,4);

save param_borrcon.mat b_obs c_obs lb_obs y_obs