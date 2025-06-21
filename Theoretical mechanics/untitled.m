function sortedArray = mergeSort(inputArray)
    if length(inputArray) <= 1
        sortedArray = inputArray;
        return;
    end
    
    mid = floor(length(inputArray) / 2);
    leftHalf = mergeSort(inputArray(1:mid));
    rightHalf = mergeSort(inputArray(mid+1:end));
    
    sortedArray = merge(leftHalf, rightHalf);
end

function mergedArray = merge(leftArray, rightArray)
    mergedArray = [];
    i = 1; 
    j = 1;
    
    while i <= length(leftArray) && j <= length(rightArray)
        if leftArray(i) <= rightArray(j)
            mergedArray(end + 1) = leftArray(i);
            i = i + 1;
        else
            mergedArray(end + 1) = rightArray(j);
            j = j + 1;
        end
    end
    
    mergedArray = [mergedArray, leftArray(i:end), rightArray(j:end)];
end