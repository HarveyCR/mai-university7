function [A_sorted, compCount] = traceLetterSelectionSort(A)
% Сортировка простым выбором
    if isstring(A)
        A_sorted = char(A);
    else
        A_sorted = A(:)';  % убедимся, что вектор-строка
    end
    n = numel(A_sorted);
    compCount = 0;

    % Печать исходного массива
    fprintf('Исходный массив:      ');
    for k = 1:n
        fprintf('%4c', A_sorted(k));
    end
    fprintf('\n');

    for i = 1:n-1
        fprintf('--------- Шаг %02d ---------\n', i);
        minIdx = i;
        % Поиск «лексикографического минимума»
        for j = i+1:n
            compCount = compCount + 1;
            fprintf('Сравнение %03d (%02d,%02d):', compCount, j, minIdx);
            for k = 1:n
                fprintf('%4c', A_sorted(k));
            end
            fprintf('\n');
            if A_sorted(j) < A_sorted(minIdx)
                minIdx = j;
            end
        end
        % Обмен, если минимум не на месте
        if minIdx ~= i
            [A_sorted(i), A_sorted(minIdx)] = deal(A_sorted(minIdx), A_sorted(i));
            fprintf('Обмен (%02d,%02d):         ', i, minIdx);
            for k = 1:n
                fprintf('%4c', A_sorted(k));
            end
            fprintf('\n');
        end
    end

    fprintf('=============================================\n');
    fprintf('Количество сравнений: %7d\n', compCount);
end
