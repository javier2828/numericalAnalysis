%Javier Salazar 1001144647 Section 3.3 Problem 6A
% Newton and Secant Method
%---------------parameters----------------------
fun = @(x) (x^3 - 3*x + 1);
fun_der = @(x) (3*x^2 - 3);
maxIterations = 100;
x_0_newton = 2;
errorTol = 5*10^-16;
delta = 5*10^-2;
%---------------main function--------------------
tic
x_newton = newtonMethod(fun, fun_der, x_0_newton, maxIterations, errorTol, delta);
toc
a = x_newton(2);
b = x_0_newton;
tic
x_secant = secantMethod(fun, a, b, maxIterations, errorTol);
toc
trueSol = roots([1 0 -3 1]); trueSol = trueSol(2);
figure
plot(x_newton);
hold on
plot(x_secant);
hold on
plot(trueSol*ones(length(x_newton)));
title('Newton and Secant Method Comparison (epsilon=5*10 -16)', 'fontSize', 20)
xlabel('Iterations', 'fontSize', 20);
ylabel('Root Value', 'fontSize', 20);
hold off
error_newton = abs((trueSol-x_newton)/(trueSol));
error_secant = abs((trueSol-x_secant)/(trueSol));
figure
semilogy(error_newton);
hold on
semilogy(error_secant);
title('Absolute Relative Error Comparison: Newton and Secant (epsilon=5*10 -16)', 'fontSize', 20)
xlabel('Iterations', 'fontSize', 20);
ylabel('Error Value (log)', 'fontSize', 20);
hold off
%---------------------secant method----------------------
function x = secantMethod(fun, a, b, maxIterations, errorTol)
x = zeros(1,maxIterations);
x(1) = a;
f_a = fun(a);
f_b = fun(b);
if (abs(f_a) > abs(f_b))
    a_temp = a;a = b;b = a_temp;
    f_a_temp = f_a;f_a = f_b;f_b = f_a_temp;
end
for n = 2:maxIterations
    if (abs(f_a) > abs(f_b))
    a_temp = a;a = b;b = a_temp;
    f_a_temp = f_a;f_a = f_b;f_b = f_a_temp;
    end
    d = (b-a)/(f_b-f_a);
    b = a;
    f_b = f_a;
    d = d*f_a;
    if (abs(d) < errorTol)
        x = x(1:n-1);
        return
    end
    a = a - d;
    x(n) = a;
    f_a = fun(a);
end
end
%---------------------newton method---------------------
function x = newtonMethod(fun, fun_der, x_0, maxIterations, errorTol, delta)
f_x = fun(x_0);
x = zeros(1, maxIterations);
x(1) = x_0;
for n = 1:maxIterations
    f_p = fun_der(x_0);
    if (abs(f_p) < delta)
        disp("Small Derivative. Will cause Issues.");
        return
    end
    d = f_x/f_p;
    x(n+1) = x(n) - d;
    f_x = fun(x(n+1));
    if (abs(d) < errorTol)
        x = x(1:n+1);
        return
    end
end
end