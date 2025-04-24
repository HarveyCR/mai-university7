% Параметры системы
A = 1;                % амплитуда (макс. отклонение)
k = 10;               % жёсткость пружины (Н/м)
m = 1;                % масса (кг)
omega = sqrt(k/m);    % угловая частота

L0 = 2;               % длина "спокойной" пружины
n_turns = 15;         % число витков пружины
amp_zigzag = 0.2;     % амплитуда зигзага (высота витков)

T = 10;               % общее время анимации (сек)
fps = 30;             % кадров в секунду

t = linspace(0, T, T*fps);  % вектор времени

% Настройка графика
figure;
axis equal;
axis([-10 10 -10 10]);
grid on;
title('Колебания пружины вдоль оси X');
xlabel('x');
ylabel('y');

for i = 1:length(t)
    % Положение груза в момент времени t(i)
    x_mass = L0 + A * cos(omega * t(i));

    % Построение пружины как зигзага от (0,0) до (x_mass, 0)
    x_spring = linspace(0, x_mass, 4 * n_turns + 1);
    y_spring = zeros(size(x_spring));
    for j = 2:2:length(x_spring)-1
        y_spring(j) = amp_zigzag;
        y_spring(j+1) = -amp_zigzag;
    end

    % Очистка и перерисовка
    cla;
    plot(x_spring, y_spring, 'b-', 'LineWidth', 2); hold on;

    % Рисуем груз
    plot(x_mass, 0, 'ro', 'MarkerSize', 14, 'MarkerFaceColor', 'r');

    drawnow;
end
