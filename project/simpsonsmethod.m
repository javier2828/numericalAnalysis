% Gavin Sabine 1001020462 Numerical Project Method Comparison
clc
clear variables
%----------parameters-----------------
func = @(x) ((1-cos(x))./x);
a = 0; 
b = 2*pi;
n = 50; %maximum number of points used
xPlot=linspace(1,2*n-1,n);
y=zeros(1,n); %the ans to the interegration
%--------------main function-------------
for k=2:n %number of points currently used
deltax = (b-a)/(xPlot(k)-1);
x = linspace(a,b,xPlot(k));
%first value is f(0) which is undefined for given function so define f(0)=0
y(k) = y(k) + 0; %first value
for i=2:xPlot(k)-1 %values mod first and last
    if( rem(i,2) == 0) 
        y(k) = y(k) + 4*func(x(i)); %if i is odd
    else 
        y(k) = y(k) + 2*func(x(i)); %if i is even
    end
end
y(k) = y(k) + func(x(k)); %last value
y(k) = (deltax/3)*y(k);
end

%--------------plots-------------
relativeTolerence = 1*10^-9; % abs. relative tolerence for integral function built in matlab (quadrature technique)
truthValue = integral(func,0,2*pi, 'RelTol',relativeTolerence); % ground truth for comparison
hold on;
plot(xPlot, y, 'Color', 'blue');
hold on;
plot(xPlot,ones(size(xPlot)) * truthValue, 'Color', 'green');
ylabel('Expected Value', 'Interpreter', 'latex', 'FontSize',20);
xlabel('Number of Points Used', 'Interpreter', 'latex', 'FontSize',20);
title('Simpsons Integration Method', 'Interpreter', 'latex', 'FontSize',20);
legend({'Simpsons Approximation', 'Truth Value'}, 'FontSize',20, 'Interpreter', 'latex');