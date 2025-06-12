function B = heapifydownN1(B, i, l)
% HEAPIFYDOWNN1 Просеивание вниз для мин-кучи
    left  = 2 * i;
    if left > l
        return;
    end
    right = left + 1;
    smallest = i;

    if left <= l && B(left,1) < B(smallest,1)
        smallest = left;
    end
    if right <= l && B(right,1) < B(smallest,1)
        smallest = right;
    end

    if smallest ~= i
        B([i smallest], :) = B([smallest i], :);
        B = heapifydownN1(B, smallest, l);
    end
end