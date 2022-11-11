function [r,v,E,nu] = propagateKepler_Hackbardt_Chris(r0,v0,t0,t,mu)
%This function finds the position and velocity in an orbit at final time, t
%
%Input: r0, a column vector with the initial position
%Input: v0, a column vector with the initial velocity
%Input: t0, the initial time in seconds
%Input: t, the final time in seconds
%Input: mu, gravitational parameter
%
%Output: r, a column vector with the position
%Output: v, a column vector with the velocity
%Output: E, eccentric anamoly
%Output: nu, true anamoly

oe = rv2oe_Hackbardt_Chris(r0,v0,mu);
a = oe(1);
e = oe(2);
nu0 = oe(6);
E0 = 2*atan2(sqrt(1-e)*sin(nu0/2),sqrt(1+e)*cos(nu0/2));
tau=2*pi*sqrt(a^3/mu);
k=floor((t)/tau);
E = KeplerSolver_Hackbardt_Chris(a,e,mu,t0,t,E0,k);
nu= 2*atan2(sqrt(1+e)*sin(E/2),sqrt(1-e)*cos(E/2));
oe(6)=nu;
[r,v]  = oe2rv_Hackbardt_Chris(oe,mu);
end