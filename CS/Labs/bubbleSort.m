function [A_sorted] = bubbleSort(A_sorted)
    % Копируем входной массив, чтобы не менять оригинал
    n = numel(A_sorted);
    k = 1;
    
    % Основной цикл проходов по всему массиву
    for i = 1:n-1
        % Флаг, показывает, были ли перестановки в этом проходе
        swapped = false;
        
        % Внутренний цикл сравнения соседних элементов
        for j = 1:n-i
            if A_sorted(j) > A_sorted(j+1)
                % Меняем элементы местами
                temp = A_sorted(j);
                A_sorted(j) = A_sorted(j+1);
                A_sorted(j+1) = temp;
                
                disp(['Количество итераций: ', num2str(k)])
                disp(A_sorted)

                swapped = true;
            end
            k = k + 1;
        end
        
        % Если за проход ни одна пара не была переставлена — массив уже отсортирован
        if ~swapped
            break;
        end
    end
end
