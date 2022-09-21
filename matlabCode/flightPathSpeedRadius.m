function [nu, e, energy, p, h, rp, ra] = flightPathSpeedRadius(v,r,gamma,mu)
    %This functions calculates true anomaly, eccentricity, and total energy given speed, flight path angle, and radius
    %Function call: [nu e energy p h rp ra] = flightPathSpeedRadius(v,r,gamma,mu)
    %
    %Input: v, speed
    %Input: r, radius
    %Input: gamma, flight path angle
    %Input: mu, gravitational parameter
    %
    %Output: nu, true anomaly
    %Output: e, eccentricity
    %Output: energy, total mechanical energy
    %Output: p, semi-latus rectum
    %Output: h, magnitude of the specific angular momentum
    %Output: rp, periapsis radius
    %Output: ra, apoapsis radius
    
    a = ((((v/sqrt(mu))^2)-(2/r))^-1)*-1;
    h = r*v*cos(gamma);
    p = (h^2)/mu;
    e=sqrt(1-(p/a));
    nu = acos((p/(r*e))-(1/e));
    energy = -(mu)/(2*a);
    rp = p/(1+e);
    ra = p/(1-e);
end