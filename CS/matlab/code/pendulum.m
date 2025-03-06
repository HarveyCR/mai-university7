clc; clear; close all;

function dydt = dampedPendulum(t, y)
    g = 9.81;   % Ускорение свободного падения
    L = 1;      % Длина маятника
    b = 0.2;    % Коэффициент трения (сопротивление воздуха)
    
    dydt = [y(2);                % dy1/dt = угловая скорость
            -g/L * sin(y(1)) - b * y(2)];  % dy2/dt = угловое ускорение с учетом трения
end

% Начальные условия
theta0 = pi/4;   % Начальный угол (в радианах)
omega0 = 0;      % Начальная угловая скорость
L = 1; 
% Время моделирования
tspan = [0 20];  % Время от 0 до 20 секунд

% Решение системы
[t, y] = ode45(@dampedPendulum, tspan, [theta0, omega0]);

% Построение графика угла отклонения от времени
figure;
plot(t, y(:,1), 'r', 'LineWidth', 2);
xlabel('Время (с)');
ylabel('Угол (рад)');
title('Затухающие колебания маятника с учетом трения');
grid on;

% Анимация маятника
figure;
for i = 1:length(t)
    clf;  % Очистка текущего графика
    x = L * sin(y(i,1));        % Координата x
    y_pos = -L * cos(y(i,1));   % Координата y
    
    plot([0, x], [0, y_pos], 'b-', 'LineWidth', 2);  % Строка, представляющая маятник
    hold on;
    plot(x, y_pos, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');  % Точка (груз)
    axis([-L L -L 0.5]);  % Ограничения на оси
    xlabel('X');
    ylabel('Y');
    grid on;
    pause(0.05);  % Пауза для анимации
end
