% bisection_iterative_script.m
% Решение уравнения: exp(x) + log(x) - 10*x = 0 методом бисекции

% Задаём функцию
f = @(x) exp(x) + log(x) - 10*x;

% Начальные значения
a = 3; 
b = 4;
tol = 1e-5;         % критерий точности
max_iter = 100;     % максимальное число итераций

% Проверка наличия знакопеременности
if f(a)*f(b) > 0
    error('На заданном интервале функция не меняет знак. Выберите другой интервал.');
end

% Инициализация переменных для хранения результатов итераций
iter = 0;
data = [];  % матрица для хранения: [iter, mid, f(mid)]

fprintf(' Ит |       x_{mid}     |     f(x_{mid})\n');
fprintf('-------------------------------------------\n');

while iter < max_iter
    iter = iter + 1;
    mid = (a + b)/2;
    fmid = f(mid);
    
    % Сохраняем данные для вывода
    data = [data; iter, mid, fmid];
    
    % Вывод текущей итерации в командное окно
    fprintf('%4d | %14.6f | %14.6f\n', iter, mid, fmid);
    
    % Если достигнута требуемая точность по значению функции, завершаем
    if abs(fmid) < tol
        break;
    end
    
    % Определение нового интервала
    if f(a)*fmid < 0
        b = mid;
    else
        a = mid;
    end
end

% Вывод результата
fprintf('\nПриблизительное значение корня: %.6f\n', mid);
fprintf('Количество итераций: %d\n', iter);

% Построение графиков:
figure;
subplot(2,1,1)
plot(data(:,1), data(:,2), 'b-o','LineWidth',1.5);
xlabel('Номер итерации');
ylabel('Приближение x');
title('График последовательных приближений');

subplot(2,1,2)
plot(data(:,1), data(:,3), 'r-o','LineWidth',1.5);
xlabel('Номер итерации');
ylabel('f(x)');
title('График значений функции');

% Геометрическая интерпретация: 
% На основе полученной таблицы можно на листе бумаги построить схему: на оси абсцисс отмечены значения x, 
% а вертикально – значения f(x). В каждой итерации выбор нового интервала соответствует делению отрезка пополам 
% и выбор подотрезка, на котором функция меняет знак.
