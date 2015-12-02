function W = hopweights(DATA)
%
% function W = hopweights(DATA)
%
% This function determines the weights of a Hopfield network vis Hebbian
% learning.
%
% INPUTS:
%       DATA:
% OUTPUTS:
%       W:
[N, dim] = size(DATA);
eta = 1/N;
W = zeros(dim,dim);
for i = 1:dim
    for j = 1:dim
        if i == j
            W(i,j) = 0;
        else
            Xi = DATA(:,i);
            Xj = DATA(:,j);
            W(i,j) = Xi' * Xj;
        end
    end
end
