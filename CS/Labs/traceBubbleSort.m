function [A_sorted, compCount] = traceBubbleSort(A)
% Пузырьковая сортировка

    A_sorted = A;                 % копия, чтобы не портить оригинал
    n = numel(A_sorted);
    compCount = 0;                % счётчик сравнений
    
    % Печать исходного массива
    fprintf('Исходный массив:      ');
    fprintf('%4d', A_sorted);
    fprintf('\n');
    
    % Основной алгоритм
    for pass = 1:n-1
        fprintf('--------- Проход %02d ---------\n', pass);
        swapped = false;
        
        for j = 1:(n-pass)
            compCount = compCount + 1;
            % Лог сравнения
            fprintf('Сравнение %03d (%02d,%02d):', ...
                    compCount, j, j+1);
            fprintf('%4d', A_sorted);
            fprintf('\n');
            
            if A_sorted(j) > A_sorted(j+1)
                % обмен
                [A_sorted(j), A_sorted(j+1)] = deal(A_sorted(j+1), A_sorted(j));
                swapped = true;
                
                % Лог обмена
                fprintf('Обмен (%02d,%02d):         ', j, j+1);
                fprintf('%4d', A_sorted);
                fprintf('\n');
            end
        end
        
        if ~swapped
            % если за этот проход не было обменов — выходим
            break;
        end
    end
    
    fprintf('=============================================\n');
    fprintf('Количество сравнений: %7d\n', compCount);
end
