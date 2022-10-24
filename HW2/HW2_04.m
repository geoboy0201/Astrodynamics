clc; clear;

a = 15307.548;
e = 0.7;
Omega = 194;
i = 39;
omega = 85;
nu = 0:0.1:(2*pi);
mu = 398600;
Iz = [0;0;1];

Omega = deg2rad(Omega);
i = deg2rad(i);
omega = deg2rad(omega);

hvecm = zeros(0,length(nu));
evecm = zeros(0,length(nu));
nvecm = zeros(0,length(nu));
nvecx = zeros(0,length(nu));
nvecy = zeros(0,length(nu));

for i=1:length(nu)
    oe = [a; e; Omega; i; omega; nu(i)];
    [rvec,vvec]  = oe2rv_Hackbardt_Chris(oe,mu);
    hvec = cross(rvec,vvec);
    r = norm(rvec);
    hvecm(i) = norm(hvec);
    evecm(i) = norm(((cross(vvec,hvec))/mu)-(rvec/r));
    nvec = cross(Iz,hvec);
    nvecm(i) = norm(nvec);
    nvecx(i) = nvec(1);
    nvecy(i) = nvec(2);
end

plot(nu,hvecm,nu,evecm,nu,nvecm)
% plot(0,0,'o')
% hold on
% plot(nvecx,nvecy)