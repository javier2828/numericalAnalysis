% Javier Salazar 1001144647 Section 1.1 Problem 5
%problem 5
n = 20;
p_n = zeros(1,n);
p_n(1) = 1;
for i=2:n
    p_n(i) = exp(1) - i*p_n(i-1);
end
figure
plot(1:20, p_n, '-o')
title('Problem 5 Forward Algorithm Plot p(1)=1 n=20')
xlabel('n term')
ylabel('p(n)')
dlmwrite('hw2_data.csv',p_n,'delimiter',',');

% problem 6 
%part a
p_values = zeros(1,n);
p_values(end) = 1/8;
for i=n-1:-1:1
    p_values(i) = exp(1) - i*p_values(i+1);
end
figure
plot(1:20, p_values, '-o')
title('Problem 6 Backwards Algorithm Plot p(21)=1/8 ')
xlabel('n term')
ylabel('p(n)')
dlmwrite('hw2_data.csv',p_values,'delimiter',',','-append');
%part b
p_values2 = zeros(1,n);
p_values2(end) = 20;
for i=n-1:-1:1
    p_values2(i) = exp(1) - i*p_values2(i+1);
end
figure
plot(1:20, p_values2, '-o')
title('Problem 6 Backward Algorithm Plot P(21)=20 n=20')
xlabel('n term')
ylabel('p(n)')
dlmwrite('hw2_data.csv',p_values2,'delimiter',',','-append');
% part c
p_values3 = zeros(1,n);
p_values3(end) = 100;
for i=n-1:-1:1
    p_values3(i) = exp(1) - i*p_values3(i+1);
end
figure
plot(1:20, p_values3, '-o')
title('Problem 6 Backwards Algorithm Plot p(21)=100 n=20')
xlabel('n term')
ylabel('p(n)')
dlmwrite('hw2_data.csv',p_values3,'delimiter',',','-append');