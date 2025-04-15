%% Скрипт для исследования зависимости точности вычисленного корня 
% от максимального числа итераций при использовании метода ложного положения

clear; clc; close all;

% Заданная целевая функция и истинное приближённое значение корня
f = @(x) exp(x) + log(x) - 10*x;
true_root = 3.5265;

% Диапазон поиска корня (гарантируется изменение знака функции)
bracket = [3, 4];

% Фиксированная точность
tol = 1e-6;

% Задаем набор значений максимального числа итераций для эксперимента
iterMaxValues = 1:50;  % можно варьировать диапазон
errors = zeros(size(iterMaxValues));
iterations_used = zeros(size(iterMaxValues));

% Для каждого значения максимального числа итераций вычисляем корень
for i = 1:length(iterMaxValues)
    currentMaxIter = iterMaxValues(i);
    [root, iterUsed] = falsePositionMethod(f, bracket, tol, currentMaxIter);
    errors(i) = abs(true_root - root);  % абсолютная погрешность
    iterations_used(i) = iterUsed;
end

% Построение графика зависимости абсолютной ошибки от числа итераций
figure;
semilogy(iterMaxValues, errors, 'b-o','LineWidth',2);  % semilogy задает логарифмический масштаб по Y
xlabel('Максимальное число итераций');
ylabel('Абсолютная ошибка |x_{approx} - x_{true}|');
title('Зависимость точности вычисленного корня от числа итераций');
grid on;
