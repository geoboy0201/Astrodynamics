clc;clear;close all;

rv0 = [-1217.39430415697,-3091.41210822807,-6173.40732877317];
vv0 = [9.88635815507896,-0.446121737099303,-0.890884522967222];
mu = 398600;
oe = rv2oe_Hackbardt_Chris(rv0,vv0,mu);
a = oe(1);
e = oe(2);
Omega = oe(3);
i = oe(4);
omega = oe(5);
p = oe(1)*(1-e^2);

period = 2*pi*sqrt(a^3/mu);

deltat = 5*60;
initialt=timeChangeIntegral(@timeChangeIntegrand,pi,oe(6),p,e,mu,20);
finalt = (2*period)+initialt;
times = initialt:deltat:finalt;
times = times';

nuValues = computeNu(times,rv0,vv0,mu);
[rvValuesECI,vvValues] = computeRandV(nuValues,a,e,Omega,i,omega,mu);

OmegaE = (2*pi)/((23*3600)+(56*60)+4);

rvValuesECEF = eci2ecef(times,rvValuesECI,OmegaE);
[lonE,lat] = ecef2LonLat(rvValuesECEF);

earthSphere
hold on
plot3(rvValuesECI(:,1),rvValuesECI(:,2),rvValuesECI(:,3))
view(49.5,22.8)

mercatorDisplay(lonE,lat)