function [A_sorted, compCount] = traceSelectionSort(A)
% Сортировка простым выбором

    A_sorted = A(:)';             % копия в виде строки
    n = numel(A_sorted);
    compCount = 0;

    % Печать исходного массива
    fprintf('Исходный массив:      ');
    fprintf('%4d', A_sorted);
    fprintf('\n');

    for i = 1:n-1
        fprintf('--------- Шаг %02d ---------\n', i);
        minIdx = i;
        % Поиск минимального в сегменте i..n
        for j = i+1:n
            compCount = compCount + 1;
            fprintf('Сравнение %03d (%02d,%02d):', compCount, j, minIdx);
            fprintf('%4d', A_sorted);
            fprintf('\n');
            if A_sorted(j) < A_sorted(minIdx)
                minIdx = j;
            end
        end
        % Обмен текущего элемента с найденным минимумом
        if minIdx ~= i
            [A_sorted(i), A_sorted(minIdx)] = deal(A_sorted(minIdx), A_sorted(i));
            fprintf('Обмен (%02d,%02d):         ', i, minIdx);
            fprintf('%4d', A_sorted);
            fprintf('\n');
        end
    end

    fprintf('=============================================\n');
    fprintf('Количество сравнений: %7d\n', compCount);
end
