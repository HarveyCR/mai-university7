function [root, iter] = newton_recursive(f, x_current, tol, max_iter, iter)
% NEWTON_RECURSIVE - Рекурсивная реализация метода Ньютона для поиска корня.
%
% Синтаксис:
%   [root, iter] = newton_recursive(f, x_current, tol, max_iter, iter)
%
% Входные аргументы:
%   f         - дескриптор функции
%   x_current - текущее приближение корня
%   tol       - требуемая точность (например, 1e-6)
%   max_iter  - максимум допустимых итераций
%   iter      - текущий номер итерации (необязательный аргумент, по умолчанию 0)
%
% Выходные аргументы:
%   root - найденное приближённое значение корня
%   iter - общее число итераций, выполненных до сходимости

% Инициализация текущего номера итерации, если не передано
if nargin < 5
    iter = 0;
end

% Если функция уже достаточно близка к нулю или достигнут максимум итераций,
% возвращаем текущее приближение.
if abs(f(x_current)) < tol
    root = x_current;
    return;
end

% Численное вычисление производной
h = 1e-6;
df_val = (f(x_current + h) - f(x_current)) / h;
if df_val == 0
    error('Производная равна нулю. Решение не найдено.');
end

% Один итерационный шаг метода Ньютона
x_next = x_current - f(x_current)/df_val;
iter = iter + 1;
% Рекурсивный вызов
[root, iter] = newton_recursive(f, x_next, tol, max_iter, iter);
end
