function K = kernel_matrix(X1, X2, sigma)
% This function computes Kernel matrix K(X_i,X_j).

% input：
  % X1,X2： training data or test data
  % sigma: the parameter for the gaussian kernel function.

% output:
  % K: Kernel matrix
X1row = size(X1,1);
X2row = size(X2,1);
K = zeros(X1row, X2row);
for i = 1:X1row
    K(i,:) =  exp(-sum((repmat(X1(i,:),X2row,1)-X2).^2,2) ./(2*sigma^2)) ;  % Vectorised
end
end