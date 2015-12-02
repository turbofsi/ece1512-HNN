% Main loop for experiment 2. To illustrat how could we improve the
% capacity of hopfield network. Also better shows the trend of # of
% memories stored in the network and # of corrected convergence
clear;
load semeion.data;
DATA = semeion(:,1:256);
index = numindex(semeion(:,257:266));
DP = [dataprep(DATA) index(:,2)];       
% Divide data into 10 matrices containing one number each
H_zeros = DP(index(:,2)==0,:);
H_ones = DP(index(:,2)==1,:);
H_twos = DP(index(:,2)==2,:);
H_threes = DP(index(:,2)==3,:);
H_fours = DP(index(:,2)==4,:);
H_fives = DP(index(:,2)==5,:);
H_sixes = DP(index(:,2)==6,:);
H_sevens = DP(index(:,2)==7,:);
H_eights = DP(index(:,2)==8,:);
H_nines = DP(index(:,2)==9,:);
% Matrix of stored memories
memories = [H_zeros(1,:); H_ones(1,:); H_twos(1,:); H_threes(1,:); ...
    H_fours(1,:); H_fives(1,:); H_sixes(1,:); H_sevens(1,:); ...
    H_eights(1,:); H_nines(1,:)];
[m, n] = size(memories);
% Matrix of validation data
testdata = [H_zeros; H_ones; H_twos; H_threes; H_fours; H_fives; ...
    H_sixes; H_sevens; H_eights; H_nines];
[N, n] = size(testdata);
% Determine weights
% Standard vs. Optimized
%W = hopweights(memories(:,1:256));      % standard hebb learning rule
% determine weights with modified formula for increased storage
W = hopweights2(memories(:,1:256));     % optimized weights
% test loop
results = zeros(N,2);
for i=1:N
	Xtest = testdata(i,1:256); % Test image
	testNumber = testdata(i,257); % Test number written 
    X_new = Xtest;
	X_old = ones(size(Xtest));
	count = 1; % number of iterations in update loop
	% Stopping condition is where there is no change in states between
	% iterations
	while X_old*X_new' ~= length(Xtest)
	    count = count + 1;
	    % Asynchronous update
	    if count == 100
            break 
        else
	        X_old = X_new; % the new image is now is now old
	        X_new = AUpdate(X_old,W);   % perform asynchronous update
	    end
	end
	% compare X_new to memories to determine difference
	bits = zeros(m,1);
	for j = 1:m
	    diff = X_new.*memories(j,1:256);
	    bits(j) = length(diff(diff~=1));
	end
	% choose closest match to memory
	[bitmin, match1] = min(bits);
	[bitmax, match2] = max(bits);
	if memories(match1,257) == testNumber
	% 1 or -1
	% # of flipped bits
	    results(i,1) = 1;       % note that it's correct
	    results(i,2) = bitmin;  % store minimum # of bits flipped
	elseif bitmax == 256        % in case inverse of memory is stable
	    results(i,1) = 1;       % note that it's correct
	    results(i,2) = bitmax;  % store number of bits off
	else                        % incorrect
	    results(i,2) = 1000;
	end
end