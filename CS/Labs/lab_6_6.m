%% Исходные данные и построение конуса

% Параметры
a = 1; 
b = 2; 
c = 1.5;
h = 5;

% Сетка координат
t = linspace(0, 2*pi, 100);    % угловые значения
z = linspace(-h, h, 100);       % высота по оси z
[T, Z_grid] = meshgrid(t, z);

% Уравнение конуса
X0 = a * Z_grid .* cos(T);     % x = a*z*cos(t)
Y0 = b * Z_grid .* sin(T);     % y = b*z*sin(t)
Z0 = c * Z_grid;               % масштабирование по оси z

%% Анимация 4: Последовательное вращение вокруг осей Z, Y, X

figure;
hSurface = surf(X0, Y0, Z0, Y0);  % отображение поверхности (цвет по оси Y)
colormap(jet);
shading interp;
axis equal;
% Первоначальные подписи осей (будут заменяться в процессе анимации)
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Конус. Последовательное вращение (Z -> Y -> X)');
grid on;
view(45,30);
hold on;

angleStep = 1;         % шаг изменения угла (в градусах)
pauseTime = 0.005;     % уменьшенная задержка для ускорения анимации

% Инициализация базовых координат для последовательного поворота
X_base = X0;
Y_base = Y0;
Z_base = Z0;

%% Вращение вокруг оси Z (обновляем подпись оси Z)
hZLabel = get(gca, 'ZLabel');  % получаем объект подписи оси Z
for angle = 0:angleStep:360
    theta = deg2rad(angle);
    Rz = [cos(theta) -sin(theta) 0;
          sin(theta)  cos(theta) 0;
          0           0          1];
      
    coords = [X_base(:)'; Y_base(:)'; Z_base(:)'];
    newCoords = Rz * coords;
    X_rot = reshape(newCoords(1,:), size(X0));
    Y_rot = reshape(newCoords(2,:), size(Y0));
    Z_rot = reshape(newCoords(3,:), size(Z0));
    
    set(hSurface, 'XData', X_rot, 'YData', Y_rot, 'ZData', Z_rot);
    
    if mod(angle,45) == 0
        set(hZLabel, 'Color', rand(1,3));  % изменение цвета подписи оси Z
    end
    set(hZLabel, 'String', sprintf('%d°', angle));
    
    drawnow;
    pause(pauseTime);
end

% Обновляем базу после вращения вокруг Z
X_base = X_rot;
Y_base = Y_rot;
Z_base = Z_rot;

%% Вращение вокруг оси Y (обновляем подпись оси Y)
hYLabel = get(gca, 'YLabel');  % получаем объект подписи оси Y
for angle = 0:angleStep:360
    theta = deg2rad(angle);
    Ry = [ cos(theta) 0 sin(theta);
            0         1     0;
          -sin(theta) 0 cos(theta)];
      
    coords = [X_base(:)'; Y_base(:)'; Z_base(:)'];
    newCoords = Ry * coords;
    X_rot = reshape(newCoords(1,:), size(X0));
    Y_rot = reshape(newCoords(2,:), size(Y0));
    Z_rot = reshape(newCoords(3,:), size(Z0));
    
    set(hSurface, 'XData', X_rot, 'YData', Y_rot, 'ZData', Z_rot);
    
    if mod(angle,45) == 0
        set(hYLabel, 'Color', rand(1,3));
    end
    set(hYLabel, 'String', sprintf('%d°', angle));
    
    drawnow;
    pause(pauseTime);
end

% Обновляем базу после вращения вокруг Y
X_base = X_rot;
Y_base = Y_rot;
Z_base = Z_rot;

%% Вращение вокруг оси X (обновляем подпись оси X)
hXLabel = get(gca, 'XLabel');  % получаем объект подписи оси X
for angle = 0:angleStep:360
    theta = deg2rad(angle);
    Rx = [1      0           0;
          0 cos(theta) -sin(theta);
          0 sin(theta)  cos(theta)];
      
    coords = [X_base(:)'; Y_base(:)'; Z_base(:)'];
    newCoords = Rx * coords;
    X_rot = reshape(newCoords(1,:), size(X0));
    Y_rot = reshape(newCoords(2,:), size(Y0));
    Z_rot = reshape(newCoords(3,:), size(Z0));
    
    set(hSurface, 'XData', X_rot, 'YData', Y_rot, 'ZData', Z_rot);
    
    if mod(angle,45) == 0
        set(hXLabel, 'Color', rand(1,3));
    end
    set(hXLabel, 'String', sprintf('%d°', angle));
    
    drawnow;
    pause(pauseTime);
end
