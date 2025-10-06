%% isoclines_and_integral_curves_2x_over_yplusx.m
% Построение изоклин и интегральных кривых для y' = 2x/(y+x)
clc; clear; close all;

% правая часть ОДУ
odefun = @(x,y) (2.*x) ./ (y + x);

% Параметры окна и сетки
xlim_plot = [-6 6];
ylim_plot = [-6 6];
nx = 41; ny = 41;

% Сетка для поля направлений
[xg, yg] = meshgrid(linspace(xlim_plot(1), xlim_plot(2), nx), ...
                    linspace(ylim_plot(1), ylim_plot(2), ny));

% Вычислим наклон, избегая точки сингулярности y + x = 0
den = (xg + yg);
slope = nan(size(den));
idx = abs(den) > 1e-6;
slope(idx) = (2 .* xg(idx)) ./ den(idx);

% Нормализация векторов для quiver
U = ones(size(slope));
V = slope;
L = sqrt(U.^2 + V.^2);
U = U ./ L; V = V ./ L;

figure('Color','w','Position',[200 200 900 800]); hold on; box on; grid on;
title('Изоклины и интегральные кривые для y'' = 2x/(y+x)');
xlabel('x'); ylabel('y');
axis([xlim_plot ylim_plot]); axis equal;

% Поле направлений (серое)
hQ = quiver(xg(idx), yg(idx), U(idx), V(idx), 0.45, 'Color',[0.6 0.6 0.6]);
set(hQ,'AutoScale','off','LineWidth',0.5);

% Выберем значения k (4 отрицательных и 4 положительных, равноудалённых по шагу)
k_values = [-4 -3 -2 -1 1 2 3 4];

% Линия для построения изоклин
x_line = linspace(xlim_plot(1), xlim_plot(2), 600);

for ki = 1:length(k_values)
    k = k_values(ki);
    % Обрабатываем k = 0 отдельно (тогда условие y' = 0 -> 2x = 0 -> x = 0)
    if abs(k) < 1e-9
        % вертикальная изоклина x=0
        plot([0 0], ylim_plot, 'Color',[0.85 0.45 0.9], 'LineWidth',1.4);
        % подпись
        text(0+0.15, 0.8*ylim_plot(2), 'k=0', 'Color',[0.4 0 0.5], 'FontSize',9);
        continue;
    end
    
    % из уравнения (2x)/(y+x) = k → 2x = k(y+x) → y = x*(2-k)/k
    m = (2 - k) / k;
    y_line = m .* x_line;
    valid = (y_line >= ylim_plot(1)) & (y_line <= ylim_plot(2));
    plot(x_line(valid), y_line(valid), 'Color',[0.85 0.45 0.9], 'LineWidth',1.2);
    
    % Добавим маленькие штрихи вдоль изоклины (направление отрезка [1;k])
    xs = linspace(xlim_plot(1)+0.6, xlim_plot(2)-0.6, 16);
    ys = m .* xs;
    keep = ys>=ylim_plot(1) & ys<=ylim_plot(2) & abs(xs+ys) > 1e-6;
    xs = xs(keep); ys = ys(keep);
    dirvec = [1; k]; dirvec = dirvec / norm(dirvec);
    len = 0.28;
    for j = 1:length(xs)
        plot([xs(j)-len*dirvec(1)/2, xs(j)+len*dirvec(1)/2], ...
             [ys(j)-len*dirvec(2)/2, ys(j)+len*dirvec(2)/2], ...
             'Color',[0.85 0.45 0.9],'LineWidth',1.0);
    end
    
    % подпись k у края
    txt_x = xlim_plot(1) + 0.14*ki*(xlim_plot(2)-xlim_plot(1))/length(k_values);
    txt_y = m * txt_x;
    if txt_y >= ylim_plot(1) && txt_y <= ylim_plot(2)
        text(txt_x, txt_y, sprintf('k=%g', k), 'Color',[0.4 0 0.5], 'FontSize',9);
    end
end

% Отметим особую линию сингулярности y = -x
xs_sing = linspace(xlim_plot(1), xlim_plot(2), 2);
ys_sing = -xs_sing;
plot(xs_sing, ys_sing, '--', 'Color',[0.3 0.3 0.3], 'LineWidth',1.0);

% --- Интегральные кривые ---
% Интегрируем dy/dx = 2x/(y+x) от x0 = 0 вправо и влево для нескольких y0
xspan_f = [0 6];
xspan_b = [0 -6];

% Подбор начальных условий (избегаем y0 = 0, т.к. на x=0 и y=0 знаменатель = 0)
y0_list = [-5 -3 -1 -0.4 0.4 1 3 5];

opts = odeset('RelTol',1e-6,'AbsTol',1e-8);
for i = 1:length(y0_list)
    y0 = y0_list(i);
    % вправо
    try
        [Xf,Yf] = ode45(odefun, xspan_f, y0, opts);
        plot(Xf, Yf, 'k', 'LineWidth', 1.6);
    catch
        % пропустить разрывы
    end
    % влево
    try
        [Xb,Yb] = ode45(odefun, xspan_b, y0, opts);
        plot(Xb, Yb, 'k', 'LineWidth', 1.6);
    catch
    end
end

legend({'Поле направлений','Изоклины и штрихи','Сингулярность y=-x','Интегральные кривые'}, 'Location','bestoutside');
set(gca,'FontSize',10);
hold off;
