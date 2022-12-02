clc;clear;
%Defines givens
mu=398600;
r1=350+6378.145;
i1=28;
i1=deg2rad(i1);
e1=0;
Omega1=0;
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
i2=55;
i2=deg2rad(i2);
a2=26558;
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

%Calculates theta
theta=acos((dot(hvec1,hvec2)/(norm(hvec1)*norm(hvec2))));
theta=rad2deg(theta);

%plots
hold on
scale=10;
plot3(position1T(1),position1T(2),position1T(3),'r*')
plot3(positionT(end,1),positionT(end,2),positionT(end,3),'r*')
plot3(position1(:,1),position1(:,2),position1(:,3),position2(:,1),position2(:,2),position2(:,3))
plot3(positionT(:,1),positionT(:,2),positionT(:,3))
quiver3(position1T(1),position1T(2),position1T(3),deltaV1vec(1),deltaV1vec(2),deltaV1vec(3),5000)
quiver3(positionT(end,1),positionT(end,2),positionT(end,3),deltaV2vec(1),deltaV2vec(2),deltaV2vec(3),5000)
axis([-30000 30000 -30000 30000 -30000 30000])
title('View of the transfer between two circular orbits')
subtitle('Delta Vs not to scale')
view(62.1,16.85)

%Prints results
DeltaLet=char(916);
subScr1=char(8321);
subScr2=char(8322);
fprintf('The line of intersection is along %g %g %g\n',lvec(1),lvec(2),lvec(3))
fprintf(['The magnitude of ' DeltaLet 'V' subScr1 ' = %g km/s\n'],deltaV1)
fprintf(['The magnitude of ' DeltaLet 'V' subScr2 ' = %g km/s\n'],deltaV2)
fprintf(['The total ' DeltaLet 'V required is %g km/s\n'],deltaV1+deltaV2)
fprintf('The transfer takes %g hours to complete\n',timeForTrans/3600)
fprintf('The location of impulse one is: %g km %g km %g km\n',position1T(1),position1T(2),position1T(3))
fprintf('The location of impulse two is: %g km %g km %g km\n',positionT(end,1),positionT(end,2),positionT(end,3))
fprintf('The eccentricity of the transfer orbit is %g\n',eT)
fprintf('Theta = %g deg',theta)