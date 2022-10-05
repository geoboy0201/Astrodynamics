clc;clear;close all;

rvec = [5634.297397, -2522.807863, -5037.930889];
vvec = [8.286176, 1.815144, 3.624759];
mu = 398600;
Re = 6378.145;

hvec = cross(rvec,vvec);
h = norm(hvec);
p = h^2/mu;
r = norm(rvec);
evec = (cross(vvec,hvec)/mu)-(rvec/r);
e = norm(evec);
a = p/(1-e^2);
tau = 2*pi*sqrt(a^3/mu);
period = tau/3600;

nvec = cross([0,0,1],hvec);
argPeriapsis = atan2(dot(evec,cross(hvec,nvec)),h*dot(evec,nvec));
if argPeriapsis<0
    argPeriapsis = argPeriapsis + (2*pi);
end
nuAscendingNode = (2*pi)-argPeriapsis;
nuDescendingNode = nuAscendingNode + pi;

nu1rad = nuAscendingNode;
nu2rad = nuDescendingNode;

N = [10,15,20,25];
nu1deg = rad2deg(nuAscendingNode);
nu2deg = rad2deg(nuDescendingNode);

deltat=zeros(length(N),0);
for i=1:length(N)
    deltat(i) = timeChangeIntegral(@timeChangeIntegrand,nu1deg,nu2deg,p,e,mu,N);
end

nu = 0:0.1:2*pi;
earth(length(nu))=Re;
earth(:)=Re;
orbitEquation = p./(1+e*cos(nu));
polarplot(nu,orbitEquation,'r')
hold on
polarplot(nu1rad,p/(1+e*cos(nu1rad)),'ro',nu2rad,p/(1+e*cos(nu2rad)),'rs')
hold on
polarplot(nu,earth,'b')

fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
fprintf(' Part (a): \n');
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
fprintf('X Component Angular Momentum Vector [kg m^2/s]:%16.8f\n',hvec(1));
fprintf('Y Component Angular Momentum Vector [kg m^2/s]:%16.8f\n',hvec(2));
fprintf('Z Component Angular Momentum Vector [kg m^2/s]:%16.8f\n',hvec(3));
fprintf('----------------------------------------------------------\n');
fprintf('Magnitude of Angular Momentum [kg m^2/s]: \t %16.8f\n',h);
fprintf('----------------------------------------------------------\n');
fprintf(2,'Semi-Latus Rectum (p) [km]: \t\t\t %16.8f\n',p);
fprintf('----------------------------------------------------------\n');
fprintf('Magnitude of Radius at Given Point [km]:%16.8f\n',r);
fprintf('----------------------------------------------------------\n');
fprintf('X Component Eccentricity Vector:\t\t%16.8f\n',evec(1));
fprintf('Y Component Eccentricity Vector:\t\t%16.8f\n',evec(2));
fprintf('Z Component Eccentricity Vector:\t\t%16.8f\n',evec(3));
fprintf('----------------------------------------------------------\n');
fprintf(2,'Eccentricity (e): \t\t\t\t\t %16.8f\n',e);
fprintf('----------------------------------------------------------\n');
fprintf('Semi-Major Axis (a) [km]: \t\t\t %16.8f\n',a);
fprintf('----------------------------------------------------------\n');
fprintf('Orbital Period [seconds]: \t\t\t %16.8f\n',tau);
fprintf('----------------------------------------------------------\n');
fprintf(2,'Orbital Period [hours]: \t\t\t %16.8f\n', period);
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
fprintf(' Part (b): \n');
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
fprintf('True Anomaly of Ascending Node: %g deg\n',nu1deg);
fprintf('----------------------------------------------------------\n');
fprintf('True Anomaly of Descending Node: %g deg\n',nu2deg');
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
fprintf(' Part (c): Time change from nu1=%g deg to nu2=%g deg \n',nu1deg,nu2deg);
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
for i=1:length(N)
    fprintf('Time elapsed (%g,%g) deg [hours] (N=%i):%16.8f\n',nu1deg,nu2deg,N(i),deltat(i));
end
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
fprintf(' Part (d): Time change from nu2=%g deg to nu1=%g deg \n',nu2deg,nu1deg);
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
% for i=1:length(N),
%   fprintf('Time elapsed (%i,%i) deg [hours] (N=%i):%15.8f\n',nu2deg,nu2deg+180,N(i),deltat2(i));
% end
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
fprintf(' Part (e): Please provide a written explanation indicating\n');
fprintf(' anything that is interesting regarding the orbital period\n');
fprintf(' that was computed in part (b) of this question. If more \n');
fprintf(' lines of fprintf statements are needed, simply copy and \n');
fprintf(' paste more fprintf statements to your code and continue \n');
fprintf(' with your explanation. \n');
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
close all;