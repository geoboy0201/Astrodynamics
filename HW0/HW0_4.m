%% Defines variables and initial conditions
clc;clear;close all;
mu = 398600;
trange = [0 38032];
xconditions = [6997.56; -34108; 20765.49];
vconditions = [0.1559; 0.25517; 1.80763];
po = [xconditions vconditions];
options = odeset('RelTol',1e-8);

%% Solves and plots the solution to the ODE, Includes velocity vectors and point at t = 0
[t p] = ode113(@twoBodyOde,trange,po,options,mu);
figure
plot3(p(:,1),p(:,2),p(:,3),'b')
hold on
plot3(p(1,1),p(1,2),p(1,3),'.k','MarkerSize',20)
hold on
quiver3(p(1:3:153,1),p(1:3:153,2),p(1:3:153,3),p(1:3:153,4),p(1:3:153,5),p(1:3:153,6),4,'r')
xlabel('X')
ylabel('Y')
zlabel('Z')

%% Function which defines the ODE
function pdot = twoBodyOde(t,p,mu)
    pos = p(1:3);
    vel = p(4:6);
    rad = norm(pos,2);
    posdot = vel;
    veldot = -mu/(rad^3)*pos;
    pdot = [posdot; veldot];
end