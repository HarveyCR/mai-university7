% slope_field_new_rhs.m
% Поле направлений для y' = (2x - y) / (x - 5y)
clear; close all;

% область и сетка
xmin = -3; xmax = 3;
ymin = -3; ymax = 3;
nx = 30; ny = 30;
[x, y] = meshgrid(linspace(xmin,xmax,nx), linspace(ymin,ymax,ny));

% правая часть
den = x - 5.*y;
dy = (2.*x - y) ./ den;
epsDen = 1e-6;
dy(abs(den) < epsDen) = NaN;    % не рисуем там, где знаменатель ~0

% векторы направления (dx = 1)
U = ones(size(dy)); V = dy;
L = sqrt(U.^2 + V.^2);
U = U ./ L; V = V ./ L;

figure('Color','w');
quiver(x, y, U, V, 0.6, 'b');   % поле направлений (синие стрелки)
axis([xmin xmax ymin ymax]);
axis equal; grid on; hold on;
xlabel('x'); ylabel('y');
title('Поле направлений и интегральные кривые для y'' = (2x - y)/(x - 5y)');

% параметры интегрирования и события (останавливаем при x - 5y == 0)
opts = odeset('Events', @event_singularity, 'RelTol',1e-6, 'AbsTol',1e-8);

% начальная вертикаль (точка старта по x)
x0 = -2.9;
x_forward = [x0, xmax];
x_backward = [x0, xmin];

% начальные значения y при x = x0 (один цвет для всех кривых)
ics = [-2, -1, -0.5, 0.5, 1, 2];

for y0 = ics
    % интегрируем вперёд
    try
        solF = ode45(@(xx,yy) f_rhs(xx,yy), x_forward, y0, opts);
        xxF = linspace(x0, solF.x(end), 400);
        yyF = deval(solF, xxF);
        plot(xxF, yyF, 'k', 'LineWidth', 1.5);   % все кривые — чёрные
    catch
        % пропускаем при ошибке
    end

    % интегрируем назад
    try
        solB = ode45(@(xx,yy) f_rhs(xx,yy), x_backward, y0, opts);
        xxB = linspace(x0, solB.x(end), 400);
        yyB = deval(solB, xxB);
        plot(xxB, yyB, 'k', 'LineWidth', 1.5);
    catch
        % пропускаем
    end
end

% (опционально) нарисовать линию сингулярности y = x/5
xs = linspace(xmin, xmax, 400);
plot(xs, xs./5, '--r', 'LineWidth', 1);  % пунктирной красной линией

hold off;

% --- локальные функции ---

function dydx = f_rhs(x, y)
    % dy/dx = (2x - y) / (x - 5y)
    denom = x - 5.*y;
    % если близко к сингулярности — возвращаем NaN (events остановит раньше)
    if abs(denom) < 1e-12
        dydx = NaN;
    else
        dydx = (2.*x - y) ./ denom;
    end
end

function [value, isterminal, direction] = event_singularity(x, y)
    % событие: x - 5y == 0  -> останавливаем интегратор
    value = x - 5.*y;      % когда value == 0 — сработает событие
    isterminal = 1;        % 1 — останов
    direction = 0;         % реагируем на любой переход через 0
end
