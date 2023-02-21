%% Defines variables used in the equaions and the four initial guesses
clc;clear;
a = 0.5863552428728520;
C = -2.735509517401657;
x0 = [0 pi/2 pi 3*pi/2];
%% Defines the three functions used, orginal, derivative, and solved for x
f = @(x) x-a*sin(x)+C;
g = @(x) 1-a*cos(x);
b = @(x) a*sin(x)-C;
fprintf('--------Newton''s Method---------- \n');
%% loops through initial conditions and applies newton's method for 10 iterations
for j=1:length(x0)
    guess = x0(j);
    fprintf('Initial Guess: %f\n',guess);
    for i=1:10
        nextg = guess - (f(guess)/g(guess));
        fprintf('%f   %f \n',guess,nextg);
        guess = nextg;
    end
    fprintf('\n Converges to %f \n\n\n',guess);
end
%% loops through initial conditions and applies fixed point method for 10 iterations
fprintf('---------Fixed Point----------- \n');
for j=1:length(x0)
    guess = x0(j);
    fprintf('Initial Guess: %f\n',guess);
    for i=1:10
        nextg = b(guess);
        fprintf('%f   %f \n',guess,nextg);
        guess = nextg;
    end
    fprintf('\nConverges to %f \n\n\n',guess);
end