function  mse  = kernel_mse(K, y, alpha)
% The function is to calculate the Mean Squared Error (MSE) 
% input:
  % K : a kernel matrix
  % y : a vector
  % alpha: dual weights
% output:
  % mse: a single value
m = size(y,1); % rows of y
sse = (K*alpha - y)'*(K*alpha - y);
mse = sse/m; % calculate the Mean Squared Error (MSE)
end

