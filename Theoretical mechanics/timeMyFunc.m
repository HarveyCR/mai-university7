function elapsed = timeMyFunc(funcHandle, varargin)
% timeMyFunc запускает функцию funcHandle с аргументами varargin
% и возвращает время её выполнения в секундах.
%
% Пример:
%   t = timeMyFunc(@myHeavyFunction, arg1, arg2);

    tic;                              % стартуем таймер
    funcHandle(varargin{:});          % вызываем функцию
    elapsed = toc;                    % останавливаем и читаем время
    fprintf('Время выполнения: %.6f сек\n', elapsed);
end
