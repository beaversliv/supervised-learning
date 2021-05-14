function score = k_fold_cv(X_train, y_train, gamma, sigma, k)
% This function is to perform KRR on the training set using K-fold cross-validation
% input:
  % x_train : training data
  % y_train : training data
  % gamma: a vector
  % sigma: a vector
  % k: number of folding cross-validation
  
% output:
  % score: a matrix
set_size = floor(size(X_train,1)/k); % size of single fold
remainder = mod(size(X_train,1),set_size); % remainder sample size
index = cell(k,1); % index for folds

for i = 1:k % set index for folds
    index{i} = set_size*(i - 1) + 1:set_size*i;
end

index{k} = [index{k} size(X_train, 1) - remainder + 1:size(X_train, 1)];
scores = zeros(k,1);
K_mat = kernel_matrix(X_train, X_train, sigma);% compute K for all folds
for i = 1:k
    every_y = y_train(index{i},:)  ;
    cat_y = vertcat(y_train([index{[1:i-1 i + 1:k]}],:)); %concat y
    
    K = K_mat;% Create temporary K for k-1 training folds
    K(index{i},:) = [];
    K(:,index{i}) = [];
    
    alpha = dual_weight_krr(K, cat_y, gamma); % dual weight
    K = K_mat(index{i},:);% Create temporary K for the testing
    K(:,index{i}) = [];
    scores  = kernel_mse(K, every_y, alpha);
end
score = mean(scores);
end