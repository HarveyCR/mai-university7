function [root, iter] = falsePositionMethod(func, bracket, tol, maxIter)
% FALSEPOSITIONMETHOD Ищет приближённое значение корня функции по методу ложного положения.
%
% Синтаксис:
%   [root, iter] = falsePositionMethod(func, bracket, tol, maxIter)
%
% Входные параметры:
%   func    - дескриптор целевой функции (например, @(x) exp(x)+log(x)-10*x);
%   bracket - диапазон поиска корня в виде [a, b], где f(a)*f(b) < 0;
%   tol     - точность вычисления (необязательный, по умолчанию 1e-6);
%   maxIter - максимальное число итераций (необязательный, по умолчанию 100).
%
% Выходные параметры:
%   root - найденное приближённое значение корня;
%   iter - число итераций, выполненных до останова.
%
% Проверка аргументов:
if nargin < 2
    error('Необходимо задать минимум два аргумента: функцию и диапазон поиска.');
end
if nargin < 3 || isempty(tol)
    tol = 1e-6;
end
if nargin < 4 || isempty(maxIter)
    maxIter = 100;
end

% Проверка типа и размерности диапазона
if ~isnumeric(bracket) || numel(bracket) ~= 2
    error('Второй аргумент должен быть в виде диапазона [a, b].');
end

a = bracket(1);
b = bracket(2);

% Проверка на наличие изменения знака
if func(a)*func(b) > 0
    error('Функция должна менять знак на концах диапазона [a, b].');
end

iter = 0;
c = a; % инициализация
while iter < maxIter
    fa = func(a);
    fb = func(b);
    
    % Вычисляем точку пересечения прямой, соединяющей (a, f(a)) и (b, f(b))
    c_prev = c;
    c = (a*fb - b*fa) / (fb - fa);
    fc = func(c);
    iter = iter + 1;
    
    % Остановка по критерию: если значение функции в точке c мало
    % или если ширина интервала стала меньше заданной точности
    if abs(fc) < tol || abs(b - a) < tol || (iter > 1 && abs(c - c_prev) < tol)
        root = c;
        return;
    end
    
    % Определяем, в какой части интервала происходит смена знака
    if fa*fc < 0
        b = c;
    else
        a = c;
    end
end

% Если максимум итераций достигнут без выполнения критерия сходимости,
% возвращаем последнее приближение.
root = c;
end
