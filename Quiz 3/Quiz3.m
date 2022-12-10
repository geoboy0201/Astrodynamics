clc;clear;
mu=398600;
r1=350+6378.145;
i1=deg2rad(28);
Omega1=deg2rad(60);
oei=[r1,0,Omega1,i1,0,0];

r2=20200+6378.145;
i2=deg2rad(57);
Omega2=deg2rad(120);
oef=[r2,0,Omega2,i2,0,0];

[pos1,v1]  = oe2rv_Hackbardt_Chris(oei,mu);
tau1=2*pi*sqrt(r1^3/mu);
[times1, pos1, vel1] = propagateOnCircle(pos1,v1,0,tau1,mu,500);

[pos2,v2]  = oe2rv_Hackbardt_Chris(oef,mu);
tau2=2*pi*sqrt(r2^3/mu);
[times2, pos2, vel2] = propagateOnCircle(pos2,v2,0,tau2,mu,500);

S=2;
f=0.5;
[dv1,dv2,dv3,posT,time]=biEllipticWithPlaneChange(oei,oef,S,f,mu);
hold on
earthSphere
plot3(posT(:,1),posT(:,2),posT(:,3),'.')
plot3(pos1(:,1),pos1(:,2),pos1(:,3),'.')
plot3(pos2(:,1),pos2(:,2),pos2(:,3),'.')