% Заданная функция
f = @(x) exp(x) + log(x) - 10*x;
% Приблизительно известное значение корня для сравнения:
exact_root = 3.5265; 

% Диапазон начальных приближений
range = [3, 4];
% Зададим достаточно строгую точность для стабильного результата при большом числе итераций
tol = 1e-8;  

max_iter_total = 20;

errors = zeros(max_iter_total, 1);
iters = zeros(max_iter_total, 1);

% Вариант: запуск функции с постепенно увеличивающимся числом итераций
for k = 1:max_iter_total
    [root, iter] = secant_method(f, range, tol, k);
    iters(k) = iter;
    errors(k) = abs(root - exact_root);
end

figure;
% Используем логарифмический масштаб по оси Y
semilogy(iters, errors, '-o');
xlabel('Количество итераций');
ylabel('Абсолютная ошибка |root - 3.5265|');
title('Зависимость точности от числа итераций (логарифмическая ось)');
grid on;
