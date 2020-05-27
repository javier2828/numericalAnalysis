% Javier Salazar 1001144647 Numerical Project Method Comparison
clc
clear variables
%----------parameters-----------------
func = @(x) ((1-cos(x))./x); % function input
a = 0; % domain parameter 1
b = 2*pi; % domain parameter 2
plotPoints = 24; % how many 2^point calculations to go up to
samplingDist = truncate(makedist('Normal', 'mu', 2.33, 'sigma', 1.31), a, b); % define distribution with hyperparamters
%--------------main function-------------
truthValue = integral(func,0,2*pi, 'RelTol', eps); % ground truth for comparison
%probabilitySeed = rng(204, 'twister'); % seed to generate same monte carlo
%inforation used during modification
arrayImportance = zeros(1,plotPoints); % storing results to graph error and time etc..
arrayRomberg = zeros(1, plotPoints);
arrayPoints = zeros(1, plotPoints);
arrayTimeImportance = zeros(1, plotPoints);
arrayTimeRomberg = zeros(1, plotPoints);
for i=1:plotPoints % run algorithms and store info
    arrayPoints(i) = 2^i;
    tic %start stopwatch
    arrayRomberg(i) = rombergsMethod(func, a, b, i+1); % run romberg to max order
    arrayTimeRomberg(i) = toc; % store time in array
    tic % do same for monte carlo
    arrayImportance(i) = importanceIntegration(func, arrayPoints(i), samplingDist); %monte carlo method run using sample dist
    arrayTimeImportance(i) = toc; % store time
end
errorRomberg = abs((truthValue-arrayRomberg)./(truthValue)); % calculate error for all trials of rombers
errorImportance = abs((truthValue-arrayImportance)./(truthValue)); % same for monte carlo 

figure; % plot errors
semilogy(1:plotPoints, errorRomberg, 'Color', 'red', 'LineStyle', 'none', 'Marker', 'o');
hold on
semilogy(1:plotPoints, errorImportance, 'Color', 'blue', 'LineStyle', 'none', 'Marker', 'x');
hold on
title('Absolute Relative Error Plot', 'Interpreter', 'latex', 'FontSize',20);
ylabel('Error Value ($\log_{10}$)', 'Interpreter', 'latex', 'FontSize',20);
xlabel('Function Computations ($\log_2$)', 'Interpreter', 'latex', 'FontSize',20);
legend({'Romberg Method', 'Monte Carlo Importance Sampling'}, 'FontSize',20, 'Interpreter', 'latex');
hold off

figure; % plot time 
semilogy(1:plotPoints, arrayTimeRomberg, 'Color', 'red', 'LineStyle', 'none', 'Marker', 'o'); % log plot
hold on
semilogy(1:plotPoints, arrayTimeImportance, 'Color', 'blue', 'LineStyle', 'none', 'Marker', 'x');
hold on
title('Computation Time Comparison (seconds)', 'Interpreter', 'latex', 'FontSize',20);
ylabel('Computation Time ($\log_{10}$)', 'Interpreter', 'latex', 'FontSize',20);
xlabel('Function Computations ($\log_2$)', 'Interpreter', 'latex', 'FontSize',20);
legend({'Romberg Method', 'Monte Carlo Importance Sampling'}, 'FontSize',20, 'Interpreter', 'latex', 'Location','northwest');
hold off
%---------------romberg-----------------
function value = rombergsMethod(func, a, b, n) % n = number of rows. direct relationship between n and function computations
r = zeros(n,n); % initialize table
h = b-a; % start with first row first point
func_a = func(a);
if (isnan(func_a))
    func_a = 0;
end
r(1,1) = (h/2)*(func_a + func(b)); % one trap to calculate
for i = 2:n % go through other rows
    h = h/2; % better approximation going down rows, more traps
    sum = 0; % temp value
    for k = 1:2:(2^(i-1)-1) % calculate
        sum = sum + func(a+k*h); % get summation of function values
    end
    r(i,1) = 0.5*r(i-1, 1) + sum*h; %store new approximation
    for j = 2:i % perform richardson extrapolation algorithm to get highest order
        r(i,j) = r(i, j-1) + ((r(i, j-1)-r(i-1,j-1))/(4^j -1)); % richardson formula for romberg
    end
end
value = r(n,n); % return best approximation
end
%--------------importance sampling on monte carlo integration----------------
function expectedValue = importanceIntegration(func, numberPoints, samplingDist)
    randomSamples = random(samplingDist, 1, numberPoints); % sample distribution
    functionValues = func(randomSamples)./(pdf(samplingDist,randomSamples)); % calculate function values for arbitrary pdf
    expectedValue = sum(functionValues, 'omitnan')*(1/numberPoints); % get expected values for iterations
end