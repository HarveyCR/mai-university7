function [root, iter] = secant_method(func, range, tol, max_iter)
% secant_method - Метод секущих для поиска приближённого корня уравнения.
%
% Синтаксис:
%   [root, iter] = secant_method(func, range, tol, max_iter)
%
% Входные аргументы:
%   func     - дескриптор функции (function handle)
%   range    - вектор из двух элементов с начальными приближениями [x0, x1]
%   tol      - требуемая точность (необязательный, по умолчанию 1e-4)
%   max_iter - максимальное число итераций (необязательный, по умолчанию 100)
%
% Выходные аргументы:
%   root - найденное приближение корня
%   iter - количество выполненных итераций

    % Проверка аргументов
    if nargin < 2
        error('Необходимо задать функцию и диапазон начальных приближений.');
    end
    if ~isa(func, 'function_handle')
        error('Первый аргумент должен быть дескриптором функции.');
    end
    if numel(range) ~= 2
        error('Диапазон начальных приближений должен содержать два элемента.');
    end
    if nargin < 3 || isempty(tol)
        tol = 1e-4;
    end
    if nargin < 4 || isempty(max_iter)
        max_iter = 100;
    end

    % Инициализация
    x0 = range(1);
    x1 = range(2);
    iter = 0;

    while iter < max_iter
        f0 = func(x0);
        f1 = func(x1);
        if (f1 - f0) == 0
           error('Деление на ноль, метод не может продолжаться.');
        end
        
        x2 = x1 - f1*(x1 - x0)/(f1 - f0);
        iter = iter + 1;
        
        if abs(x2 - x1) < tol
            root = x2;
            return;
        end
        
        x0 = x1;
        x1 = x2;
    end
    root = x2;
    warning('Максимальное число итераций достигнуто');
end
