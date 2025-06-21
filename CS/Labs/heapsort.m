function sortedArray = heapsort(array)
    function heapify(array, n, i)
        largest = i; % Initialize largest as root
        left = 2 * i; % left = 2*i
        right = 2 * i + 1; % right = 2*i + 1
    
        % If left child is larger than root
        if left <= n && array(left) > array(largest)
            largest = left;
        end
    
        % If right child is larger than largest so far
        if right <= n && array(right) > array(largest)
            largest = right;
        end
    
        % If largest is not root
        if largest ~= i
            array([i, largest]) = array([largest, i]); % Swap
    
            % Recursively heapify the affected sub-tree
            heapify(array, n, largest);
        end
    end
    n = length(array);
    
    % Build heap (rearrange array)
    for i = floor(n/2):-1:1
        heapify(array, n, i);
    end
    
    % One by one extract elements from heap
    for i = n:-1:2
        % Move current root to end
        array([1, i]) = array([i, 1]);
        
        % Call heapify on the reduced heap
        heapify(array, i-1, 1);
    end
    
    sortedArray = array;
end

