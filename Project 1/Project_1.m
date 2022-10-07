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

nu1deg = rad2deg(nuAscendingNode);
nu2deg = rad2deg(nuDescendingNode);

N = [10,15,20,25];
deltat=zeros(length(N),1);
for i=1:length(N)
    deltat(i) = timeChangeIntegral(@timeChangeIntegrand,nu1rad,nu2rad,p,e,mu,N(i));
end
deltat = deltat/3600;

nu1rad=nu1rad+2*pi;
deltat2 = zeros(length(N),1);
for i=1:length(N)
    [nus,w] = GaussPointsWeights(nu2rad,nu1rad,N(i));
    for j=1:N(i)
        f = (p^2)/(sqrt(mu*p)*(1+e*cos(nus(j)))^2);
        deltat2(i) = deltat2(i) + (f*w(j));
    end
end
deltat2 = deltat2/3600;

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
fprintf(' Part (d): Time change from nu2=%g deg to nu1=%g deg \n',nu2deg,nu2deg+180);
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
for i=1:length(N)
  fprintf('Time elapsed (%g,%g) deg [hours] (N=%i):%15.8f\n',nu2deg,nu2deg+180,N(i),deltat2(i));
end
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
fprintf(' Part (f): \n');
fprintf(' The orbital period is half of the rotational period of   \n');
fprintf(' earth. This means the spacecraft will orbit the earth    \n');
fprintf(' twice everyday. It also means that the spacecraft will   \n');
fprintf(' cross periapsis over the same two points everyday,       \n');
fprintf(' switching back and forth between the two every crossing. \n');
fprintf('----------------------------------------------------------\n');
fprintf('----------------------------------------------------------\n');
close all;