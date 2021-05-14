function [alpha] = dual_weight_krr(K, y, gamma)
% The function is to perform kernel ridge regression 
% input:
  % K : kernel matrix
  % y : a vector
  % gamma: ridge parameter, a scalar 
  
% output:
  % alpha: dual weights
l = size(y,1); % the row numbers of y
alpha = (K + gamma*l*eye(l))\y; 
end

