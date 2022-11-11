clc;clear;
%Defines variables
r0=[68524.298;-17345.863;-51486.409];
v0=[-0.578936;0.957665;0.357759];
t0=1329.16;
tf=3885.73;
t0=t0*60;
tf=tf*60;
mu=398600;

%Calculates position and velocity at tf
[r,v,E,nu] = propagateKepler_Hackbardt_Chris(r0,v0,t0,tf,mu);

%Calculates position and velocity at 100 times between t0 and tf
times=linspace(t0,tf)';
randv=zeros(length(times),6);
for i=1:length(times)
    t=times(i);
    [r,v] = propagateKepler_Hackbardt_Chris(r0,v0,t0,t,mu);
    randv(i,:)=[r',v'];
end

%Calculates orbit using Kepler and ODE113
[time,p]=twoBodyOdeSolver(r0,v0,t0,tf,mu);

%Plots positions at the 100 times
plot3(randv(:,1),randv(:,2),randv(:,3),'b*',p(:,1),p(:,2),p(:,3),'r.')
legend('Kepler Plot','ODE113 Plot','Location','northeast')

%Creates a table with all positions and velocities at the 100 times
saveTable =[times,randv];
table = array2table(saveTable,"VariableNames",["Time","X Position","Y Position","Z Position","X Velocity","Y Velocity","Z Velocity"]);
table
xlswrite('Orbit1.xlsx',saveTable)

%Prints values at tf
fprintf('The eccentric anomaly E is %g\n',E)
fprintf('The true anomaly nu is %g\n',nu)
vector = array2table(randv(i,:),"VariableNames",["X Position","Y Position","Z Position","X Velocity","Y Velocity","Z Velocity"]);
vector