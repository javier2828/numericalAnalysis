%Javier Salazar 1001144647 CE 2.1 Exercise 4
clc
clear all
n = 15;
A = zeros(n,n);
B = zeros(n,1);
for i = 1:n
    for j=1:n
        A(i,j) = -1 + 2*min(i,j);
    end
    B(i) = sum(A(i,:));
end
X = naiveGauss(A,B);


function X = naiveGauss(A, B)
    n = length(B);
    X = zeros(n,1);
    for k=1:n-1
        for i=k+1:n
           A(i,k) = A(i,k)/A(k,k);
           for j = k+1:n
               A(i,j) = A(i,j) - A(i,k)*A(k,j);
           end
           B(i) = B(i) - A(i,k)*B(k);
        end
    end
    X(n) = B(n)/A(n,n);
    for i=n-1:-1:1
        sum = B(i);
        for j = i+1:n
            sum = sum - A(i,j)*X(j);
        end
        X(i) = sum/A(i,i);
    end
end