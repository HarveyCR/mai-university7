function sortedArray = insertion_sort(inputArray)
    n = length(inputArray);
    sortedArray = inputArray; % Create a copy of the input array

    for i = 2:n
        key = sortedArray(i);
        j = i - 1;

        % Move elements of sortedArray[0..i-1], that are greater than key,
        % to one position ahead of their current position
        while j >= 1 && sortedArray(j) > key
            sortedArray(j + 1) = sortedArray(j);
            j = j - 1;
        end
        sortedArray(j + 1) = key;
    end
end