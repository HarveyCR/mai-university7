function [root, iter] = bisection_recursive(func, a, b, tol, iter, max_iter)
% bisection_recursive рекурсивно находит приближённое значение корня func(x)=0.
%
% Входные параметры:
%   func     - дескриптор функции
%   a, b     - границы интервала
%   tol      - требуемая точность (опционально, по умолчанию 1e-5)
%   iter     - текущий номер итерации (опционально, по умолчанию 0)
%   max_iter - максимальное число итераций (опционально, по умолчанию 100)
%
% Выходные параметры:
%   root - приближённое значение корня
%   iter - количество выполненных итераций

    % Установка значений по умолчанию, если необходимо
    if nargin < 4 || isempty(tol)
        tol = 1e-5;
    end
    if nargin < 5 || isempty(iter)
        iter = 0;
    end
    if nargin < 6 || isempty(max_iter)
        max_iter = 100;
    end
    
    % Проверка знакопеременности при первом вызове (при iter==0)
    if iter == 0 && func(a)*func(b) > 0
        error('На заданном интервале функция не меняет знак.');
    end
    
    mid = (a + b)/2;
    fmid = func(mid);
    iter = iter + 1;
    
    % Базовый случай остановки
    if abs(fmid) < tol || iter >= max_iter
        root = mid;
        return;
    end
    
    % Рекурсивный вызов для подходящего подотрезка
    if func(a)*fmid < 0
        [root, iter] = bisection_recursive(func, a, mid, tol, iter, max_iter);
    else
        [root, iter] = bisection_recursive(func, mid, b, tol, iter, max_iter);
    end
end
