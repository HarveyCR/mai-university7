clc;
clear;
figure;
hold on;
axis equal;
axis off;

view(3); 
az = 45; 
el = 30; 
set(gca, 'CameraPosition', [3, 3, 3]); % Камера на фиксированном месте
set(gca, 'CameraTarget', [0, 0, 0]); % Точка фокуса (центр сцены)
set(gca, 'CameraUpVector', [0, 0, 1]); % Направление вверх для камеры
set(gca, 'CameraViewAngle', 6); % Установить угол обзора

% Создание группы объектов для елки
treeGroup = hgtransform;

% Слои елки (вверх направленные конусы)
num_layers = 3; % Количество слоев елки
layer_height = 1.2; % Высота каждого конуса
base_height = 0; % Начальная высота основания

% Массив для хранения объектов слоев елки
layerHandles = gobjects(num_layers, 1);

for i = 1:num_layers
    % Параметры конусов
    radius = 1.2 - (i-1) * 0.4; % Уменьшающийся радиус
    height = layer_height; % Высота каждого конуса
    [X, Y, Z] = cylinder([radius, 0], 50); % Конус вверх
    Z = Z * height + base_height; % Смещение по оси Z для наложения слоев
    base_height = base_height + height; % Обновление высоты для следующего слоя
    h = surf(X, Y, Z, 'EdgeColor', 'none'); % Рисуем конус с плоскими поверхностями
    layerHandles(i) = h; % Сохраняем ручку слоя
    set(h, 'Parent', treeGroup); % Добавление конуса в группу объектов
end

% Ствол елки (цилиндр)
trunk_radius = 0.2;
trunk_height = 1;
[X, Y, Z] = cylinder(trunk_radius, 30);
Z = Z * trunk_height;
Z = Z - trunk_height; % Расположение ствола внизу
h = surf(X, Y, Z, 'FaceColor', [0.5, 0.25, 0], 'EdgeColor', 'none'); % Коричневый ствол
set(h, 'Parent', treeGroup); % Добавление ствола в группу объектов
% Звезда на вершине елки
star_x = 0;
star_y = 0;
star_z = base_height; % Позиция звезды на верхушке
h = scatter3(star_x, star_y, star_z, 600, 'yellow', 'filled', 'Marker', 'p');
set(h, 'Parent', treeGroup); % Добавление звезды в группу объектов