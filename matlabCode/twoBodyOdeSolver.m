function [t,p]=twoBodyOdeSolver(pos,vel,t0,tf,mu)
%This function solves the two body ODE given initial velocity, position, time, and final time
%
%Input: pos, a column vector with the initial position
%Input: vel, a column vector with the initial velocity
%Input: t0, the initial time in seconds
%Input: tf, the final time in seconds
%Input: mu, gravitational parameter
%
%Output: t, a column vector with times between t0 an tf
%Output: p, a matrix with the first 3 columns being position vectors, and the last 3 being velocity vectors
    options = odeset('RelTol',1e-8);
    po=[pos,vel];
    trange=[t0,tf];
    [t,p] = ode113(@twoBodyOde,trange,po,options,mu);
end