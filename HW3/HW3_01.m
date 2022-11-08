clc;clear;
r1=[68524.298;-17345.863;-51486.409];
v1=[-0.578936;0.957665;0.357759];
r2=[2721.965;3522.863;5267.244];
v2=[9.572396;-0.474701;-2.725664];
r3=[6997.56;-34108.00;20765.49];
v3=[0.15599;0.25517;1.80763];
r4=[1882.725;9864.690;4086.088];
v4=[-5.565367;5.451548;2.258105];
r5=[-664.699;8112.75;4479.81];
v5=[-0.87036;-0.068046;-8.290459];
r6=[-10515.45;-5235.37;49.1700];
v6=[-2.10305;-4.18146;5.56329];
t0=60*[1329.16;3.93;242.82;616.79;21.02;27];
ts=60*[3885.73;1771.58;612.69;1880.41;1913.38;57];
r=[r1,r2,r3,r4,r5,r6]';
v=[v1,v2,v3,v4,v5,v6]';
mu=398600;
positions={};
times=[];

for i=1:length(t0)
    pos=r(i,:);
    vel=v(i,:);
    ti=t0(i);
    tf=ts(i);
    [t,p]=twoBodyOdeSolver(pos,vel,ti,tf,mu);
    positions{i}=p;
    for j=1:length(t)
        times(j,i)=t(j);
    end
end

for i=1:length(positions)
    figure(i)
    pandv=positions{i};
    plot3(pandv(:,1),pandv(:,2),pandv(:,3))
    tf=times(length(pandv),i);
    fprintf('%i) The postion and velocity at tf = %g sec is :\n',i,tf)
    table = array2table(pandv(length(positions),:),"VariableNames",["X Position","Y Position","Z Position","X Velocity","Y Velocity","Z Velocity"])
    
end
close all;