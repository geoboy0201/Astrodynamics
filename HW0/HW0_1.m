%% Defines all of the variables used in the differential equation
clc;clear;close all;
omegan = 1;
trange = [0 2*pi/omegan];
conditions = [1 0 0 1];
options = odeset('RelTol',1e-8);

%% Loops through both sets of inital conditions and gets a solution and plots it
for i=1:2:length(conditions)
    po = [conditions(i) conditions(i+1)];
    [t p] = ode113(@harmonicOscillator,trange,po,options,omegan);
    x(:,i) = p(:,1);
    x(:,i+1) = p(:,2);
end

%% Creates Plots for part c
figure
plot(t,x(:,1),t,x(:,3))
xlabel('Time')
ylabel('x(t)')
title("x(t) vs t")
legend('x(0) = 1','x(0) = 0')
figure
plot(t,x(:,2),t,x(:,4))
xlabel('Time')
ylabel('v(t)')
title("v(0) vs t")
legend('v(0) = 0','v(0) = 1')

%% Defines analytic solution and its derivative
analytic = @(t,x0,v0,omegan) x0*cos(omegan*t)+(v0/omegan)*sin(omegan*t);
danalytic= @(t,x0,v0,omegan) -x0*omegan*sin(omegan*t)+v0*cos(omegan*t);

%% Plots the analytic solution and the matlab solution
%the postion plot
figure
plot(t,x(:,1),t,x(:,3),t,analytic(t,conditions(1),conditions(2),omegan),'--',t,analytic(t,conditions(3),conditions(4),omegan),'--')
xlabel('Time')
ylabel('x(t)')
title("x(t) vs t")
legend('ODE113 x(0) = 1','ODE113 x(0) = 0','Analytic x(0) = 1','Analytic x(0) = 0')
%the velocity plot
figure
plot(t,x(:,2),t,x(:,4),t,danalytic(t,conditions(1),conditions(2),omegan),'--',t,danalytic(t,conditions(3),conditions(4),omegan),'--')
xlabel('Time')
ylabel('v(t)')
title("v(t) vs t")
legend('ODE113 v(0) = 0','ODE113 v(0) = 1','Analytic v(0) = 0','Analytic v(0) = 1')

%% Funtion to turn the second order ODE into first order system
function pdot = harmonicOscillator(t,p,omegan)
    x1=p(1);
    x2=p(2);
    pdot=zeros(size(p));
    x1dot=x2;
    x2dot=-omegan^2*x1;
    pdot(1) = x1dot;
    pdot(2) = x2dot;
end