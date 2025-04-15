function [root, iter] = secant_method_recursive(func, x0, x1, tol, max_iter, iter)
% secant_method_recursive - Рекурсивная реализация метода секущих.
%
% Синтаксис:
%   [root, iter] = secant_method_recursive(func, x0, x1, tol, max_iter)
%
% Входные аргументы:
%   func     - дескриптор функции (function handle)
%   x0, x1   - два начальных приближения
%   tol      - требуемая точность (необязательный, по умолчанию 1e-4)
%   max_iter - максимальное число итераций (необязательный, по умолчанию 100)
%
% Выходные аргументы:
%   root - найденное приближение корня
%   iter - количество выполненных итераций (суммарно)

    if nargin < 6
        iter = 0;
    end
    if nargin < 4 || isempty(tol)
        tol = 1e-4;
    end
    if nargin < 5 || isempty(max_iter)
        max_iter = 100;
    end

    f0 = func(x0);
    f1 = func(x1);
    if (f1 - f0) == 0
        error('Деление на ноль. Метод не может продолжаться.');
    end
    
    % Вычисление нового приближения
    x2 = x1 - f1*(x1 - x0)/(f1 - f0);
    iter = iter + 1;
    
    % Проверка условия остановки
    if abs(x2 - x1) < tol || iter >= max_iter
        root = x2;
        return;
    else
        % Рекурсивный вызов: передаем x1 и новое x2
        [root, iter] = secant_method_recursive(func, x1, x2, tol, max_iter, iter);
    end
end
