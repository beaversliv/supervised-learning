%%
%Question 4
%Boston Housing Linear Regression
clear all;
close all;
clc;
%% load data
addpath('Functions\');
load('Bostondata.mat'); % load original data
data_X = table2array(Bostondata(:,1:end-1)); % independent variable
data_y = table2array(Bostondata(:,end)); % dependent variable
run = 20;
run_vec = 1:run;
%% (a) Naive Regression
MSE_a_train = [];
MSE_a_test = [];
for i = 1:run %loop for 20 runs and take average results
    x_naive = ones(size(data_y)); % create a vector of ones
    [x_train, y_train, x_test,y_test] = split_data(x_naive, data_y, 2/3); % random split data with 2/3 of training data and 1/3 of test data
    [w,y_pred,mse_train] = LinearReg(x_train,y_train,x_test,1); % training data
    [mse_test] = pred_data(x_test,y_test,w); % test data and test error
    MSE_a_train(i) = mse_train; % train error
    MSE_a_test(i) = mse_test; % test error
    fprintf('\n  Iteration %d/20 has done!\n',i);
end
mse_a_train = mean(MSE_a_train); %average of runs
mse_a_train_std = std(MSE_a_train); % standard deviation of training error
mse_a_test = mean(MSE_a_test);%average of runs
mse_a_test_std = std(MSE_a_test); % standard deviation of test error
disp(['MSE of train error is ',num2str(mse_a_train),' with standard deviation ',num2str(mse_a_train_std)])
disp(['MSE of test error is ',num2str(mse_a_test),' with standard deviation ',num2str(mse_a_test_std)])

% plot the result
x_a_plot = ones(size(data_y));
y_a_plot = x_a_plot.*w;
figure(1)
plot(linspace(0,2,size(data_y,1)),y_a_plot,'-');
hold on
plot(x_a_plot,data_y,'*')
hold off
title('naive regression')
xlabel('x')
ylabel('y')

%% (b) Linear Regression with one attribute
columns = size(data_X,2);
MSE_b_test = [];
MSE_b_train = [];
MSE_b_test_std = [];
MSE_b_train_std = [];
for j = 1:columns % loop single attribute
    x_single = data_X(:,j); %single attribute
    y_single = data_y; % dependent variable
    MSE_test_runs = [];
    MSE_train_runs = [];
    for i = 1:run %loop for 20 runs and take average results
        [x_train, y_train, x_test,y_test] = split_data(x_single, y_single, 2/3); %(2/3,1/3) random split
        [w,y_pred,mse_train] = LinearReg(x_train,y_train,x_test,2); % training data
        [mse_test] = pred_data(x_test,y_test,w); % test data 
        MSE_test_runs(i) = mse_test; % test error
        MSE_train_runs(i) = mse_train; % training error
        fprintf('\n  Attibute %d , iteration %d/20 has done!\n',j,i);
    end
    MSE_b_test(j) = mean(MSE_test_runs); %average of runs
    MSE_b_train(j) = mean(MSE_train_runs); %average of runs
    MSE_b_test_std(j) = std(MSE_test_runs); % standard deviation of test error
    MSE_b_train_std(j) = std(MSE_train_runs);% standard deviation of train error
end

% plot the results
x_label = {'CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','LSTAT'};
% x_label is the abbreviation of each attribute
n=size(x_label,2);
x_axis=1:1:n;
plot(x_axis,MSE_b_test);
hold on
plot(x_axis,MSE_b_train);
hold off
ylabel('mean squared error');
xlabel('attributes');
grid on;
set(gca,'xtick',x_axis);
set(gca,'xticklabel',x_label);
legend('test error','train error');
title('training error and test error for each attribute')
 %% (d) Linear Regression with all attributes
[MSE_all_train,MSE_all_test] = LinearReg_all_attributs(data_X,data_y,run); 
% a user defined function for linear regression using all attribution
% see more detail in LinearReg_all_attributs.m
disp([' MSE for training data is ',num2str(MSE_all_train(1)),' with std ',num2str(MSE_all_train(2))])
disp([' MSE for test data is ', num2str(MSE_all_test(1)),' with std ',num2str(MSE_all_test(2))])