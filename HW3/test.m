clc;clear;
r0=[-148893;-48542;-12314];
v0=[-1965;-1204;-492];
r0=r0*1.609;
v0=v0/2237;
mu=398600;
%oe=rv2oe_Hackbardt_Chris(r0,v0,mu);
t0=0;
times=t0:600:1000000;
RandV=[];
for i=1:length(times)
            t=times(i);
            [r,v] = propagateKepler_Hackbardt_Chris(r0,v0,t0,t,mu);
            RandV=[RandV;r',v'];
end
%moon
nu0=0;
nu=linspace(0,2*pi);
oe=[384748,0.0549006,deg2rad(125.08),deg2rad(5.15),deg2rad(318.15),nu0];
randv=[];
for i=1:length(nu)
    oe=[384748,0.0549006,deg2rad(125.08),deg2rad(5.15),deg2rad(318.15),nu(i)];
    [r,v]=oe2rv_Hackbardt_Chris(oe,mu);
    randv=[randv;r',v'];
end
hold on
plot3(RandV(:,1),RandV(:,2),RandV(:,3),randv(:,1),randv(:,2),randv(:,3),'r')
earthSphere