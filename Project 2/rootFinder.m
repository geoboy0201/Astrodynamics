function nu = rootFinder(f,t0,nu0,t,p,e,mu,N)
% --------------------------------------------------------------%
% ------------------------ ROOTFINDER.M ------------------------%
% --------------------------------------------------------------%
% Find the root of a function of the form 
% G(nu) = F(nu) - (t-t0) = 0 
% where F(nu) is given as 
% 
%                   /nu 
%                  / 
%                  | 
%          F(nu) = | f(q)dq 
%                  | 
%                  / 
%                 /nu0 
% 
% The inputs and outputs of this function are as follows: 
% Inputs: 
% f: integrand of function 
% nu0: true anomaly at current time 
% t0: current time 
% t: terminal time 
% p: semi-latus rectum 
% e: eccentricity 
% mu: gravitational parameter 
% N: number of Legendre-Gauss points 
% Output: 
% nu: true anomaly at time t 
% --------------------------------------------------------------%

deltat = (t-t0);
deltaNu = deg2rad(5);
guessNu = nu0+deltaNu;

for i=1:20
    [theta,w] = GaussPointsWeights(nu0,guessNu,N);
    theta=theta';
    F = f(theta,p,e,mu);
    F = F';
    FofNu = w.'*F;
    
    GofNu = FofNu - deltat;
    Gprime = f(guessNu,p,e,mu);
    
    guessNu = guessNu -(GofNu/Gprime);
end

nu = guessNu;

end