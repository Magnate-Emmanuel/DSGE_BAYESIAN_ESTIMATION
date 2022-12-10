var b c lb y;
varexo u;

parameters RHO, BETA, M, R, SIGMA, GAMMAC;

R = 1.05;
BETA = 0.945;
RHO   = 0.9;
SIGMA = 0.05;
M = 1;
GAMMAC = 1;

model;
c = y + b - R*b(-1);

[name='constraint', relax='borrcon']
b =  M*y;
[name='constraint', bind='borrcon']
lb = 0;

lb = 1/c^GAMMAC - BETA*R/c(+1)^GAMMAC;

log(y) = RHO*log(y(-1)) + u;
end;

occbin_constraints;
name 'borrcon'; bind lb<0; relax b>M*y;
end;

steady_state_model;
b=M;
c=1+M-R*M;
ec=c;
lb=(1-BETA*R)/(c^GAMMAC);
y=1;
end;

shocks;
var u; stderr SIGMA;
end;

steady;

randn('seed',1);
shockssequence = randn(500,1)*SIGMA;

shocks(surprise);
var u;
periods 1:500;
values (shockssequence);
end;

occbin_setup;
occbin_solver(simul_periods=500,simul_check_ahead_periods=300);
occbin_graph b c lb y;