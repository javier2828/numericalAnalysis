% Javier Salazar 1001144647 Set 5 Ex 3
clc
clear all
x1 = 10;
x2 = -10;
n = 50;
taylor_x1 = zeros(1,n);
taylor_x2 = zeros(1,n);
for i=1:n
    taylor_x1(i) = exp_approx(x1, i);
    taylor_x2(i) = exp_approx(x2, i);
end
error_x1 = abs((exp(x1)-taylor_x1)./(exp(x1)));
error_x2 = abs((exp(x2)-taylor_x2)./(exp(x2)));
figure
subplot(2,1,1);
semilogy(error_x1);
title('Abs. relative error of exp(10) as a function of Taylor approx. n')
xlabel('n term')
ylabel('log(|exp(10)-taylor(n)|)')
subplot(2,1,2);
semilogy(error_x2);
title('Abs. relative error of exp(-10) as a function of Taylor approx. n')
xlabel('n term')
ylabel('log(|exp(-10)-taylor(n)|)')

function taylorValue = exp_approx(x, n)
    taylorValue = 1;
    xTerm = 1;
    for i=1:n
        xTerm = xTerm*(x/i);
        taylorValue = taylorValue + xTerm;
    end
end
