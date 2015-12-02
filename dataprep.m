function DH = dataprep(DATA)
%
% function DH = dataprep(DATA)
%
% this function converts binary data (0,1) into the proper format for a
% Hopfield network (-1,1)
%
% INPUTS:
%       DATA:   256xN, binary data of handwritten images
% OUTPUTS:
%       DH:     256xN, binary data converted to 1 & -1
D_mod = DATA - ones(size(DATA));    % modified to include only 0 and -1
DH = DATA + D_mod;