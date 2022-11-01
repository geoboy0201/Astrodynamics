clc;clear;
load question02.mat -ascii
m = 200;
c = 1750;
maxes=islocalmax(question02(:,2));
maxVals=[question02(1,2)];
maxPlace=[question02(1,1)];
for i =1:length(maxes)
    if maxes(i)
        maxVals=[maxVals,question02(i,2)];
        maxPlace=[maxPlace,question02(i,1)];
    end
end
t=question02(:,1);
zetaOmegan=c/(2*m);
x=exp(-zetaOmegan*t);
period=maxPlace(2)-maxPlace(1);

dampedFreq=(2*pi)/period;
k=(exp(zetaOmegan*maxPlace(1)))/(exp(zetaOmegan*maxPlace(2)));
decrement=log(k);
hold on
plot(maxPlace,maxVals,'r*')
plot(question02(:,1),question02(:,2),'b')
plot(t,x,t,-x)