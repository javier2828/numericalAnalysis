% Javier Salazar 1001144647 Section 8.4 Problem 3 - Gauss-Seidel Method
clc
clear variables
%--------------parameters-----------------------------------
A = [7, 3, -1, 2; 3, 8, 1, -4; -1, 1, 4, -1; 2, -4, -1, 6]; % matrix
B = [-1; 0; -3; 1]; % RHS
X = zeros(4, 1); % initialize x
k_max = 100; % max iterations allowed
delta = 10^-10; % smallest value for diagonal value
error = 1.7*10^-5; % precision of solution
%---------------------main function----------------------------
tic % time function for fun
[K_final, X_final] = gaussIterative(A, B, X, k_max, delta, error); % call GS
toc % end timing
%---------------gauss-seidel iterative function-------------------
function [k, X] = gaussIterative(A, B, X, k_max, delta, error) % returns iteration and final X
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
    end
    if (norm(X-Y , Inf) < error) % take l-inf norm of difference between current and past solution
        % This is done so that the max relative error is below the
        % threshold. This ensures the other errors are below.
        return % if error is low enough, it is converging and thus soluton is good up to error value
    end
end
end
%----------------------end gauss-seidel----------------------------
