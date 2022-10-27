function [rvValues,vvValues] = computeRandV(nuValues,a,e,Omega,inc,omega,mu)
% --------------------------------------------------------------%
% ----------------------- COMPUTERANDV.M -----------------------%
% --------------------------------------------------------------%
% Compute the values of the R and V for the calculated values of 
% true anomaly. 
% Inputs:
% nuValues: column matrix of values of true anomaly 
% a: semi-major axis 
% e: eccentricity 
% Omega: longitude of the ascending node 
% inc: orbital inclination 
% omega: argument of the periapsis 
% mu: gravitational parameter of planet 
% Outputs: 
% rvValues: column matrix of values of position, 
% where each row in the matrix RVVALUES is 
% expressed in planet-centered inertial Cartesian 
% coordinates 
% vvValues: column matrix of values of inertial velocity, 
% where each row in the matrix VVVALUES is 
% expressed in planet-centered inertial Cartesian 
% coordinates 
% --------------------------------------------------------------
% NOTE: the number of ROWS in RVVALUES and VVVALUES should be 
% the same as the number of ROWS in NUVALUES 
% --------------------------------------------------------------
rvValues = zeros(length(nuValues),3);
vvValues = zeros(length(nuValues),3);

for i=1:length(nuValues)
    oe = [a,e,Omega,inc,omega,nuValues(i)];
    [rvec,vvec]  = oe2rv_Hackbardt_Chris(oe,mu);
    for j=1:3
    rvValues(i,j)=rvec(j);
    vvValues(i,j)=vvec(j);
    end
    
end

end