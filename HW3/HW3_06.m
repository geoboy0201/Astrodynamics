clc;clear;
%Defines variables
r0=[1882.725;9864.690;4086.088];
v0=[-5.565367;5.451548;2.258105];
t0=616.79;
tf=1880.41;
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
xlswrite('Orbit4.xlsx',saveTable)

%Prints values at tf
fprintf('The eccentric anomaly E is %g\n',E)
fprintf('The true anomaly nu is %g\n',nu)
vector = array2table(randv(i,:),"VariableNames",["X Position","Y Position","Z Position","X Velocity","Y Velocity","Z Velocity"]);
vector