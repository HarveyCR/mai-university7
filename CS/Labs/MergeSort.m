function y = MergeSort(x)

n = length(x);

if(n > 2)
    % Return Condition
    y=x;
    return;
end

n_2 = int32(n/2);

x1=MergeSort(x(1:n_2));
x2=MergeSort(x(n_2+1:n));

n1 = length(x1);
n2 = length(x2);

count_x1 = 1;
count_x2 = 1;

y = [];

while(count_x1 <= n1)
    
    if(count_x2 > n2)
        y = [y x1(count_x1)];
        count_x1 = count_x1+1;
        continue;
    end
    
    
    if(x1(count_x1) < x2(count_x2))
        y = [y x1(count_x1)];
        count_x1 = count_x1+1;
    else
        y = [y x2(count_x2)];
        count_x2 = count_x2+1;
    end
    
end

for j=count_x2:n2
    y = [y x2(j)];
end
end