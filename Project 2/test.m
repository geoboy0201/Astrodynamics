clc; clear;

rv0 = [-1217.39430415697,-3091.41210822807,-6173.40732877317];
vv0 = [9.88635815507896,-0.446121737099303,-0.890884522967222];
mu = 398600;
oe = rv2oe_Hackbardt_Chris(rv0,vv0,mu);
a=oe(1);
period = 2*pi*sqrt(a^3/mu);
period = period/60;
deltat = 5*60;
finalt = 2*period;
times = 0:deltat:finalt;
times = times';
f=@timeChangeIntegrand;
nu0=oe(6);
N=20;
e = oe(2);
p = oe(1)*(1-e^2);
nuValues(1)=oe(6);
nu0=nuValues(1);

for i=1:length(times)-1
    t0 = times(i);
    t = times(i+1);
    
    deltat = (t-t0);
    deltaNu = 5;
    guessNu = nu0+deltaNu;

    for j=1:20
        [theta,w] = GaussPointsWeights(nu0,guessNu,N);
        theta=theta';
        F = f(theta,p,e,mu);
        F = F';
        FofNu = w.'*F;
        
        GofNu = FofNu - deltat;
        Gprime = f(guessNu,p,e,mu);

        guessNu = guessNu -(GofNu/Gprime);
    end

nuValues(i) = guessNu;
nu0 = guessNu;
    
end

