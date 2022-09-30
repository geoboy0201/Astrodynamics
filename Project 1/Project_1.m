clc;clear;
rvec = [5634.297397, -2522.807863, -5037.930889];
vvec = [8.286176, 1.815144, 3.624759];
mu = 398600;
Re = 6378.145;

hvec = cross(rvec,vvec);
h = norm(hvec);
p = h^2/mu;
r = norm(rvec);
evec = (cross(vvec,hvec)/mu)-(rvec/r);
e = norm(evec);
a = p/(1-e^2);
tau = 2*pi*sqrt(a^3/mu);
period = tau/3600;