function [x,g] = generate_data(num,sigma)
% The function is to generate simulated data
% input:
  % num: number of data need to generate
  % sigma: standard deviation of normal data
  
% output:
  % x: x
  % g: sin(2*pi*x).^2 +error

x = rand(num,1); %uniform distributed data
error = normrnd(0,sigma,num,1); %noise random variable normal distributed with mean 0 and std 0.07
g = sin(2*pi*x).^2 +error;
end

