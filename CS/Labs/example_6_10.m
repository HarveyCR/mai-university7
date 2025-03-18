AB = [A B];
row_count = size(AB, 1);
col_count_A = size(A, 2);
col_count_B = size(B, 2);
row_ones = ones(1, col_count_B);
xs = zeros(col_count_A, col_count_B);

for col = 1:col_count_A-1
    [adsmax, index] = max(abs(AB(col:end, col)));
    if index > 1
        AB([index+col-1 col],:) = AB([col index+col-1],:);
    end
    AB(col+1: end, col: end) = AB(col+1:end, col: end) - ...
    (AB(col+1: end,col)./AB(col,col)) *AB(col, col:end);
end


for row = row_count:-1:1
    if row == row_count
        x(row, :) = AB(row, col_count_A+1:end)./AB (row, row);
    
    elseif row==row_count-1    
        x (row, :) = (AB(row,col_count_A+1:end)-...
        AB(row, row+1).*x(row+1, :)) ./ AB(row, row);
    
    else    
        x(row,:) = (AB(row,col_count_A+1:end) - ...
        dot(AB (row, row+1:col_count_A)'*row_ones,...
        x(row+1:end,:)))./AB(row, row);
    end
end