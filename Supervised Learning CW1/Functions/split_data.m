function [X_train, y_train, X_test,y_test] = split_data(X, y,train_size)
% This function randomly splits a given sample data set X and y with a defined fraction train_size,
% input：
  % X：independent variable
  % y：dependent variable
  % train_size: the size for training data set 
  
% output:
  % X_train: training data
  % y_train: training data
  % X_test: test data
  % y_test: test data
ids = randperm(size(X,1)); % Shuffle data
X = X(ids,:);
y = y(ids,:);
test_frac = 1- train_size;
% divide data
X_train = X(1:floor(size(X,1)*train_size),:);
y_train = y(1:floor(size(X,1)*train_size));
X_test = X(floor(size(X,1)*test_frac) + 1:end,:);
y_test = y(floor(size(X,1)*test_frac) + 1:end);
end