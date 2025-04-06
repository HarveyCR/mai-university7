function plot_custom_cone(varargin)
% plot_custom_cone - строит конус второго порядка с произвольными параметрами.
%
% Использование:
%   plot_custom_cone('a',2, 'b',3, 'c',4, 'h',5, 'Color', 'red', ...
%                   'Title', 'Мой конус', 'Position', [100 100 800 600], 'Rotation', [30,15,0])
%
% Допустимые параметры (имя-значение):
%   a         - коэффициент a (по умолчанию 1)
%   b         - коэффициент b (по умолчанию 1)
%   c         - коэффициент c (по умолчанию 1)
%   h         - высота конуса (по умолчанию 1)
%   Color     - цвет конуса (по умолчанию 'blue')
%   Title     - заголовок окна (по умолчанию 'Построение конуса')
%   Position  - позиция окна [left, bottom, width, height] (по умолчанию [100, 100, 800, 600])
%   Rotation  - вектор углов поворота [alpha, beta, gamma] (в градусах, по умолчанию [45, 0, 0])
%
% Если параметр не указан, используется значение по умолчанию.

    % Значения по умолчанию
    params.a = 1;
    params.b = 1;
    params.c = 1;
    params.h = 1;
    params.Color = 'blue';
    params.Title = 'Построение конуса';
    params.Position = [100, 100, 800, 600];
    params.Rotation = [45, 0, 0]; % углы поворота: [alpha, beta, gamma] в градусах

    % Проверка, что число аргументов чётное (пара имя-значение)
    if mod(length(varargin),2) ~= 0
        error('Ошибка: Параметры должны передаваться парами "имя-значение".');
    end

    % Обработка входных параметров
    for i = 1:2:length(varargin)
        fieldName = varargin{i};
        fieldValue = varargin{i+1};
        if ischar(fieldName)
            if isfield(params, fieldName)
                params.(fieldName) = fieldValue;
            else
                warning('Неизвестный параметр: %s. Он будет проигнорирован.', fieldName);
            end
        else
            error('Ошибка: Имена параметров должны быть строками.');
        end
    end

    % Создание графического окна с заданными свойствами
    fig = figure('Name', params.Title, 'Position', params.Position);
    
    % Параметризация конуса (до поворота)
    theta = linspace(0, 2*pi, 50);
    z = linspace(0, params.h, 50);
    [Theta, Z] = meshgrid(theta, z);
    % Формулы параметризации конуса:
    %   x = a*(z/c)*cos(theta), y = b*(z/c)*sin(theta)
    X = params.a * (Z / params.c) .* cos(Theta);
    Y = params.b * (Z / params.c) .* sin(Theta);
    
    % Применение поворота к конусу, если задан параметр Rotation
    rotAngles = params.Rotation;
    if ~isnumeric(rotAngles) || numel(rotAngles) ~= 3
        error('Ошибка: Параметр Rotation должен быть числовым вектором из 3 элементов.');
    end
    % Преобразование углов из градусов в радианы
    alpha = deg2rad(rotAngles(1));
    beta  = deg2rad(rotAngles(2));
    gamma = deg2rad(rotAngles(3));

    % Матрицы вращения
    Rx = [1, 0, 0; 0, cos(alpha), -sin(alpha); 0, sin(alpha), cos(alpha)];
    Ry = [cos(beta), 0, sin(beta); 0, 1, 0; -sin(beta), 0, cos(beta)];
    Rz = [cos(gamma), -sin(gamma), 0; sin(gamma), cos(gamma), 0; 0, 0, 1];
    % Комбинированная матрица вращения (порядок: Rx -> Ry -> Rz)
    R = Rz * Ry * Rx;

    % Применение поворота ко всем точкам конуса
    pts = [X(:)'; Y(:)'; Z(:)'];
    pts_rot = R * pts;
    % Преобразуем результат обратно в матричный формат
    X_rot = reshape(pts_rot(1, :), size(X));
    Y_rot = reshape(pts_rot(2, :), size(Y));
    Z_rot = reshape(pts_rot(3, :), size(Z));

    % Построение поверхности конуса с заданным цветом
    surf(X_rot, Y_rot, Z_rot, 'FaceColor', params.Color);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title(params.Title);
    axis equal;
    grid on;
end

plot_custom_cone('a', 3, 'b', 2, 'c', 6, 'Color', 'blue', 'Rotation', [0,0,0]);
