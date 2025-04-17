function [root, iter] = bisection_method(func, interval, tol, max_iter)
% bisection_method находит приближённое значение корня уравнения func(x)=0
% с использованием метода бисекции.
%
% Входные параметры:
%   func     - дескриптор функции (анонимная функция или функция-файл)
%   interval - вектор [a, b] с начальным диапазоном, где происходит поиск корня
%   tol      - требуемая точность (опционально, по умолчанию 1e-5)
%   max_iter - максимальное число итераций (опционально, по умолчанию 100)
%
% Выходные параметры:
%   root     - найденное приближённое значение корня
%   iter     - фактическое число итераций

    % Проверка количества входных аргументов
    if nargin < 2
        error('Необходимо задать функцию и интервал.');
    end
    if nargin < 3 || isempty(tol)
        tol = 1e-5;
    end
    if nargin < 4 || isempty(max_iter)
        max_iter = 100;
    end
    
    if numel(interval) ~= 2
        error('Диапазон должен быть в виде вектора из двух элементов: [a, b].');
    end
    
    a = interval(1);
    b = interval(2);
    
    % Проверка знакопеременности
    if func(a)*func(b) > 0
        error('На заданном интервале функция не меняет знак.');
    end
    
    iter = 0;
    while iter < max_iter
        iter = iter + 1;
        mid = (a + b)/2;
        fmid = func(mid);
        
        if abs(fmid) < tol
            root = mid;
            return;
        end
        
        if func(a)*fmid < 0
            b = mid;
        else
            a = mid;
        end
    end
    
    % Если максимум итераций достигнут, вернуть последнее приближение
    root = mid;
end
