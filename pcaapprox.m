function [approxComponents, approxVector] = pcaapprox(newData, approxnum, meanVec, eigenvectorMatrix)

% Approximates some new data based on a Principal Components Analysis.
%
%
% pcaapprox takes as parameters:
%
% newData - a column vector to be approximated.
% approxNum - a value giving the order of the approximation.
% meanVec - the PCA mean vector (from PCAPRELIM)
% eigenvectorMatrix - the eigenvectors of the PCA, taken from the PCA
% prelim work that was performed on the dataset.
%
%
% pcaapprox(newData, approxNum, meanVec, eigenvectorMatrix) returns:
%
% approxComponents - The components as a row vector of scalar values.
% approxVector - The approximation of the newData as a vector.

diffvec = newData - meanVec;
approxComponents = zeros(approxnum, 1);
approxVector = meanVec;

% Loop through the eigenvectors, finding the components
% and building the approximation
for i = 1:approxnum
    evec = eigenvectorMatrix(:, i);
    beta = dot(diffvec, evec);
    approxComponents(i, 1) = beta;
    approxVector = approxVector + beta * evec;
end