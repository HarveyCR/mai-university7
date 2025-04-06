function [sum_series, n, exact_value] = exp_series(x, epsilon, max_iter)
    % Функция вычисления суммы ряда для e^(2x)
    % Вход:
    %   x - значение из [0.1, 0.6]
    %   epsilon - допустимая погрешность (по умолчанию 1e-4)
    %   max_iter - максимальное число итераций (по умолчанию 50)
    % Выход:
    %   sum_series - сумма ряда
    %   n - число выполненных итераций
    %   exact_value - точное значение exp(2*x)

    % Проверка ввода
    if nargin < 3
        error('Необходимо указать все три параметра: x, epsilon, max_iter');
    end

    if x < 0.1 || x > 0.6
        error('x должен быть в диапазоне [0.1, 0.6]');
    end

    if epsilon <= 0
        error('epsilon должен быть положительным');
    end

    if max_iter <= 0 || rem(max_iter,1) ~= 0
        error('max_iter должен быть положительным целым числом');
    end

    % Инициализация
    sum_series = 0;
    current_term = 1;  % a_0 = (2x)^0/0! = 1
    n = 0;
    exact_value = exp(2*x);

    % Вычисление суммы ряда с использованием локальной функции для вычисления следующего члена
    while n < max_iter
        sum_series = sum_series + current_term;
        n = n + 1;
        
        % Проверка точности
        if abs(sum_series - exact_value) < epsilon
            break;
        end
        
        % Вычисление следующего члена ряда через локальную функцию
        current_term = nextTerm(current_term, x, n);
    end

    % Вывод предупреждения, если точность не достигнута
    if abs(sum_series - exact_value) >= epsilon
        warning('Точность не достигнута за %d итераций', max_iter);
    end

    % Локальная функция вычисления следующего члена ряда
    function next = nextTerm(current, x_val, iter)
        % Вычисление следующего члена ряда по формуле:
        % a_{k+1} = a_k * (2*x)/k, где k = iter
        next = current * (2*x_val) / iter;
    end
end

%% Скрипт для вызова функции и построения таблицы и графика
% Очищаем рабочее пространство
clear;
clc;

% Параметры расчета
x_value = 0.3;           % Значение x из [0.1, 0.6]
tolerance = 1e-6;        % Точность
max_iterations = 100;      % Максимальное число итераций

% Вызов функции с тремя входными аргументами
[sum_result, iterations, exact] = exp_series(x_value, tolerance, max_iterations);

% Вывод результатов в командном окне
fprintf('\nРЕЗУЛЬТАТЫ:\n');
fprintf('x = %.2f\n', x_value);
fprintf('Сумма ряда: %.8f\n', sum_result);
fprintf('Точное значение: %.8f\n', exact);
fprintf('Разница: %.2e\n', abs(exact - sum_result));
fprintf('Итераций выполнено: %d\n', iterations);

%% Построение таблицы для различных значений x
% Определяем 11 значений x в диапазоне [0.1, 0.6]
x_vals = linspace(0.1, 0.6, 11);
sum_vals = zeros(size(x_vals));

for i = 1:length(x_vals)
    [sum_vals(i), ~, ~] = exp_series(x_vals(i), tolerance, max_iterations);
end

% Вывод таблицы в командном окне
fprintf('\nТаблица значений x и соответствующих сумм ряда:\n');
fprintf('   x       Sum_series\n');
for i = 1:length(x_vals)
    fprintf('%.2f      %.8f\n', x_vals(i), sum_vals(i));
end

%% Построение графика зависимости точности вычисления от числа итераций
% Выбираем случайное значение x из ранее построенной таблицы
rand_idx = randi(length(x_vals));
x_rand = x_vals(rand_idx);

% Для выбранного x рассчитываем погрешность на каждом шаге
iterations_vec = 1:max_iterations;
error_vec = zeros(1, max_iterations);
current_term = 1;
sum_series = 0;

exact_value = exp(2*x_rand);

for k = 1:max_iterations
    sum_series = sum_series + current_term;
    error_vec(k) = abs(exact_value - sum_series);
    % Вычисляем следующий член ряда через локальную функцию
    current_term = (2*x_rand/current_term) * current_term; % ошибка в этом варианте, поэтому вместо этого:
    current_term = (2*x_rand) / k * current_term;
end

figure;
plot(iterations_vec, error_vec, '-o');
xlabel('Количество итераций');
ylabel('Погрешность вычисления');
title(sprintf('Зависимость погрешности от числа итераций при x = %.2f', x_rand));
grid on;
