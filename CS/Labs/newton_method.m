function [root, iter] = newton_method(f, init, tol, max_iter)
% NEWTON_METHOD - Поиск корня уравнения с помощью метода Ньютона.
%
% Синтаксис:
%   [root, iter] = newton_method(f, init, tol, max_iter)
%
% Входные аргументы:
%   f        - дескриптор функции (функция от x)
%   init     - начальное приближение (числовое скалярное значение)
%   tol      - требуемая точность (необязательный, по умолчанию 1e-6)
%   max_iter - максимум итераций (необязательный, по умолчанию 100)
%
% Выходные аргументы:
%   root - приближённое значение корня
%   iter - число итераций, выполненных до сходимости
%
% Проверка аргументов
if nargin < 2
    error('Требуется передать не менее двух аргументов: функцию и начальное приближение.');
end
if ~isa(f, 'function_handle')
    error('Первый аргумент должен быть дескриптором функции.');
end
if nargin < 3 || isempty(tol)
    tol = 1e-6;
end
if nargin < 4 || isempty(max_iter)
    max_iter = 100;
end
if ~isnumeric(init) || ~isscalar(init)
    error('Начальное приближение должно быть числовым скалярным значением.');
end

% Параметры для численного дифференцирования
h = 1e-6;

% Инициализация переменной
x_current = init;
iter = 0;

while iter < max_iter
    f_val = f(x_current);
    % Проверка сходимости по значению функции
    if abs(f_val) < tol
        break;
    end
    % Численное вычисление производной
    df_val = (f(x_current + h) - f(x_current)) / h;
    if df_val == 0
        error('Производная равна нулю. Решение не найдено.');
    end
    % Итерационный шаг по методу Ньютона
    x_current = x_current - f_val / df_val;
    iter = iter + 1;
end
root = x_current;
end
