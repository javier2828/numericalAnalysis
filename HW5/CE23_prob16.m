% Javier Salazar 1001144647 Chapter 2.3 Problem 16C
% Bidiagonal Linear system
clc
clear all
n = 7; %input as specified by book
a = [1, 2, 3, 4, 5, 6]; % setting a, d, and b by the index
d = [1, 2, 3, 4, 5, 6, 7]; % solution by calculator confirmed before execution
b = [1, 2, 3, 4, 5, 6, 7];
xVector = biDiag(n, a, d, b); % function for bidiaganol linear system

function x = biDiag(n, a, d, b)
x = zeros(n,1); % initialize
x(1) = b(1)/d(1); % first and last solution is trivial
x(n) = b(n)/d(n); % calculate based on one coefficient
stopPoint = median(1:1:n); % figure out midpoint that requires forward and backward x values
for i = 2:stopPoint-1 % iterate from first non trivial x to last one before midpoint
    x(i) = (b(i)-a(i-1)*x(i-1))/d(i); % store solution 
    newIndex = n-i+1; % new index for going backwards in system to save computation time
    x(newIndex) = (b(newIndex)-a(newIndex)*x(newIndex+1))/d(newIndex); %store from last nontrivial x to after midpoint
end
x(stopPoint) = (b(stopPoint)-a(stopPoint)*x(stopPoint+1)-a(stopPoint-1)*x(stopPoint-1))/d(stopPoint); % calculate special midpoint x that requires two x information
end