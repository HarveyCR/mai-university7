function sortedArray = quick_sort(array)
    if length(array) <= 1
        sortedArray = array;
    else
        pivot = array(end);
        left = array(array < pivot);
        right = array(array > pivot);
        sortedArray = [quickSort(left), pivot, quickSort(right)];
    end
end