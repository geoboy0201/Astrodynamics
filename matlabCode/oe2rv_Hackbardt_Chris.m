function [rPCI,vPCI]  = oe2rv_Hackbardt_Chris(oe,mu)

% This function calculates the postion and velocity vector with respect to the planet using orbital elements.
% Function Call: [rPCI,vPCI]  = oe2rv_Hackbardt_Chris(oe,mu)
% Input:  Orbital Elements: (6 by 1 column vector)
%   oe(1): Semi-major axis
%   oe(2): Eccentricity
%   oe(3): Longitude of the ascending node (rad)
%   oe(4): Inclination (rad)
%   oe(5): Argument of the periapsis (rad)
%   oe(6): True anomaly (rad)
%   mu:    Planet gravitational parameter     (scalar)
% Outputs:
%   rPCI:  Planet-Centered Inertial (PCI) Cartesian position
%          (3 by 1 column vector)
%   vPCI:  Planet-Centered Inertial (PCI) Cartesian inertial velocity
%          (3 by 1 column vector)

a = oe(1);
e = oe(2);
Omega = oe(3);
i = oe(4);
omega = oe(5);
nu = oe(6);

p = a*(1-e^2);
r = p/(1+(e*cos(nu)));

rvecP = [r*cos(nu);r*sin(nu);0];
vvecP = (sqrt(mu/p))*[-sin(nu);e+cos(nu);0];

T_NI = [cos(Omega),-sin(Omega),0;sin(Omega),cos(Omega),0;0,0,1];
T_QN = [1,0,0;0,cos(i),-sin(i);0,sin(i),cos(i)];
T_PQ = [cos(omega),-sin(omega),0;sin(omega),cos(omega),0;0,0,1];
T_PI = T_NI * T_QN * T_PQ;

rPCI = T_PI * rvecP;
vPCI = T_PI * vvecP;
end
