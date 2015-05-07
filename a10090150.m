% Zachary Baum ~ 10090150 ~ 12zmcb
% CISC 271 Assignment 1 ~ Winter 2015

function [Bspace, Nspace] = a1(A, b)

% Creates an augmented matrix from A and b and puts it into RREF.

augmentedMatrix = rref([A b]);

% Now we find the Basic solution for Ax = b, by removing the last column 
% from the RREF of the augmented matrix of A and b as it is the basic
% solution for the problem.

Bspace = augmentedMatrix(:,length(augmentedMatrix));

% Next, we create the null space vector by taking the free variables from
% the augmented matrix. We do this by:
%
% First, finding the RREF of A, and the basis vectors. From that, we know
% the rank of the matrix A.

[reducedA, basisVecs] = rref(A);
matRank = length(basisVecs);
        
% Determine the non basis vectors by eliminating the numbers of the columns
% from the vector that has numbers going from 1:length(A). This allows us
% to pick the rows of the identity later on.

m = length(A);
nonBasis = 1:length(A);
nonBasis(basisVecs) = [];


% Next we find the size of the Null Space by making it of dimension
% m by m-r.

Nspace = zeros(m, m - matRank);

% Then, if the length of A is greater than the rank of A, we fill the Null
% Space with the identity matrix of the corresponding columns where they
% are needed in the final Null Space.

if m > matRank
    Nspace(nonBasis,:) = eye(m - matRank,m - matRank);
    
% Lastly, if the rank of A is greater than 0, we take the Null Space which
% holds length(toFill) columns and we put in the negative of the RREF of
% matrix A from the section that is from the 1st entry to the nth entry;
% where n is the rank of the matrix.
    
    if matRank > 0
        Nspace(basisVecs,:) = -reducedA(1:matRank,nonBasis);
    end
end