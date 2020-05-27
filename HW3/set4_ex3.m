% Javier Salazar 1001144647 Set 4 Example 3
clc
clear all
n = 20000;
x = (2)*rand(n,1) - 1;
y = (2)*rand(n,1) - 1;
circleRadius = x.^2 + y.^2;
numOfPointsCircle = sum(circleRadius<=1);
pi = (numOfPointsCircle/n)*4;
disp(pi);
figure
scatter(x,y);
hold on
th = 0:pi/50:2*pi;
xunit = cos(th);
yunit = sin(th);
plot(xunit, yunit);
title({sprintf('Monte Carlo simulation. 200 u-random Pi: %0.2f', pi);sprintf('Points within circle: %0.0f', numOfPointsCircle)})
xlabel('Square of side 2. X location of points.')
ylabel('Square of side 2. Y location of points.')
