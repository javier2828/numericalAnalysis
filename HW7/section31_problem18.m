%Javier Salazar 1001144647 Section 3.1 Problem 18C
% Bisection Method
%------------parameters----------------------------------------
func = @(x) (cos(x)-x*sin(x));
errorTol = 5*10^-6;
domain = [0, pi/2];
maxIteration = 1000;
%-------------------main function-----------------------------
root = bisectionMethod(func, domain, maxIteration, errorTol);
areaRectangle = root*cos(root);
%-----------------------bisection function------------------------
function c = bisectionMethod(func, domain, maxIteration, errorTol)
f_a = func(domain(1));
f_b = func(domain(2));
if (f_a*f_b > 0)
    c = NaN;
    disp("Function has same signs at a and b. By IVT, not possible.")
    return
end
error = domain(2)-domain(1);
for n = 1:maxIteration
    error = error/2;
    c = domain(1) + error;
    f_c = func(c);
    if (abs(error) < errorTol)
        return
    end
    if (f_a*f_c < 0)
        domain(2) = c;
        f_b = f_c;
    else
        domain(1) = c;
        f_a = f_c;
    end
end
end
%-----------------------------------------------------------------
