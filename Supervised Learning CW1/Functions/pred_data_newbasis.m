function mse_test = pred_data_newbasis(x_test,y_test,w)
% The function is to predict with the new basis {sin(1*pi*x),sin(2*pi*x),...,sin(k*pi*x)}
% input:
  % x_test: test data
  % y_test: test data
  
% output:
  % mse: mean squared error for the test data
  
k = length(w);
X = []; 
m = length(y_test);
for i = 1:k
    X(:,i) = sin(i*pi*x_test); %polynomial basis
end
y_pred = X*w; % prediction
SSE = (y_test-y_pred).^2;
mse_test = sum(SSE)/m; %mean squared error
end
