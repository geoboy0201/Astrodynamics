function [t,p]=twoBodyOdeSolver(pos,vel,t0,tf,mu)

options = odeset('RelTol',1e-8);
po=[pos,vel];
trange=[t0,tf];
[t,p] = ode113(@twoBodyOde,trange,po,options,mu);
end