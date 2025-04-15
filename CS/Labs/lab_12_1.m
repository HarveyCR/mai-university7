%% Поиск корня уравнения exp(x) + log(x) - 10*x = 0 методом бисекции (итерационный подход)
clear; clc; close all;

% Определяем функцию
f = @(x) exp(x) + log(x) - 10*x;

% Исходный интервал [a, b]
a = 3;
b = 4;

% Задаем параметры точности и максимальное число итераций
tol = 1e-6;
max_iter = 100;

% Инициализация массивов для хранения результатов итераций
iter = [];      % номера итераций
approximations = [];   % приближенные значения корня
f_values = [];  % значения функции в точках приближений

count = 0;
while (b - a) > tol && count < max_iter
    count = count + 1;
    
    % Текущая точка - середина отрезка
    c = (a + b) / 2;
    fc = f(c);
    
    % Сохраняем данные итерации
    iter(end+1,1) = count;
    approximations(end+1,1) = c;
    f_values(end+1,1) = fc;
    
    % Выбираем подинтервал для следующей итерации:
    if f(a)*fc < 0
        b = c;
    else
        a = c;
    end
end

% Формируем таблицу результатов и выводим в командное окно
ResultTable = table(iter, approximations, f_values, ...
    'VariableNames', {'Iteration', 'Approximation', 'fValue'});
disp(ResultTable);

%% Построение графиков по результатам итерационного поиска
% График 1: Приближения корня по итерациям
figure;
subplot(2,1,1);
plot(iter, approximations, '-o','LineWidth',1.5);
xlabel('Номер итерации');
ylabel('Приближение x');
title('Приближения корня по итерациям');
grid on;

% График 2: Значения функции по итерациям
subplot(2,1,2);
plot(iter, f_values, '-o','LineWidth',1.5);
xlabel('Номер итерации');
ylabel('f(x)');
title('Значения функции f(x) по итерациям');
grid on;

%% Геометрическая интерпретация метода
figure;
% Строим график функции на расширенном интервале
x_vals = linspace(min(approximations)-0.5, max(approximations)+0.5, 1000);
y_vals = f(x_vals);
plot(x_vals, y_vals, 'b-', 'LineWidth',1.5); 
hold on;
% Ось Ox (линия нулевого значения функции)
plot(x_vals, zeros(size(x_vals)), 'k--'); 

% Отображаем последовательные приближения: для каждой итерации вертикальная линия с точкой
for i = 1:length(approximations)
    % Вертикальная линия от оси Ox до графика функции
    plot([approximations(i) approximations(i)], [0 f(approximations(i))], 'r--');
    % Точка приближения
    plot(approximations(i), f(approximations(i)), 'ko','MarkerFaceColor','g');
end
xlabel('x');
ylabel('f(x)');
title('Геометрическая интерпретация метода бисекции');
grid on;
hold off;
