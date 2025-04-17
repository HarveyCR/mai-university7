% Определяем функцию
f = @(x) exp(x) + log(x) - 10*x;
interval = [3, 4];
tol = 1e-4;
maxIter = 100;

% Инициализируем массив для хранения конечной погрешности на каждой итерации
iterations = 1:maxIter;
final_errors = zeros(size(iterations));

% Для каждого значения максимального числа итераций получаем корень и вычисляем абсолютную погрешность
for k = iterations
    try
        root = false_position_method(f, interval, tol, k);
        final_errors(k) = abs(f(root));
    catch err
        % В случае ошибки (например, неверный интервал) записываем NaN
        final_errors(k) = NaN;
    end
end

% Построение графика с логарифмической осью ординат
figure;
semilogy(iterations, final_errors, 'o-', 'LineWidth', 2);
xlabel('Количество итераций');
ylabel('Абсолютное значение f(root)');
title('Зависимость точности от количества итераций');
grid on;
