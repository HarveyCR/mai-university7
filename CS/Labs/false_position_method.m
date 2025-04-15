function [root, iter] = false_position_method(f, interval, tol, maxIter)
% FALSE_POSITION_METHOD - метод ложного положения для нахождения корня уравнения
%
% Синтаксис:
%   [root, iter] = false_position_method(f, interval, tol, maxIter)
%
% Входные параметры:
%   f        - дескриптор функции (function handle)
%   interval - интервал [a, b], в котором функция меняет знак
%   tol      - требуемая точность (опционально, по умолчанию 1e-4)
%   maxIter  - максимальное число итераций (опционально, по умолчанию 100)
%
% Выходные параметры:
%   root - найденное приближение значения корня
%   iter - количество выполненных итераций

    if nargin < 3 || isempty(tol)
        tol = 1e-4;
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = 100;
    end
    
    % Проверка корректности интервала
    if numel(interval) ~= 2
        error('Параметр interval должен быть в виде двухэлементного массива [a, b].');
    end
    a = interval(1);
    b = interval(2);
    
    if f(a) * f(b) >= 0
        error('Функция не меняет знак на концах интервала. Метод ложного положения не применим.');
    end
    
    iter = 0;
    c_old = a;  % для вычисления разницы между итерациями
    while iter < maxIter
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
        iter = iter + 1;
        
        % Условия остановки: по значению функции или по изменению приближения
        if abs(f(c)) < tol || abs(c - c_old) < tol
            root = c;
            return
        end
        
        if f(a)*f(c) < 0
            b = c;
        else
            a = c;
        end
        
        c_old = c;
    end
    % Если достигнуто максимальное число итераций, возвращается последнее приближение
    root = c;
end
