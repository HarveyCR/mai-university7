% newton_iterative.m
% Очистка рабочей области
clear; clc;

% Определение функции и её производной
f = @(x) exp(x) + log(x) - 10*x;
df = @(x) exp(x) + 1./x - 10;

% Заданные параметры
initial_approximation = 5.00;   % начальное приближение (хотя диапазон [3,4] указан, здесь берём 5.00 как в условии)
tol = 1e-6;                     % требуемая точность
max_iter = 100;                 % максимум итераций

% Массивы для хранения данных по итерациям
iter_arr = [];
x_arr = [];
f_arr = [];

% Начальные установки
iter = 0;
x_current = initial_approximation;

while iter < max_iter
    f_val = f(x_current);
    df_val = df(x_current);
    
    % Сохраняем данные итерации
    iter_arr(end+1) = iter;
    x_arr(end+1) = x_current;
    f_arr(end+1) = f_val;
    
    % Выход, если достигнута требуемая точность
    if abs(f_val) < tol
        break;
    end
    
    % Формула Ньютона
    x_current = x_current - f_val / df_val;
    iter = iter + 1;
end

% Вывод результатов в командное окно в виде таблицы
T = table(iter_arr', x_arr', f_arr', 'VariableNames', {'Iteration', 'Approximation', 'FunctionValue'});
disp(T);

% Построение графиков последовательных приближений и значений функции
figure;
subplot(2,1,1);
plot(iter_arr, x_arr, '-o', 'LineWidth',1.5);
xlabel('Итерация');
ylabel('Приближение x');
title('Приближения x vs Итерация');
grid on;

subplot(2,1,2);
plot(iter_arr, f_arr, '-o', 'LineWidth',1.5);
xlabel('Итерация');
ylabel('f(x)');
title('Значения функции f(x) vs Итерация');
grid on;
