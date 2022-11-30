clc;clear;close all;
R1=1:0.01:20;
R2=10:0.01:16;
S=[2,5,10,11,12,15];

dvH=@(R) (sqrt((2.*R)./(1+R))-1)+(sqrt(1./R).*(1-sqrt(2./(1+R))));
dvE=@(R,S) (sqrt((2.*R.*S)./(1+R.*S))-1)+(sqrt(1./(R.*S)).*(sqrt(2./(1+S))-sqrt(2./(1+R.*S))))+(sqrt(2.*S./(R+R.*S))-sqrt(1./R));
dvP=@(R) (sqrt(2)-1)+(sqrt(1./R).*(sqrt(2)-1));

figure(1)
hold on
p1H=dvH(R1);
p1P=dvP(R1);
p1E=zeros(length(R1),length(S));
for i=1:length(S)
    p1E(:,i)=dvE(R1,S(i))';
    plot(R1,p1E(:,i))
end
legend('S=2','S=5','S=10','S=11','S=12','S=15','Location','southeast')
plot(R1,p1H,'b','DisplayName','Hohmann')
plot(R1,p1P,'r','DisplayName','Parabolic')
xlabel('R')
ylabel('\DeltaV/Vc1')
legend

figure(2)
hold on
p1H=dvH(R2);
p1P=dvP(R2);
p1E=zeros(length(R2),length(S));
for i=1:length(S)
    p1E(:,i)=dvE(R2,S(i))';
    plot(R2,p1E(:,i))
end
legend('S=2','S=5','S=10','S=11','S=12','S=15','Location','southwest')
plot(R2,p1H,'b','DisplayName','Hohmann')
plot(R2,p1P,'r','DisplayName','Parabolic')
xlabel('R')
ylabel('\DeltaV/Vc1')
axis([-inf inf 0.51 0.55])