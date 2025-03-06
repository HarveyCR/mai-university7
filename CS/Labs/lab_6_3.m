% Параметры
a = 1; b = 2; c = 1.5; h = 5;

% Создание сетки для построения конуса
theta = linspace(0, 2*pi, 100);   % Углы для круговых сечений
z = linspace(0, h, 50);           % Высота от 0 до h
[Z, Theta] = meshgrid(z, theta);
% Исходные координаты (будем использовать их в каждой анимации)
X0 = (Z / h) * a .* cos(Theta);
Y0 = (Z / h) * b .* sin(Theta);
Z0 = Z;

% Создание фигуры
figure;
hold on;
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Конус второго порядка');
grid on;
axis([-5 5 -5 5 -5 h]);  % Фиксированные пределы осей
view(3);                % Фиксированный 3D вид

% Отображаем исходный конус
hConus = surf(X0, Y0, Z0);
colormap jet;

% Создание текстовых меток для отображения углов
hAngleX = text(-2.5, 2.5, h, 'Angle X: 0°', 'Color', 'black', 'FontSize', 12);
hAngleY = text(-2.5, 2.3, h, 'Angle Y: 0°', 'Color', 'black', 'FontSize', 12);
hAngleZ = text(-2.5, 2.1, h, 'Angle Z: 0°', 'Color', 'black', 'FontSize', 12);

% Функции поворота
rotateX = @(theta) [1, 0, 0; 0, cos(theta), -sin(theta); 0, sin(theta), cos(theta)];
rotateY = @(theta) [cos(theta), 0, sin(theta); 0, 1, 0; -sin(theta), 0, cos(theta)];
rotateZ = @(theta) [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];

%% Анимация: Вращение вокруг оси X
for angleX = 0:1:360
    rad = deg2rad(angleX);                  % Перевод в радианы
    R = rotateX(rad);                       % Матрица поворота вокруг X
    % Применяем поворот к исходным координатам
    rotatedXYZ = [X0(:), Y0(:), Z0(:)] * R';
    X_rot = reshape(rotatedXYZ(:,1), size(X0));
    Y_rot = reshape(rotatedXYZ(:,2), size(Y0));
    Z_rot = reshape(rotatedXYZ(:,3), size(Z0));
    
    % Обновляем график конуса
    set(hConus, 'XData', X_rot, 'YData', Y_rot, 'ZData', Z_rot);
    
    % Обновляем текстовые метки: только угол по оси X меняется, Y и Z равны 0
    set(hAngleX, 'String', sprintf('Angle X: %d°', angleX));
    set(hAngleY, 'String', 'Angle Y: 0°');
    set(hAngleZ, 'String', 'Angle Z: 0°');
    
    % Изменяем цвет метки, если угол кратен 45°
    if mod(angleX,45)==0
        set(hAngleX, 'Color', 'red');
    else
        set(hAngleX, 'Color', 'black');
    end
    
    pause(0.01);
end

pause(1);  % Пауза между анимациями

%% Анимация: Вращение вокруг оси Y
for angleY = 0:1:360
    rad = deg2rad(angleY);
    R = rotateY(rad);                       % Матрица поворота вокруг Y
    rotatedXYZ = [X0(:), Y0(:), Z0(:)] * R';
    X_rot = reshape(rotatedXYZ(:,1), size(X0));
    Y_rot = reshape(rotatedXYZ(:,2), size(Y0));
    Z_rot = reshape(rotatedXYZ(:,3), size(Z0));
    
    set(hConus, 'XData', X_rot, 'YData', Y_rot, 'ZData', Z_rot);
    
    % Обновляем метки: угол по оси Y меняется, X и Z равны 0
    set(hAngleX, 'String', 'Angle X: 0°');
    set(hAngleY, 'String', sprintf('Angle Y: %d°', angleY));
    set(hAngleZ, 'String', 'Angle Z: 0°');
    
    if mod(angleY,45)==0
        set(hAngleY, 'Color', 'blue');
    else
        set(hAngleY, 'Color', 'black');
    end
    
    pause(0.01);
end

pause(1);

%% Анимация: Вращение вокруг оси Z
for angleZ = 0:1:360
    rad = deg2rad(angleZ);
    R = rotateZ(rad);                       % Матрица поворота вокруг Z
    rotatedXYZ = [X0(:), Y0(:), Z0(:)] * R';
    X_rot = reshape(rotatedXYZ(:,1), size(X0));
    Y_rot = reshape(rotatedXYZ(:,2), size(Y0));
    Z_rot = reshape(rotatedXYZ(:,3), size(Z0));
    
    set(hConus, 'XData', X_rot, 'YData', Y_rot, 'ZData', Z_rot);
    
    % Обновляем метки: угол по оси Z меняется, X и Y равны 0
    set(hAngleX, 'String', 'Angle X: 0°');
    set(hAngleY, 'String', 'Angle Y: 0°');
    set(hAngleZ, 'String', sprintf('Angle Z: %d°', angleZ));
    
    if mod(angleZ,45)==0
        set(hAngleZ, 'Color', 'green');
    else
        set(hAngleZ, 'Color', 'black');
    end
    
    pause(0.01);
end
