%% 
%Question 2. Discuss the phenomena of overfitting
clear all;
close all;
clc;
addpath('Functions\');

%%
%(a) ii fit data and plot with different k values
[x_train,y_train] = generate_data(30,0.07); % simulated data
x_plot = 0:0.01:1;
k_vec = [2 5 10 14 18]; % polynomial dimension
m = length(x_train);
for k1 = 1:length(k_vec)
    k = k_vec(k1);    
    X=zeros(m,k);
    X_test = zeros(length(x_plot),k);
    for i = 1:k
        X(:,i) = x_train.^(i-1); % creating the basis matrix
        X_test(:,i) = x_plot.^(i-1); 
    end
    w = (X'*X)^(-1)*X'*y_train;
    y_pred = (X_test*w)'; 
    str{k1}=['k= ' num2str(k)];
    plot(x_plot,y_pred, 'LineWidth',1.5);
    hold on
end
    plot(x_train,y_train,'.')
    hold off 
    title('superimposed plot of fitted data')
    xlabel('x')
    ylabel('g')
    legend(str);
