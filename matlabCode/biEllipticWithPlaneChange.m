function [dv1,dv2,dv3,posT,time]=biEllipticWithPlaneChange(oei,oef,S,f,mu)
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

r0=oei(1);
rf=oef(1);
ra=S*rf;
v0=sqrt(mu/r0);
vf=sqrt(mu/rf);

at1=(r0+ra)/2;
et1=(ra-r0)/(ra+r0);
Omegat1=f*(oef(3)-oei(3));
it1=f*(oef(4)-oei(4));
oet1=[at1,et1,Omegat1,it1,oei(5),0];

at2=(rf+ra)/2;
et2=(ra-rf)/(ra+rf);
Omegat2=Omegat1;
it2=oef(4);
oet2=[at2,et2,Omegat2,it2,oef(5),0];

nut1=0:0.001:pi;
nut2=pi:0.001:2*pi;

posT=[];
for i=1:length(nut1)
    oet1(6)=nut1(i);
    [r,~] = oe2rv_Hackbardt_Chris(oet1,mu);
    posT1(i,:)=r';
end
for i=1:length(nut2)
    oet2(6)=nut2(i);
    [r,~] = oe2rv_Hackbardt_Chris(oet2,mu);
    posT2(i,:)=r';
end
posT=[posT1;posT2];

dv1=0;
dv2=0;
dv3=0;
time=0;


end