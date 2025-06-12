function f = factorial_rec(n)
    % Рекурсивная функция для вычисления факториала n
    if n == 0 f = 1;           % базовый случай
    else f = n * factorial_rec(n-1); end  % рекурсивный шаг 
end