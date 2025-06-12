function [A_sorted, compCount] = traceInsertionSort(A)
% Сортировка вставками

    A_sorted = A(:)';         % копируем и делаем строку
    n = numel(A_sorted);
    compCount = 0;            % счётчик сравнений

    % Печать исходного массива
    fprintf('Исходный массив:      ');
    fprintf('%4d', A_sorted);
    fprintf('\n');

    % Сортировка вставками через обмены соседних элементов
    for i = 2:n
        fprintf('--------- Шаг %02d ---------\n', i-1);
        j = i;
        % Вставляем элемент A_sorted(i) в отсортированную часть [1..i-1]
        while j > 1
            compCount = compCount + 1;
            % Лог сравнения
            fprintf('Сравнение %03d (%02d,%02d):', compCount, j, j-1);
            fprintf('%4d', A_sorted);
            fprintf('\n');

            if A_sorted(j) < A_sorted(j-1)
                % Меняем местами соседние элементы
                [A_sorted(j), A_sorted(j-1)] = deal(A_sorted(j-1), A_sorted(j));
                fprintf('Обмен (%02d,%02d):         ', j, j-1);
                fprintf('%4d', A_sorted);
                fprintf('\n');
                j = j - 1;
            else
                break;  % дальше вставлять не нужно
            end
        end
    end

    fprintf('=============================================\n');
    fprintf('Количество сравнений: %7d\n', compCount);
end
