clc;clear;
r0=[2721.965;3522.863;5267.244];
v0=[9.572396;-0.474701;-2.725664];
t0=1329.16;
t=3885.73;
t0=t0*60;
t=t*60;
mu=398600;

oe = rv2oe_Hackbardt_Chris(r0,v0,mu);
a = oe(1);
e = oe(2);
nu0 = oe(6);
E0 = 2*atan2(sqrt(1-e)*sin(nu0/2),sqrt(1+e)*cos(nu0/2));
tau=2*pi*sqrt(a^3/mu);
k=floor((t)/tau);

C=sqrt(mu/a^3)*(t-t0)-(2*pi*k)+(E0-(e*sin(E0)));
f = @(x) e*sin(x)+C;
n=10*ceil(1/(1-e));
guessE=E0-e*sin(E0);
for i=1:n
    guessE=f(guessE);
    fprintf('%g\n',guessE)
end
E=guessE;

nu= 2*atan2(sqrt(1+e)*sin(E/2),sqrt(1-e)*cos(E/2));
oe(6)=nu;
[r,v]  = oe2rv_Hackbardt_Chris(oe,mu);