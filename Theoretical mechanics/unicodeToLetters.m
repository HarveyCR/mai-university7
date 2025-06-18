function charArray = unicodeToLetters(codePoints)
% unicodeToLetters Преобразует числовые Unicode-коды в символы
%   charArray = unicodeToLetters(codePoints)
%   - codePoints: вектор или матрица чисел (целые значения Unicode)
%   - charArray: массив тех же размеров, но типа char

    % Проверяем, что вход — числовой массив
    if ~isnumeric(codePoints)
        error('Вход должен быть числовым массивом с целыми Unicode-кодами.');
    end

    % Убедимся, что кодовые точки целочисленные и неотрицательные
    if any(codePoints(:) < 0) || any(floor(codePoints(:)) ~= codePoints(:))
        error('Все элементы codePoints должны быть неотрицательными целыми числами.');
    end

    % Преобразуем числа в char (UTF-16 кодовые единицы)
    charArray = char(codePoints);
end
