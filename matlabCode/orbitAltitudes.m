function [a e p h va vp] = orbitAltitudes(aa,ap,rb,mu)
    %This function calculates properties of a earth orbit with inputs of altitude at apoapsis and periapsis
    %Function call: [a e p h va vp] = orbitAltitudes(aa,ap,rb,mu)
    %
    %Input: aa, altitude at apoapsis
    %Input: ap, altitude at periapsis
    %Input: rb, radius of body
    %Input: mu, gravitational parameter
    %
    %Output: a, semi-major axis
    %Output: e, eccentricity
    %Output: p, semi-latus rectum
    %Output: h, magnitude of the specific angular momentum
    %Output: va, velocity at apoapsis
    %Output: vp, velocity at periapsis
    
    ra = aa+rb;
    rp = ap+rb;
    a = (ra+rp)/2;
    e = (ra-rp)/(ra+rp);
    p = a*(1-e^2);
    h = sqrt(mu*p);
    vp = sqrt(mu)*sqrt((2/rp)-(1/a));
    va = sqrt(mu)*sqrt((2/ra)-(1/a));
end