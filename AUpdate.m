function Xnew = AUpdate(X,W)
[m, n] = size(W);
a = zeros(m,1);
Xnew = zeros(size(X));
for i = 1:m
    a(i) = W(i,:)*X'; 
    if a(i)>=0
        Xnew(i) = 1;
    else
        Xnew(i) = -1;
    end
end