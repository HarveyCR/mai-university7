% Параметры спирали
a_values = [0.5, 1, 1.5, 2, 2.5];  % Различные значения a
b = 0.1;  % Коэффициент экспоненты

% Диапазон углов (в радианах)
phi = linspace(0, 4*pi, 1000); % от 0 до 4*pi с 1000 точками

% Создание графика
figure;
hold on;
grid on;
axis equal;
title('Логарифмические спирали для разных значений a');
xlabel('x');
ylabel('y');

% Цвета для разных спиралей
for i = 1:length(a_values)
    a = a_values(i);
    r = a .* exp(b * phi);
    x = r .* cos(phi);
    y = r .* sin(phi);
    
    % Определение цвета с помощью switch-case
    switch i
        case 1
            color = 'r'; % Красный
        case 2
            color = 'g'; % Зелёный
        case 3
            color = 'b'; % Синий
        case 4
            color = 'm'; % Пурпурный
        case 5
            color = 'k'; % Чёрный
        otherwise
            color = 'c'; % Голубой (на случай непредвиденных ситуаций)
    end
    
    % Построение кривой
    plot(x, y, 'Color', color, 'LineWidth', 1.5);
end

hold off;
legend(arrayfun(@(a) sprintf('a = %.1f', a), a_values, 'UniformOutput', false));
