clc;clear;tic;close all;
period=24;%hours
e=0.25;
i=63.4;%degrees
omega=[90,270];%degrees
Omega=[0,45,90,135,180];%degrees
nu0=0;
deltat=5*60;%sec
mu=398600;
t0=0;
fig=1;
OmegaE = (2*pi)/(24*3600);%((23*3600)+(56*60)+4);

i=deg2rad(i);
period=period*60*60;
omega=deg2rad(omega);
Omega=deg2rad(Omega);

%Calculates the postion of each orbit every 5 minutes
a=(((period/(2*pi))^2)*mu)^(1/3);
times=t0:deltat:period;
allOrbits{1}=[];
for c=1:length(omega)
    for j=1:length(Omega)
        oe=[a,e,Omega(j),i,omega(c),nu0];
        [r0,v0]=oe2rv_Hackbardt_Chris(oe,mu);
        RandV=[];
        for k=1:length(times)
            t=times(k);
            [r,v,E,nu] = propagateKepler_Hackbardt_Chris(r0,v0,t0,t,mu);
            RandV=[RandV;r',v'];
        end
        allOrbits{c,j}=RandV;
    end
end
%plots orbits on two plots
for m=1:length(omega)
    figure(fig)
    fig=fig+1;
    earthSphere
    title(['\omega = ',num2str(rad2deg(omega(m))),'^{o}'])
    for n=1:length(Omega)
        orbit=allOrbits{m,n};
        hold on
        plot3(orbit(:,1),orbit(:,2),orbit(:,3))
    end
    legend({[''],['\Omega = ',num2str(rad2deg(Omega(1))),'^{o}'],['\Omega = ',num2str(rad2deg(Omega(2))),'^{o}'],...
        ['\Omega = ',num2str(rad2deg(Omega(3))),'^{o}'],['\Omega = ',num2str(rad2deg(Omega(4))),'^{o}'],...
        ['\Omega = ',num2str(rad2deg(Omega(5))),'^{o}']})
end
%Calculates lon and lat of orbits
ecef{1}=[];
lonLat{1}=[];
for m=1:length(omega)
    for n=1:length(Omega)
        orbit=allOrbits{m,n};
        ecef{m,n}=eci2ecef(times,orbit(:,1:3),OmegaE);
        [lonE,lat] = ecef2LonLat(ecef{m,n});
        lonLat{m,n}=[lonE,lat];
    end
end
%Plots the mercator display
marker=['o','s','d','v','>'];
earth = imread('earth.jpg');
for m=1:length(omega)
    figure(fig)
    fig=fig+1;
    hold on
    image('CData',earth,'XData',[-180 180],'YData',[90 -90])
    title(['\omega = ',num2str(rad2deg(omega(m))),'^{o}'])
    for n=1:length(Omega)
        plots=lonLat{m,n};
        plot(plots(:,1)*180/pi,plots(:,2)*180/pi,marker(n));
    end
    legend({['\Omega = ',num2str(rad2deg(Omega(1))),'^{o}'],['\Omega = ',num2str(rad2deg(Omega(2))),'^{o}'],...
        ['\Omega = ',num2str(rad2deg(Omega(3))),'^{o}'],['\Omega = ',num2str(rad2deg(Omega(4))),'^{o}'],...
        ['\Omega = ',num2str(rad2deg(Omega(5))),'^{o}']},'Location','eastoutside')
end
omega90=lonLat{1,1}*180/pi;
lat=omega90(:,2);
for n=2:length(lat)
    if lat(n)<0&&lat(n-1)>0
        pos2negLat=times(n);
    end
    if lat(n)>0&&lat(n-1)<0
        neg2posLat=times(n);
    end
end
if neg2posLat>pos2negLat
    timeInSouth90=period-(neg2posLat-pos2negLat);
    timeInNorth90=period-timeInSouth90;
else
    timeInSouth90=pos2negLat-neg2posLat;
    timeInNorth90=period-timeInSouth90;
end

omega270=lonLat{2,1}*180/pi;
lat=omega270(:,2);
for n=2:length(lat)
    if lat(n)<0&&lat(n-1)>0
        pos2negLat=times(n);
    end
    if lat(n)>0&&lat(n-1)<0
        neg2posLat=times(n);
    end
end
if neg2posLat>pos2negLat
    timeInSouth270=period-(neg2posLat-pos2negLat);
    timeInNorth270=period-timeInSouth270;
else
    timeInSouth270=pos2negLat-neg2posLat;
    timeInNorth270=period-timeInSouth270;
end
%close all
toc;