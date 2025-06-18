function elapsed = timeMyFunc(funcHandle, lists)
% timeMyFunc запускает функцию funcHandle с аргументами varargin
% и возвращает время её выполнения в секундах.
%
% Пример:
%   t = timeMyFunc(@myHeavyFunction, arg1, arg2);
for i = 1:length(lists)
    tic;                              % стартуем таймер
    funcHandle(lists{i});          % вызываем функцию
    elapsed = toc;                    % останавливаем и читаем время
    fprintf('Время выполнения: %.6f сек\n', elapsed);
end
end
