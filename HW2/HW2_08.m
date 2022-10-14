clc;clear;

a = 19133.333;
e = 0.5;
Omega = 30;
i = 45;
omega = 45;
nu = 0;
mu = 398600;

Omega = deg2rad(Omega);
i = deg2rad(i);
omega = deg2rad(omega);
nu = deg2rad(nu);

oe = [a; e; Omega; i; omega; nu];

[rvec,vvec]  = oe2rv_Hackbardt_Chris(oe,mu);

fprintf('X Component Position [km]:  %16.8f\n',rvec(1));
fprintf('Y Component Position [km]:  %16.8f\n',rvec(2));
fprintf('Z Component Position [km]:  %16.8f\n\n',rvec(3));

fprintf('X Component Velocity [km/s]:  %16.8f\n',vvec(1));
fprintf('Y Component Velocity [km/s]:  %16.8f\n',vvec(2));
fprintf('Z Component Velocity [km/s]:  %16.8f\n\n',vvec(3));