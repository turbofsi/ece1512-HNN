function W = hopweights2(DATA)
%
% function W = hopweights2(DATA)
%
% Hopfield weights via an optimized Hebbian learning process. Adapted from
% MacKay P. 516.
%
% INPUTS:
%       DATA:   NxI, N memories to store, I neurons (binary)
% OUTPUTS:
%       W:      NxN, optimized weight matrix
[N, I] = size(DATA);     % I is the number of Nuerons, N is number of
                        % stored memories
X = DATA;               % initialize data
t = DATA;
% turns -1s to 0s (the reverse of dataprep.m)
for i = 1:N
    for j = 1:I
        if DATA(i,j) == -1
            t(i,j) = 0;
        end
    end
end
eta = 0.1;
alpha = 1;
% eta=0.1 and alpha=1 seem to be the best combination
W = X' * X;               % initialize weights via Hebb?s rule
SoS_old = 0;
SoS_new =1;
%for i = 1:L
Wcount =0;
while abs(SoS_new-SoS_old)>0.01
    if Wcount == 10000
        break
    end
    SoS_new - SoS_old
    W_old = W;
    SoS_old = SoS_new;
    Wcount = Wcount+1;
    for i = 1:I
        W(i,i) = 0;
    end
    a= X*W;
    Y= 1./(1+exp(-a));
    e= t-Y;
    gw = X' * e;
    gw=gw + gw';
    W = W + eta*(gw-alpha*W);
    SoS_new = sum(sum((W-W_old).^2,1));
end