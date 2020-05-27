% Javier Salazar 1001144647
% Section 5.1C - Problem 7
%----parameters--------------------
fun = @(x) exp(-(x^2));
a = 0;
b = 1;
n = 59;
%--------main function---------------
value = trapIntegrate(a, b, fun, n);
truthValue = 0.5*sqrt(pi)*erf(1);
absRelError = abs((truthValue-value)/truthValue);
%--------trapezoidal function----------
function sum = trapIntegrate(a, b, fun, n)
h = (b-a)/n;
sum = (fun(a)+fun(b))*0.5;
for i = 1:n-1
    x = a + i*h;
    sum = sum + fun(x);
end
sum = sum*h;
end