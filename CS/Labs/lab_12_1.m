% newton_method.m
% Решение уравнения: exp(x) + log(x) - 10 = 0 методом Ньютона

% Определяем функцию и её производную
f   = @(x) exp(x) + log(x) - 10;
df  = @(x) exp(x) + 1./x;

% Начальное приближение (учтите, что ln(x) определена только при x > 0)
x0    = 2;
tol   = 1e-6;      % заданная точность
maxIter = 100;     % максимальное число итераций

% Инициализация переменных для сохранения итераций
iter = 0;
X = x0;            % вектор приближений
fX = f(x0);        % вектор значений функции

% Итерационный процесс с использованием цикла while
fprintf('Результаты поиска корня:\n')
fprintf('---------------------------------------------\n')
fprintf('|Номер Итерации| |Значение X| |Значение f(x)|\n')

while abs(fX(end)) > tol && iter < maxIter
    iter = iter + 1;
    x_old = X(end);
    % Метод Ньютона: x_new = x_old - f(x_old)/f'(x_old)
    x_new = x_old - f(x_old)/df(x_old);

    % Сохранение новых значений
    X   = [X; x_new];
    fX  = [fX; f(x_new)];

    fprintf('|', iter, '| ', '|', X, '|', '|', fX, '|\n')

end

% Вывод результатов в виде таблицы
%T = table((0:iter)', X, fX, 'VariableNames', {'| Номер Итерации |', '| Значение X |', '| Значение f(x) |'});
%disp(T)

%% Построение графиков последовательных приближений
figure;
% График приближений x по итерациям
subplot(2,1,1)
plot(0:iter, X, '-o', 'LineWidth', 1.5)
xlabel('Номер итерации')
ylabel('Приближение x')
title('Последовательные приближения корня')
grid on;

% График значений функции f(x) по итерациям
subplot(2,1,2)
plot(0:iter, fX, '-o', 'LineWidth', 1.5)
xlabel('Номер итерации')
ylabel('Значение f(x)')
title('Значения функции на последовательных приближениях')
grid on;

%% Геометрическая интерпретация метода Ньютона
figure;
% Зададим область для построения графика функции
x_min = min(X) - 1;
x_max = max(X) + 1;
x_vals = linspace(x_min, x_max, 400);
plot(x_vals, f(x_vals), 'b-', 'LineWidth', 2)
hold on;

% Для каждой итерации строим касательную к графику функции
for i = 1:length(X)-1
    xi = X(i);
    fxi = f(xi);
    dfxi = df(xi);
    % Уравнение касательной: y = fxi + dfxi*(x - xi)
    xt = linspace(xi - 0.5, xi + 0.5, 50);
    yt = fxi + dfxi*(xt - xi);
    plot(xt, yt, 'r--', 'LineWidth', 1)
    
    % Отображаем точки приближений и проводим вертикальную линию до оси absciss
    plot(xi, fxi, 'ko', 'MarkerFaceColor', 'k')
    plot([xi, xi], [0, fxi], 'k:', 'LineWidth', 1)
end

% Отметим последнюю точку
plot(X(end), f(X(end)), 'ko', 'MarkerFaceColor', 'k')
xlabel('x')
ylabel('f(x)')
title('Геометрическая интерпретация метода Ньютона')
grid on;
hold off;
