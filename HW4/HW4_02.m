clc;clear;
HminusP = @(R) (sqrt((2.*R)./(1+R))-1)+(sqrt(1./R).*(1-sqrt(2./(1+R))))-((sqrt(2)-1)+(sqrt(1./R).*(sqrt(2)-1)));
transR=fsolve(HminusP,10);
S=[2,5,10,11,12,15];
Rvals=zeros(1,length(S));
for i=1:length(S)
    s=S(i);
    HminusE = @(R) (sqrt((2.*R)./(1+R))-1)+(sqrt(1./R).*(1-sqrt(2./(1+R))))-((sqrt((2.*R.*s)./(1+R.*s))-1)+(sqrt(1./(R.*s)).*(sqrt(2./(1+s))-sqrt(2./(1+R.*s))))+(sqrt(2.*s./(R+R.*s))-sqrt(1./R)));
    Rvals(i)=fsolve(HminusE,12);
end
clc;
scatter(S,Rvals,'filled')
xlabel('S')
ylabel('R')
fprintf('The value of R where the total impulse of the Hohmann transfer is the same as the total impulse of the bi-parabolic transfer is: %g\n',transR)
fprintf('The values of R where the total impulse of the Hohmann transfer is the same as the total impulse of the bi-elliptic transfer at S=2,5,10,11,12,15 is \n')
fprintf('%g, ',Rvals)