% bisection_accuracy_plot.m
% Скрипт для анализа зависимости точности корня от числа итераций
% При построении используется логарифмический масштаб оси ординат.

% Задаём функцию
f = @(x) exp(x) + log(x) - 10*x;
true_root = 3.5265;  % известное приблизительное значение корня для сравнения

% Задаём диапазон
interval = [3, 4];

% Подготовка массива для хранения ошибок и числа итераций.
max_iter_array = 1:50;   % варьируем число итераций от 1 до 50
errors = zeros(size(max_iter_array));

for i = 1:length(max_iter_array)
    max_iter = max_iter_array(i);
    % Вычисление корня при заданном количестве итераций
    [approx_root, iter_used] = bisection_method(f, interval, 1e-5, max_iter);
    % Абсолютная ошибка относительно известного значения
    errors(i) = abs(approx_root - true_root);
end

% Построение графика с логарифмической осью ординат
figure;
semilogy(max_iter_array, errors, 'b-o','LineWidth',1.5);
xlabel('Максимальное число итераций');
ylabel('Абсолютная ошибка');
title('Зависимость точности решения от числа итераций');
grid on;
