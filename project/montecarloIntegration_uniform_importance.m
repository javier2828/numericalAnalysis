%Javier Salazar 1001144647 9/29/18
%Monte Carlo Integration Techniques (Method 2)
%-----------parameters-----------------------
clc % clear command prompt
clear all % clear workspace
iterations = 1000; % point iterations to sample function
domain = [0, 2*pi]; % domain to be integrated
func = @(x) (1-cos(x))./x; % function to be integrated
sampleDistribution = 'Normal'; % sampling distribution for importance technique
hyperParameterA = 2.33; % mean or hyper parameter 1 for distribution
hyperParameterB = 1.31; % covariance or hyper parameter 2 for distribution
plotOption = "Yes"; % plot graphs or compute numbers only
relativeTolerence = 1*10^-9; % abs. relative tolerence for integral function built in matlab (quadrature technique)
rng('default'); % use the default pseudorandom generator
probabilitySeed = rng(678, 'twister'); % use same seed for uniform and importance for fair comparison %321, 234
%-----------computations (main function)----------------------------------
truthValue = integral(func,0,2*pi, 'RelTol',relativeTolerence); % ground truth for comparison
[integralValueUniform, uniformPlot, ~] = integrateFunction(iterations, func, "Uniform", domain, sampleDistribution, hyperParameterA, hyperParameterB); % uniform technique
[integralValueImportance, importancePlot, samplingDist] = integrateFunction(iterations, func, "Importance", domain, sampleDistribution, hyperParameterA, hyperParameterB); %importance technique
plotFunction(iterations, uniformPlot, importancePlot, func, truthValue, samplingDist, plotOption) % plot information
%-------------------------------------------------------
%--------------integration function---------------------
function [expectedValue, plotY, samplingDist] = integrateFunction(iterations, func, sampling, domain, sampleDistribution, hyperParameterA, hyperParameterB)
if (sampling == "Uniform")% uniform method from a to b
     randomSamples = domain(1) + (domain(2)-domain(1)).*rand(iterations,1); % generate random samples
     functionValues = func(randomSamples); % sample function
     plotX = 1:1:iterations; % plot values
     plotY = cumsum(functionValues', 'omitnan').*(1./plotX)*(domain(2)-domain(1)); % plot as a function of iterations
     expectedValue = plotY(end); % final value is the last iteration number
     samplingDist = 0; %needed for function not to throw errors, ignore.
end
if (sampling == "Importance") %reweighing sampling points based on distribution
    samplingDist = truncate(makedist(sampleDistribution, 'mu', hyperParameterA, 'sigma', hyperParameterB), domain(1), domain(2)); % define distribution
    randomSamples = random(samplingDist, 1, iterations); % sample distribution
    functionValues = func(randomSamples)./(pdf(samplingDist,randomSamples)); % calculate function values for arbitrary pdf
    plotX = 1:1:iterations; % plot iterations
    plotY = cumsum(functionValues, 'omitnan').*(1./plotX); % get expected values for iterations
    expectedValue = plotY(end); % final vaiue is final result
end
end
%-------------------------------------------------------------
%----------------------plotting function---------------------------
function [] = plotFunction(iterations, uniformPlot, importancePlot, func, truthValue, samplingDist, plotOption)
if (plotOption == "Yes")
    xPlot = linspace(0, 2*pi, 1000); %plot integrable function
    yPlot = func(xPlot);
    figure
    plot(xPlot, yPlot, 'Color', 'red');
    hold on
    plot(xPlot,pdf(samplingDist,xPlot),'Color','blue') % plot sample distribution with integrable function
    legend({'Integrable Function', 'Truncated Gaussian $\mu$=2.33 $\sigma$=1.31'}, 'FontSize',20, 'Interpreter', 'latex');
    title('Integrable Function $f(x) = \frac{1-\cos(x)}{x} \quad 0 < x \leq 2\pi$ and Sampling Distribution', 'FontSize',20, 'Interpreter', 'latex');
    xlabel('x value', 'FontSize',20, 'Interpreter', 'latex');
    ylabel('pdf value and function value', 'FontSize',20, 'Interpreter', 'latex');
    hold off
    
    plotX = 1:1:iterations; % plot truth value, uniform expectations. and importance expectations
    figure;
    plot(plotX, uniformPlot, 'Color', 'red');
    hold on
    plot(plotX, importancePlot, 'Color', 'blue');
    hold on
    plot(plotX,truthValue*ones(iterations), 'Color', 'green');
    ylabel('Expected Value', 'Interpreter', 'latex', 'FontSize',20);
    xlabel('Iteration', 'Interpreter', 'latex', 'FontSize',20);
    title('Monte Carlo Integration Methods', 'Interpreter', 'latex', 'FontSize',20);
    legend({'Uniform Sampling', 'Importance Sampling', 'Truth Value'}, 'FontSize',20, 'Interpreter', 'latex');
    hold off
    
    % plot absolute relative error for both uniform and importance methods
    errorPlotUniform = abs((truthValue-uniformPlot)/(truthValue));
    errorPlotImportance = abs((truthValue-importancePlot)/(truthValue));
    figure;
    semilogy(errorPlotUniform, 'Color', 'red'); % log plot
    hold on
    semilogy(errorPlotImportance, 'Color', 'blue');
    hold on
    title('Absolute Relative Error Plot', 'Interpreter', 'latex', 'FontSize',20);
    ylabel('Error Value', 'Interpreter', 'latex', 'FontSize',20);
    xlabel('Iteration', 'Interpreter', 'latex', 'FontSize',20);
    legend({'Uniform Sampling', 'Importance Sampling'}, 'FontSize',20, 'Interpreter', 'latex');
    hold off
end
end
%---------------------------------------------------------------------
