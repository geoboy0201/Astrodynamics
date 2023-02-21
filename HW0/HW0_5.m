%% Defines the initial conditions and variables needed
clc;clear;close all;
mu = 1;
options = odeset('RelTol',1e-10);
e = [0 1/4 1/2 3/4];
conditions = [1 0 0];
j=1;
%% Loops through all values of e. Calculates the new vtheta0 each time. Solves the ODE and stores the results in a cell array
for i=1:length(e)
    r0 = conditions(1);
    theta0=conditions(2);
    vr0=conditions(3);
    eval = e(i);
    pval=r0*(1+eval);
    ra = pval/(1-eval);
    a = (r0+ra)/2;
    vtheta0= sqrt(mu*pval)/r0;
    trange=[0 2*pi*sqrt(a^3/mu)];
    p0 = [r0 theta0 vr0 vtheta0];
    [t p] = ode113(@twoBody,trange,p0,options,mu);
    z{j}=p(:,1);
    z{j+1}=p(:,2);
    j=j+2;
end
%% Plots theta vs r and adds labels
polarplot(z{2},z{1},z{4},z{3},z{6},z{5},z{8},z{7})
legend('e=0','e=0.25','e=0.5','e=0.75')
polaraxis = gca;
polaraxis.ThetaAxisUnits = 'radians';
title('Theta vs r at Different Eccentricities')
%% the function which defines the ODE
function pdot = twoBody(t,p,mu)
    r = p(1);
    theta = p(2);
    vr = p(3);
    vtheta = p(4);
    rdot = vr;
    thetadot = vtheta/r;
    vrdot = (vtheta^2)/r-mu/(r^2);
    vthetadot = -vr*vtheta/r;
    pdot=zeros(size(p));
    pdot(1)=rdot;
    pdot(2)=thetadot;
    pdot(3)=vrdot;
    pdot(4)=vthetadot;
end