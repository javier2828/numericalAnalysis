% Javier Salazar 1001144647 Section 8.4 Problem 4 - SOR Gauss-Seidel Method
clc
clear variables
%--------------parameters-----------------------------------
A = [7, 3, -1, 2; 3, 8, 1, -4; -1, 1, 4, -1; 2, -4, -1, 6]; % matrix
B = [-1; 0; -3; 1]; % RHS
X = zeros(4, 1); % initialize x
k_max = 100; % max iterations allowed
delta = 10^-10; % smallest value for diagonal value
error = 0.6*10^-4; % precision of solution
%---------------------main function----------------------------
w = 1:0.1:2;
totalW = length(w);
K_final = zeros(1, totalW);
X_final = zeros(4, totalW);
for wStep = 1:totalW
    [K_final(wStep), X_final(:,wStep)] = SORgaussIterative(A, B, X, k_max, delta, error, w(wStep)); % call SOR
end
figure
plot(w, K_final);
title('Iterations Versus Weighted Average Value', 'FontSize', 20);
xlabel('Weight Value W', 'FontSize', 20);
ylabel('Iteration K', 'FontSize', 20);
%---------------SOR gauss-seidel iterative function-------------------
function [k, X] = SORgaussIterative(A, B, X, k_max, delta, error, w) % returns iteration and final X
n = length(X); % get length of solution vector
for k = 1:k_max % go through set iterations
    Y = X; % set new Y as old X for computations
    for i = 1:n % go through each row in matrix
        sumValue = B(i); % start with B of that row
        diagValue = A(i,i); % get diagonal value
        if (abs(diagValue) < delta) % make sure matrix is non singular
            sprintf('Diagonal value too small!'); newline;
            return
        end
        for j = 1:i-1 % go through and move to RHS using previous calculated values
            sumValue = sumValue - A(i,j)*X(j);
        end
        for j = i+1:n % use previous values stored
            sumValue = sumValue - A(i,j)*Y(j);
        end
        X(i) = sumValue/diagValue; % now divide by coefficient of X_i to get solution
        X(i) = w*X(i) + (1-w)*Y(i); % weighted average of current and previous solution
    end
    if (norm(abs(X-Y) , Inf) < error) % take l-inf norm of difference between current and past solution
        % This is done so that the max relative error is below the
        % threshold. This ensures the other errors are below.
        return % if error is low enough, it is converging and thus soluton is good up to error value
    end
end
end
%----------------------end SOR gauss-seidel----------------------------
