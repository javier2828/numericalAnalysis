% Javier Salazar 1001144647 CE 1.2 Problem 11
n = 20;
s_n = zeros(1,n);
p_n = zeros(1,n-1);
s_n(2) = 1;
p_n(1) = 2;
for k = 3:20
    s_n(k) = s_n(k-1)/(2+2*sqrt(1-s_n(k-1)));
    p_n(k-1) = (2^(k-1))*sqrt(s_n(k));
end
s_n = s_n(2:end);
figure
subplot(2,1,1);
plot(2:20, s_n);
title('Sn as a function of n')
xlabel('n term')
ylabel('Sn approximation')
subplot(2,1,2);
plot(2:20, p_n);
title('Pn as a function of n. P = 3.1416 at n >=9')
xlabel('n term')
ylabel('Pn approximation of Pi')