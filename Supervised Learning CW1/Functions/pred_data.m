function mse_test = pred_data(x_test,y_test,w)
% This function is to caculate mse of test data
% input:
  % x_test: test data
  % y_test: test data
  % w: equation coefficient y = X*w

% output:
  % mse: mse of test data
k = length(w);
X = [];
m = length(y_test);
for i = 1:k
    X(:,i) = x_test.^(i-1);  %polynomial basis
end
y_pred = X*w; % prediction
SSE = (y_test-y_pred).^2; 
mse_test = sum(SSE)/m; % mean squared error
end
