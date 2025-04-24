function [root, iter] = false_position_recursive(f, a, b, tol, maxIter, iter)
% Входные параметры:
%   f       - дескриптор функции
%   a, b    - начальный интервал [a, b]
%   tol     - требуемая точность
%   maxIter - максимальное число итераций
%   iter    - текущее число итераций (необязательный параметр, по умолчанию 0)
%
% Выходные параметры:
%   root - приближённое значение корня
%   iter - общее число выполненных итераций

    if nargin < 6
        iter = 0;
    end

    if iter >= maxIter
        % Если превышено максимальное число итераций, возвращаем последнее приближение
        root = (a * f(b) - b * f(a)) / (f(b) - f(a));
        return;
    end

    % Вычисление приближения по методу ложного положения
    c = (a * f(b) - b * f(a)) / (f(b) - f(a));
    
    % Если достигнута требуемая точность, то возвращаем результат
    if abs(f(c)) < tol
        root = c;
        iter = iter + 1;
        return;
    end

    iter = iter + 1;
    
    % Рекурсивное обновление интервала в зависимости от знака
    if f(a)*f(c) < 0
        [root, iter] = false_position_recursive(f, a, c, tol, maxIter, iter);
    else
        [root, iter] = false_position_recursive(f, c, b, tol, maxIter, iter);
    end
end
    