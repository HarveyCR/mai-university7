function sorted_massive = test(massive)
    if length(massive) <= 1
        sorted_massive = massive;
    else
        pivot = massive(end);
        left = massive(massive < pivot);
        right = massive(massive > pivot);
        sorted_massive = [test(left) massive(massive == pivot) test(right)]; 
        
    end
end


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