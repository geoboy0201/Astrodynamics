clc;clear;

rv0 = [-1217.39430415697,-3091.41210822807,-6173.40732877317];
vv0 = [9.88635815507896,-0.446121737099303,-0.890884522967222];
mu = 398600;
oe = rv2oe_Hackbardt_Chris(rv0,vv0,mu);
a=oe(1);
period = 2*pi*sqrt(a^3/mu);
period = period/60;