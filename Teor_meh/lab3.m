<<<<<<< HEAD
% Исходный столбец B
B = [4; 10; 3; 5; 1];

% Вызов пирамидальной сортировки
B_sorted = heapsort(B);

% Показать результат
disp(B_sorted);

[70; 77; 82; 64; 18; 6; 26;23]
=======
L = 0.5;         % длина нити (м)
g = 9.81;        % ускорение свободного падения (м/с^2)
theta0 = pi/4;   % начальный угол отклонения (рад)
omega0 = 0;      % начальная угловая скорость (рад/с)

% Параметры шара
r = 0.2;                   % радиус шара (м)
omega_ball = 2*pi/2;      % собственная угловая скорость вращения шара (рад/с)

t_total = 10;           
fps = 30;              
tspan = linspace(0, t_total, t_total*fps);
dt = tspan(2) - tspan(1);

% Решаем уравнение движения маятника
odefun = @(t, x) [ x(2); -(g/L)*sin(x(1)) ];
x0 = [theta0; omega0];
[tt, xx] = ode45(odefun, tspan, x0);

x = L * sin(xx(:,1));
y = -L * cos(xx(:,1));
theta = xx(:,1);

figure('Color','w');
axis equal; hold on;
axis([-L-r, L+r, -L-r-0.1, r+0.1]);

% Начальные объекты: шар, линия самоповорачивания, точка и нить
ball = rectangle('Position', [x(1)-r, y(1)-r, 2*r, 2*r], ...
                  'Curvature', [1,1], 'FaceColor', [0.2 0.6 1], 'EdgeColor', 'none');
self_line = line([x(1), x(1) + r], [y(1), y(1)], 'LineWidth', 1.5, 'Color', [0 1 0]);
self_point = plot(x(1) + r, y(1), 'o', 'MarkerSize', 8, 'MarkerFaceColor', [0 1 0], 'MarkerEdgeColor', 'none');
rod = line([0, x(1)], [0, y(1)], 'LineWidth', 2, 'Color', [0 0 0]);

xlabel('x, м'); ylabel('y, м');
title('Маятник: самовращающийся шар');

for k = 1:length(tt)
    x_c = x(k); y_c = y(k);
    set(ball, 'Position', [x_c-r, y_c-r, 2*r, 2*r]);
    phi = omega_ball * tt(k);
    x_edge_s = x_c + r * cos(phi);
    y_edge_s = y_c + r * sin(phi);
    set(self_line, 'XData', [x_c, x_edge_s], 'YData', [y_c, y_edge_s]);
    set(self_point, 'XData', x_edge_s, 'YData', y_edge_s);
    set(rod, 'XData', [0, x_c], 'YData', [0, y_c]);
    uistack(rod, 'top');
    drawnow;
    pause(dt * 2);
end
>>>>>>> 2fa5eacf8e65b3d8f53f854a3eaa0fc6ce7cde4e
