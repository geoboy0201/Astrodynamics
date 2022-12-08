clc;clear;
mu=398600;
r1=500+6378.145;
i1=28.5;
Omega1=60;

r2=20200+6378.145;
i2=57;
Omega2=120;

i1=deg2rad(i1);
i2=deg2rad(i2);
Omega1=deg2rad(Omega1);
Omega2=deg2rad(Omega2);

[posT,timeT,dV1,dV2]=twoImpulseHohmann(r1,r2,i1,i2,Omega1,Omega2,mu);
[posT2,timeT2,dVP2,dVA2]=twoNImpulseOrbitTransfer(r1,r2,i1,i2,Omega1,Omega2,4,mu);

oe1=[r1,0,Omega1,i1,0,0];
oe2=[r2,0,Omega2,i2,0,0];
[r1v,v1v]=oe2rv_Hackbardt_Chris(oe1,mu);
[r2v,v2v]=oe2rv_Hackbardt_Chris(oe2,mu);
tau1=2*pi*sqrt(r1^3/mu);
tau2=2*pi*sqrt(r2^3/mu);
[times1, positions1, velocities1] = propagateOnCircle(r1v,v1v,0,tau1,mu,500);
[times2, positions2, velocities2] = propagateOnCircle(r2v,v2v,0,tau2,mu,500);

hold on
earthSphere
plot3(posT2(:,1),posT2(:,2),posT2(:,3))
plot3(posT(:,1),posT(:,2),posT(:,3))
plot3(positions1(:,1),positions1(:,2),positions1(:,3))
plot3(positions2(:,1),positions2(:,2),positions2(:,3))
% quiver3(posT(1,1),posT(1,2),posT(1,3),dV1(1),dV1(2),dV1(3),5000)
% quiver3(posT(end,1),posT(end,2),posT(end,3),dV2(1),dV2(2),dV2(3),5000)
% quiver3(positions2(1:20:500,1),positions2(1:20:500,2),positions2(1:20:500,3),velocities2(1:20:500,1),velocities2(1:20:500,2),velocities2(1:20:500,3),10)
% quiver3(positions1(1:20:500,1),positions1(1:20:500,2),positions1(1:20:500,3),velocities1(1:20:500,1),velocities1(1:20:500,2),velocities1(1:20:500,3),10)