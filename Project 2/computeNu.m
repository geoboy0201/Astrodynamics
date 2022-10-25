function nuValues = computeNu(tValues,rv0,vv0,mu)
% --------------------------------------------------------------%
% ------------------------ COMPUTENU.M -------------------------%
% --------------------------------------------------------------%
% Compute the values of the true anomaly at the times given in 
% the column matrix TVALUES using the initial position given in 
% RV0 and the initial inertial velocity given in VV0. 
% Inputs: 
%   tValues: column matrix of values of time 
%       rv0: initial position expressed in 
%            planet-centered inertial Cartesian coordinates 
%       vv0: initial inertial velocity expressed in 
%            planet-centered inertial Cartesian coordinates 
%       mu: gravitational parameter of planet 
% Output: 
%    nuValues: column matrix of values of true anomaly that is 
%              of the same length as the column matrix TVALUES 
% --------------------------------------------------------------%

oe = rv2oe_Hackbardt_Chris(rv0,vv0,mu);
N = 20;
nuValues = zeros(0,length(tValues));
e = oe(2);
p = oe(1)*(1-e^2);
nuValues(1)=oe(6);

for i=1:length(tValues)-1
    t0 = tValues(i);
    t = tValues(i+1);
    nuValues(i+1) = rootFinder(@timeChangeIntegrand,t0,nu0,t,p,e,mu,N);
end

end