% Параметры времени
t0 = 0;            % начальное время
t_end = 10;        % конечное время
dt = 0.001;        % шаг по времени
t = t0:dt:t_end;

% Закон движения в полярных координатах
r = 2 + cos(6*t);
phi = 7*t + 1.2*cos(6*t);

% Перевод в декартовы координаты
x = r .* cos(phi);
y = r .* sin(phi);

% Вычисление производных (скорость и ускорение)
dx = gradient(x, dt);
dy = gradient(y, dt);
ddx = gradient(dx, dt);
ddy = gradient(dy, dt);

% Построение траектории
figure;
plot(x, y, 'k--'); hold on;
axis([-3 3 -3 3]);
xlabel('x');
ylabel('y');
title('Траектория и анимация движения точки');

fixedLengthX = 0.5;
fixedLengthY = 1.2;
% Анимация движения точки с отображением стрелок скорости и ускорения фиксированной длины
for k = 1:10:length(t)
    % Отрисовка текущей точки
    plot(x(k), y(k), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    
    % Нормализация вектора скорости и построение стрелки
    vNorm = sqrt(dx(k)^2 + dy(k)^2);
    if vNorm > 0
        vx = (dx(k)/vNorm)*fixedLengthX;
        vy = (dy(k)/vNorm)*fixedLengthY;
    else
        vx = 0; vy = 0;
    end
    quiver(x(k), y(k), vx, vy, 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 2);
    
    % Нормализация вектора ускорения и построение стрелки
    aNorm = sqrt(ddx(k)^2 + ddy(k)^2);
    if aNorm > 0
        ax = (ddx(k)/aNorm)*fixedLengthX;
        ay = (ddy(k)/aNorm)*fixedLengthY;
    else
        ax = 0; ay = 0;
    end
    quiver(x(k), y(k), ax, ay, 0, 'g', 'LineWidth', 1.5, 'MaxHeadSize', 2);
    
    pause(0.01);  % задержка для анимации
    
    % Обновление графика: очищаем динамические объекты, оставляя траекторию
    if k < length(t)
        cla;
        plot(x, y, 'k--'); hold on;
        axis equal;
        xlabel('x');
        ylabel('y');
        title('Траектория и анимация движения точки');
    end
end
