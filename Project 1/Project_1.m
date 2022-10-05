clc;clear;close all;

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

nvec = cross([0,0,1],hvec);
argPeriapsis = atan2(dot(evec,cross(hvec,nvec)),h*dot(evec,nvec));
if argPeriapsis<0
    argPeriapsis = argPeriapsis + (2*pi);
end
nuAscendingNode = (2*pi)-argPeriapsis;
nuDescendingNode = nuAscendingNode + pi;

N = [10,15,20,25];
nu1 = nuAscendingNode;
nu2 = nuDescendingNode;

for i=1:length(N)
    deltat(i) = timeChangeIntegral(@timeChangeIntegrand,nu1,nu2,p,e,mu,N);
end

nu = 0:0.1:2*pi;
earth(length(nu))=Re;
earth(:)=Re;
orbitEquation = p./(1+e*cos(nu));
polarplot(nu,orbitEquation,'r')
hold on
polarplot(nu,earth,'b')