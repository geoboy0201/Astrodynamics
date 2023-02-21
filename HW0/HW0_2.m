%% Defines variables and range for x values
clc;clear;close all;
omegan = 1;
conditions = [1 0 0 1];
x = -10:0.01:10;
%% defines the function
xdot = @(x,x0,v0,omegan) sqrt((omegan)^2*x.^2+2*v0+2*omegan*x0);
%% Computes the equation for each set of initial conditions and x
for i=1:2:length(conditions)
    x0 = conditions(i);
    v0 = conditions(i+1);
    v(:,i) = xdot(x,x0,v0,omegan);
end
%% plots the function for both sets of initial conditions over x
plot((x),(v(:,1)),x,v(:,3),'--')
xlabel('x')
ylabel('Xdot(x)')
title("x vs xdot")
legend('x(0) = 1 v(0) = 0','x(0) = 0 v(0) = 1')