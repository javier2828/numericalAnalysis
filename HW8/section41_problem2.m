%Javier Salazar 1001144647 Section 4.1 Problem 2
clc
clear variables
%-------------parameters-----------------
n = 11;
x = linspace(1, 6, n);
y = atan(x);
%---------------main function----------------
a = coefficients(n, x, y);
t = linspace(0, 8, 33);
interpValues = evaluate(n, x, a, t);
y_new = atan(t);
figure
plot(t, y_new, t, interpValues, '--');
title('Arc Tan Function & Interpolated Polynomial (Dashed Line)', 'FontSize', 20);
xlabel('X Value', 'FontSize', 20);
ylabel('Y Value', 'FontSize', 20);
abs_rel_error = abs((y_new-interpValues)./(y_new));
figure
semilogy(t, abs_rel_error);
title('Abs. Rel. Error Comparison', 'FontSize', 20);
xlabel('X Value', 'FontSize', 20);
ylabel('Y Value (log)', 'FontSize', 20);
figure
plot(t, abs(y_new-interpValues));
title('Abs. Error Comparison', 'FontSize', 20);
xlabel('X Diff. Value', 'FontSize', 20);
ylabel('Y Diff. Value', 'FontSize', 20);
%------------a vector function------------------
function a = coefficients(n, x, y)
a = y;
for j = 1:n
    for i = n:-1:j+1
        a(i) = (a(i)-a(i-1))/(x(i)-x(i-j));
    end
end
end
%---------------evaluate p(x) function--------------
function values = evaluate(n, x, a, t)
numberPoints = length(t);
values = ones(1, numberPoints)*a(n);
for k = 1:numberPoints
    for i = n-1:-1:1
        values(k) = values(k)*(t(k)-x(i))+a(i);
    end  
end
end