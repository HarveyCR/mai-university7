% Анимация сферического тела на внешней пружине, внутреннего груза на пружинах
clear; clf; hold on; axis equal; grid on;

% Параметры системы
R       = 1;                   % радиус шара
m_b     = 1; k_ext = 10;       % масса шара и жесткость внешней пружины
k_int   = 50; m_i   = 0.2;     % жесткость и масса внутреннего груза

% Геометрия крепления
wall_x  = -5;                  % x-координата вертикальной балки (стены)
y_beam  = 0;                   % y-координата горизонтальной опоры (балки)

% Амплитуда и частота внешних колебаний
A_ext   = 1.5;  omega_ext = sqrt(k_ext/m_b);  % амплитуда и угловая частота
% Амплитуда и частота внутренних колебаний
A_int   = 0.2;  omega_int = sqrt(k_int/m_i);

dt = 0.02; T = 10; t = 0:dt:T;

% Начальное положение шара
center0 = [wall_x + 1 + A_ext + R, R];  % стартовая точка при максимальном сжатии пружины

% --- Рисуем опоры ---
% Вертикальная балка (стена)
h_wall = line([wall_x, wall_x], [-1, 4], 'LineWidth',6, 'Color',[0.4 0.4 0.4]);
% Горизонтальная балка (площадка)
beam_x_end = wall_x + 1 + 2*A_ext + 2*R + 2;
h_beam = line([wall_x-1, beam_x_end], [y_beam, y_beam], 'LineWidth',6, 'Color',[0.4 0.4 0.4]);

% Внешняя пружина (прикрепляется к шару)
h_spring_ext = line([wall_x, center0(1)-R], [center0(2), center0(2)], 'LineWidth',2);
% Шар как круг через rectangle с Curvature=[1,1]
h_ball = rectangle('Position',[center0(1)-R, center0(2)-R, 2*R, 2*R], ...
                   'Curvature',[1,1], 'EdgeColor','b','LineWidth',2);

% Внутренние пружины и груз внутри шара
h_spring1 = line([center0(1), center0(1)], [center0(2)+0.9*R, center0(2)+0.8*R], 'LineWidth',1.5);
h_spring2 = line([center0(1), center0(1)], [center0(2)-0.9*R, center0(2)-0.8*R], 'LineWidth',1.5);
h_mass    = rectangle('Position',[center0(1)-0.1, center0(2)-0.1, 0.2, 0.2], ...
                       'Curvature',0.1, 'FaceColor','r');

% Настройка осей
xlim([wall_x-1, beam_x_end+1]); ylim([-1, 4]);

for i = 1:length(t)
    % Полное гармоническое смещение без ограничений
    s = A_ext * sin(omega_ext * t(i));        % смещение внешней пружины
    theta = s / R;                           % угол прокрутки шара
    center = [wall_x + 1 + A_ext - s + R, R];% центр шара движется от максимального сжатия

    % Обновление внешней пружины, прикрепленной к шару
    Ns = 16; x0 = wall_x; x1 = center(1) - R; ys0 = center(2);
    xs = linspace(x0, x1, Ns);
    ys_vec = ys0 + 0.15 * sin(12 * (xs - x0) / (x1 - x0) * 2 * pi);
    set(h_spring_ext, 'XData', xs, 'YData', ys_vec);

    % Обновление позиции шара
    set(h_ball, 'Position', [center(1)-R, center(2)-R, 2*R, 2*R]);

    % Внутренние колебания груза
    y_rel = A_int * sin(omega_int * t(i));
    p_mass = [0; y_rel];
    Rmat = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    p_mass_glob = Rmat * p_mass + center';

    % Точки крепления внутренних пружин внутри шара
    p1 = Rmat * [0; R] + center';
    p2 = Rmat * [0; -R] + center';

    % Обновление внутренних пружин и груза
    set(h_spring1, 'XData', [p_mass_glob(1), p1(1)], 'YData', [p_mass_glob(2), p1(2)]);
    set(h_spring2, 'XData', [p_mass_glob(1), p2(1)], 'YData', [p_mass_glob(2), p2(2)]);
    set(h_mass,    'Position', [p_mass_glob(1)-0.1, p_mass_glob(2)-0.1, 0.2, 0.2]);

    drawnow;
    pause(0.05);
end
