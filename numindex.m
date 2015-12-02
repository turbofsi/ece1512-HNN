function index = numindex(D)

[m n] = size(D);
index = zeros(m,2);
for j= 1:m 
	if D(j,:) == [1 0 0 0 0 0 0 0 0 0] 
		index(j,:) = [j 0];
	elseif D(j,:) == [0 1 0 0 0 0 0 0 0 0] 
		index(j,:) = [j 1];
	elseif D(j,:) == [0 0 1 0 0 0 0 0 0 0] 
		index(j,:) = [j 2];
	elseif D(j,:)==[0 0 0 1 0 0 0 0 0 0]  
		index(j,:) = [j 3];
	elseif D(j,:)==[0 0 0 0 1 0 0 0 0 0]  
		index(j,:) = [j 4];
	elseif D(j,:)==[0 0 0 0 0 1 0 0 0 0]  
		index(j,:) = [j 5];
	elseif D(j,:)==[0 0 0 0 0 0 1 0 0 0]  
		index(j,:) = [j 6];
	elseif D(j,:)==[0 0 0 0 0 0 0 1 0 0]  
		index(j,:) = [j 7];
	elseif D(j,:)==[0 0 0 0 0 0 0 0 1 0]  
		index(j,:) = [j 8];
	else
		index(j,:) = [j 9]; 
	end 
end