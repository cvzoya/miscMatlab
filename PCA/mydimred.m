function[evecs,mean,coeffs,evals] = mydimred(X,type,num)
% Compute PCA dimensionality reduction on data matrix X, where each column
% is a data point, and each row represents a variable. 
% If type == 1, return the top num eigenvectors ('evecs') and eigenvalues
% ('evals') computed, and project X onto this basis of eigenvectors.
% If type == 2, return the eigenvectors that account for the top num% of
% the total variance in the data, and project X onto this basis. Also
% return the 'mean' taken over all the datapoints, used for mean-centering 
% the data. 'coeffs' is the projection of X onto the eigenbasis.

% Zoya Gavrilov, Jan. 7, 2013

if nargin < 3, error('Insufficient number of arguments.'); end
[evecs,mean,evals] = mypca(X);

if type == 1
    if num > length(evals)
       error('The third argument can not exceed the number of rows in X') 
    end
    evecs = evecs(:,1:num);
    evals = evals(1:num);
else
    if num < 0 || num > 100
       error('The third argument should lie between 0 and 100'); 
    end
    totvar = cumsum(evals)./sum(evals); % calculate variance accounted for 
    where = find(totvar >= num/100, 1); % first time variance >= num
    evecs = evecs(:,1:where);
    evals = evals(1:where);
end

coeffs = evecs'*X; % project X onto eigenvectors


