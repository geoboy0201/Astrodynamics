clc;clear;
mu=398600;
r1=300+6378.145;
i1=57;
i1=deg2rad(i1);
e1=0;
Omega1=60;
Omega1=deg2rad(Omega1);
omega=0;
nu=0:0.01:2*pi;
position1=zeros(length(nu),3);
for i=1:length(nu)
    oe1=[r1,e1,Omega1,i1,omega,nu(i)];
    [r,v]=oe2rv_Hackbardt_Chris(oe1,mu);
    position1(i,:)=r';
end

i2=0;
period=23.934*60*60;
a2=(mu*(period/(2*pi))^2)^(1/3);
r2=a2;
e2=0;
Omega2=0;
position2=zeros(length(nu),3);
for i=1:length(nu)
    oe2=[a2,e2,Omega2,i2,omega,nu(i)];
    [r,v]=oe2rv_Hackbardt_Chris(oe2,mu);
    position2(i,:)=r';
end
plot3(position1(:,1),position1(:,2),position1(:,3),position2(:,1),position2(:,2),position2(:,3))