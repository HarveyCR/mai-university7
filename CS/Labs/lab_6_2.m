% Параметры спирали
a_values = [0.5, 1, 1.5, 2, 2.5];  % Различные значения a
b = 0.1;  % Коэффициент экспоненты

% Диапазон углов (в радианах)
phi = linspace(0, 4*pi, 1000); % от 0 до 4*pi с 1000 точками

% Создание графического окна
fig = figure;
hold on;
grid on;
axis([-10 10 -10 10]);
xlabel('x');
ylabel('y');

% Цвета для разных спиралей
colors = {'r', 'g', 'b', 'm', 'k'};

% Флаг для работы цикла
setappdata(fig, 'running', true);

% Основной цикл анимации
while getappdata(fig, 'running')
    for i = 1:length(a_values)
        if ~getappdata(fig, 'running')
            break; % Выход из цикла, если окно закрыто
        end
        
        a = a_values(i);
        r = a .* exp(b * phi);
        x = r .* cos(phi);
        y = r .* sin(phi);
        
        % Обновляем заголовок графика с текущим значением a
        title(sprintf('Анимация логарифмических спиралей (a = %.1f)', a));
        
        % Построение кривой
        h = plot(x, y, 'Color', colors{i}, 'LineWidth', 1.5);
        pause(0.5); % Задержка для анимации
        
        % Удаление линии
        delete(h);
    end
end

% Закрываем окно корректно
delete(fig);
