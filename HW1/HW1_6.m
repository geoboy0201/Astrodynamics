clc;clear;
rvec = [-12 -20 15];
rvec = (1/20)*rvec;
mu = 1;
r = norm(rvec);
inertialAccel = -(mu/r^3)*rvec;
fprintf('Inertial Acceleration in I is: ');
fprintf('%g, %g, %g',inertialAccel(1),inertialAccel(2),inertialAccel(3));