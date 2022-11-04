clc;clear;

%Different constants needed. Converts times to seconds
rvec=[-5613.97603835865;-2446.44383433555;2600.48533877841];
vvec=[2.12764777374332;-7.13421216656605;-2.1184067703542];
t0=33.2;
t0=t0*60;
tf=100.2;
tf=tf*60;
mu=398600;
N=45;

%Creates matricies with position and velocity vecctors at times given
[times, positions, velocities] = propagateOnCircle(rvec,vvec,t0,tf,mu,N);

%Creates a table with time, position, and velocity
results=[times,positions,velocities];
table = array2table(results,"VariableNames",["Time","X Position","Y Position","Z Position","X Velocity","Y Velocity","Z Velocity"]);
%computes the postion of orbit using ODE113
trange=[times(1),times(N)];
po=[rvec,vvec];
options = odeset('RelTol',1e-8);
[t,p] = ode113(@twoBodyOde,trange,po,options,mu);

%Plots ODE113 solution and circular propagation solution
figure(1)
pp = plot3(positions(:,1),positions(:,2),positions(:,3),'-o',p(:,1),p(:,2),p(:,3),'-s');
view(35,15);
xl = xlabel('$x$ (km)');
yl = ylabel('$y$ (km)');
zl = zlabel('$z$ (km)');
ll = legend('Propagate on Circle','ODE113','Location','northeast');
set(xl,'FontSize',16,'Interpreter','LaTeX');
set(yl,'FontSize',16,'Interpreter','LaTeX');
set(zl,'FontSize',16,'Interpreter','LaTeX');
set(ll,'FontSize',16,'Interpreter','LaTeX');
set(gca,'FontSize',16,'TickLabelInterpreter','LaTeX');
grid on;

azimuth = 45;
elevation = 45;

%Plots postion and velocity vectors
quiverScale = 2;
figure(2)
pp = quiver3(positions(:,1),positions(:,2),positions(:,3),velocities(:,1),velocities(:,2),velocities(:,3),quiverScale,'-o');
view(35,15);
xl = xlabel('$x$ (km)');
yl = ylabel('$y$ (km)');
zl = zlabel('$z$ (km)');
set(xl,'FontSize',16,'Interpreter','LaTeX');
set(yl,'FontSize',16,'Interpreter','LaTeX');
set(zl,'FontSize',16,'Interpreter','LaTeX');
set(gca,'FontSize',16,'TickLabelInterpreter','LaTeX');
grid on;

function pdot = twoBodyOde(t,p,mu)
    pos = p(1:3);
    vel = p(4:6);
    rad = norm(pos,2);
    posdot = vel;
    veldot = -mu/(rad^3)*pos;
    pdot = [posdot; veldot];
end