syms x k;

% Определить кусочную функцию
f_x = piecewise(x > 0, 0, x < 0, 1);
% Аналитически вычислить коэффициенты Фурье
a0 = (1/pi) * int(f_x, x, -pi, pi);
a_k = (1/pi) * int(f_x * cos(k*x), x, -pi, pi);
b_k = (1/pi) * int(f_x * sin(k*x), x, -pi, pi);

% Выбер набора значений для частичных сумм
N_values = [1, 2, 4, 8, 16, 32];
colors = lines(numel(N_values)); 

% Figure 1: Частичные суммы
figure('Name', 'Частичные суммы рядов Фурье');
hold on;
for idx = 1:numel(N_values)
    N = N_values(idx);
    % Вычислить частичную сумму символически
    S_N = a0/2 + symsum(a_k*cos(k*x) + b_k*sin(k*x), k, 1, N);
    
    % Преобразование в анонимную функцию для построения графика
    f_sum = matlabFunction(S_N, 'Vars', x);
    
    % Plot частичной суммы
    fs = fplot(f_sum, [-2*pi, 2*pi], 'LineWidth', 1.5);
    fs.Color = colors(idx, :);
    
    legend_entries{idx} = sprintf('N = %d', N);
end

% Постройение графика исходной функции для сравнения
xd = [-2*pi, -pi, -pi, 0, 0, pi, pi, 2*pi];
yd = [0,    0,   1,    1,  0,  0,  1,   1];
plot(xd, yd, 'r--', 'LineWidth', 2);
legend_entries{end+1} = 'f(x)';

legend(legend_entries, 'Location', 'best');
xlabel('x');
ylabel('f_N(x)');
title('Частичные суммы ряда Фурье для ступенчатой функции');
grid on;
hold off;

% Figure 2: Среднеквадратичное отклонение в зависимости от количества членов
sigma = zeros(size(N_values));
for idx = 1:numel(N_values)
    N = N_values(idx);
    S_N = a0/2 + symsum(a_k*cos(k*x) + b_k*sin(k*x), k, 1, N);
    err_sq = (f_x - S_N)^2;
    sigma(idx) = double(sqrt(int(err_sq, x, -pi, pi)));
end

figure('Name', 'Среднеквадратичное отклонение');
plot(N_values, sigma, '-o', 'LineWidth', 1.5);
xlabel('Количество терминов (N)');
ylabel('Среднеквадратичное отклонение');
title('Среднеквадратичное отклонение аппроксимации ряда Фурье');
grid on;
