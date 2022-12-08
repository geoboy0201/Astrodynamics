clc;clear;
mu=398600;
N=4;
r1=500+6378.145;
i1=28.5;
Omega1=60;

r2=20200+6378.145;
i2=57;
Omega2=120;

i1=deg2rad(i1);
i2=deg2rad(i2);
Omega1=deg2rad(Omega1);
Omega2=deg2rad(Omega2);

[posT,timeT,dVP,dVA,totDV]=twoNImpulseOrbitTransfer(r1,r2,i1,i2,Omega1,Omega2,N,mu);
