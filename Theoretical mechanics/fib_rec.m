function f = fib_rec(n)
    % Рекурсивная функция для n-го числа Фибоначчи
    if n == 0 f = 0;               % базовый случай 1
    elseif n == 1    f = 1;               % базовый случай 2
    else f = fib_rec(n-1) + fib_rec(n-2);  % рекурсивный шаг
    end
end
