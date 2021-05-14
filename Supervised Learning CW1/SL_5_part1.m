%% Question 5 part 1
% the code for question5 will be divided into 2 part, this part is part 1.
% In this part we run KRR only one time and part 2 will run 20 times.
% 2/3 of data for training, 1/3 for test, and the results will run 20 times
clear all;
close all;
clc;
%% load data
addpath('Functions\'); % add path of the function files
load('Bostondata.mat'); % load original data
data_X = table2array(Bostondata(:,1:end - 1)); % independent variable
data_y = table2array(Bostondata(:,end)); % dependent variable

%% a)set parameters
random_run = 20; % the random number 
gamma = 2.^(-40:-26);
sigma = 2.^(7:0.5:13);
gamma_ = 2.^(-40:-26);
sigma_ = 2.^(7:0.5:13);
[g, s] = meshgrid(gamma_, sigma_);
[G, S] = meshgrid(gamma, sigma); % divide the grid
[rows, columns] = size(G);
G = G(:);
S = S(:);
dim_S = length(S);

%% b) train model
    % (1) Perform KRR on the training set using K-fold cross-validation 
    [X_train, y_train, X_test,y_test] = split_data(data_X, data_y, 2/3); % split train data and test data
    five_fold_score = zeros(dim_S, 1);
    for j = 1:dim_S
        five_fold_score(j) = k_fold_cv(X_train, y_train, G(j), S(j), 5); % use 5-fold cross-validation to compute
    end
    [val, idx] = min(five_fold_score);
    gamma = G(idx);
    sigma = S(idx);
    disp(['gamma is ',num2str(gamma),' sigma is ', num2str(sigma)])
    % (2) Compute MSE 
    K_train = kernel_matrix(X_train, X_train, sigma); % compute kernel of training datas
    alpha = dual_weight_krr(K_train, y_train, gamma); % commpute alpha 
    mse_train = kernel_mse(K_train, y_train, alpha)% compute MSE
    
    K_test = kernel_matrix(X_test, X_train, sigma); % compute kernel of test datas
    mse_test = kernel_mse(K_test, y_test, alpha) % compute MSE


%% plot cross validation error
cv_score = reshape(five_fold_score, rows, columns);
surf(log(g), log(s), log(cv_score));
box on
xlabel('log(\gamma)');
ylabel('log(\sigma)');
zlabel('log(Score)');
title('5-fold-cross-validation');
colorbar;




