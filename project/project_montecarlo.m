%Javier Salazar 1001144647 9/29/18
%Monte Carlo Integration Techniques (Method 2)
%-----------parameters-----------------------
clc
clear all
iterations = 1000;
domain = [0, 2*pi];
func = @(x) (1-cos(x))./x;
plotOption = "Yes";
relativeTolerence = 1e-12;
rng('shuffle');
probabilitySeed = rng(564, 'twister');
%-----------computations (main function)----------------------------------
truthValue = integral(func,0,2*pi, 'RelTol',relativeTolerence);
[integralValueUniform, uniformPlot, ~] = integrateFunction(iterations, func, "Uniform", domain, probabilitySeed);
[integralValueImportance, importancePlot, samplingDist] = integrateFunction(iterations, func, "Importance", domain, probabilitySeed);
plotFunction(iterations, uniformPlot, importancePlot, func, truthValue, samplingDist, plotOption)
%-------------------------------------------------------
function [expectedValue, plotY, samplingDist] = integrateFunction(iterations, func, sampling, domain, probabilitySeed)
if (sampling == "Uniform")
     rng(probabilitySeed);
     randomSamples = domain(1) + (domain(2)-domain(1)).*rand(iterations,1);
     functionValues = func(randomSamples);
     plotX = 1:1:iterations;
     plotY = cumsum(functionValues').*(1./plotX)*(domain(2)-domain(1));
     expectedValue = plotY(end);
     samplingDist = 0;
end
if (sampling == "Importance")
    rng(probabilitySeed);
    samplingDist = truncate(makedist('Normal', 'mu', 2.33, 'sigma', 1.31), domain(1), domain(2));
    rng(probabilitySeed);
    randomSamples = random(samplingDist, 1, iterations);
    functionValues = func(randomSamples)./(pdf(samplingDist,randomSamples));
    plotX = 1:1:iterations;
    plotY = cumsum(functionValues).*(1./plotX);
    expectedValue = plotY(end);
end
end

function [] = plotFunction(iterations, uniformPlot, importancePlot, func, truthValue, samplingDist, plotOption)
if (plotOption == "Yes")
    xPlot = linspace(0, 2*pi, 1000);
    yPlot = func(xPlot);
    figure
    plot(xPlot, yPlot, 'Color', 'red');
    hold on
    plot(xPlot,pdf(samplingDist,xPlot),'Color','blue')
    legend({'Integrable Function', 'Truncated Gaussian $\mu$=2.33 $\sigma$=1.31'}, 'FontSize',20, 'Interpreter', 'latex');
    title('Integrable Function $f(x) = \frac{1-\cos(x)}{x} \quad 0 < x \leq 2\pi$ and Sampling Distribution', 'FontSize',20, 'Interpreter', 'latex');
    xlabel('x value', 'FontSize',20, 'Interpreter', 'latex');
    ylabel('pdf value and function value', 'FontSize',20, 'Interpreter', 'latex');
    hold off
    
    plotX = 1:1:iterations;
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
    
    errorPlotUniform = abs((truthValue-uniformPlot)/(truthValue));
    errorPlotImportance = abs((truthValue-importancePlot)/(truthValue));
    figure;
    semilogy(errorPlotUniform, 'Color', 'red');
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
