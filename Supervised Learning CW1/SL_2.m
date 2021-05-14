%% 
%Question 2. Discuss the phenomena of overfitting
clear all;
close all;
clc;
addpath('Functions\');
%%
% (a) i plot the simulated data
[x_train,y_train] = generate_data(30,0.07); % simulated data
x_plot = 0:0.01:1;
y_pred = sin(2*pi*x_plot).^2;
plot(x_train,y_train,'.')
hold on
plot(x_plot,y_pred,'LineWidth',1.5);
hold off
title('plot of function with simulated data')
xlabel('x')
ylabel('g')
%%
%(a) ii fit data
%This part plot fitted curves with different dimension k values
%please see and run this part in another file called part2_kplot.m

% k_vec = [2 5 10 14 18]; % polynomial dimension
 x_pred = 0:0.01:1;
% please add a breakpoint at line 27, and run section with step out each time
% then you will see 5 curves superimposed over a plot of data points with different k values
% for k1 = 1:length(k_vec)
%     k = k_vec(k1);
%     [w,y_pred,mse] = LinearReg(x_train,y_train,x_pred,k1);
%     str=['k= ' num2str(k)];
%     plot(x_train,y_train,'.')
%     hold on
%     plot(x_pred,y_pred, 'LineWidth',1.5);
%     hold off
%     title('superimposed plot of fitted data')
%     xlabel('x')
%     ylabel('g')
%     legend(str);
% end

%%
% (b)calculate training error using log(MSE)
ln_MSE = [];
for k2 = 1:18
    [w,y_pred,mse] = LinearReg(x_train,y_train,x_pred,k2);
    ln_MSE(k2) = log(mse);   
    fprintf('\n  k = %d, log(MSE) of traing data is %d ',k2,log(mse));
end
k = 1:18;
plot(k,ln_MSE);
title('training error')
xlabel('k')
ylabel('natural log of training error')
%%
% (c) generate test data and calculate test error using log(MSE)
[x_test,y_test] = generate_data(1000,0.07);
ln_MSE_test = [];
for k3 = 1:18
    [w,y_pred,mse_train] = LinearReg(x_train,y_train,x_pred,k3);
    mse_test = pred_data(x_test,y_test,w); %test error
    ln_MSE_test(k3) = log(mse_test); %log(MSE)
    fprintf('\n  k = %d, log(MSE) of test data is %d ',k3,log(mse_test));
end
k = 1:18;
plot(k,ln_MSE_test);
title('test error')
xlabel('k')
ylabel('natural log of test error')

%%
%(d) average results of 100 runs
num_run = 100;
num_k = 18;
x_pred = 0:0.01:1;
ln_MSE_train = [];
ln_MSE_test_d = [];
for k4 = 1:num_k  %loop the polynomial basis
    disp(['k = ',num2str(k4)])
    MSE_train = [];
    MSE_test = [];
    for run = 1:num_run %loop 100 runs
        [x_train,y_train] = generate_data(30,0.07); % generate train data
        [x_test,y_test] = generate_data(1000,0.07); % generate test data
        [w,y_pred,mse_train] = LinearReg(x_train,y_train,x_pred,k4);
        mse_test = pred_data(x_test,y_test,w); % test error
        MSE_train(run) = mse_train;
        MSE_test(run) = mse_test;
        fprintf('\n  k = %d, iteration %d/100 has done!\n',k4,run);
    end
    ln_MSE_train(k4) = log(mean(MSE_train)); %log(avg_MSE) for training data
    ln_MSE_test_d(k4) = log(mean(MSE_test)); %log(avg_MSE) for test data
end
disp('  End of iteration! ');
k_test_train = 1:18;

% plot two figures
figure(1)
plot(k_test_train,ln_MSE_train);
title('train error')
xlabel('k')
ylabel('natural log of train error')

figure(2)
plot(k_test_train,ln_MSE_test_d);
title('test error')
xlabel('k')
ylabel('natural log of test error')
