clc;clear;

a = 1.6;
e = 0.4;
Omega = 287;
i = 46;
omega = 28;
nu = 139;
mu = 1;

Omega = deg2rad(Omega);
i = deg2rad(i);
omega = deg2rad(omega);
nu = deg2rad(nu);

oe = [a; e; Omega; i; omega; nu];

[rvec,vvec]  = oe2rv_Hackbardt_Chris(oe,mu);

fprintf('X Component Position:  %16.8f\n',rvec(1));
fprintf('Y Component Position:  %16.8f\n',rvec(2));
fprintf('Z Component Position:  %16.8f\n\n',rvec(3));

fprintf('X Component Velocity:  %16.8f\n',vvec(1));
fprintf('Y Component Velocity:  %16.8f\n',vvec(2));
fprintf('Z Component Velocity:  %16.8f\n\n',vvec(3));