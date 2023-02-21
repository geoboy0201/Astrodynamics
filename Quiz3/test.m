clc;clear;close all;
% posT1=[];
% oe=[100000,0.7,0,pi/4,pi/2,0];
% mu=398600;
% nu=0:0.001:2*pi;
% for i=1:length(nu)
%     oe(6)=nu(i);
%     [r,~] = oe2rv_Hackbardt_Chris(oe,mu);
%     posT1(i,:)=r';
% end
% hold on
% plot3(posT1(:,1),posT1(:,2),posT1(:,3),'.')
% earthSphere

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

%%
[ri,vi] = oe2rv_Hackbardt_Chris(oei,mu);
[rf,vf] = oe2rv_Hackbardt_Chris(oef,mu);
hvec1=cross(ri,vi);
hvec2=cross(rf,vf);
lvec=cross(hvec1,hvec2);
lvec=lvec/norm(lvec);
u1vec=cross(hvec1,lvec)/norm(hvec1);
u2vec=cross(hvec2,lvec)/norm(hvec2);

r0=oei(1);
rf=oef(1);
ra=S*rf;
v0=sqrt(mu/r0);
vf=sqrt(mu/rf);

posdV1=r0*lvec;
veldV1b4=v0*u1vec;
veldV3after=vf*u2vec;

%First Transfer Orbit
%Uses Rodrigues' rotation formula to find vel vector at periapsis of first transfer orbit
at1=(r0+ra)/2;
vpT1=sqrt(mu)*sqrt((2/r0)-(1/at1));
dv1afterDirection=angleBetweenVectors(hvec1,hvec2)*f;
I=eye(3);
K=[0,-lvec(3),lvec(2);lvec(3),0,-lvec(1);-lvec(2),lvec(1),0];
R=I+(sin(dv1afterDirection).*K)+((1-cos(dv1afterDirection)).*K^2);
vel1T1=R*veldV1b4;
vel1T1=(vel1T1/norm(vel1T1))*vpT1;

oet1=rv2oe_Hackbardt_Chris(posdV1,vel1T1,mu);
tauT1=2*pi*sqrt(oet1(1)^3/mu);

timeT1=0:60:tauT1/2;
for i=1:length(timeT1)
    %oet1(6)=nut1(i);
    [r,v] = propagateKepler_Hackbardt_Chris(posdV1,vel1T1,0,timeT1(i),mu);
    posT1(i,:)=r';
    velT1(i,:)=v';
end

%Second Transfer Orbit
%Uses Rodrigues' rotation formula to find vel vector at apoapsis transfer orbit
at2=(rf+ra)/2;
vAT2=sqrt(mu)*sqrt((2/ra)-(1/at2));
hvecT1=cross(posdV1,vel1T1);
dv2afterDirection=-angleBetweenVectors(hvecT1,hvec2);
posdV2=posT1(end,:);
posDV2dir=posdV2/norm(posdV2);
K=[0,-posDV2dir(3),posDV2dir(2);posDV2dir(3),0,-posDV2dir(1);-posDV2dir(2),posDV2dir(1),0];
R=I+(sin(dv2afterDirection).*K)+((1-cos(dv2afterDirection)).*K^2);

vellastT1=velT1(end,:)';
vel1T2dir=R*(vellastT1/norm(vellastT1));
vel1T2=vel1T2dir*vAT2;
oet2=rv2oe_Hackbardt_Chris(posdV2,vel1T2,mu);

nut2=pi:0.001:2*pi;
for i=1:length(nut2)
    oet2(6)=nut2(i);
    [r,v] = oe2rv_Hackbardt_Chris(oet2,mu);
    posT2(i,:)=r';
    velT2(i,:)=v';
end
posT=[posT1;posT2];
vellastT2=velT2(end,:);

%Finds the delta vs
dv1=norm(vel1T1-veldV1b4);
dv2=norm(vel1T2-vellastT1);
dv3=norm(veldV3after-vellastT2');
time=0;
%%
posdV3=posT2(end,:);

hold on
earthSphere
plot3(posT(:,1),posT(:,2),posT(:,3),'.')
plot3(pos1(:,1),pos1(:,2),pos1(:,3),'.')
plot3(pos2(:,1),pos2(:,2),pos2(:,3),'.')
quiver3(posdV1(1),posdV1(2),posdV1(3),dv1(1),dv1(2),dv1(3),10000)
quiver3(posdV2(1),posdV2(2),posdV2(3),dv2(1),dv2(2),dv2(3),10000)
quiver3(posdV3(1),posdV3(2),posdV3(3),dv3(1),dv3(2),dv3(3),10000)
quiver3(posdV3(1),posdV3(2),posdV3(3),veldV3after(1),veldV3after(2),veldV3after(3),10000)
quiver3(posdV3(1),posdV3(2),posdV3(3),vellastT2(1),vellastT2(2),vellastT2(3),10000)