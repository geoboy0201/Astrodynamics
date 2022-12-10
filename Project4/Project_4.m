clc;clear;
mu=398600;
N=[1,2,3,4,5,6];
r1=500+6378.145;
i1=28.5;
Omega1=60;

r2=20200+6378.145;
i2=57;
Omega2=120;

i1=deg2rad(i1);
i2=deg2rad(i2);
Omega1=deg2rad(Omega1);
Omega2=deg2rad(Omega2);

dVAs=[];
dVPs=[];
totdVs=[];
totTimes=[];
for i=1:length(N)
    [posT,timeT,dVP,dVA,totDV]=twoNImpulseOrbitTransfer(r1,r2,i1,i2,Omega1,Omega2,N(i),mu);
    dVAs(i)=sum(dVA);
    dVPs(i)=sum(dVP);
    totdVs(i)=totDV;
    totTimes(i)=timeT(end);
end

figure
plot(N,dVAs)
title('Magnitude of Apoapsis Impulses vs N')
xlabel('N')
ylabel('Apoapsis Impulses (km/s)')
set(gca, 'XTick', 0:N(end))
figure
plot(N,dVPs)
title('Magnitude of Periapsis Impulses vs N')
xlabel('N')
ylabel('Periapsis Impulses (km/s)')
set(gca, 'XTick', 0:N(end))
figure
plot(N,totdVs)
title('Magnitude of Total Impulse vs N')
xlabel('N')
ylabel('Total Impulse (km/s)')
set(gca, 'XTick', 0:N(end))
figure
plot(N,totTimes)
title('Total Time Required for Transfer vs Time')
xlabel('N')
ylabel('Time (sec)')
set(gca, 'XTick', 0:N(end))

fprintf('\nThe total impulse required increases as a function of N\n')
fprintf('because it is inefficient to change the plane of an orbit at a lower orbit than the final, highest orbit\n')