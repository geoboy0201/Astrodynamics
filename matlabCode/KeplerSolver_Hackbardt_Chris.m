function E = KeplerSolver_Hackbardt_Chris(a,e,mu,t0,t,E0,k)
%This function solves Kepler's equation using fixed point iteration
%
%Input: a, semi-major axis
%Input: e, eccentricity
%Input: mu, gravitational parameter
%Input: t0, the initial time in seconds
%Input: t, the final time in seconds
%Input: E0, initial eccentric anamoly
%Input: k, number of periapsis crossings
%
%Output: E, eccentric anamoly

C=sqrt(mu/a^3)*(t-t0)-(2*pi*k)+(E0-(e*sin(E0)));
f = @(x) e*sin(x)+C;
n=10*ceil(1/(1-e));
guessE=E0-(e*sin(E0));
for i=1:n
    guessE=f(guessE);
end
E=guessE;
end