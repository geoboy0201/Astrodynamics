function oe = rv2oe_Hackbardt_Chris(rPCI,vPCI,mu)

% This function calculates the six orbital elements from the position vector and velocity vector
% Function Call: oe = rv2oe_Hackbardt_Chris(rPCI,vPCI,mu)
%
% Inputs:
%    rPCI:  Cartesian planet-centered inertial (PCI) position (3 by 1)
%    vPCI:  Cartesian planet-centered inertial (PCI) velocity (3 by 1)
%    mu:    gravitational parameter of centrally attacting body
% Outputs:  orbital elements
%    oe(1): semi-major axis
%    oe(2): eccentricity
%    oe(3): longitude of the ascending node (rad)
%    oe(4): inclination (rad)
%    oe(5): argument of the periapsis (rad)
%    oe(6): true anomaly (rad)

rvec = rPCI;
vvec = vPCI;

Ix = [1;0;0];
Iy = [0;1;0];
Iz = [0;0;1];

hvec = cross(rvec,vvec);
h = norm(hvec);
p = h^2/mu;
r = norm(rvec);
evec = ((cross(vvec,hvec))/mu)-(rvec/r);
e = norm(evec);
a = p/(1-e^2);
nvec = cross(Iz,hvec);
n = norm(nvec);
Omega = atan2(dot(nvec,Iy),dot(nvec,Ix));
if Omega < 0
    Omega = Omega + (2*pi);
end
inc = atan2(dot(hvec,cross(nvec,Iz)),n*dot(hvec,Iz));
omega = atan2(dot(evec,cross(hvec,nvec)),h*dot(evec,nvec));
if omega < 0
    omega = omega + (2*pi);
end
nu = atan2(dot(rvec,cross(hvec,evec)),h*dot(rvec,evec));
if nu < 0
    nu = nu + (2*pi);
end

oe = [a; e; Omega; inc; omega; nu];
end