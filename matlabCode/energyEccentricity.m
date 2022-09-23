function [h, p, a, rp, ra]=energyEccentricity(energy,e,mu)
    %This function takes orbital energy and eccentricity to calculate h, p, a, rp, ra
    %Function Call: [h, p, a, rp, ra]=energyEccentricity(energy,e,mu)
    %
    %Input: energy, orbital energy
    %Input: e, eccentricity 
    %Input: mu, gravitational parameter
    %
    %Output: h, magnitude of the specific angular momentum
    %Output: p, semi-latus rectum
    %Output: a, semi-major axis
    %Output: rp, periapsis radius
    %Output: ra, apoapsis radius
    
    a = -mu/(2*energy);
    p = a*(1-e^2);
    h = sqrt(mu*p);
    rp = a*(1-e);
    ra = a*(1+e);
end