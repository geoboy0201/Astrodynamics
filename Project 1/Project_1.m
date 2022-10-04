clc;clear;

rvec = [5634.297397, -2522.807863, -5037.930889];
vvec = [8.286176, 1.815144, 3.624759];
mu = 398600;
Re = 6378.145;

hvec = cross(rvec,vvec);
h = norm(hvec);
p = h^2/mu;
r = norm(rvec);
evec = (cross(vvec,hvec)/mu)-(rvec/r);
e = norm(evec);
a = p/(1-e^2);
tau = 2*pi*sqrt(a^3/mu);
period = tau/3600;




po = [rvec, vvec];
trange = [0, period*3600];
options = odeset('RelTol',1e-8);

[t,p] = ode113(@twoBodyOde,trange,po,options,mu);
figure
plot3(p(:,1),p(:,2),p(:,3),'r')
hold on
c=[0,0];
pos = [c-Re,2*Re,2*Re];
rectangle('Position',pos,'Curvature',[1 1])
hold on
xlabel('X')
ylabel('Y')
zlabel('Z')

% Function which defines the ODE
function pdot = twoBodyOde(t,p,mu)
    pos = p(1:3);
    vel = p(4:6);
    rad = norm(pos,2);
    posdot = vel;
    veldot = -mu/(rad^3)*pos;
    pdot = [posdot; veldot];
end