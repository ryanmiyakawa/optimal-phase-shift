% This is a function for computing optimal thickness from a given phase
% shift


% optimalThickness = f(n, phaseShift)

% function [output1, output2, ...] = functionName(input1, input2, ...)



%{

1. hyphenation:

my-variable


2. camel case

myGreatVariable

3. underscores:

my_variable



%}


function d = optimalThickness(n2, phaseShift)

lambda = 13.5;
n1 = 1;
theta1 = 6*pi/180; % 6 degrees
theta2 = asin(n1/n2 * sin(theta1));




d = phaseShift * lambda/(4*pi * (n1/cos(theta1) - n2/cos(theta2) ));


% if d is negative, then this is not realistic, and we need to look for
% another solution


counter = 0;
while (d < 0)
    % Then we know that d is too small, and we'd like to choose the next
    % value
    
    phaseShift = phaseShift - 2*pi;
    counter = counter + 1;
    
    d = (phaseShift) * lambda/(4*pi * (n1/cos(theta1) - n2/cos(theta2) ));
    
    
    if (counter > 50)
        disp('Were likely in an infinite loop')
        break %abort the while loop
    end
    
end









