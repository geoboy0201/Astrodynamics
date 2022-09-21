function [hVec, eVec, hDote, p, a, nu] = positionVelocity(rVec, vVec, mu)
    %This function takes postion and velocity vectors as inputs and calculates orbital quantities
    %Function call: [hVec, eVec, hDote, p, a, nu] = positionVelocity(rVec, vVec, mu)
    %
    %Input: rVec, postion vector
    %Input: vVec, velocity vector
    %Input: mu, gravitational parameter
    %
    %Output: hVec, specific angular momentum vector
    %Output: eVec, eccentricity vector
    %Output: hDote, dot product of specific angular momentum vector and eccentricity vector
    %Output: p, semi-latus rectum
    %Output: a, semi-major axis
    %Output: nu, true anomaly
    
    hVec = cross(rVec,vVec);
    r = norm(rVec);
    eVec = (cross(vVec,hVec)/mu)-(rVec/r);
    hDote = dot(hVec,eVec);
    h = norm(hVec);
    p = h^2/mu;
    e = norm(eVec);
    a = abs(p/(1-e^2));
    nu = acos((p/(r*e))-(1/e));
end