function [dv1,dv2,dv3,posT,time] = biEllipticWithPlaneChange(oei,oef,S,f,mu)
%This function calculates the 3 impulses needed to complete a bi-elliptic orbit transfer

%Input: oei, vector containing the orbital elements of the initial orbit
%Input: oef, vector containing the orbital elements of the final orbit
%Input: S, the ratio ri/rf. The ratio of apoapsis of transfer orbit to radius of final orbit
%Input: f, fraction of orbit crank performed at first impulse
%Input: mu, gravitaional constant

%Output: dv1, magnitude of impulse one
%Output: dv2, magnitude of impulse two
%Output: dv3, magnitude of impulse three
%Output: posT, matrix containing position of transfer orbit
%Output: time, vector containing times associated with postitions in posT
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

tauT2=2*pi*sqrt(oet2(1)^3/mu);
timeT2=0:60:tauT2/2;
for i=1:length(timeT2)
    [r,v] = propagateKepler_Hackbardt_Chris(posdV2,vel1T2,0,timeT2(i),mu);
    posT2(i,:)=r';
    velT2(i,:)=v';
end
posT=[posT1;posT2];
timeT2=timeT2+timeT1(end);
vellastT2=velT2(end,:);

%Finds the delta vs
dv1=norm(vel1T1-veldV1b4);
dv2=norm(vel1T2-vellastT1);
dv3=norm(veldV3after-vellastT2');
time=[timeT1';timeT2'];


end