clc;clear;close all;
%Defines givens
mu=398600;
r1=300+6378.145;
i1=28.5;
i1=deg2rad(i1);
e1=0;
Omega1=0;
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

%calculates the first impulse (not changing i)
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

%calculates pos of transfer orbit (not chnging i)
nuT=0:0.001:pi;
oeT=rv2oe_Hackbardt_Chris(position1T,V1aft,mu);
positionT=zeros(length(nuT),3);
velocityT=zeros(length(nuT),3);
for i=1:length(nuT)
    oeT(6)=nuT(i);
    [r,v]=oe2rv_Hackbardt_Chris(oeT,mu);
    positionT(i,:)=r';
    velocityT(i,:)=v';
end

%calculates second impulse (part of first transfer orbit)
v2bf=sqrt(((2*mu)/r2)-(mu/aT));
V2b4=-v2bf*u1vec;
u2vec=-cross(hvec2,lvec)/norm(hvec2);
V2aft=v2*u2vec;
deltaV2=v2-v2bf;
deltaV2vec=V2aft-V2b4;

%Calculates first impulse (changes i)
oeT2=oeT;
oeT2(4)=i2;
oeT2(6)=0;
[r,v]=oe2rv_Hackbardt_Chris(oeT2,mu);
position1T2=r';
velocity1T2=v';
V1T2aft=velocity1T2;
deltaV1T2vec=V1T2aft-V1b4;
deltaV1T2=norm(deltaV1T2vec);
oeT2(5)=pi;

positionT2=zeros(length(nuT),3);
velocityT2=zeros(length(nuT),3);
nuT2=0:0.001:pi;
for j=1:length(nuT2)
    oeT2(6)=nuT2(j);
    [r,v]=oe2rv_Hackbardt_Chris(oeT2,mu);
    positionT2(j,:)=r';
    velocityT2(j,:)=v';
end

%Calculates second impules raises orbit
V2T2b4=velocityT2(end,:);
V2T2aft=v2*u2vec;
deltaV2T2vec=V2T2aft-V2T2b4;
deltaV2T2=norm(deltaV2T2vec);

percentInc=0:0.01:1;
deltaInc=(i2-i1);
deltaVs=zeros(1,length(percentInc));
for i=1:length(percentInc)
    %Calculates first impulse (changes i)
    oeT3=oeT;
    oeT3(4)=i1+(percentInc(i)*deltaInc);
    oeT3(6)=0;
    [r,v]=oe2rv_Hackbardt_Chris(oeT3,mu);
    position1T3=r';
    velocity1T3=v';
    V1T3aft=velocity1T3;
    deltaV1T3vec=V1T3aft-V1b4;
    deltaV1T3=norm(deltaV1T3vec);
    oeT3(5)=pi;
    oeT3(6)=pi;

    %Calculates second impules raises orbit and finishes inclination change
    [r,v]=oe2rv_Hackbardt_Chris(oeT3,mu);
    positionendT3=r';
    velocityendT3=v';
    V2T3b4=velocityendT3;
    V2T3aft=v2*u2vec;
    deltaV2T3vec=V2T3aft-V2T3b4;
    deltaV2T3=norm(deltaV2T3vec);
    
    deltaVs(i)=deltaV1T3+deltaV2T3;
end
deltaVs=deltaVs/v1;
figure(1)
plot(percentInc,deltaVs)

%plots
figure(2)
hold on
scale=10;
plot3(position1T(1),position1T(2),position1T(3),'r*')
plot3(positionT(end,1),positionT(end,2),positionT(end,3),'r*')
plot3(position1(:,1),position1(:,2),position1(:,3),position2(:,1),position2(:,2),position2(:,3))
plot3(positionT(:,1),positionT(:,2),positionT(:,3),positionT2(:,1),positionT2(:,2),positionT2(:,3))
quiver3(position1T(1),position1T(2),position1T(3),deltaV1vec(1),deltaV1vec(2),deltaV1vec(3),5000)
quiver3(positionT(end,1),positionT(end,2),positionT(end,3),deltaV2vec(1),deltaV2vec(2),deltaV2vec(3),5000)
quiver3(position1T2(1),position1T2(2),position1T2(3),deltaV1T2vec(1),deltaV1T2vec(2),deltaV1T2vec(3),5000)
quiver3(positionT2(end,1),positionT2(end,2),positionT2(end,3),deltaV2T2vec(1),deltaV2T2vec(2),deltaV2T2vec(3),5000)
axis([-50000 50000 -50000 50000 -50000 50000])
title('View of the transfer between two circular orbits')
subtitle('Delta Vs not to scale')
view(-259.6770,16.8)

%Prints results
DeltaLet=char(916);
subScr1=char(8321);
subScr2=char(8322);
fprintf(2,'For a transfer with inclination change occuring at apoapsis of transfer orbit\n')
fprintf(['The magnitude of ' DeltaLet 'V' subScr1 ' = %g km/s\n'],deltaV1)
fprintf(['The magnitude of ' DeltaLet 'V' subScr2 ' = %g km/s\n'],deltaV2)
fprintf(['The total ' DeltaLet 'V required is %g km/s\n'],deltaV1+deltaV2)
fprintf(2,'For a transfer with inclination change occuring at periapsis of transfer orbit\n')
fprintf(['The magnitude of ' DeltaLet 'V' subScr1 ' = %g km/s\n'],deltaV1T2)
fprintf(['The magnitude of ' DeltaLet 'V' subScr2 ' = %g km/s\n'],deltaV2T2)
fprintf(['The total ' DeltaLet 'V required is %g km/s\n'],deltaV1T2+deltaV2T2)