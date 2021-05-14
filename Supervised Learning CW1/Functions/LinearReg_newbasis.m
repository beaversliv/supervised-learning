function [w,mse_train] = LinearReg_newbasis(x_train,y_train,k)
% The function is to perform linear regression using new basis {sin(1*pi*x),sin(2*pi*x),...,sin(k*pi*x)}
% input:
  % x_train: training data
  % y_train: training data
  % k: dimension of polynomial basis
  
% output:
  % w: coefficient of the fitted equation y = X*w
  % mse_train: mean squared error of training data

m = length(x_train);
X=zeros(m,k);
w=zeros(k,1);
for i = 1:k
    X(:,i) = sin(i*pi*x_train); % creating the basis matrix
end
w = X\y_train;
SSE = (y_train-X*w).^2;
mse_train = sum(SSE)/m; %mean squared error of training data
end

