function deltat = timeChangeIntegral(f,nu1,nu2,p,e,mu,N)
% --------------------------------------------------------------%
% This function employs Legendre-Gauss quadrature to compute an %
% approximation to                                              %
%                             /nu2                              %
%                            /                                  %
%                           |                                   %
%        deltat = t2 - t1 = | f(nu,p,e,mu)dnu                   %
%                           |                                   %
%                           /                                   %
%                          /nu1                                 %
% where f(nu) is a function that used to define the change in   %
% The inputs and outputs of this function are as follows:       %
% Inputs:                                                       %
% f = a handle to the function to be integrated                 %
% nu1 = lower integration limit                                 %
% = initial true anomaly (rad)                                  %
% nu2 = upper integration limit                                 %
% = terminal true anomaly (rad)                                 %
% p = parameter (semi-latus rectum)                             %
% e = eccentricity                                              %
% mu = gravitational parameter                                  %
% N = number of Gauss points & weights                          %
% used to approximate the integral                              %
% Output:                                                       %
% deltat = Gauss quadrature approximation of                    %
% deltat, where deltat = t2 - t1 is the                         %
% time change from nu1 to nu2                                   %
% --------------------------------------------------------------%

[nus,w] = GaussPointsWeights(nu1,nu2,N);
F = f(nus,p,e,mu);
deltat = w.'*F;

end