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

hvecm = cell(0,length(nu));
evecm = cell(0,length(nu));
nvecm = cell(0,length(nu));

for i=1:length(nu)
    oe = [a; e; Omega; i; omega; nu(i)];
    [rvec,vvec]  = oe2rv_Hackbardt_Chris(oe,mu);
    hvec = cross(rvec,vvec);
    r = norm(rvec);
    hvecm{i} = hvec;
    evecm{i} = ((cross(vvec,hvec))/mu)-(rvec/r);
    nvec = cross(Iz,hvec);
    nvecm{i} = nvec;
end

plot(nu,hvecm)