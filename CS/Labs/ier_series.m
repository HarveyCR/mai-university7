% fourier_piecewise_linear.m
% Скрипт для разложения в ряд Фурье кусочно‑линейной функции,
% построения частичных сумм и графика среднеквадратического отклонения

clear; close all; clc;

%% Параметры
L = pi;               % полупериод, функция задана на [-L, L]
T = 2*L;              % полный период
N_max = 50;           % максимальное число гармоник для расчёта
N_plot = [1,3,5,10];  % номера гармоник, для которых рисуем S_N
nx = 1000;            % число точек для графиков

x = linspace(-L, L, nx);

%% а) Задание кусочно‑линейной функции f(x)
% Пример варианта: 
%  f(x) = 
%    0,   -pi <= x < 0
%    x/L, 0 <= x <= pi

f = zeros(size(x));
for i = 1:length(x)
    if x(i) < 0
        f(i) = 0;
    else
        f(i) = x(i)/L;
    end
end

%% б) Вычисление коэффициентов a0, a_k и b_k
a0 = (1/L) * trapz(x, f);          % интеграл по одному периоду
a0 = a0;                           % уже = 1/pi * ∫ f(x)dx если L=pi

a = zeros(1, N_max);
b = zeros(1, N_max);
for k = 1:N_max
    a(k) = (1/L) * trapz(x, f .* cos(k * pi * x / L));
    b(k) = (1/L) * trapz(x, f .* sin(k * pi * x / L));
end

%% в) Построение частичных сумм S_N(x)
S = zeros(length(N_plot), length(x));
for idx = 1:length(N_plot)
    N = N_plot(idx);
    S(idx, :) = a0/2 * ones(size(x));
    for k = 1:N
        S(idx, :) = S(idx, :) + a(k)*cos(k*pi*x/L) + b(k)*sin(k*pi*x/L);
    end
end

%% г) Отрисовка графиков частичных сумм
figure('Name','Частичные суммы ряда Фурье','NumberTitle','off');
plot(x, f, 'k', 'LineWidth', 1.5); hold on;
colors = lines(length(N_plot));
for idx = 1:length(N_plot)
    plot(x, S(idx,:), 'LineWidth', 1.2, 'Color', colors(idx,:));
end
legend(['f(x)', arrayfun(@(n) sprintf('S_{%d}',n), N_plot,'Uni',0)]);
xlabel('x'); ylabel('f, S_N'); 
title('Частичные суммы ряда Фурье');
grid on;

%% 2. Построение графика среднеквадратического отклонения
sigma = zeros(1, N_max);
for N = 1:N_max
    % соберем S_N
    SN = a0/2 * ones(size(x));
    for k = 1:N
        SN = SN + a(k)*cos(k*pi*x/L) + b(k)*sin(k*pi*x/L);
    end
    % среднеквадратичное отклонение по периоду
    sigma(N) = sqrt( (1/T)*trapz(x, (f - SN).^2 ) );
end

figure('Name','Среднеквадратичное отклонение','NumberTitle','off');
plot(1:N_max, sigma, 'LineWidth', 1.5);
xlabel('N (число гармоник)'); 
ylabel('\sigma_N'); 
title('Сходимость в среднем квадратическом смысле');
grid on;
