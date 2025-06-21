function sortedArray = sort_simple_selection(array)
    n = length(array);
    for i = 1:n-1
        % Assume the minimum is the first element
        minIndex = i;
        % Test against elements after i to find the smallest
        for j = i+1:n
            if array(j) < array(minIndex)
                minIndex = j;
            end
        end
        % Swap the found minimum element with the first element
        if minIndex ~= i
            temp = array(i);
            array(i) = array(minIndex);
            array(minIndex) = temp;
        end
    end
    sortedArray = array;
end