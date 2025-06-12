% Ряд Фурье
% sympref('dispaley', 'unicode');

syms x real;
syms L real;
syms pi;
syms k integer positive; % Целое число

% Определение кусочно-линейной функции

disp('Кусочно Линейная Функция f(x) = ')

f(x) = piecewise(x > 0, 1, 0);

pretty(f(x));