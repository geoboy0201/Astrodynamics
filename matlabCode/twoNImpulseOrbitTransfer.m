function [posT,timeT,dVP,dVA,totDV]=twoNImpulseOrbitTransfer(r1,r2,i1,i2,Omega1,Omega2,N,mu)
%This function calculates the impulses needed to complete N Hohmann
%transfers

%Input: r1, radius of orbit 1
%Input: r2, radius of orbit 2
%Input: i1, inclination of orbit 1
%Input: i2, inclination of orbit 2
%Input: Omega1, longitude of ascending node of orbit 1
%Input: Omega1, longitude of ascending node of orbit 1
%Input: N, number of Ho
%Input: mu, gravitaional parameter

%Output: posT, 500x3 matrix containing postions along the transfer orbit
%Output: timeT, column matrix of times associated with positions in posT
%Output: dV1, impulse at periapsis of transfer
%Output: dV2, impulse at apoapsis of transfer
%Output: totDV, the total delta V required to complete the transfer

rn=r1+((1:N)/N)*(r2-r1);
Omegan=Omega1+((1:N)/N)*(Omega2-Omega1);
in=i1+((1:N)/N)*(i2-i1);

rn=[r1,rn];
Omegan=[Omega1,Omegan];
in=[i1,in];

dOmega=Omegan(2)-Omegan(1);

dVP=zeros(N,1);
dVA=zeros(N,1);
posT=[];
velT=[];
timeT=[0];

N=1:N;
for i=1:length(N)
    %elliptic
    [post,velt,timet,dV1,dV2]=twoImpulseHohmann(rn(i),rn(i+1),in(i),in(i+1),Omegan(i),Omegan(i+1),mu);
    posT=[posT;post];
    velT=[velT;velt];
    timet=timet+timeT(length(timeT));
    timeT=[timeT;timet'];
    dVP(i)=norm(dV1);
    dVA(i)=norm(dV2);
    %circular
    if i<length(N)
    taut=2*pi*sqrt(rn(i+1)^3/mu);
    dOmegaTime=dOmega/sqrt(mu/rn(i+1)^3);
    [timet, post] = propagateOnCircle(post(end,:),velt(end,:)+dV2,timeT(end),timeT(end)+(taut/2)+dOmegaTime,mu,500);
    posT=[posT;post];
    timeT=[timeT;timet];
    end
end

timeT(1)=[];

totDV=sum(dVP)+sum(dVA);
fprintf('The total time to complete the transfer is %g seconds or %g hours\n',timeT(end),timeT(end)/3600)

%Plots 3D view of transfer
hold on
earthSphere
plot3(posT(:,1),posT(:,2),posT(:,3))
hold off

%Plots the ground track;
OmegaE = (2*pi)/((23*3600)+(56*60)+4);
rvValuesECEF = eci2ecef(timeT,posT,OmegaE);
[lonE,lat] = ecef2LonLat(rvValuesECEF);
mercatorDisplay(lonE,lat)

end