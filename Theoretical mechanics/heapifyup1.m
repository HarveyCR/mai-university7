function B = heapifyup1(B, i)
% HEAPIFYUP1 Просеивание вверх для мин-кучи
    if i == 1
        return;
    end
    parent = floor(i/2);
    
    if B(i,1) < B(parent,1)
        B([i parent], :) = B([parent i], :);
        B = heapifyup1(B, parent);
    end
end