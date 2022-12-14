clc;clear;
rVec = [0 2 0];
vVec = [(-1/sqrt(3)) (sqrt(2)/sqrt(3)) 0];
mu = 1;
[hVec, eVec, hDote, p, a, nu] = positionVelocity(rVec, vVec, mu);
fprintf('The specific angular momentum vector is: ');
fprintf('%g, %g, %g\n',hVec(1),hVec(2),hVec(3));
fprintf('The eccentricity vector is: ');
fprintf('%g, %g, %g\n',eVec(1),eVec(2),eVec(3));
fprintf('h in I dotted with the eccentricity vector = %g\n',hDote);
fprintf('p = %g km\n',p);
fprintf('a = %g km\n',a);
fprintf('true anomaly = %g rad\n',nu);