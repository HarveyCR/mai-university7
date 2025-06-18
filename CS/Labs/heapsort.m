function B = heapsort(B)
% HEAPSORT Сортировка массива-матрицы B по первому столбцу методом "пирамидальной сортировки"
    n = size(B,1);

    % 1) Построение мин-кучи: вставляем по одному элементу
    for i = 2 : n
        B = heapifyup1(B, i);
    end

    % 2) Извлечение элементов из кучи в конец массива
    for l = n : -1 : 2
        % Меняем корень (минимум) с последним элементом текущей кучи
        B([1 l], :) = B([l 1], :);
        % Восстанавливаем мин-кучу на префиксе [1..l-1]
        B = heapifydownN1(B, 1, l-1);
    end

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
end

% heapsort([70; 77; 82; 64; 18; 6; 26; 23])
