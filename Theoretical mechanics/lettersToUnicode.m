function codePoints = lettersToUnicode(charArray)
% lettersToUnicode Преобразует символы в их Unicode-коды
%   codePoints = lettersToUnicode(charArray)
%   - charArray: вектор символов или строка
%   - codePoints: вектор тех же размеров с числовыми кодами Unicode

    % Проверяем, что вход действительно символы или строка
    if ~(ischar(charArray) || isstring(charArray))
        error('Вход должен быть char-массивом или string.');
    end

    % Для строк преобразуем их в char-массив
    if isstring(charArray)
        charArray = char(charArray);
    end

    % MATLAB хранит строки в UTF-16, поэтому double возвращает кодовые единицы UTF-16
    codePoints = double(charArray);
end
