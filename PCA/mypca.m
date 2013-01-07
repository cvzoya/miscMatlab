function[evecs,mean,evals] = mypca(X)
% Compute PCA dimensionality reduction on data matrix X, where each column
% is a data point, and each row represents a variable. The transpose trick
% is used to reduce computation in case the number of data points is less
% than the number of variables. Returned are the eigenvectors ('evecs'), 
% eigenvalues ('evals'), and the 'mean' taken over all the datapoints, 
% used for mean-centering the data.

% Zoya Gavrilov, Jan. 7, 2013

if nargin < 1, error('Please provide a data matrix X as input'); end

[m,n] = size(X);
mean = sum(X,2)/n;      % compute mean of data
X = X-repmat(mean,1,n); % substract the mean

% perform the transpose trick (see below) for computation efficiency
if n < m
    cov = X'*X/n; % compute n*n covariance matrix
else
    cov = X*X'/n; % compute m*m covariance matrix        
end

[evecs,evals]=eig(cov);  %eigendecomposition
evals = diag(evals);

% Sort eigenvectors by eigenvalues
[~,p]=sort(evals,'descend');
evals = evals(p);

% Plot the eigenvalues
plot(1:size(evals,1),evals,'r-');
title('Eigenvalues');
xlabel('Eigenvalue Number');
ylabel('Eigenvalue');

evecs = evecs(:,p);

% according to the transpose trick, if v is an eigenvector of X'*X then Xv
% is an eigenvector of X*X' with the same eigenvalue
if n < m
    evecs = X*evecs; 
end

% normalize eigenvectors
evecs = normc(evecs);

% to project data onto eigenvectors, compute: evecs'*X

