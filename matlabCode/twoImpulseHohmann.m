function [posT,timeT,dV1,dV2]=twoImpulseHohmann(r1,r2,i1,i2,Omega1,Omega2,mu)

%This function calculates the two impulses needed to complete a Hohmann
%transfer

%Input: r1, radius of orbit 1
%Input: r2, radius of orbit 2
%Input: i1, inclination of orbit 1
%Input: i2, inclination of orbit 2
%Input: Omega1, longitude of ascending node of orbit 1
%Input: Omega1, longitude of ascending node of orbit 1
%Input: mu, gravitaional parameter

%Output: posT, 500x3 matrix containing postions along the transfer orbit
%Output: timeT, column matrix of times associated with positions in posT
%Output: dV1, impulse at periapsis of transfer
%Output: dV2, impulse at apoapsis of transfer

nu=0:0.001:2*pi;
e=0;
omega=0;
oe1=[r1,e,Omega1,i1,omega,0];
oe2=[r2,e,Omega2,i2,omega,0];
position1=zeros(length(nu),3);
velocity1=zeros(length(nu),3);
position2=zeros(length(nu),3);
velocity2=zeros(length(nu),3);
for i=1:length(nu)
    oe1(6)=nu(i);
    oe2(6)=nu(i);
    [r,v]=oe2rv_Hackbardt_Chris(oe1,mu);
    position1(i,:)=r';
    velocity1(i,:)=v';
    [r,v]=oe2rv_Hackbardt_Chris(oe2,mu);
    position2(i,:)=r';
    velocity2(i,:)=v';
end

v1=sqrt(mu/r1);
v2=sqrt(mu/r2);
hvec1=cross(position1(1,:),velocity1(1,:));
hvec2=cross(position2(1,:),velocity2(1,:));
lvec=cross(hvec1,hvec2);
lvec=lvec/norm(lvec);
position1T=r1*lvec;
aT=(r1+r2)/2;
eT=(r2-r1)/(r2+r1);
deltaV1=sqrt(((2*mu)/r1)-(mu/aT))-v1;
u1vec=cross(hvec1,lvec)/norm(hvec1);
V1b4=v1*u1vec;
dV1=deltaV1*u1vec;
V1aft=V1b4+dV1;

tauT=2*pi*sqrt(aT^3/mu);
timeT=linspace(0,tauT/2,500);   
posT=zeros(length(timeT),3);
for i=1:length(timeT)
    [r] = propagateKepler_Hackbardt_Chris(position1T,V1aft,0,timeT(i),mu);
    posT(i,:)=r';
end

v2bf=sqrt(((2*mu)/r2)-(mu/aT));
V2b4=-v2bf*u1vec;
u2vec=-cross(hvec2,lvec)/norm(hvec2);
V2aft=v2*u2vec;
dV2=V2aft-V2b4;
deltaV2=norm(dV2);

end