function [aa, energy, h, p] = periapsisAltEccentricity(ap,e,rb,mu)
    %This function takes altitude at periapsis and eccentricity to calculate altitude at apoapsis, orbital energy, h, and p
    %Function Call: [aa, energy, h, p] = periapsisAltEccentricity(ap,e,rb,mu)
    %
    %Input: ap, altitude at periapsis
    %Input: e, eccentricity
    %Input: rb, radius of body
    %Input: mu, gravitational parameter
    %
    %Output: aa, apoapsis altitude
    %Output: energy, orbital energy
    %Output: h, magnitude of the specific angular momentum
    %Output: p, semi-latus rectum
    
    rp = ap + rb;
    a = rp/(1-e);
    ra = a*(1+e);
    aa = ra - rb;
    p = a*(1-e^2);
    h = sqrt(mu*p);
    energy = -(mu)/(2*a);
end