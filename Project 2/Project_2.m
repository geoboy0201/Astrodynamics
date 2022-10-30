clc;clear;close all;

%Defines position and velocity, calculates oribital elements and names them
rv0 = [-1217.39430415697,-3091.41210822807,-6173.40732877317];
vv0 = [9.88635815507896,-0.446121737099303,-0.890884522967222];
mu = 398600;
oe = rv2oe_Hackbardt_Chris(rv0,vv0,mu);
a = oe(1);
e = oe(2);
Omega = oe(3);
i = oe(4);
omega = oe(5);
p = oe(1)*(1-e^2);

%Calculates the period in seconds
period = 2*pi*sqrt(a^3/mu);

%Sets deltat to five minutes (code will calculate earth coordinates at a
%point every five minutes on the orbit)
%Calculates t0 to be time from apoapsis
deltat = 5*60;
initialt=timeChangeIntegral(@timeChangeIntegrand,pi,oe(6),p,e,mu,20);
finalt = (2*period)+initialt;
times = initialt:deltat:finalt;
times = times';

%Calculates nu, position, and velocity values for points every five minutes on orbit
nuValues = computeNu(times,rv0,vv0,mu);
[rvValuesECI,vvValues] = computeRandV(nuValues,a,e,Omega,i,omega,mu);

%Rotation rate of earth
OmegaE = (2*pi)/((23*3600)+(56*60)+4);

%Converts ECI postion to ECEF and then to longitude and latitude
rvValuesECEF = eci2ecef(times,rvValuesECI,OmegaE);
[lonE,lat] = ecef2LonLat(rvValuesECEF);

%Creates earth and plots orbit
earthSphere
hold on
plot3(rvValuesECI(:,1),rvValuesECI(:,2),rvValuesECI(:,3))
view(49.5,22.8)

%Plots the longitudes and latitudes
mercatorDisplay(lonE,lat)

%Converts longitudes and latitudes to degrees
lonE = rad2deg(lonE);
lat = rad2deg(lat);

%Finds the two coordinates where latitude is a local maximum
westLon=[];
westLat=[];
eastLon=[];
eastLat=[];
for i=1:length(lonE)
    if lonE(i)<0
        westLon=[westLon;lonE(i)];
        westLat=[westLat;lat(i)];
    else
        eastLon=[eastLon;lonE(i)];
        eastLat=[eastLat;lat(i)];
    end
end
[maxWestLat,i] = max(westLat);
[maxEastLat,j] = max(eastLat);
maxWestLon = westLon(i);
maxEastLon = eastLon(i);

%Prints the answers
fprintf('Part a:\n');
fprintf('The segments at the highest latitudes on earth are at apoapsis on\n');
fprintf('the orbit\n\n');
fprintf('Part b:\n');
fprintf('The coordinates where greatest latitude occurs are:\n');
fprintf('%g degrees east, %g degrees north\n',maxEastLon,maxEastLat);
fprintf('%g degrees west, %g degrees north\n\n',maxWestLon,maxWestLat);
fprintf('Part c:\n');
fprintf('The city in the east is: Tutonchany, Russia\n');
fprintf('The location in the west is: Nunavut, Canada, on the coast of Hudson Bay\n\n');
fprintf('Part d:\n');
fprintf('The spacecraft spends most of its time in the northern regions of earth since the orbit\n');
fprintf('is inclined and is highly eccentric. The eccentricity vector points towards the southern\n');
fprintf('hemisphere of earth, meaning periapsis occurs over the southern hemisphere, and apoapsis\n');
fprintf('occurs above the northern hemisphere. We also know that the speed of a spacecraft at apoapsis\n');
fprintf('is slower than its speed at periapsis. These results combined explain why the spacecraft\n');
fprintf('spends most of its time above the locations on earth mentioned.\n');