% This program is for Experiment 1 which shows the capacity of HNN
close all;
clear;
load semeion.data; %load data
X = semeion;
XX = X(:,1:256);
%possible training set
data(1,:) = XX(2,:);
data(2,:) = XX(25,:);
data(3,:) = XX(44,:);
data(4,:) = XX(64,:);
data(5,:) = XX(87,:);
data(6,:) = XX(104,:);  
data(7,:) = XX(124,:);  
data(8,:) = XX(143,:); 
data(9,:) = XX(165,:); 
data(10,:) = XX(180,:); 
% for i = 1 : 10
%     Y = reshape(data(i,:),16,16);
%     subplot(2, 5, i);
%     imshow(Y')
% end
[n, I] = size(data);
datamones = data - ones(size(data));
newdata = data + datamones;
t = data;
eta = 0.01;
alpha = 0.01;
w = newdata' * newdata;
S_old = 0;
S_new = 1;
wcount = 0;
while abs(S_new - S_old) > 0.01
    if wcount == 10000
        break; 
    end
    S_new - S_old
    w_old = w;
    S_old = S_new;
    wcount = wcount + 1;
    %construct weight matrix
    for i = 1:I
        w(i,i) = 0;
    end
    a = newdata*w;
    y = 1./(1 + exp(-a));
    e = t - y;
    gw = newdata' * e;
    gw = gw + gw';
    w=w+ eta*(gw-alpha*w); S_new = sum(sum((w-w_old).^2,1));
end
XXones = XX - ones(size(XX));
newXX = XX + XXones;
Xerr(5,:) = newXX(9,:);
Xerr(7,:) = newXX(4,:);
Xerr(9,:) = newXX(27,:);
Xerr(11,:) = newXX(30,:);
%Xerror = newXX(22,:);
% Xerror = newXX(45,:);
% Xerror = newXX(63,:);
% Xerror = newXX(83,:);
% Xerror = newXX(103,:);
% Xerror = newXX(123,:);
% Xerror = newXX(144,:);
% Xerror = newXX(166,:);
% Xerror = newXX(181,:);
for h = 5:2:11
    Xerror = Xerr(h,:);
    Xtest = Xerror;
    X_new = Xtest;
    X_old = ones(size(Xtest));
    count = 0;
    while X_old*X_new' ~= length(Xtest)
        count = count +1;
        % step 3: (A)synchonous update
        if count == 50
            break; 
        else
            X_old = X_new; % previous new is now old
            X_new = AUpdate(X_old,w);
        end
    end
    count
    %plot initial state and stable state it converges to
    Y = reshape(Xerr(h,:),16,16);
    subplot(4,2,h-4);
    imshow(Y');
    title('Initial State');
    X = reshape(X_new, 16, 16);
    subplot(4,2,h-3);
    imshow(X');
    title('Stable State');
end