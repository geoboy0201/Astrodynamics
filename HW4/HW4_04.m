clc;clear;
%Defines givens
mu=398600;
r1=300+6378.145;
i1=57;
i1=deg2rad(i1);
e1=0;
Omega1=60;
Omega1=deg2rad(Omega1);
omega=0;

%Calculates position of first orbit
nu=0:0.001:2*pi;
position1=zeros(length(nu),3);
velocity1=zeros(length(nu),3);
for i=1:length(nu)
    oe1=[r1,e1,Omega1,i1,omega,nu(i)];
    [r,v]=oe2rv_Hackbardt_Chris(oe1,mu);
    position1(i,:)=r';
    velocity1(i,:)=v';
end

%Calculates pos of second orbit
i2=0;
period=23.934*60*60;
a2=(mu*(period/(2*pi))^2)^(1/3);
r2=a2;
e2=0;
Omega2=0;
position2=zeros(length(nu),3);
velocity2=zeros(length(nu),3);
for i=1:length(nu)
    oe2=[a2,e2,Omega2,i2,omega,nu(i)];
    [r,v]=oe2rv_Hackbardt_Chris(oe2,mu);
    position2(i,:)=r';
    velocity2(i,:)=v';
end

%calculates the first impulse
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
deltaV1vec=deltaV1*u1vec;
V1aft=V1b4+deltaV1vec;

%calculates pos of transfer orbit
nuT=0:0.001:pi;
oeT=rv2oe_Hackbardt_Chris(position1T,V1aft,mu);
positionT=zeros(length(nuT),3);
velocityT=zeros(length(nuT),3);
for i=1:length(nuT)
    oeT(6)=nu(i);
    [r,v]=oe2rv_Hackbardt_Chris(oeT,mu);
    positionT(i,:)=r';
    velocityT(i,:)=v';
end

%calculates second impulse
v2bf=sqrt(((2*mu)/r2)-(mu/aT));
V2b4=-v2bf*u1vec;
u2vec=-cross(hvec2,lvec)/norm(hvec2);
V2aft=v2*u2vec;
deltaV2=v2-v2bf;
deltaV2vec=V2aft-V2b4;

%Calculates time and mass for transfer
tauT=2*pi*sqrt(aT^3/mu);
timeForTrans=tauT/2;
g0=9.80665;
Isp=320;
massRatio1=exp(deltaV1/(g0*Isp));
massRatio2=exp(deltaV2/(g0*Isp));

%plots
hold on
scale=10;
plot3(position1T(1),position1T(2),position1T(3),'r*')
plot3(positionT(end,1),positionT(end,2),positionT(end,3),'r*')
plot3(position1(:,1),position1(:,2),position1(:,3),position2(:,1),position2(:,2),position2(:,3))
plot3(positionT(:,1),positionT(:,2),positionT(:,3))
quiver3(position1T(1),position1T(2),position1T(3),deltaV1vec(1),deltaV1vec(2),deltaV1vec(3),5000)
quiver3(positionT(end,1),positionT(end,2),positionT(end,3),deltaV2vec(1),deltaV2vec(2),deltaV2vec(3),5000)
axis([-50000 50000 -50000 50000 -50000 50000])
title('View of the transfer between two circular orbits')
subtitle('Delta Vs not to scale')
view(-259.6770,16.8)

%Prints results
DeltaLet=char(916);
subScr1=char(8321);
subScr2=char(8322);
fprintf(['The magnitude of ' DeltaLet 'V' subScr1 ' = %g km/s\n'],deltaV1)
fprintf(['The magnitude of ' DeltaLet 'V' subScr2 ' = %g km/s\n'],deltaV2)
fprintf(['The total ' DeltaLet 'V required is %g km/s\n'],deltaV1+deltaV2)
fprintf('The transfer takes %g seconds to complete\n',timeForTrans)
fprintf('The mass ratio for impulse 1 is %g\n',massRatio1)
fprintf('The mass ratio for impulse 2 is %g\n',massRatio2)
fprintf('Changing the longitude of the ascending node does change where the orbit transfer begins\n')
fprintf('since that would rotate the orbit plane about the z-axis.\n')