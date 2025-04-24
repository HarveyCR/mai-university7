f = @(x) exp(x) + log(x) - 10*x;

% Заданные параметры
initial_approximation = 5.0;
tol = 1e-6;
% Для сравнения используем заданное приближение корня
actual_root = 3.5265;  

% Диапазон максимального числа итераций
max_iter_values = 1:100;
errors = zeros(size(max_iter_values));

for i = 1:length(max_iter_values)
    max_iter = max_iter_values(i);
    try
        [root, iter] = newton_method(f, initial_approximation, tol, max_iter);
        errors(i) = abs(root - actual_root);
    catch ME
        % Если возникла ошибка (например, деление на ноль), записываем NaN
        errors(i) = NaN;
    end
end

% Построение графика зависимости ошибки от числа итераций (логарифмическая ось ординат)
figure;
semilogy(max_iter_values, errors, 'b-o', 'LineWidth',1.5);
xlabel('Максимальное число итераций');
ylabel('Ошибка |x - x_{actual}|');
title('Зависимость точности найденного корня от числа итераций');
grid on;
