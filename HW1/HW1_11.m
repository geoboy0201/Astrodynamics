clc;clear;
givenEnergy = -2*10^8; %ft^2/s
e = 0.2;
mu = 398600;
energy = givenEnergy / 10763910.41671; %ft^2/s^2 to km^2/s^2
[h, p, a, rp, ra]=energyEccentricity(energy,e,mu);
fprintf('h = %g m^2/s\n',h);
fprintf('p = %g km\n',p);
fprintf('a = %g km\n',rp);
fprintf('rp = %g km\n',rp);
fprintf('ra = %g km\n',ra);