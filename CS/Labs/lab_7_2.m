function plot_cone(params, varargin)
% plot_cone - строит график конуса второго порядка с возможностью поворота.
%
% Синтаксис:
%   plot_cone(params)
%   plot_cone(params, rotAngles)
%
% Входные параметры:
%   params   - числовой вектор [a, b, c, h], где a, b, c - коэффициенты,
%              h - высота конуса.
%
% Дополнительный параметр:
%   rotAngles - вектор [alpha, beta, gamma] углов вращения (в градусах)
%               вокруг осей X, Y и Z соответственно. По умолчанию: [45, 0, 0].
%
% Уравнение конуса: (x^2/a^2) + (y^2/b^2) - (z^2/c^2) = 0

    % Проверка количества входных параметров
    if nargin < 1 || nargin > 2
        error('Ошибка: Функция должна принимать один обязательный и один дополнительный параметр.');
    end

    % Проверка первого параметра
    if ~isnumeric(params) || numel(params) ~= 4
        error('Ошибка: Первый параметр должен быть числовым вектором [a, b, c, h].');
    end

    % Определение углов вращения
    if nargin == 2
        rotAngles = varargin{1};
        if ~isnumeric(rotAngles) || numel(rotAngles) ~= 3
            error('Ошибка: Второй параметр должен быть числовым вектором с 3 элементами (углы вращения).');
        end
    else
        rotAngles = [45, 0, 0];
    end

    % Извлечение параметров конуса
    a = params(1); b = params(2); c = params(3); h = params(4);

    % Параметризация конуса.
    % Для конуса с вершиной в начале координат можно задать:
    %   x = a*(z/c)*cos(theta), y = b*(z/c)*sin(theta), z = z,
    % где z изменяется от 0 до h, а theta от 0 до 2*pi.
    theta = linspace(0, 2*pi, 50);
    z = linspace(0, h, 50);
    [Theta, Z] = meshgrid(theta, z);
    X = a * (Z / c) .* cos(Theta);
    Y = b * (Z / c) .* sin(Theta);

    % Применение поворота.
    % Преобразуем координаты в виде набора точек для применения матричного умножения.
    pts = [X(:)'; Y(:)'; Z(:)'];

    % Построение матриц вращения.
    alpha = deg2rad(rotAngles(1));
    beta  = deg2rad(rotAngles(2));
    gamma = deg2rad(rotAngles(3));

    Rx = [1 0 0; 0 cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];
    Ry = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];
    Rz = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];

    % Комбинированная матрица вращения (порядок: Rx -> Ry -> Rz)
    R = Rz * Ry * Rx;
    pts_rot = R * pts;

    % Преобразуем координаты обратно в матричный формат
    X_rot = reshape(pts_rot(1,:), size(X));
    Y_rot = reshape(pts_rot(2,:), size(Y));
    Z_rot = reshape(pts_rot(3,:), size(Z));

    % Построение поверхности
    figure;
    surf(X_rot, Y_rot, Z_rot);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title('Построение конуса второго порядка');
    axis equal;
    grid on;
end

% Вызов с явным заданием углов поворота:
plot_cone([2, 3, 4, 5], [30, 15, 0]);
% Или без второго параметра (будут использованы значения по умолчанию):
plot_cone([2, 3, 4, 5]);
