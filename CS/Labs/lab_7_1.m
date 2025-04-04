function r = distance_spiral(theta, a, b)
% distance_spiral - вычисляет расстояние от точки логарифмической спирали до полюса.
% Формула: r = a * exp(b * theta)
%
% Входные параметры (обязательные):
%   theta - угол (числовой скаляр)
%   a     - коэффициент a (числовой скаляр)
%   b     - коэффициент b (числовой скаляр)
%
% Выходной параметр:
%   r     - расстояние

    % Проверка числа входных параметров
    if nargin ~= 3
        error('Ошибка: Функция требует три входных параметра: угол, a и b.');
    end

    % Проверка типов входных параметров (должны быть числовыми скалярами)
    if ~isscalar(theta) || ~isnumeric(theta) || ...
       ~isscalar(a)     || ~isnumeric(a)     || ...
       ~isscalar(b)     || ~isnumeric(b)
        error('Ошибка: Все входные параметры должны быть числовыми скалярами.');
    end

    % Вычисление расстояния по формуле
    r = a * exp(b * theta);
end

% Пример вызова:
r = distance_spiral(pi/4, 2, 0.5);
