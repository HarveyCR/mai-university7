function [A_sorted, compCount] = traceLetterInsertionSort(A)
% Сортировка вставками

    % Приводим к символьному вектору
    if isstring(A)
        A_sorted = char(A);
    else
        A_sorted = A;
    end
    n = numel(A_sorted);
    compCount = 0;
    
    % Печать исходного массива
    fprintf('Исходный массив:      ');
    for k = 1:n
        fprintf('%4c', A_sorted(k));
    end
    fprintf('\n');
    
    % Сортировка вставками через обмены смежных элементов
    for i = 2:n
        fprintf('--------- Шаг %02d ---------\n', i-1);
        j = i;
        % На каждой итерации сравниваем и, при необходимости,
        % обмениваем A_sorted(j) и A_sorted(j-1) до позиции вставки
        while j > 1
            compCount = compCount + 1;
            % Лог сравнения
            fprintf('Сравнение %03d (%02d,%02d):', compCount, j, j-1);
            for k = 1:n
                fprintf('%4c', A_sorted(k));
            end
            fprintf('\n');
            
            if A_sorted(j) < A_sorted(j-1)
                % Обмен смежных элементов
                [A_sorted(j), A_sorted(j-1)] = deal(A_sorted(j-1), A_sorted(j));
                fprintf('Обмен (%02d,%02d):         ', j, j-1);
                for k = 1:n
                    fprintf('%4c', A_sorted(k));
                end
                fprintf('\n');
                j = j - 1;
            else
                % Если не требует обмена — выходим из цикла вставки
                break;
            end
        end
    end
    
    fprintf('=============================================\n');
    fprintf('Количество сравнений: %7d\n', compCount);
end
