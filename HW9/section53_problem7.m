% Javier Salazar 1001144647
% Section 5.3 Problem 7
clc
clear all

a = -1;
b = 1;
f = @(x) (1/sqrt(1-x^2));

h = (b-a)/2;
midPointRule = 2*h*f(a+1*h);

h = (b-a)/3;
twoPointRule = 1.5*h*(f(a+1*h)+f(a+2*h));

h = (b-a)/4;
threePointRule = (4/3)*h*(2*f(a+1*h)-f(a+2*h)+2*f(a+3*h));

h = (b-a)/5;
fourPointRule = (5/24)*h*(11*f(a+1*h)+f(a+2*h)+f(a+3*h)+11*f(a+4*h));

h = (b-a)/6;
fivePointRule = (6/20)*h*(11*f(a+1*h)-14*f(a+2*h)+26*f(a+3*h)-14*f(a+4*h)+11*f(a+5*h));