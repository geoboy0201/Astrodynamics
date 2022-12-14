clc;clear;
r = 403000;
trueAnomaly = 151;
nu = deg2rad(trueAnomaly);
v = 2.25;
mu = 398600;
rb=6378.145;
[e, ap, vp] = radiusSpeedTrueAnomaly(r,v,nu,rb,mu);
fprintf('e = %g\n',e);
fprintf('altitude at periapsis = %g km\n',ap);
fprintf('speed at periapsis = %g km/s\n',vp);