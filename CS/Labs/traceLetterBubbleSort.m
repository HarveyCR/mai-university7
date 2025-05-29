function [A_sorted, compCount] = traceLetterBubbleSort(A)
% Пузырьковая сортировка
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
    
    % Основной цикл пузырька
    for pass = 1:n-1
        fprintf('--------- Проход %02d ---------\n', pass);
        swapped = false;
        
        for j = 1:(n-pass)
            compCount = compCount + 1;
            % Лог сравнения
            fprintf('Сравнение %03d (%02d,%02d):', ...
                    compCount, j, j+1);
            for k = 1:n
                fprintf('%4c', A_sorted(k));
            end
            fprintf('\n');
            
            % Сравнение символов по их коду (алфавит)
            if A_sorted(j) > A_sorted(j+1)
                % Меняем местами
                [A_sorted(j), A_sorted(j+1)] = deal(A_sorted(j+1), A_sorted(j));
                swapped = true;
                
                % Лог обмена
                fprintf('Обмен (%02d,%02d):         ', j, j+1);
                for k = 1:n
                    fprintf('%4c', A_sorted(k));
                end
                fprintf('\n');
            end
        end
        
        if ~swapped
            break;  % если за проход не было обменов — массив отсортирован
        end
    end
    
    fprintf('=============================================\n');
    fprintf('Количество сравнений: %7d\n', compCount);
end
