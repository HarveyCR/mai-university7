function s = sum_rec(A)
    % Рекурсивная функция для суммы элементов вектора A
    if isempty(A) s = 0;              % базовый случай: пустой массив
    else s = A(1) + sum_rec(A(2:end));  % рекурсивный шаг
    end
end

