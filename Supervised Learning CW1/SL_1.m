%%
% In Question 1 we perform linear regression with data
% set{(1,3),(2,2),(3,0),(4,5)} and the basis{1,x,x^2,x^3}
clear all;
close all;
clc;
addpath('Functions\');
%%
% (a) superimposing the curves corresponding to each fit.
x = [1,2,3,4]';
y = [3 2 0 5]';
k_n = 4;
w_n = []; % the coefficients of fitted equation
x_plot = 0:0.01:5;
y_plot = [];
MSE = []; % mean squared error
for p = 1:k_n
    [w_n,y_plot,mse]= LinearReg(x,y,x_plot,p); % a userdefined function for linear regression
    MSE(p) = mse;
    plot(x_plot,y_plot,'LineWidth',1.5)   
    str{p}=['k= ' num2str(p)];
    hold on
end
plot(x,y,'r*')
hold off
title('superimposed plot of fitted data')
xlabel('X')
ylabel('Y')
legend(str); 
%%
% b) the equations corresponding to the curves fitted for k = 1,2,3,4
[w_1,y_plot1,mse1]= LinearReg(x,y,x_plot,1);
[w_2,y_plot2,mse2]= LinearReg(x,y,x_plot,2);
[w_3,y_plot3,mse3]= LinearReg(x,y,x_plot,3);
[w_4,y_plot4,mse4]= LinearReg(x,y,x_plot,4);
disp(['k = 1, the equations is ',num2str(w_1(1))])
disp(['k = 2, the equations is ',num2str(w_2(1)),' + ',num2str(w_2(2)),'x'])
disp(['k = 3, the equations is ',num2str(w_3(1)),' ',num2str(w_3(2)),'x + ',num2str(w_3(3)),'x^2'])
disp(['k = 4, the equations is ',num2str(w_4(1)),' + ',num2str(w_4(2)),'x ',num2str(w_4(3)),'x^2 + ',...
    num2str(w_4(4)),'x^3'])

%%
% (c) plot the MSE for each fitted curve
k_c = 1:4;
figure(2)
plot(k_c,MSE)
title('Mean Squared Error of four dimensions')
xlabel('k')
ylabel('error')
disp('the mean squared error for the four fitted curves')
MSE