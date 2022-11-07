function [times, positions, velocities] = propagateOnCircle(pos,vel,t0,tf,mu,N)
%This function calculates position and veolocity N times evenly spaced betwen t0 and tf
%
%Function call: [times, postions, velocities] = propagateOnCircle(pos,vel,t0,tf,mu,N);
%
%Input: pos, a column vector with the initial ECI postion
%Input: vel, a column vector with the initial ECI inertial velocity
%Input: t0, the initial time. Time from apoapsis to initial postion
%Input: tf, the final time
%Input: mu, gravitational parameter
%Input: N, number of time intervals
%
%Output: times, column vector of times, starting at t0 and ending at tf. Length of N with even spacing
%Output: postions, matrix of size Nx3 containing ECI positions stored row-wise at every time in the times vector
%Output: velocities, matrix of size Nx3 containing ECI velocities stored row-wise at every time in the times vector
%

times=linspace(t0,tf,N);
times=times';

oe = rv2oe_Hackbardt_Chris(pos,vel,mu);
nui=oe(6);
a=oe(1);
thetaDot=sqrt(mu/a^3);

positions=zeros(N,3);
velocities=zeros(N,3);

positions(1,:)=pos';
velocities(1,:)=vel';

for i=2:N
    theta=thetaDot*(times(i)-times(i-1));
    nuOfT=nui+theta;
    oe(6)=nuOfT;
    [rPCI,vPCI]  = oe2rv_Hackbardt_Chris(oe,mu);
    positions(i,:)=rPCI';
    velocities(i,:)=vPCI';
    nui=nuOfT;
end
end