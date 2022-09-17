function [nu e energy] = flightPathSpeedRadius(v,r,gamma,mu)
    %This functions calculates true anomaly, eccentricity, and total energy given speed, flight path angle, and radius
    %Function call: [nu e energy] = flightPathSpeedRadius(v,r,gamma,mu)
    %
    %Input: v, speed
    %Input: r, radius
    %Input: gamma, flight path angle
    %Input: mu, gravitational parameter
    %Output: nu, true anomaly
    %Output: e, eccentricity
    %Output: energy, total mechanical energy
    
    a = ((((v/sqrt(mu))^2)-(2/r))^-1)*-1;
    
    trueAnomaly = @(x) ((r*tan(gamma)*cos(x))/(sin(x)-tan(gamma)*cos(x)))+a*((tan(gamma))/(sin(x)-tan(gamma)*cos(x)))^2+(r-a);
    nu = fzero(trueAnomaly,[0.0001 3.14]);
    
    e=(tan(gamma))/(sin(nu)-tan(gamma)*cos(nu));
    
    energy = -(mu)/(2*a);
end