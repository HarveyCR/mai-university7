% Анимация точки в полярных координатах с векторами скорости, ускорения
% и центром кривизны (фиксированная область просмотра, уменьшенные стрелки)

% 1. Параметры времени
Tmax = 10;          % время моделирования, с
dt   = 0.005;        % шаг по времени, с
t    = 0:dt:Tmax;   % вектор времени

% 2. Задание полярных координат r(t) и phi(t)
r   = 2 + sin(12*t);
phi = t + 0.2*cos(13*t);

% 3. Перевод в декартовы координаты
x = r .* cos(phi);
y = r .* sin(phi);

% 4. Первая и вторая производные r и phi
dr    = 12 * cos(12*t);
dphi  = 1 - 0.2*13 * sin(13*t);
d2r   = -12^2 * sin(12*t);
d2phi = -0.2 * 13^2 * cos(13*t);

% 5. Скорость и ускорение в декартовых проекциях
vx = dr .* cos(phi) - r .* sin(phi) .* dphi;
vy = dr .* sin(phi) + r .* cos(phi) .* dphi;

ax = d2r .* cos(phi) ...
     - 2*dr .* sin(phi) .* dphi ...
     - r .* cos(phi) .* dphi.^2 ...
     - r .* sin(phi) .* d2phi;
ay = d2r .* sin(phi) ...
     + 2*dr .* cos(phi) .* dphi ...
     - r .* sin(phi) .* dphi.^2 ...
     + r .* cos(phi) .* d2phi;

% 6. Расчёт центра кривизны
%   скор² = vx^2 + vy^2; поперечный вектор v_perp = [-vy, vx]
%   скалярное произведение (v × a) = vx.*ay - vy.*ax
speed2 = vx.^2 + vy.^2;
crossVA = vx .* ay - vy .* ax;  
cx = x - (vy .* speed2) ./ crossVA;
cy = y + (vx .* speed2) ./ crossVA;

% 7. Подготовка окна и фиксация области просмотра
figure;
hold on; grid on; axis equal;
plot(x, y, 'k:');              % вся траектория пунктиром

% вычисляем границы по r и добавляем небольшой запас
margin = 0.2;
Rmax = max(r) + margin;
axis([-Rmax, Rmax, -Rmax, Rmax]);

% 8. Инициализация графических объектов
hP = plot(0,0,'ro','MarkerSize',8,'MarkerFaceColor','r');    % точка
hV = quiver(0,0,0,0,'b','MaxHeadSize',2,'LineWidth',1.5);    % скорость
hA = quiver(0,0,0,0,'r','MaxHeadSize',2,'LineWidth',1.5);    % ускорение
hC = plot(0,0,'go','MarkerSize',8,'MarkerFaceColor','g');    % центр кривизны

legend('Траектория','Точка','Скорость','Ускорение','Центр кривизны', ...
       'Location','best');
xlabel('x'); ylabel('y');
title('Анимация: точка, векторы скорости/ускорения и центр кривизны');

% 9. Масштабирование стрелок
scaleV = 0.05;   % уменьшает вектор скорости
scaleA = 0.01;   % уменьшает вектор ускорения

% 10. Цикл анимации
for k = 1:length(t)
    % обновляем положение точки
    set(hP, 'XData', x(k), 'YData', y(k));
    
    % обновляем вектор скорости
    set(hV, 'XData', x(k), 'YData', y(k), ...
            'UData', vx(k)*scaleV, 'VData', vy(k)*scaleV);
        
    % обновляем вектор ускорения
    set(hA, 'XData', x(k), 'YData', y(k), ...
            'UData', ax(k)*scaleA, 'VData', ay(k)*scaleA);
    
    % обновляем центр кривизны
    set(hC, 'XData', cx(k), 'YData', cy(k));
    
    drawnow;
end
