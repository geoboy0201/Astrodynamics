function [e, ap, vp] = radiusSpeedTrueAnomaly(r,v,nu,mu)
    %This function takes radius, speed, and true anomaly as inputs and calculates periapsis altitude, periapsis speed, and eccentricity
    %Function call: [e, ap, vp] = radiusSpeedTrueAnomaly(r,v,nu,mu)
    %
    %Input: r, radius
    %Input: v, speed
    %Input: nu, true anomaly
    %
    %Output: e, eccentricity
    %Output: ap, periapsis altitude
    %Output: vp, periapsis speed
    
    a = ((((v/sqrt(mu))^2)-(2/r))^-1)*-1;
    
    eccen = @(e) a*e^2+r*e*cos(nu)-a+r;
    e = fzero(eccen,1);
    ap = 0;
    vp = 0;
end