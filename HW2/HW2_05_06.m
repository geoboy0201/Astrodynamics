clc;clear;

rvec = [0.7;0.6;0.3];
vvec = [-0.8;0.8;0];
mu = 1;

oe = rv2oe_Hackbardt_Chris(rvec,vvec,mu);
a = oe(1);
e = oe(2);
Omega = oe(3);
i = oe(4);
omega = oe(5);
nu = oe(6);

tau = (2*pi)*sqrt(a^3/mu);
hvec = cross(rvec,vvec);
h = norm(hvec);
p = h^2/mu;
energy = -mu/(2*a);

calculatedOE = [a; e; Omega; i; omega; nu];
[calculatedRvec,calculatedVvec]  = oe2rv_Hackbardt_Chris(calculatedOE,mu);

fprintf('Semi-Major Axis (a) [AU]: \t\t\t\t\t\t %16.8f\n',a);
fprintf('Eccentricity (e) [AU]: \t\t\t\t\t\t\t %16.8f\n',e);
fprintf('Longitude of the Ascending Node (Omega) [rad]:   %16.8f\n',Omega);
fprintf('Orbital Inclination (i) [rad]: \t\t\t\t\t %16.8f\n',i);
fprintf('Argument of the Periapsis (omega) [rad]:  \t\t %16.8f\n',omega);
fprintf('True Anomaly (nu) [rad]: \t\t\t\t\t\t %16.8f\n\n',nu);

fprintf(2,'Orbital Period []: \t\t\t\t\t\t\t\t %16.8f\n\n',tau);

fprintf('Semi-Latus Rectum (p) [AU]: \t\t\t\t\t %16.8f\n\n',p);

fprintf('X Component Angular Momentum Vector [kg m^2/s]:  %16.8f\n',hvec(1));
fprintf('Y Component Angular Momentum Vector [kg m^2/s]:  %16.8f\n',hvec(2));
fprintf('Z Component Angular Momentum Vector [kg m^2/s]:  %16.8f\n\n',hvec(3));
fprintf('Magnitude of Angular Momentum [kg m^2/s]: \t\t %16.8f\n\n',h);

fprintf('Orbital Energy  [kg km^2 s^-2]: \t\t\t\t %16.8f\n\n',energy);

fprintf('Using the calculated orbital elements to recalculate the position and velocity vectors:\n');
fprintf('X Component Position [AU]:  %16.8f\n',calculatedRvec(1));
fprintf('Y Component Position [AU]:  %16.8f\n',calculatedRvec(2));
fprintf('Z Component Position [AU]:  %16.8f\n\n',calculatedRvec(3));

fprintf('X Component Velocity [AU/TU]:  %16.8f\n',calculatedVvec(1));
fprintf('Y Component Velocity [AU/TU]:  %16.8f\n',calculatedVvec(2));
fprintf('Z Component Velocity [AU/TU]:  %16.8f\n\n',calculatedVvec(3));