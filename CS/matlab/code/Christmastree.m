% Бесконечно вращающаяся 3D елка с падающими снежинками
clc;
clear;

% Настройка фигуры
figure;
hold on;
axis equal;
axis off;

% Принудительно устанавливаем фиксированное положение камеры
view(3); % Установить вид 3D
az = 45; % Азимут камеры
el = 30; % Элеватор камеры
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
h = scatter3(star_x, star_y, star_z, 200, 'yellow', 'filled', 'Marker', 'p');
set(h, 'Parent', treeGroup); % Добавление звезды в группу объектов

% Освещение и настройки отображения
lightangle(-45, 30);
lighting gouraud;
camlight;
title('3D Вращающаяся Елка с Падающими Снежинками');

% Параметры снежинок
num_snowflakes = 50; % Уменьшено количество снежинок
% Генерация случайных позиций снежинок
snowflakeX = rand(1, num_snowflakes) * 4 - 2; % Случайные X-позиции
snowflakeY = rand(1, num_snowflakes) * 4 - 2; % Случайные Y-позиции
snowflakeZ = rand(1, num_snowflakes) * 2 + 2; % Случайные Z-позиции (высота)
snowflakes = scatter3(snowflakeX, snowflakeY, snowflakeZ, 50, 'w', 'filled'); % Снежинки

% Скорость падения снежинок (замедление падения)
fallingSpeed = rand(1, num_snowflakes) * 0.03 + 0.02; % Падение медленнее

% Анимация бесконечного вращения с изменением цвета градиента и падением снега
angle = 0; % Начальный угол
while true
    % Определяем матрицу вращения
    rotationMatrix = makehgtform('zrotate', deg2rad(angle));
    % Применяем вращение к группе объектов елки
    set(treeGroup, 'Matrix', rotationMatrix);
    
    % Каждые 60 кадров (примерно каждые 2 секунды) меняем цвет градиента
    if mod(angle, 60) == 0
        % Генерация нового цветового градиента для всех слоев
        for i = 1:num_layers
            % Генерация случайных цветов для слоев
            color = rand(1, 3); % Случайный цвет
            set(layerHandles(i), 'FaceColor', color); % Обновление цвета слоя
        end
    end
    
    % Обновляем позиции снежинок
    snowflakeZ = snowflakeZ - fallingSpeed; % Падение снежинок по оси Z
    
    % Проверка, если снежинка выходит за пределы, сбрасываем ее наверх
    for i = 1:num_snowflakes
        if snowflakeZ(i) < 0
            snowflakeZ(i) = rand * 2 + 2; % Сброс на верхнюю позицию
            snowflakeX(i) = rand * 4 - 2; % Случайная позиция X
            snowflakeY(i) = rand * 4 - 2; % Случайная позиция Y
        end
    end
    % Обновление позиций снежинок
    set(snowflakes, 'XData', snowflakeX, 'YData', snowflakeY, 'ZData', snowflakeZ);
    
    % Увеличиваем угол
    angle = angle + 1;
    if angle >= 360
        angle = 0; % Сброс угла после полного оборота
    end
    
    pause(0.03); % Контроль скорости вращения
end
