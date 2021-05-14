function [w,y_pred,mse_train] = LinearReg(x_train,y_train,x_test,k)
% The function is to perform linear regression
% input:
  % x_train: training data
  % y_train: training data
  % x_test: test data, this argument is useless except for plotting
  % k: dimension of polynomial basis
  
% output:
  % w: coefficient of the fitted equation y = X*w
  % y_pred: predict data using test data, this will be used for plotting
  % MSE: mean squared error of training data
m = length(x_train);
X=zeros(m,k);
X_test = zeros(length(x_test),k);
w=zeros(k,1);
for i = 1:k
    X(:,i) = x_train.^(i-1); % creating the basis matrix
    X_test(:,i) = x_test.^(i-1); 
end
w = X\y_train; % weight sector
% also you can try
%w = (X'*X)^(-1)*X'*y_train;
y_pred = (X_test*w)'; 
sse = (y_train-X*w).^2;
mse_train = sum(sse)/m; %mean squared error of training data
end

