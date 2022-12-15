clc;clear;close all;
mu=398600;
S=[2,5,10,20];
f=[0,0.5,1];

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

R=r2/r1;
dVBP=norm(v1)*((sqrt(2)-1)+sqrt(1/R)*(sqrt(2)-1));
dvp=zeros(1,length(f));
dvp(:)=dVBP;

totdV=zeros(length(S),length(f));
for i=1:length(f)
    figure
    hold on
    for j=1:length(S)
        [dv1,dv2,dv3,posT,time]=biEllipticWithPlaneChange(oei,oef,S(j),f(i),mu);
        plot3(posT(:,1),posT(:,2),posT(:,3))
        totdV(j,i)=dv1+dv2+dv3;
    end
    plot3(pos1(:,1),pos1(:,2),pos1(:,3))
    plot3(pos2(:,1),pos2(:,2),pos2(:,3))
    view(-160,55)
end
figure
hold on
plot(f,totdV(1,:),f,totdV(2,:),f,totdV(3,:),f,totdV(4,:),f,dvp)
xlabel('f')
ylabel('dV')
legend('S = 2','S = 5','S = 10','S = 20','Bi-Parabolic','Location','northwest')