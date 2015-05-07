function [eigenvalueVector, meanVec, eigenvectorMatrix] = pcaprelim(Z)

% Performs the preliminary Principal Components Analysis
% (PCA) of A, a matrix in which the data are represented as columns.
%
%
% pcaprelim(Z) returns:
%
% eigenvalueVector - Eigenvalues of the PCA(Z) all sorted into
% non-ascending order.
% meanVec - Mean vector of the initial dataset Z.
% eigenvectorMatrix - Eigenvectors of the PCA(Z), as column vectors.

% Finds the mean vector and makes it the same size as Z.
% Uses mean(Z,2) to get the mean of the value in each column of a row.
[m, n] = size(Z);
meanVec = mean(Z, 2);
meanMat = meanVec * ones(1, n);

% Find the difference matrix by removing the mean from each value of Z.
diffMat = Z - meanMat;

% Find the covariance matrix.
covarMat = diffMat * diffMat' / (m - 1);

% Find the eigenvectors as a matrix and the eigenvalues as a vector.
[eVecs, eVals] = eig(covarMat);
diagEVals = diag(eVals);

% Sort the eigenvalues in non-ascending order.
[~, index] = sort(diagEVals, 1, 'descend');

% Reorder the original eigenvector matrix so that they correspond to the
% sorted eigenvalue vector.
eigenvalueVector = diagEVals(index);
eigenvectorMatrix = eVecs(:, index);
