function f = timeChangeIntegrand(nu,p,e,mu)
% --------------------------------------------------------------%
% Integrand f(nu,p,e,mu) that is used to obtain the time change %
% deltat =t2 - t1 %
% Inputs: %
% nu: true anomaly (rad) %
% p: parameter (semi-latus rectum) %
% e: eccentricity %
% mu: gravitational paramter %
% Output: %
% f: value of function at (nu,p,e,mu) %
% --------------------------------------------------------------%

f = (sqrt(mu*p)*(1+e*cos(nu))^2)/(p^2);

end