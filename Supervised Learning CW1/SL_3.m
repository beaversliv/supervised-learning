%%
% Question 3 
% Change the new basis {sin(1*pi*x),sin(2*pi*x),...,sin(k*pi*x)}
% repeat the experiments in 2(b-d)
clear all;
close all;
clc;
addpath('Functions\');
%%
% (a)calculate training error
[x_train,y_train] = generate_data(30,0.07); %generate training data
ln_MSE = [];
for k2 = 1:18
    [w,mse] = LinearReg_newbasis(x_train,y_train,k2);
    ln_MSE(k2) = log(mse);   %log(MSE)
    fprintf('\n  k = %d, log(MSE) of traing data is %d ',k2,log(mse));
end
k = 1:18;
plot(k,ln_MSE);
title('training error')
xlabel('k')
ylabel('natural log of training error')
%%
% (b) calculate test error
[x_test,y_test] = generate_data(1000,0.07); % generate test data
ln_MSE_test = [];
for k3 = 1:18
    [w,mse_train] = LinearReg_newbasis(x_train,y_train,k3);
    mse_test = pred_data_newbasis(x_test,y_test,w); %test error 
    ln_MSE_test(k3) = log(mse_test); %log(MSE)
    fprintf('\n  k = %d, log(MSE) of test data is %d ',k3,log(mse_test));
end
k = 1:18;
plot(k,ln_MSE_test);
title('test error')
xlabel('k')
ylabel('natural log of test error')

%%
%(c) average results of 100 runs
num_run = 100;
num_k = 18;
x_pred = 0:0.01:1;
ln_MSE_train = [];
ln_MSE_test_c = [];
for k4 = 1:num_k % loop polynomial basis
    disp(['k = ',num2str(k4)])
    MSE_train = [];
    MSE_test = [];
    for run = 1:num_run
        [x_train,y_train] = generate_data(30,0.07); % for each run re-generate train data
        [x_test,y_test] = generate_data(1000,0.07); % re-generate test data
        [w,mse_train] = LinearReg_newbasis(x_train,y_train,k4); % train error
        mse_test = pred_data_newbasis(x_test,y_test,w); %test error
        MSE_train(run) = mse_train; 
        MSE_test(run) = mse_test;
        fprintf('\n  k = %d, iteration %d/100 has done!\n',k4,run);
    end
    ln_MSE_train(k4) = log(mean(MSE_train)); %log(avg_MSE)
    ln_MSE_test_c(k4) = log(mean(MSE_test)); %log(avg_MSE)
end
disp('  End of iteration! ');
k_test_train = 1:18;

figure(1)
plot(k_test_train,ln_MSE_train);
title('train error')
xlabel('k')
ylabel('natural log of train error')

figure(2)
plot(k_test_train,ln_MSE_test_c);
title('test error')
xlabel('k')
ylabel('natural log of test error')