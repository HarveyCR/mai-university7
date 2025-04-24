clear; clc; close all;

% === ПАРАМЕТРЫ ===
% Внешняя пружина и шар
n_coils_ext   = 20;        % витков внешней пружины
x_length_max  = 30;        % максимальная длина пружины
amp_ext       = 1;         % амплитуда «волны» пружины
R_ball        = 5;         % радиус большого шара

% Анимация: сжатие → разжатие
frames        = 200;                          
comp_half     = linspace(1, 0.4, frames/2);   
comp_full     = [comp_half, fliplr(comp_half)]; 

% Внутренняя система (внутри шара)
r_local       = R_ball;    % полуразмер «диаметра»  
n_coils_int   = 10;        % витков внутренних пружин
amp_int       = 0.3;       % визуальная амплитуда внутренних пружин
c             = 20;        % жесткость (для физики, не для визуализации)
mA            = 1;         % масса грузика
g             = 9.81;      % ускорение свободного падения

% === ПОДГОТОВКА ЛОКАЛЬНЫХ ПРУЖИН (не меняются во времени) ===
s = linspace(-r_local, +r_local, 200)';                          % 200×1
coil_wave = amp_int * sin(2*pi*n_coils_int * (s + r_local)/(2*r_local));
mid = numel(s)/2;
spring1_local = [ s(1:mid),     coil_wave(1:mid)   ];           % от -r до 0
spring2_local = [ s(mid:end),   coil_wave(mid:end) ];           % от  0 до +r

% === ИНИЦИАЛИЗАЦИЯ ===
prev_L = x_length_max * comp_full(1);
phi    = 0;

% === ОКНО РИСОВАНИЯ ===
figure('Color','w');
axis equal;
axis([-1, x_length_max+R_ball+2, -R_ball-2, amp_ext+R_ball+2]);
hold on;
xlabel('X'); ylabel('Y');
title('Анимация пружины, шара и внутренней системы');

% === ЦИКЛ АНИМАЦИИ ===
for i = 1:numel(comp_full)
    cla;
    
    % 1) Сжатие/разжатие внешней пружины и катящийся шар
    L   = x_length_max * comp_full(i);
    dL  = L - prev_L;
    phi = phi - dL / R_ball;   % обновляем угол прокатывания
    prev_L = L;
    
    % — рисуем внешнюю пружину —
    x_ext = linspace(0, L, n_coils_ext*20);
    y_ext = amp_ext * sin(2*pi*n_coils_ext * x_ext / L);
    plot(x_ext, y_ext, 'b', 'LineWidth', 2);
    
    % — рисуем шар и маркер прокатывания —
    Xc = L;  Yc = 0;
    th = linspace(0,2*pi,200);
    fill(Xc + R_ball*cos(th), Yc + R_ball*sin(th), [0.9,0.7,0.3], 'EdgeColor','k');
    plot([Xc, Xc + R_ball*cos(phi)], [Yc, Yc + R_ball*sin(phi)], ...
         'k-', 'LineWidth', 2);
    
    % 2) Внутренняя система жестко прикреплена внутри шара
    % смещение грузика A вдоль локальной оси
    x_rel = (mA * g) / (2 * c) * sin(phi);
    
    % сдвигаем локальные пружины и точку A на половину смещения
    spring1 = spring1_local + [ +x_rel/2, 0 ];
    spring2 = spring2_local + [ -x_rel/2, 0 ];
    P_A_local = [ +x_rel/2, 0 ];
    
    % поворот локальной системы на угол phi и перенос в (Xc,Yc)
    rotateXY = @(XY) [ XY(:,1)*cos(phi) - XY(:,2)*sin(phi), ...
                       XY(:,1)*sin(phi) + XY(:,2)*cos(phi) ];
                   
    glob1 = rotateXY(spring1) + [Xc, Yc];
    glob2 = rotateXY(spring2) + [Xc, Yc];
    A_glob = ([P_A_local] * [cos(phi), -sin(phi); sin(phi), cos(phi)]) + [Xc, Yc];
    
    % рисуем внутренние пружины
    plot(glob1(:,1), glob1(:,2), 'r', 'LineWidth', 1.5);
    plot(glob2(:,1), glob2(:,2), 'r', 'LineWidth', 1.5);
    
    % рисуем грузик A
    R_A = 0.5;
    thA = linspace(0,2*pi,50);
    fill(A_glob(1) + R_A*cos(thA), A_glob(2) + R_A*sin(thA), ...
         [0.2,0.6,0.2], 'EdgeColor','none');
    
    drawnow;
    pause(0.02);
end
