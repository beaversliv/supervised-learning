function [MSE_all_train,MSE_all_test] = LinearReg_all_attributs(data_X,data_y,run)
% The function is to perform linear regression using all attributes
% input:
  % data_X:  independent variable
  % data_y:  dependent variable
  % run: number of runs
  
% output:
  % MSE_all_train: training error, with two values, MSE_all_train(1) = MSE,
  % MSE_all_train(2) = std(MSE)
  % MSE_all_test:  test error, with two values, MSE_all_test(1) = MSE,
  % MSE_all_test(2) = std(MSE)
MSE_all_test = [];
MSE_all_train = [];
MSE_train = [];
MSE_test = [];
    for i  = 1:run
        [x_train, y_train, x_test,y_test] = split_data(data_X, data_y, 2/3); % (2/3,1/3) random split data
        m = size(x_train,1); % size of training set
        one_train=ones(m,1); % avector of ones
        n = size(x_test,1); % size of test set
        one_test=ones(n,1);% avector of ones
        X_train = [x_train,one_train];
        X_test = [x_test,one_test];
        w = (X_train'*X_train)^(-1)*X_train'*y_train; % weight vector 
        %w = X_train\y_train_all;
        y_train_hat = (X_train*w); % predict using x_train
        y_test_hat = (X_test*w); % predict using x_test
        SSE_train = (y_train-y_train_hat).^2;
        SSE_test = (y_test-y_test_hat).^2;
        MSE_test(i) =sum(SSE_test)/n; % test error
        MSE_train(i) = sum(SSE_train)/m; % train error
        fprintf('\n Iteration %d/%d has done!\n',i,run);
    end
    disp(' End of iteration! ');
    MSE_all_test(1) =mean(MSE_test); % average the results
    MSE_all_train(1) = mean(MSE_train) ; % average the results
    MSE_all_test(2) = std(MSE_test); % standard deviation of test error
    MSE_all_train(2) = std(MSE_train); % standard deviation of train error
end
