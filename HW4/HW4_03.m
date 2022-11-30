clc;clear;
v1=1;
mu=1;
v2=0.5;
r1=mu/v1^2;
r2=mu/v2^2;
R=r2/r1;
if R<11.938
    fprintf('The Hohmann transfer is the most efficient\n')
end

%Finds properties of the transfer orbit
eT=(r2-r1)/(r2+r1);
aT=(r1+r2)/2;
pT=aT*(1-eT^2);
nuT=0:0.01:pi;
radiusT=pT./(1+eT*cos(nuT));
[xT,yT]=pol2cart(nuT,radiusT);

%Finds delta V
dv1=sqrt(mu/r1)*(sqrt((2*R)/(1+R))-1);
dv2=sqrt(mu/r1)*sqrt(1/R)*(1-sqrt((2)/(1+R)));

%Finds coords of circular orbits
nu=0:0.01:2*pi;
radius1=zeros(1,length(nu));
radius1(:)=r1;
radius2=zeros(1,length(nu));
radius2(:)=r2;
[x1,y1]=pol2cart(nu,radius1);
[x2,y2]=pol2cart(nu,radius2);

hold on
plot(x1,y1,x2,y2,xT,yT)
scale=10;
quiver(xT(1),yT(1),0,dv1,scale)
quiver(xT(length(nuT)),yT(length(nuT)),0,-dv2,scale)
axis([-5 5 -5 5])
set(gcf,'position',[300,300,500,500])
title('Plot of Hohmann transfer')
subtitle('Delta Vs not to scale')